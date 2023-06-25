module GSIM (
    input         i_clk,
    input         i_reset,
    input         i_valid,
    input  [511:0]  i_a,
    input  [63:0]  i_b,
    output        o_valid,
    output [255:0] o_x
);
    reg [2:0] reciprocal_counter_r;
    wire [2:0] reciprocal_counter_w;
    // reg reciprocal_start_r, reciprocal_start_w;
    reg reciprocal_start;
    // reg reciprocal_rst_r;
    wire reciprocal_rst;
    // reg reciprocal_temp_r;
    wire reciprocal_finish;
    wire [7:0] divisor;
    wire [31:0] quotient;
    wire reciprocal_end;

    wire [7:0] a [0:7][0:7];

    reg IM_temp;
    // wire IM_rst_w;
    // reg IM_rst_r;
    reg IM_rst;
    reg IM_start;
    wire [447:0] IM_a;
    wire [7:0] b [0:7];
    // reg [47:0] IM_a_R_r [0:7];
    // wire [47:0] IM_a_R_w [0:7];
    reg [255:0] IM_a_R_r;
    // reg [255:0] IM_a_R_w;
    // wire [383:0] IM_a_R;
    wire [63:0] IM_b;
    // wire [511:0] IM_x;
    // reg [63:0] IM_x_r [0:7];
    // wire [63:0] IM_x_w [0:7];
    reg [255:0] IM_x_r;
    // reg [255:0] IM_x_w;
    wire [39:0] x_temp;
    wire IMc;
    wire [255:0] x_nxt;


    parameter IDLE = 2'd0;
    parameter RECIPROCAL = 2'd1;
    parameter RUN = 2'd2;

    reg [1:0] state_r, state_w;

    reciprocal reciprocal(
        .i_clk(i_clk),
        .i_reset(reciprocal_rst|| i_reset),
        .i_valid(reciprocal_start),
        .i_divisor(divisor),
        .o_valid(reciprocal_finish),
        .o_quotient(quotient)
    );

    iteration_cell iteration_cell(
        .i_clk(i_clk),
        .i_reset(IM_rst|| i_reset),
        .i_valid(IM_start),
        .i_a(IM_a),
        .i_a_R(IM_a_R_r),
        .i_b(IM_b),
        .i_x(IM_x_r), // initial value of x array
        .o_x(o_x),
        .o_valid(o_valid)
    );

    assign reciprocal_counter_w = reciprocal_counter_r + 1;
    assign divisor = a[reciprocal_counter_r][reciprocal_counter_r];
    assign reciprocal_end = &{reciprocal_finish, reciprocal_counter_r};
    assign reciprocal_rst = ~reciprocal_start;


    assign IM_a = {
        a[0][1], a[0][2], a[0][3], a[0][4], a[0][5], a[0][6], a[0][7], 
        a[1][0], a[1][2], a[1][3], a[1][4], a[1][5], a[1][6], a[1][7],
        a[2][0], a[2][1], a[2][3], a[2][4], a[2][5], a[2][6], a[2][7], 
        a[3][0], a[3][1], a[3][2], a[3][4], a[3][5], a[3][6], a[3][7], 
        a[4][0], a[4][1], a[4][2], a[4][3], a[4][5], a[4][6], a[4][7],
        a[5][0], a[5][1], a[5][2], a[5][3], a[5][4], a[5][6], a[5][7],
        a[6][0], a[6][1], a[6][2], a[6][3], a[6][4], a[6][5], a[6][7], 
        a[7][0], a[7][1], a[7][2], a[7][3], a[7][4], a[7][5], a[7][6]};
    // assign IM_a_R = {IM_a_R_r[0], IM_a_R_r[1], IM_a_R_r[2], IM_a_R_r[3], IM_a_R_r[4], IM_a_R_r[5], IM_a_R_r[6], IM_a_R_r[7]};
    // assign IM_x = {IM_x_r[0], IM_x_r[1], IM_x_r[2], IM_x_r[3], IM_x_r[4], IM_x_r[5], IM_x_r[6], IM_x_r[7]};
    // assign IM_a_R_w = (state_r == RECIPROCAL && reciprocal_finish&&reciprocal_temp_r) ? {IM_a_R_r[223:0], quotient} : IM_a_R_r;
    // assign IM_x_w = (state_r == RECIPROCAL && reciprocal_finish&&reciprocal_temp_r) ? {IM_x_r[223:0], x_temp[37:6]+x_temp[5]} : IM_x_r;
    assign x_temp = $signed(quotient) * $signed(b[reciprocal_counter_r]);
    assign IM_b = i_b;

    
    assign b[7] = i_b[7:0];
    assign b[6] = i_b[15:8];
    assign b[5] = i_b[23:16];
    assign b[4] = i_b[31:24];
    assign b[3] = i_b[39:32];
    assign b[2] = i_b[47:40];
    assign b[1] = i_b[55:48];
    assign b[0] = i_b[63:56];

    assign x_nxt = {IM_x_r[223:0], x_temp[37:6]+x_temp[5]};

    genvar n;
    genvar m;
    generate
        for (n=0; n<8; n=n+1) begin: nloop
            for (m=0; m<8; m=m+1) begin: mloop
                assign a[7-n][7-m] = i_a[n*64+m*8+7-:8];
            end
        end
    endgenerate

    // genvar j;
    // generate
    //     for (j=0; j<8; j=j+1) begin: register
    //         assign IM_a_R_w[j] = ((reciprocal_counter_r == j) ? (quotient) : (IM_a_R_r[j]));
    //         assign IM_x_w[j] = ((reciprocal_counter_r == j) ? (x_temp2) : (IM_x_r[j]));
    //     end
    // endgenerate

    // always @(*) begin
    //     case(state_r)
    //         IDLE: reciprocal_start_w = i_valid;
    //         RECIPROCAL: reciprocal_start_w = ~reciprocal_temp_r;
    //         RUN: reciprocal_start_w = 1'b0;
    //         default: reciprocal_start_w = 1'b0;
    //     endcase
    // end

    always @(*) begin
        case(state_r)
            IDLE: state_w = (i_valid) ? (RECIPROCAL) : (IDLE);
            RECIPROCAL: state_w = (reciprocal_end) ? (RUN) : (RECIPROCAL);
            RUN: state_w = (o_valid) ? (IDLE) : (RUN);
            default: state_w = IDLE;
        endcase
    end

    // integer k;
    // always @(posedge reciprocal_temp_r or posedge i_reset) begin
    //     if (i_reset) begin
    //         reciprocal_counter_r <= 3'b0;
    //         // for (k=0; k<8; k=k+1) begin
    //         //     IM_a_R_r[k] <= 0;
    //         //     IM_x_r[k] <= 0;
    //         // end
    //         IM_a_R_r <= 0;
    //         IM_x_r <= 0;
    //     end
    //     else begin
    //         reciprocal_counter_r <= reciprocal_counter_w;
    //         // for (k=0; k<8; k=k+1) begin
    //         //     IM_a_R_r[k] <= IM_a_R_w[k];
    //         //     IM_x_r[k] <= IM_x_w[k];
    //         // end
    //         IM_a_R_r <= IM_a_R_w;
    //         IM_x_r <= IM_x_w;
    //     end
    // end
    always @(negedge i_clk) begin
      if (i_reset) reciprocal_start <= 0;
      else begin
          case (state_r)
              IDLE: reciprocal_start <= i_valid;
              RECIPROCAL: reciprocal_start <= ~reciprocal_finish;
              RUN: reciprocal_start <= 0;
              default: reciprocal_start <= 0;
          endcase
      end
    end
    always @(posedge i_clk) begin
        if (i_reset || state_r!=RECIPROCAL) begin
            reciprocal_counter_r <= 0;
        end
        else if (reciprocal_rst) begin
            reciprocal_counter_r <= reciprocal_counter_w;
        end
        else begin
            reciprocal_counter_r <= reciprocal_counter_r;
        end
    end

    always @(negedge i_clk) begin
        if (i_reset) begin
            IM_start <= 0;
            IM_rst <= 0;
        end
        else begin
            IM_start <= IM_rst;
            IM_rst <= reciprocal_end;
        end
    end

    always @(posedge i_clk) begin
        if (i_reset) begin
            state_r <= IDLE;
            // reciprocal_start_r <= 1'b0;
            // reciprocal_temp_r <= 1'b0;
            // reciprocal_rst_r <= 1'b1;
            // IM_rst_r <= 1'b0;
            // IM_temp <= 1'b0;
            // IM_start <= 1'b0;
            // reciprocal_counter_r <= 3'b0;
            // IM_a_R_r <= 0;
            // IM_x_r <= 0;
        end
        else begin
            state_r <= state_w;
            // reciprocal_start_r <= reciprocal_start_w;
            // reciprocal_temp_r <= reciprocal_finish;
            // reciprocal_rst_r <= reciprocal_temp_r;
            // IM_rst_r <= IM_rst_w;
            // IM_temp <= reciprocal_end;
            // IM_start <= IM_temp;
            // reciprocal_counter_r <= reciprocal_counter_w;
            // IM_a_R_r <= IM_a_R_w;
            // IM_x_r <= IM_x_w;
        end
        
    end

    

    always @(negedge i_clk) begin
        if (&{~state_r[1], state_r[0], reciprocal_finish}) begin
            IM_a_R_r <= {IM_a_R_r[223:0], quotient};
            IM_x_r <= x_nxt;
        end
        else begin
            IM_a_R_r <= IM_a_R_r;
            IM_x_r <= IM_x_r;
        end
    end

endmodule

