`timescale 1ns/1ps
// AD7908: DIN is latched on falling SCLK; DOUT advances after that edge.
// Read DOUT before falling SCLK, and prepare the next DIN bit on rising SCLK.
module serial_frame16 #(parameter HALF_CYCLES=25)(
    input wire clk_50mhz,rst_p,start,
    input wire [15:0] tx_word,
    input wire miso,
    output reg sclk,cs_n,mosi,busy,done,
    output reg [15:0] rx_word
);
    localparam [1:0] IDLE=0, TRANSFER=1, QUIET=2;
    localparam integer QUIET_CYCLES=4; // 80 ns at 50 MHz (minimum is 50 ns).
    reg [1:0] state;
    reg [31:0] count;
    reg [4:0] bit_index;
    reg [15:0] tx_latched,rx_shift;
    always @(posedge clk_50mhz) begin
        if(rst_p) begin
            sclk<=1; cs_n<=1; mosi<=0; busy<=0; done<=0;
            state<=IDLE; count<=0; bit_index<=15;
            tx_latched<=0; rx_shift<=0; rx_word<=0;
        end else begin
            done<=0;
            case(state)
                IDLE: if(start) begin
                    cs_n<=0; busy<=1; count<=0; bit_index<=15;
                    tx_latched<=tx_word; rx_shift<=0; mosi<=tx_word[15];
                    state<=TRANSFER;
                end
                TRANSFER: begin
                    if(sclk && count==HALF_CYCLES/2)
                        rx_shift<={rx_shift[14:0],miso};
                    if(count==HALF_CYCLES-1) begin
                        count<=0;
                        if(sclk) sclk<=0;
                        else begin
                            sclk<=1;
                            if(bit_index==0) begin
                                cs_n<=1; rx_word<=rx_shift; done<=1;
                                state<=QUIET;
                            end else begin
                                bit_index<=bit_index-1'b1;
                                mosi<=tx_latched[bit_index-1'b1];
                            end
                        end
                    end else count<=count+1'b1;
                end
                QUIET: if(count==QUIET_CYCLES-1) begin
                    count<=0; busy<=0; state<=IDLE;
                end else count<=count+1'b1;
                default: state<=IDLE;
            endcase
        end
    end
endmodule
