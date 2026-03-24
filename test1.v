`timescale 1ns / 1ps

module ImageHasher (
    input wire clk,
    input wire reset,
    input wire [7:0] pixel_data,
    input wire pixel_valid,
    input wire [5:0] threshold,
    input wire [63:0] ref_signature,
    output reg [63:0] current_signature,
    output reg duplicate,
    output reg ready
);

    reg [13:0] sum;
    reg [7:0] buffer [0:63];
    reg [5:0] count;
    reg [1:0] state;

    localparam IDLE    = 2'b00,
               CAPTURE = 2'b01,
               GENHASH = 2'b10,
               COMPARE = 2'b11;

    integer i;

    always @(posedge clk) begin
        if (reset) begin
            sum <= 0;
            count <= 0;
            state <= IDLE;
            ready <= 0;
            duplicate <= 0;
            current_signature <= 64'b0;
        end else begin
            case (state)
                IDLE: begin
                    ready <= 0;
                   
                    if (pixel_valid) begin
                        buffer[0] <= pixel_data;
                        sum <= pixel_data; 
                        count <= 1;        
                        state <= CAPTURE;
                    end else begin
                        sum <= 0;
                        count <= 0;
                    end
                end

                CAPTURE: begin
                    if (pixel_valid) begin
                        buffer[count] <= pixel_data;
                        sum <= sum + pixel_data;
                        if (count == 63) begin
                            count <= 0;
                            state <= GENHASH;
                        end else begin
                            count <= count + 1;
                        end
                    end
                end

                GENHASH: begin
                    for (i = 0; i < 64; i = i + 1) begin
                        current_signature[i] <= (buffer[i] >= (sum >> 6));
                    end
                    state <= COMPARE;
                end

                COMPARE: begin
                    if (hamming_dist(current_signature, ref_signature) <= threshold)
                        duplicate <= 1;
                    else
                        duplicate <= 0;

                    ready <= 1;
                    state <= IDLE;
                end
            endcase

            
            $display("Time: %0t | State: %b | Count: %d | Sum: %d | Ready: %b | Pixel_valid: %b",
                     $time, state, count, sum, ready, pixel_valid);
        end
    end

    function [6:0] hamming_dist(input [63:0] a, input [63:0] b);
        reg [63:0] diff;
        integer j;
        begin
            diff = a ^ b;
            hamming_dist = 0;
            for (j = 0; j < 64; j = j + 1)
                if (diff[j])
                    hamming_dist = hamming_dist + 1;
        end
    endfunction

endmodule
