module registrador4bits(CLK,s3,s2,s1,s0,a3,a2,a1,a0,RESET,LOAD);
input CLK, a3, a2, a1, a0, LOAD, RESET;
output reg s3, s2, s1, s0;


always@(posedge CLK, posedge RESET) begin //RESET assincrono
    if(RESET == 1) begin
        s3 <= 1'b0;
        s2 <= 1'b0;
        s1 <= 1'b0;
        s0 <= 1'b0;
    end
    else begin
        if(LOAD == 1) begin
            s3 <= a3;
            s2 <= a2;
            s1 <= a1;
            s0 <= a0;
        end 
        else begin
            s3 <= s3;
            s2 <= s2;
            s1 <= s1;
            s0 <= s0;
        end
    end
end
endmodule