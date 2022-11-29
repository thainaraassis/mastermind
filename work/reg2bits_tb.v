`timescale 10ns/100ps
module reg2bits_tb;
    parameter n = 2;

    reg [n-1:0] a_tb;
    reg enable_tb, reset_tb, CLK_tb;
    wire [n-1:0] s_tb;

    reg2bits uut(.a(a_tb), .enable(enable_tb), .reset(reset_tb), .CLK(CLK_tb), .s(s_tb));

    initial begin
        CLK_tb = 0;
        enable_tb = 0;
        reset_tb = 0;
        a_tb = 0;

        $monitor("CLK = %d || enable = %d || reset = %d || in = %d || out = %d", CLK_tb, enable_tb, reset_tb, a_tb, s_tb);
    end

always #10 CLK_tb = ~CLK_tb;
always #20 a_tb = a_tb + 1;
always #80 enable_tb = ~enable_tb;
always #160 reset_tb = ~reset_tb;

endmodule