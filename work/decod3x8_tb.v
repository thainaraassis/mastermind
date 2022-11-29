`timescale 10ns/100ps

module decod3x8_tb;

reg modo_tb, s1_tb, s0_tb;
wire l7_tb,l6_tb,l5_tb,l4_tb,l3_tb,l2_tb,l1_tb,l0_tb;

decod3x8 uut (.modo(modo_tb),.s1(s1_tb),.s0(s0_tb),.l7(l7_tb),.l6(l6_tb),.l5(l5_tb),.l4(l4_tb),.l3(l3_tb),.l2(l2_tb),.l1(l1_tb),.l0(l0_tb));

initial begin

    modo_tb = 0;
    s1_tb = 0;
    s0_tb = 0;
$monitor ("l7 = %d | l6 = %d | l5 = %d | l4 = %d | l3 = %d | l2 = %d | l1 = %d | l0 = %d",l7_tb,l6_tb,l5_tb,l4_tb,l3_tb,l2_tb,l1_tb,l0_tb);
end
always #10 begin
$monitor ("l7 = %d | l6 = %d | l5 = %d | l4 = %d | l3 = %d | l2 = %d | l1 = %d | l0 = %d",l7_tb,l6_tb,l5_tb,l4_tb,l3_tb,l2_tb,l1_tb,l0_tb);
s0_tb <= s0_tb+1;
end
always #20 s1_tb <= s1_tb+1;
always #40 modo_tb <= modo_tb+1;


endmodule


