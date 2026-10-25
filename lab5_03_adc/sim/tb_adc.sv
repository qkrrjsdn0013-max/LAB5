`timescale 1ns/1ps
// AD7908 model based on Rev. E, Table 4 and Figure 27:
// leading zero is available after CS falls; DIN is latched on falling SCLK;
// DOUT advances AFTER falling SCLK and floats after the 16th falling edge.
module tb;
    reg clk=0,rst=1;
    always #10 clk=~clk;
    reg [2:0] channel=2;
    reg miso=1'bz;
    wire sclk,cs_n,mosi,valid;
    wire [11:0] sample;
    wire [7:0] led;
    adc dut(clk,rst,channel,sclk,cs_n,mosi,miso,sample,valid,led);
    reg [15:0] received_command,reply,expected_command;
    reg [2:0] selected_channel=0;
    integer bits=0,frames=0,valid_frames=0,epoch_frames=0;
    integer i,target;
    time last_mosi_change=0,last_fall=0,last_cs_rise=0,edge_time;
    reg active=0,have_cs_rise=0;

    function [7:0] value_for_channel(input [2:0] ch);
        case(ch)
            0:value_for_channel=8'h00; 1:value_for_channel=8'h01;
            2:value_for_channel=8'h80; 3:value_for_channel=8'hFF;
            4:value_for_channel=8'h55; 5:value_for_channel=8'hAA;
            6:value_for_channel=8'h7F; 7:value_for_channel=8'hC3;
        endcase
    endfunction

    always @(mosi) begin
        if(active && last_fall!=0 && $time-last_fall<5)
            $fatal(1,"DIN hold time violated");
        last_mosi_change=$time;
    end
    always @(negedge cs_n) if(!rst) begin
        if(have_cs_rise && $time-last_cs_rise<50)
            $fatal(1,"CS quiet time violated: %0t",$time-last_cs_rise);
        active=1; bits=0; received_command=0;
        expected_command=epoch_frames<2 ? 16'hFFFF : (16'hA370 | ({13'b0,channel}<<10));
        reply={1'b0,selected_channel,value_for_channel(selected_channel),4'b0000};
        #30 miso=reply[15];
    end
    always @(negedge sclk) if(active && !rst) begin
        edge_time=$time;
        last_fall=$time;
        // Check after the delta cycle so simultaneous SCLK/DIN updates cannot pass.
        #1;
        if(edge_time-last_mosi_change<10 || last_mosi_change>=edge_time)
            $fatal(1,"DIN setup time violated on bit %0d",bits);
        received_command={received_command[14:0],mosi};
        bits=bits+1;
        // Worst-case data access delay (40 ns), including output release.
        #39;
        if(bits<16) miso=reply[15-bits];
        else miso=1'bz;
    end
    always @(posedge cs_n) if(active && !rst) begin
        if(bits!=16) $fatal(1,"Expected 16 falling edges, got %0d",bits);
        if($time-last_fall<20) $fatal(1,"CS hold time violated");
        if(received_command!==expected_command)
            $fatal(1,"Command got=%h expected=%h",received_command,expected_command);
        selected_channel=received_command[12:10]; // takes effect NEXT frame
        active=0; miso=1'bz; frames=frames+1; epoch_frames=epoch_frames+1;
        last_cs_rise=$time; have_cs_rise=1;
    end
    always @(posedge valid) begin
        #1;
        if(epoch_frames<4) $fatal(1,"Published startup/dummy data");
        if(dut.rx_word!==reply || sample!==reply[11:0] || led!==reply[11:4])
            $fatal(1,"Data alignment: rx=%h expected=%h LED=%h",dut.rx_word,reply,led);
        valid_frames=valid_frames+1;
        $display("FRAME %0d: returned_channel=%0d sample=%h LED=%h",frames,reply[14:12],sample,led);
    end
    initial begin
        $dumpfile("wave.vcd"); $dumpvars(0,tb);
        repeat(3) @(negedge clk);
        if(cs_n!==1 || sclk!==1 || sample!==0) $fatal(1,"reset");
        rst=0;
        for(i=0;i<8;i=i+1) begin
            @(negedge clk); channel=i;
            target=valid_frames+2;
            wait(valid_frames>=target);
            if(led!==value_for_channel(i)) $fatal(1,"Channel %0d did not settle",i);
        end
        @(negedge clk); rst=1;
        @(posedge clk); #1;
        if(sample!==0 || valid!==0 || cs_n!==1 || sclk!==1) $fatal(1,"reset after data");
        epoch_frames=0; active=0;
        repeat(3) @(negedge clk);
        rst=0;
        target=valid_frames+1;
        wait(valid_frames>=target);
        $display("PASS ADC: AD7908 timing, 8 channels, bit alignment, startup, quiet time, reset");
        $finish;
    end
    initial begin #1000000; $fatal(1,"timeout"); end
endmodule
