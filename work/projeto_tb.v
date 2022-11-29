`timescale 10ns/100ps

module projeto_tb;

reg CLK_tb;                                                             //CLK que controla todo o sistema
reg b3_tb,b2_tb,b1_tb,b0_tb, botao_tb;                                  //botoes do jogo -> INPUTS
wire LED_3,LED_2,LED_1,LED_0,LED_F;                                     //LED_S indicativos de acerto / erro na senha -> OUTPUTS
wire [1:0]a_tb;                                                         //entrada de todos os registradores
wire [1:0] s3_tb, s2_tb, s1_tb, s0_tb, t3_tb, t2_tb, t1_tb, t0_tb;      //saidas da senha e da tentativa, com cada termo tendo 2 bits
wire L7_tb,L6_tb,L5_tb,L4_tb,L3_tb,L2_tb,L1_tb,L0_tb,RESET_tb;          //todas as entradas condicionais dos registradores de 2 bits
wire st1_tb,st0_tb,modo_tb;                                             //variaveis de estado
wire c3_tb,c2_tb,c1_tb,c0_tb;                                           //saidas dos comparadores
wire x1,x2,State_aux;                                                   //fios auxiliares, interiores ao circuito
wire Dcare_tb;                                     

    //caso qualquer botao seja apertado, havera mudanca no estado
assign State_aux = b3_tb | b2_tb | b1_tb | b0_tb;

     //fios auxiliares
assign x1 = ((L3_tb & State_aux) | LED_F); 
assign x2 = L3_tb | L4_tb;

    //definicao do reset
assign RESET_tb = (L0_tb & LED_3) | botao_tb;
assign LED_F = LED_3 & LED_2 & LED_1 & LED_0;

    //importacao de todos os modulos criados para o projeto
    //codificador
    encod4x2 codificador (.b3(b3_tb),.b2(b2_tb),.b1(b1_tb),.b0(b0_tb),.a(a_tb));
    
    //decodificador
    decod3x8 decodficador (.modo(modo_tb),.s1(st1_tb),.s0(st0_tb),.l7(L7_tb),.l6(L6_tb),.l5(L5_tb),.l4(L4_tb),.l3(L3_tb),.l2(L2_tb),.l1(L1_tb),.l0(L0_tb));
    
    //comparador
    comp2 comparador3 (.a(s3_tb),.b(t3_tb),.a_eq_b(c3_tb)); //comp 3
    comp2 comparador2 (.a(s2_tb),.b(t2_tb),.a_eq_b(c2_tb)); //comp 2
    comp2 comparador1 (.a(s1_tb),.b(t1_tb),.a_eq_b(c1_tb)); //comp 1
    comp2 comparador0 (.a(s0_tb),.b(t0_tb),.a_eq_b(c0_tb)); //comp 0

    //MdE MODO
    fsm_modo MdE_MODO(.x(x1),.CLK(CLK_tb),.s1(modo_tb),.s0(Dcare_tb));

    //MdE Registradores
    fsm_registrador MdE_REGISTRADOR(.botao(State_aux),.CLK(CLK_tb),.s1(st1_tb),.s0(st0_tb));

    //8 registradores de 2 bits, usados para salvar senha e tentativa, termo a termo
    reg2bits r0(.a(a_tb), .enable(L0_tb), .reset(RESET_tb), .CLK(CLK_tb), .s(s0_tb));   //r0
    reg2bits r1(.a(a_tb), .enable(L1_tb), .reset(RESET_tb), .CLK(CLK_tb), .s(s1_tb));   //r1
    reg2bits r2(.a(a_tb), .enable(L2_tb), .reset(RESET_tb), .CLK(CLK_tb), .s(s2_tb));   //r2
    reg2bits r3(.a(a_tb), .enable(L3_tb), .reset(RESET_tb), .CLK(CLK_tb), .s(s3_tb));   //r3
    reg2bits r4(.a(a_tb), .enable(L4_tb), .reset(RESET_tb), .CLK(CLK_tb), .s(t0_tb));   //r4
    reg2bits r5(.a(a_tb), .enable(L5_tb), .reset(RESET_tb), .CLK(CLK_tb), .s(t1_tb));   //r5
    reg2bits r6(.a(a_tb), .enable(L6_tb), .reset(RESET_tb), .CLK(CLK_tb), .s(t2_tb));   //r6
    reg2bits r7(.a(a_tb), .enable(L7_tb), .reset(RESET_tb), .CLK(CLK_tb), .s(t3_tb));   //r7
    
    // 1 registrador de 4 bits, usado para salvar a saida dos comparadores (tentativa certa/errada)
    registrador4bits reg4bits(.CLK(CLK_tb),.s3(LED_3),.s2(LED_2),.s1(LED_1),.s0(LED_0),.a3(c3_tb),.a2(c2_tb),.a1(c1_tb),.a0(c0_tb),.RESET(RESET_tb),.LOAD(x2));

    initial begin
        // botao de reset para inicializar as variaveis como 0 e tirar eventuais don't cares (x) que apareceriam
        // e atrapalhariam a logica do sistema
    botao_tb = 1;
    #2
    botao_tb = 0;

        // definindo senha = b1 b2 b1 b2 -> 01 10 01 10 (0010 0100 0010 0100)
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 1;
        b0_tb = 0;
        CLK_tb = 0;

    $monitor("Colocando Senha: Botoes: %d | %d | %d | %d || Decodificador: %d | %d | %d | %d | %d | %d | %d | %d", b3_tb,b2_tb,b1_tb,b0_tb,L0_tb,L1_tb,L2_tb,L3_tb,L4_tb,L5_tb,L6_tb,L7_tb);
        
    #2
        //para de apertar o botao, retornando tudo para 0
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;

    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 1;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    
    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;

    #2
    //tentativa 1:b2 b2 b2 b2 -> 10 10 10 10 (0100 0100 0100 0100)
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;

    $monitor("Primeira Tentativa: Botoes %d | %d | %d | %d || Decodificador: %d | %d | %d | %d | %d | %d | %d | %d", b3_tb,b2_tb,b1_tb,b0_tb,L0_tb,L1_tb,L2_tb,L3_tb,L4_tb,L5_tb,L6_tb,L7_tb);

    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;

    //tentativa 2: b3 b2 b1 b2 -> 11 10 01 10 (1000 0100 0010 0100)
    #2
        b3_tb = 1;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;

    $monitor("Segunda Tentativa: Botoes %d | %d | %d | %d || Decodificador: %d | %d | %d | %d | %d | %d | %d | %d", b3_tb,b2_tb,b1_tb,b0_tb,L0_tb,L1_tb,L2_tb,L3_tb,L4_tb,L5_tb,L6_tb,L7_tb);

    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 1;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;

    //tentativa 3 = b1 b2 b1 b2 -> 01 10 01 10 (0010 0100 0010 0100) (CORRETA!)
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 1;
        b0_tb = 0;

    $monitor("Terceira Tentativa: Botoes %d | %d | %d | %d || Decodificador: %d | %d | %d | %d | %d | %d | %d | %d", b3_tb,b2_tb,b1_tb,b0_tb,L0_tb,L1_tb,L2_tb,L3_tb,L4_tb,L5_tb,L6_tb,L7_tb);
    
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 1;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 1;
        b1_tb = 0;
        b0_tb = 0;
    #2
        b3_tb = 0;
        b2_tb = 0;
        b1_tb = 0;
        b0_tb = 0;
    
    $monitor("SIMULACAO LED 1 = %d | LED 2 = %d | LED 3 = %d | LED 4 = %d  || LED Vitoria = %d",LED_0,LED_1,LED_2,LED_3,LED_F);
    end 
    always #2 CLK_tb = ~CLK_tb;
endmodule