module encod4x2(b3,b2,b1,b0,a);

    input  b3,b2,b1,b0;
    output [1:0]a;

assign a[1] = b3 ^ b2;
assign a[0] = b3 ^ b1;

endmodule





