module iteration_cell (
    input             i_clk,
    input             i_reset,
    input             i_valid,
    input      [447:0]  i_a,
    input      [255:0] i_a_R,
    input      [63:0]  i_b,
    input      [255:0] i_x, // initial value of x array
    output reg [255:0] o_x,
    output reg        o_valid
);
    integer k;
    reg state_r;
    wire state_w;

    wire [31:0] a_R [0:7];
    // wire [15:0] a [0:7][0:6];
    wire [55:0] a [0:7];
    wire [7:0] b [0:7];

    wire [55:0] core_a;
    wire [31:0] core_a_R;
    wire [223:0] core_x;
    wire [7:0] core_b;
    wire core_rst;
    wire core_start;
    reg core_temp;
    wire core_finish;
    wire [31:0] core_x_nxt;

    reg rst;
    reg start;
    
    reg [31:0] x_r [0:7];
    wire [31:0] x_w [0:7];
    reg [2:0] counter_r;
    wire [2:0] counter_w;
    reg [2:0] iteration_counter_r;
    wire [2:0] iteration_counter_w;
    reg r_r;

    wire [31:0] x_array [0:7][0:6];
    wire [223:0] x_vector [0:7];
    wire finish;
    wire iteration_finish;
    reg core_f;
    wire oc;
    wire xc;

    Core core(
        .i_clk(i_clk), 
        .i_reset(core_rst||i_reset), 
        .a(core_a), 
        .b(core_b), 
        .a_down(core_a_R), 
        .i_valid(core_start), 
        .x(core_x), 
        .o_valid(core_finish), 
        .x_next(core_x_nxt)
        );
    assign state_w = state_r ? (~finish) : (i_valid);

    // assign x_array[0][0] = x_r[1];
    // assign x_array[0][1] = x_r[2];
    // assign x_array[0][2] = x_r[3];
    // assign x_array[0][3] = x_r[4];
    // assign x_array[0][4] = x_r[5];
    // assign x_array[0][5] = x_r[6];
    // assign x_array[0][6] = x_r[7];

    // assign x_array[1][0] = x_r[0];
    // assign x_array[1][1] = x_r[2];
    // assign x_array[1][2] = x_r[3];
    // assign x_array[1][3] = x_r[4];
    // assign x_array[1][4] = x_r[5];
    // assign x_array[1][5] = x_r[6];
    // assign x_array[1][6] = x_r[7];

    // assign x_array[2][0] = x_r[0];
    // assign x_array[2][1] = x_r[1];
    // assign x_array[2][2] = x_r[3];
    // assign x_array[2][3] = x_r[4];
    // assign x_array[2][4] = x_r[5];
    // assign x_array[2][5] = x_r[6];
    // assign x_array[2][6] = x_r[7];

    // assign x_array[3][0] = x_r[0];
    // assign x_array[3][1] = x_r[1];
    // assign x_array[3][2] = x_r[2];
    // assign x_array[3][3] = x_r[4];
    // assign x_array[3][4] = x_r[5];
    // assign x_array[3][5] = x_r[6];
    // assign x_array[3][6] = x_r[7];

    // assign x_array[4][0] = x_r[0];
    // assign x_array[4][1] = x_r[1];
    // assign x_array[4][2] = x_r[2];
    // assign x_array[4][3] = x_r[3];
    // assign x_array[4][4] = x_r[5];
    // assign x_array[4][5] = x_r[6];
    // assign x_array[4][6] = x_r[7];

    // assign x_array[5][0] = x_r[0];
    // assign x_array[5][1] = x_r[1];
    // assign x_array[5][2] = x_r[2];
    // assign x_array[5][3] = x_r[3];
    // assign x_array[5][4] = x_r[4];
    // assign x_array[5][5] = x_r[6];
    // assign x_array[5][6] = x_r[7];

    // assign x_array[7][0] = x_r[0];
    // assign x_array[7][1] = x_r[1];
    // assign x_array[7][2] = x_r[2];
    // assign x_array[7][3] = x_r[3];
    // assign x_array[7][4] = x_r[4];
    // assign x_array[7][5] = x_r[5];
    // assign x_array[7][6] = x_r[6];

    // assign x_array[6][0] = x_r[0];
    // assign x_array[6][1] = x_r[1];
    // assign x_array[6][2] = x_r[2];
    // assign x_array[6][3] = x_r[3];
    // assign x_array[6][4] = x_r[4];
    // assign x_array[6][5] = x_r[5];
    // assign x_array[6][6] = x_r[7];
    assign x_vector[0] = {x_r[1], x_r[2], x_r[3], x_r[4], x_r[5], x_r[6], x_r[7]};
    assign x_vector[1] = {x_r[0], x_r[2], x_r[3], x_r[4], x_r[5], x_r[6], x_r[7]};
    assign x_vector[2] = {x_r[0], x_r[1], x_r[3], x_r[4], x_r[5], x_r[6], x_r[7]};
    assign x_vector[3] = {x_r[0], x_r[1], x_r[2], x_r[4], x_r[5], x_r[6], x_r[7]};
    assign x_vector[4] = {x_r[0], x_r[1], x_r[2], x_r[3], x_r[5], x_r[6], x_r[7]};
    assign x_vector[5] = {x_r[0], x_r[1], x_r[2], x_r[3], x_r[4], x_r[6], x_r[7]};
    assign x_vector[6] = {x_r[0], x_r[1], x_r[2], x_r[3], x_r[4], x_r[5], x_r[7]};
    assign x_vector[7] = {x_r[0], x_r[1], x_r[2], x_r[3], x_r[4], x_r[5], x_r[6]};

    assign core_a_R = a_R[counter_r];
    // assign core_a = {a[counter_r][0], a[counter_r][1], a[counter_r][2], a[counter_r][3], a[counter_r][4], a[counter_r][5], a[counter_r][6]};
    assign core_a = a[counter_r];
    assign core_b = b[counter_r];
    // assign core_x = {x_array[counter_r][0], x_array[counter_r][1], x_array[counter_r][2], x_array[counter_r][3], x_array[counter_r][4], x_array[counter_r][5], x_array[counter_r][6]};
    assign core_x = x_vector[counter_r];

    assign core_rst = (rst);
    assign core_start = start;

    assign counter_w = counter_r + 3'b1;
    assign iteration_counter_w = iteration_counter_r + 3'b1;
    assign oc = (~i_clk && finish);
    assign xc = ~i_clk && (r_r||core_finish);

    assign finish = &{iteration_counter_r, counter_r, core_finish};
    always @(posedge i_clk) begin
        if (i_reset) core_f <= 0;
        else core_f <= core_rst;
    end 

    genvar n;
    genvar m;
    generate
        for (n=0; n<8; n=n+1) begin: nloop
            // for (m=0; m<7; m=m+1) begin: mloop
            //     assign a[n][m] = i_a[895-n*112-m*16-:16];
            // end
            assign a[n] = i_a[447-56*n-:56];
            assign b[7-n] = i_b[n*8+7-:8];
            assign a_R[n] = i_a_R[255-32*n-:32];
        end
    endgenerate

    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin: register
            assign x_w[i] = (counter_r == i) ? (core_x_nxt) : (x_r[i]);
        end
    endgenerate

    always @(posedge i_clk) begin
        if (i_reset) state_r <= 1'b0;
        else state_r <= state_w;
    end

    always @(posedge i_clk) begin
        if (i_reset) rst <= 0;
        else rst <= core_finish;
    end

    always @(posedge i_clk) begin
        if (i_reset) start <= 0;
        else start <= state_r ? (core_f) : (i_valid);
    end

    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) counter_r <= 3'b0;
        else if (core_rst) counter_r <= counter_w;
        else counter_r <= counter_r;
    end

    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) iteration_counter_r <= 3'b0;
        else if (&{counter_r, core_rst}) iteration_counter_r <= iteration_counter_w;
        else iteration_counter_r <= iteration_counter_r;
    end

    
    always @(posedge xc) begin
        if (r_r) begin
            x_r[7] <= i_x[31-:32];
            x_r[6] <= i_x[63-:32];
            x_r[5] <= i_x[95-:32];
            x_r[4] <= i_x[127-:32];
            x_r[3] <= i_x[159-:32];
            x_r[2] <= i_x[191-:32];
            x_r[1] <= i_x[223-:32];
            x_r[0] <= i_x[255-:32];
        end
        else begin
            x_r[0] <= x_w[0];
            x_r[1] <= x_w[1];
            x_r[2] <= x_w[2];
            x_r[3] <= x_w[3];
            x_r[4] <= x_w[4];
            x_r[5] <= x_w[5];
            x_r[6] <= x_w[6];
            x_r[7] <= x_w[7];
        end
    end

    
    always @(posedge oc or posedge i_reset) begin
        if (i_reset) begin
            o_x <= {i_x[0], i_x[1], i_x[2], i_x[3], i_x[4], i_x[5], i_x[6], i_x[7]};
        end
        else begin
            o_x <= {x_w[0], x_w[1], x_w[2], x_w[3], x_w[4], x_w[5], x_w[6], x_w[7]};
        end
    end

    always @(posedge i_clk) begin
        if (i_reset) begin
            o_valid <= 1'b0;
        end
        else if (finish) begin
            o_valid <= 1'b1;
        end
        else begin
            o_valid <= o_valid;
        end
    end

    always @(posedge i_clk) begin
        r_r <= i_reset;
    end
    
endmodule