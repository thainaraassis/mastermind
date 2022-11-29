module reg2bits(a, enable, reset, CLK, s);
parameter n = 2;

input [n-1:0] a; 
input enable, reset, CLK;
output reg [n-1:0] s;

always@(posedge CLK, posedge reset) begin
    
    if(reset == 1) s<=0;
    
    else begin
        if(enable == 1) s<=a;

        else 
            s<=s;
    end

end
endmodule