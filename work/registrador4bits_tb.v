`timescale 10ns/100ps
module registrador4bits_tb;

reg CLK_tb, a3_tb, a2_tb, a1_tb, a0_tb, LOAD_tb, RESET_tb;
wire s3_tb, s2_tb, s1_tb, s0_tb;

registrador4bits uut(.CLK(CLK_tb),.s3(s3_tb),.s2(s2_tb),.s1(s1_tb),.s0(s0_tb),.a3(a3_tb),.a2(a2_tb),.a1(a1_tb),.a0(a0_tb),.RESET(RESET_tb),.LOAD(LOAD_tb));

    initial begin
    a3_tb = 0;
    a2_tb = 0;
    a1_tb = 0;
    a0_tb = 0;
    CLK_tb = 0;
    RESET_tb = 0;
    LOAD_tb = 0;

    $monitor("RESET = %d || LOAD = %d || CLK = %d || entrada = %d%d%d%d || saida = %d%d%d%d",RESET_tb,LOAD_tb,CLK_tb,a3_tb,a2_tb,a1_tb,a0_tb,s3_tb,s2_tb,s1_tb,s0_tb);
end   
    always #10 CLK_tb = ~CLK_tb;
    always #20 a0_tb = ~a0_tb;
    always #40 a1_tb = ~a1_tb;
    always #80 a2_tb = ~a2_tb;
    always #160 a3_tb = ~a3_tb;
    always #320 LOAD_tb = ~LOAD_tb;
    always #640 RESET_tb = ~RESET_tb;

endmodule