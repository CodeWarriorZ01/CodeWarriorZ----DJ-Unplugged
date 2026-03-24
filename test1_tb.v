`timescale 1ns / 1ps

module ImageHasher_tb();
    reg clk;
    reg reset;
    reg [7:0] pixel_data;
    reg pixel_valid;
    reg [5:0] threshold;
    reg [63:0] ref_signature;

    wire [63:0] current_signature;
    wire duplicate;
    wire ready;

    reg [7:0] test_mem [0:63];
    integer i;

    ImageHasher uut (
        .clk(clk), .reset(reset), .pixel_data(pixel_data),
        .pixel_valid(pixel_valid), .threshold(threshold),
        .ref_signature(ref_signature), .current_signature(current_signature),
        .duplicate(duplicate), .ready(ready)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, ImageHasher_tb);

        
        clk = 0; 
        reset = 1; 
        pixel_valid = 0; 
        pixel_data = 0;
        threshold = 5;
        ref_signature = 64'hA5A5A5A5A5A5A5A5;

        //$readmemh("image_data1.hex", test_mem);    //hex file with duplicate signature value
      $readmemh("image_data.hex", test_mem);     // hex file without duplicate signature value


        #20 reset <= 0; 
        #10;

       
        for (i = 0; i < 64; i = i + 1) begin
            @(posedge clk);
            pixel_data <= test_mem[i]; 
            pixel_valid <= 1;
        end

   
        @(posedge clk);
        pixel_valid <= 0;
        pixel_data <= 0;

        fork
            begin
                wait(ready);
                #10;
                $display("Hash Generated: %h", current_signature);
                $display("Duplicate Flag: %b", duplicate);
                $finish;
            end
            begin
                #5000;
                $display("Timeout: ready never asserted!");
                $finish;
            end
        join
    end
endmodule
