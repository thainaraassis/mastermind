`timescale 10ns/100ps

module comp2_tb;
    reg [1:0] a_tb,b_tb;
    wire a_eq_b_tb;

    comp2 uut (.a(a_tb),.b(b_tb),.a_eq_b(a_eq_b_tb));

    initial begin
        a_tb = 2'b0;
        b_tb = 2'b0;
        $monitor("a = %d, b = %d a=b = %d", a_tb, b_tb,a_eq_b_tb);
    end
    always #10 begin
        a_tb <= a_tb + 1;
        $monitor("a = %d, b = %d a=b = %d", a_tb, b_tb,a_eq_b_tb);
    end
        always #40 b_tb <= b_tb + 1;
    endmodule


    

