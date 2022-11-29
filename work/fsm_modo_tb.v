`timescale 10ns/100ps
module fsm_modo_tb;
reg CLK_tb, x_tb;
wire s1_tb,s0_tb;

fsm_modo uut(.x(x_tb),.CLK(CLK_tb),.s1(s1_tb),.s0(s0_tb));

initial begin
    CLK_tb = 0;
    x_tb = 0;
    $monitor("CLK = %d || x = %d || estado = %d%d",CLK_tb,x_tb,s1_tb,s0_tb);
end

always #10 CLK_tb = ~CLK_tb;
always #20 x_tb = ~x_tb;
endmodule




