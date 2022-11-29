module fsm_registrador(botao,CLK,s1,s0);

input botao, CLK;
output reg s1,s0;

// declaracao do registrador
reg [1:0] states;

// declaracao dos estados

parameter r0 = 2'b00, r1 = 2'b01, r2 = 2'b10, r3 = 2'b11;

initial begin
    states <= r0;
end

//definicao do estado atual

always@(posedge CLK) begin
    case(states)
        r0: begin
            if (botao == 1) states <= r1;
            else 
            states <= r0;
        end
        r1: begin
            if (botao == 1) states <= r2;
            else
            states <= r1;
        end
        r2: begin
            if (botao == 1) states <= r3;
            else
            states <= r2;
        end
        r3: begin
            if (botao == 1) states <=r0;
            else
            states <= r3;
        end
        default begin
            s1 = 1'b0;
            s0 = 1'b0; 
        end
    endcase
end

//definicao da saida

always@(states) begin //como a MdE eh do tipo Moore, a saida depende apenas do estado atual
    case(states)
        r0: begin 
        s1 = 1'b0;
        s0 = 1'b0;
        end
        r1: begin
        s1 = 1'b0;
        s0 = 1'b1;
        end
        r2: begin
        s1 = 1'b1;
        s0 = 1'b0;
        end
        r3: begin
        s1 = 1'b1;
        s0 = 1'b1;
        end
    endcase
end
endmodule


