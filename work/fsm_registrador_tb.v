`timescale 10ns/100ps
module fsm_registrador_tb;
    reg  botao_tb, CLK_tb;
    wire s1_tb,s0_tb;


    fsm_registrador uut (.botao(botao_tb),.CLK(CLK_tb),.s1(s1_tb),.s0(s0_tb));

    initial begin
        CLK_tb = 0;
        botao_tb = 0;

        $monitor ("CLK = %d || Botao = %d || estado atual = %d%d",CLK_tb,botao_tb,s1_tb,s0_tb);
    end
    always #10 CLK_tb = ~CLK_tb; //para cada 10 unidades de tempo, o CLOCK mudará de 1 para 0;
    always #40 botao_tb = ~botao_tb; //para cada 40 unidades de tempo, o CLOCK mudará de 1 para 0;
endmodule


