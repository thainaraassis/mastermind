module decod3x8(modo,s1,s0,l7,l6,l5,l4,l3,l2,l1,l0);
input modo,s1,s0;
output l7,l6,l5,l4,l3,l2,l1,l0;

//a equacao das saidas do decodificador 3x8: 

    assign l0 = (~modo & ~s1 & ~s0);
    assign l1 = (~modo & ~s1 & s0);
    assign l2 = (~modo & s1 & ~s0);
    assign l3 = (~modo & s1 & s0);
    assign l4 = (modo & ~s1 & ~s0);
    assign l5 = (modo & ~s1 & s0);
    assign l6 = (modo & s1 & ~s0);
    assign l7 = (modo & s1 & s0);

endmodule


