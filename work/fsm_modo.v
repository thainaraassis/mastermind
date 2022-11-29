module fsm_modo(x,CLK,s1,s0);
input x,CLK;
output reg s1,s0;

//declaracao do registrador
reg [1:0] state;

//declaracao dos estados
// senhaM = senhaMODO(estado que serve apenas como transicao), senhaS = senhaSET(estado que serve para receber a senha). O mesmo
// serve para tentM e tentS

parameter senhaM = 2'b00, senhaS = 2'b01, tentM = 2'b10, tentS = 2'b11; 

initial begin
    state <=senhaM;
end

//descricao dos estados

always@(posedge CLK) begin
    case(state)

        senhaM: begin
            if(x==1) state <= senhaM;
            else
                state <= senhaS;
        end
        senhaS: begin
            if(x==0) state <= senhaS;
            else
                state <= tentM;
        end
        tentM: begin
            if(x==1) state <= tentM;
            else
                state <= tentS;
        end
        tentS: begin
            if(x==0) state<=tentS;
            else
                state <=senhaM;
        end
    endcase
end

//descricao das saidas

always@(state) begin //como a MdE eh do tipo Moore, a saida depende apenas do estado atual
    case(state)
        senhaM: begin
            s1 = 0;
            s0 = 0;
        end
        senhaS: begin
            s1 = 0;
            s0 = 1;
        end
        tentM: begin
            s1 = 1;
            s0 = 0;
        end
        tentS: begin
            s1 = 1;
            s0 = 1;
        end
    endcase
end
endmodule

