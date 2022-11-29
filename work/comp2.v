module comp2(a,b,a_eq_b);
    input [1:0] a,b;
    output a_eq_b;
    wire x1,x0;

    assign x1 = ~(a[1] ^ b[1]);
    assign x0 = ~(a[0] ^ b[0]);

    assign a_eq_b = x1 & x0;
endmodule