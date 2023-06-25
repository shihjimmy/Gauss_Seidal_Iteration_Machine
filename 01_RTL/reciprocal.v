module reciprocal(
    i_clk,
    i_reset,
    i_valid,
    i_divisor,
    o_valid,
    o_quotient
);
    parameter IDLE = 3'd0;
    parameter CHECK_2 = 3'd1;
    parameter ITER_1 = 3'd2;
    parameter ITER_2 = 3'd3;
    parameter OUT  = 3'd4;

    // Definition of ports
    input             i_clk, i_reset;
    input             i_valid;
    input  [7:0]      i_divisor;  // signed 8 bits
    output reg        o_valid;
    output reg [31:0] o_quotient; // S1.30
    
    // wires and regs
    wire   [3:0]    check_2; 
    reg    [2:0]    state_r,state_w;
    reg    [3:0]    count_r,count_w;
    wire            o_valid_w;
    reg    [7:0]    two_z;
    reg    [7:0]    two_z_down;  //8 bits decimal

    reg    [31:0]   a_multiply_r, a_multiply_w;
    reg    [31:0]   b_multiply_r, b_multiply_w;
    reg    [63:0]   ans_multiply_r, ans_multiply_w;

    reg    [31:0]   x_i;
    reg    [31:0]   x_i_next;
     
    always@ (*) begin
        case(state_r)
            IDLE: state_w = (i_valid) ? CHECK_2 : IDLE;
            CHECK_2: state_w = (check_2==4'd1) ? OUT : ITER_1;
            ITER_1: state_w = ITER_2;
            ITER_2: state_w = (count_r==4'd12) ? OUT : ITER_1;
            OUT:  state_w = OUT;
            default : state_w = IDLE;
        endcase
    end

    assign o_valid_w = (state_r == OUT) ? 1 : 0;
    assign check_2 = (i_divisor[0]+i_divisor[1]+i_divisor[2]+i_divisor[3]+i_divisor[4]+i_divisor[5]+i_divisor[6]+i_divisor[7]);

    always@(*) begin
        if(i_valid) begin
            // get 2^(floor(log2(x)))
            two_z[0] = (!i_divisor[7])&(!i_divisor[6])&(!i_divisor[5])
                        &(!i_divisor[4])&(!i_divisor[3])&(!i_divisor[2])&(!i_divisor[1])&(i_divisor[0]);
            two_z[1] = (!i_divisor[7])&(!i_divisor[6])&(!i_divisor[5])
                        &(!i_divisor[4])&(!i_divisor[3])&(!i_divisor[2])&(i_divisor[1]);
            two_z[2] = (!i_divisor[7])&(!i_divisor[6])&(!i_divisor[5])
                        &(!i_divisor[4])&(!i_divisor[3])&(i_divisor[2]);
            two_z[3] = (!i_divisor[7])&(!i_divisor[6])&(!i_divisor[5])
                        &(!i_divisor[4])&(i_divisor[3]);
            two_z[4] = (!i_divisor[7])&(!i_divisor[6])&(!i_divisor[5])
                        &(i_divisor[4]);
            two_z[5] = (!i_divisor[7])&(!i_divisor[6])&(i_divisor[5]);
            two_z[6] = (!i_divisor[7])&(i_divisor[6]);
            two_z[7] = (i_divisor[7]);

            // get 2^( (-1)*floor(log2(x)) )  ex: .00100000
            two_z_down = {two_z[0],two_z[1],two_z[2],two_z[3],two_z[4],two_z[5],two_z[6],two_z[7]}; 
        end
        else begin
            two_z = 0;
            two_z_down = 0;
        end
    end

    always@ (*) begin
        count_w     = count_r;
        x_i_next    = x_i;

        if(state_r == ITER_1) begin
            count_w = count_r + 1'b1;
        end
        else if(state_r == ITER_2) begin
            x_i_next = ans_multiply_w[61:30];
        end
    end
    
    always@ (*) begin
        if(state_r == CHECK_2) begin
            a_multiply_w = {{24{i_divisor[7]}}, i_divisor};
            b_multiply_w = {2'b0,two_z_down,22'b0};
        end
        else if(state_r == ITER_1) begin
            a_multiply_w = {2'b10,30'b0} - ans_multiply_w[31:0];
            if(!count_r)
                b_multiply_w = {2'b0,two_z_down,22'b0};
            else
                b_multiply_w = x_i;
        end
        else if(state_r == ITER_2) begin           
            a_multiply_w = {{24{i_divisor[7]}}, i_divisor};
            b_multiply_w = x_i_next;
        end
        else begin  
            a_multiply_w = a_multiply_r;
            b_multiply_w = b_multiply_r;
        end
    end

    always@ (*) begin
        if(state_r == ITER_1 || state_r == ITER_2)
            ans_multiply_w = a_multiply_r * b_multiply_r;
        else
            ans_multiply_w = ans_multiply_r;
    end
    
    always @(posedge i_clk) begin
        if(i_reset) begin
            x_i <= 0;
        end
        else begin
            if(state_r == ITER_1 && !count_r) begin
                x_i <= {2'b0,two_z_down,22'b0};
            end
            else if(state_r == CHECK_2 && check_2==4'd1) begin
                x_i <= {1'b0,two_z_down,23'b0};
            end
            else begin
                x_i <= x_i_next;
            end
        end
    end

    always@(posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
            ans_multiply_r <= 0;
            a_multiply_r <= 0;
            b_multiply_r <= 0;
        end
        else begin
            ans_multiply_r <= ans_multiply_w;
            a_multiply_r <= a_multiply_w;
            b_multiply_r <= b_multiply_w;
        end
    end

    always@(posedge i_clk) begin
        if(i_reset) begin
            o_quotient <= 0;
        end
        else begin
            if(state_r == OUT)
                o_quotient <= x_i;
            else
                o_quotient <= 0;
        end
    end

    always@(posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
            state_r <= IDLE;
            count_r <= 0;
        end
        else begin
            state_r <= state_w;
            count_r <= count_w;
        end
    end
    
    always@(posedge i_clk) begin
        if(i_reset) begin
            o_valid <= 0;
        end
        else begin
            o_valid <= o_valid_w;
        end
    end
   
endmodule
