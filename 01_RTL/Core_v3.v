module Core(
    i_clk,
    i_reset,
    a,
    b,
    a_down,
    i_valid,
    x,
    o_valid,
    x_next
);

    input  i_clk;
    input  i_reset;
    input  i_valid;
    // a contains 7 x 8bits a_i
    input  signed [55:0] a;  // S7
    input  signed [7:0] b;
    input  signed [31:0] a_down;
    //except the xi we are going to calculate, contains 7 x 32 bits x_i
    input  signed [223:0] x ; // S7.24
    output o_valid;
    output reg [31:0] x_next;

    integer i;
    parameter IDLE = 3'd0;
    parameter CALC = 3'd1;
    parameter CALC_2 = 3'd2;
    parameter CALC_3 = 3'd3;
    parameter OUT  = 3'd4;
    
    reg   [2:0]   state_r,state_w;
    reg   [31:0]  x_next_w;

    wire  [7:0]   a_new      [0:6];
    wire  [31:0]  x_new      [0:6];
    
    reg   [39:0]  x_temp     [0:6];
    reg   [39:0]  x_temp_w   [0:6];
    reg   [42:0]  x_temp_2, x_temp_2_w;
    reg   [74:0]  x_temp_3, x_temp_3_w;
    
    always@ (*) begin
        case(state_r)
            IDLE: state_w = (i_valid) ? CALC : IDLE;
            CALC: state_w = CALC_2;
            CALC_2: state_w = CALC_3;
            CALC_3: state_w = OUT;
            OUT : state_w = OUT;
            default: state_w = IDLE;
        endcase
    end

    assign o_valid = (state_r == OUT);

    assign x_new[0] = x[223:192];
    assign x_new[1] = x[191:160];
    assign x_new[2] = x[159:128];
    assign x_new[3] = x[127:96];
    assign x_new[4] = x[95:64];
    assign x_new[5] = x[63:32];
    assign x_new[6] = x[31:0];
    
    assign a_new[0] = a[55:48];
    assign a_new[1] = a[47:40];
    assign a_new[2] = a[39:32];
    assign a_new[3] = a[31:24];
    assign a_new[4] = a[23:16];
    assign a_new[5] = a[15:8];
    assign a_new[6] = a[7:0];

    always@ (*) begin
        if(state_r == CALC) begin
            for(i=0;i<7;i=i+1) begin
                x_temp_w[i] = $signed(x_new[i]) * $signed(a_new[i]);
            end
        end
        else begin
            for(i=0;i<7;i=i+1) begin
                x_temp_w[i] = x_temp[i];
            end
        end
    end

    always@ (*) begin
        if(state_r == CALC_2)
            x_temp_2_w = {{11{b[7]}} ,b,24'b0} - {{3{x_temp[0][39]}}, x_temp[0]} - {{3{x_temp[1][39]}}, x_temp[1]}
                        - {{3{x_temp[2][39]}}, x_temp[2]} - {{3{x_temp[3][39]}}, x_temp[3]} - {{3{x_temp[4][39]}}, x_temp[4]} 
                        - {{3{x_temp[5][39]}}, x_temp[5]} - {{3{x_temp[6][39]}}, x_temp[6]};
        else
            x_temp_2_w = x_temp_2;
    end

    always@ (*) begin
        if(state_r == CALC_3) 
            x_temp_3_w = $signed(x_temp_2) * $signed(a_down);
        else 
            x_temp_3_w = x_temp_3;
    end

    always@ (*) begin
        if(state_r == CALC_3)
            x_next_w = (x_temp_3_w[74]) ? (x_temp_3_w[61:30]+1'b1) : x_temp_3_w[61:30];
        else
            x_next_w = x_next;
    end

    always@ (posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
            state_r <= IDLE;
            x_next <= 0;

            for(i=0;i<7;i=i+1) begin
                x_temp[i] <= 0;
            end            
            x_temp_2 <= 0;
            x_temp_3 <= 0;
        end
        else begin
            state_r <= state_w;
            x_next <= x_next_w;

            for(i=0;i<7;i=i+1) begin
                x_temp[i] <= x_temp_w[i];
            end
            x_temp_2 <= x_temp_2_w;
            x_temp_3 <= x_temp_3_w;
        end
    end

endmodule