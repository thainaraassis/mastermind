`timescale 10ns/100ps
module encod4x2_tb;

    reg b3_tb, b2_tb, b1_tb, b0_tb;
    wire [1:0]a_tb;

    encod4x2 uut (.b3(b3_tb),.b2(b2_tb),.b1(b1_tb),.b0(b0_tb),.a(a_tb));

    initial begin
    
    b3_tb = 0;
    b2_tb = 0;
    b1_tb = 0;
    b0_tb = 1;
    $monitor("b3 = %d | b2 = %d | b1 = %d | b0 = %d  ----- a = %d",b3_tb, b2_tb, b1_tb, b0_tb,a_tb);

#10
    b3_tb = 0;
    b2_tb = 0;
    b1_tb = 1;
    b0_tb = 0;
    $monitor("b3 = %d | b2 = %d | b1 = %d | b0 = %d  ----- a = %d",b3_tb, b2_tb, b1_tb, b0_tb,a_tb);
    
#20
    b3_tb = 0;
    b2_tb = 1;
    b1_tb = 0;
    b0_tb = 0;
    $monitor("b3 = %d | b2 = %d | b1 = %d | b0 = %d  ----- a = %d",b3_tb, b2_tb, b1_tb, b0_tb,a_tb);
#40
    b3_tb = 1;
    b2_tb = 0;
    b1_tb = 0;
    b0_tb = 0;
    $monitor("b3 = %d | b2 = %d | b1 = %d | b0 = %d  ----- a = %d",b3_tb, b2_tb, b1_tb, b0_tb,a_tb);

    end 
endmodule