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

    reg   [2:0]   count_r, count_w;
    reg   [42:0]  a_multiply_r, a_multiply_w;
    reg   [31:0]  b_multiply_r, b_multiply_w;
    reg   [74:0]  ans_multiply_r, ans_multiply_w;
    
    reg   [39:0]  x_temp     [0:6];
    reg   [39:0]  x_temp_w   [0:6];
    reg   [42:0]  x_temp_2, x_temp_2_w;
    reg   [74:0]  x_temp_3, x_temp_3_w;
    
    always@ (*) begin
        case(state_r)
            IDLE: state_w = (i_valid) ? CALC : IDLE;
            CALC: state_w = (count_r>=3'd6) ? CALC_2 : CALC;
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
            count_w = count_r + 1'b1;

            // using "folding" technique to reduce area
            // using only one multiplier
            case(count_w)
                3'd1: begin
                    a_multiply_w = {{11{x_new[1][31]}} , x_new[1]};
                    b_multiply_w = {{24{a_new[1][7]}}  , a_new[1]};
                end
                3'd2: begin
                    a_multiply_w = {{11{x_new[2][31]}} , x_new[2]};
                    b_multiply_w = {{24{a_new[2][7]}}  , a_new[2]};
                end
                3'd3: begin
                    a_multiply_w = {{11{x_new[3][31]}} , x_new[3]};
                    b_multiply_w = {{24{a_new[3][7]}}  , a_new[3]};
                end
                3'd4: begin
                    a_multiply_w = {{11{x_new[4][31]}} , x_new[4]};
                    b_multiply_w = {{24{a_new[4][7]}}  , a_new[4]};
                end
                3'd5: begin
                    a_multiply_w = {{11{x_new[5][31]}} , x_new[5]};
                    b_multiply_w = {{24{a_new[5][7]}}  , a_new[5]};
                end
                3'd6: begin
                    a_multiply_w = {{11{x_new[6][31]}} , x_new[6]};
                    b_multiply_w = {{24{a_new[6][7]}}  , a_new[6]};
                end
                default: begin
                    a_multiply_w = a_multiply_r;
                    b_multiply_w = b_multiply_r;
                end
            endcase 
        end 
        else if(state_r == CALC_2) begin
            count_w = count_r;
            a_multiply_w = x_temp_2_w;
            b_multiply_w = a_down;
        end
        else begin
            count_w = count_r;
            a_multiply_w = a_multiply_r;
            b_multiply_w = b_multiply_r;
        end
    end

    always@ (*) begin
        if(state_r == CALC || state_r == CALC_3)
            ans_multiply_w = $signed(a_multiply_r) * $signed(b_multiply_r);
        else
            ans_multiply_w = a_multiply_r;
    end

    always@ (*) begin
        for(i=0;i<7;i=i+1) begin
            x_temp_w[i] = x_temp[i];
        end

        if(state_r ==CALC) 
            x_temp_w[count_r] = ans_multiply_w[39:0];
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
            x_temp_3_w = ans_multiply_w;
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
            count_r <= 0;
            a_multiply_r <= 0;
            b_multiply_r <= 0;
            ans_multiply_r <= 0;

            for(i=0;i<7;i=i+1) begin
                x_temp[i] <= 0;
            end            
            x_temp_2 <= 0;
            x_temp_3 <= 0;
        end
        else begin
            state_r <= state_w;
            x_next <=  x_next_w;
            count_r <= count_w;
            ans_multiply_r <= ans_multiply_w;

            if(!count_w && state_w==CALC) begin
                a_multiply_r <= {{11{x_new[0][31]}} , x_new[0]};
                b_multiply_r <= {{24{a_new[0][7]}}  , a_new[0]};
            end
            else begin
                a_multiply_r <= a_multiply_w;
                b_multiply_r <= b_multiply_w;
            end

            for(i=0;i<7;i=i+1) begin
                x_temp[i] <= x_temp_w[i];
            end
            x_temp_2 <= x_temp_2_w;
            x_temp_3 <= x_temp_3_w;
        end
    end

endmodule