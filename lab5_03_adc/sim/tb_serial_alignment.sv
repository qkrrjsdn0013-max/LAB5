`timescale 1ns/1ps
// Isolate receive alignment using the AD7908 wire format: channel 2, data A5.
module tb_serial_alignment;
    reg clk=0,rst=1,start=0,miso=1'bz;
    always #10 clk=~clk;
    wire sclk,cs,mosi,busy,done;
    wire [15:0] rx;
    reg [15:0] reply=16'h2A50;
    integer falls=0;
    serial_frame16 dut(clk,rst,start,16'hAB70,miso,sclk,cs,mosi,busy,done,rx);
    always @(negedge cs) begin falls=0; #30 miso=reply[15]; end
    always @(negedge sclk) if(!cs) begin
        falls=falls+1;
        #40;
        if(falls<16) miso=reply[15-falls]; else miso=1'bz;
    end
    initial begin
        repeat(3) @(negedge clk);
        rst=0; start=1;
        @(negedge clk); start=0;
        @(posedge done); #1;
        if(rx!==reply) $fatal(1,"RX alignment: got=%h expected=%h (channel=2, ADC=A5)",rx,reply);
        $display("PASS RX alignment: got=%h, channel=2, ADC=A5",rx);
        $finish;
    end
    initial begin #100000; $fatal(1,"timeout"); end
endmodule
