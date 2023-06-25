module Top (
    input clk,
    input reset,
    input in_en,
    input mode,
    input [15:0] data_i,
    output out_valid,
    output [7:0] data_o
);
    reg [1:0] state_w;
    reg  [1:0] state_r;
    wire [511:0] a;
    reg [511:0] a_r;
    wire [511:0] a_w;
    wire [63:0]  b;
    reg [63:0] b_r;
    wire [63:0] b_w;
    reg GSIM_rst;
    reg GSIM_start;
    wire finish;
    wire out_finish;
    wire GSIM_finish;
    wire [255:0] o_x;
    reg [1535:0] x_r;
    wire [5:0] counter_get_w;
    reg [5:0] counter_get_r;
    wire [6:0] counter_get_max;
    wire [2:0] counter_matrix_w;
    reg [2:0] counter_matrix_r;
    wire [63:0] I [0:7];

    wire [7:0] counter_out_w;
    reg [7:0] counter_out_r;
    reg o_r;
    // wire f;
    // wire ac;

    

    parameter S_IDLE = 2'd0;
    parameter S_GET  = 2'd1;
    parameter S_CALC = 2'd2;
    parameter S_OUT  = 2'd3;

    GSIM GSIM(
        .i_clk(clk),
        .i_reset((state_r==S_IDLE && reset) || (state_r!=S_IDLE && GSIM_rst)),
        .i_valid(GSIM_start),
        .i_a(a),
        .i_b(b),
        .o_valid(finish),
        .o_x(o_x)
    );  

    assign counter_get_max = (mode==0) ? 35 : 31;
    assign counter_get_w = counter_get_r+in_en;
    assign counter_out_w = (state_r == S_OUT) ? counter_out_r + 1'b1 : 0; //
    assign counter_matrix_w = (state_r == S_CALC && (finish)) ? counter_matrix_r+1 : counter_matrix_r;

    assign a = a_r;
    assign b = b_r;

    assign a_w = (in_en && counter_get_r < 32) ? {a_r[495:0], data_i} : a_r;
    // assign ac = (in_en && counter_get_r < 32 && ~clk);
    assign b_w = (mode == 0 && in_en && counter_get_r >= 31 && counter_get_r <36) ? {b_r[47:0], data_i} : ((mode == 1) ? I[counter_matrix_r] : b_r);
    // assign x_w = (mode == 1 && state_r == S_CALC && (finish&&~temp_r)) ? ({x_r[3583:0], o_x}) : (((finish^out_valid)&&mode == 0) ? {3584'b0, o_x} : ((state_r == S_OUT) ? x_r<<8 : x_r));
    // assign x_w = (state_r == S_OUT) ? (x_r<<8) : ((finish&&~temp_r) ? ({x_r[1791:0], o_x}) : (x_r));

    assign GSIM_finish = (mode == 0) ? finish : (&counter_matrix_r)&&finish;
    assign out_finish = (mode == 1 && counter_out_r==191) || (mode == 0 && counter_out_r == 23);//
    assign out_valid = (&state_r);//

    assign data_o = (mode == 0) ? (x_r[191-:8]) : (x_r[1535-:8]) ;
    // assign f = (finish||out_valid)&&clk;

    assign I[0] = {8'b1, 56'b0};
    assign I[1] = {8'b0, 8'b1, 48'b0};
    assign I[2] = {16'b0, 8'b1, 40'b0};
    assign I[3] = {24'b0, 8'b1, 32'b0};
    assign I[4] = {32'b0, 8'b1, 24'b0};
    assign I[5] = {40'b0, 8'b1, 16'b0};
    assign I[6] = {48'b0, 8'b1, 8'b0};
    assign I[7] = {56'b0, 8'b1};

    always @(*) begin
        case(state_r)
            S_IDLE: state_w = (in_en) ? S_GET : S_IDLE;
            S_GET:  state_w = (in_en) ? S_GET : S_CALC;
            S_CALC: state_w = (GSIM_finish) ? S_OUT : S_CALC;
            S_OUT:  state_w = (out_finish) ? S_IDLE : S_OUT;
            default: state_w = S_IDLE;
        endcase
    end

    always @(negedge clk) begin
        GSIM_rst <= reset || finish;
        GSIM_start <= (counter_get_r == counter_get_max) || (mode == 1 && state_r == S_CALC && GSIM_rst) || ~reset;
    end

    always @(posedge clk) begin
        if (reset) begin
            counter_get_r <= 0;
            counter_out_r <= 0;
            counter_matrix_r <= 0;
            state_r <= 0;
            a_r <= 0;
            b_r <= 0;
            // x_r <= 0;
            // GSIM_start_r <= 0;
            // GSIM_rst_r <= 0;
            o_r <= 0;
        end
        else begin
            counter_get_r <= counter_get_w;
            counter_out_r <= counter_out_w;
            counter_matrix_r <= counter_matrix_w;
            state_r <= state_w;
            a_r <= a_w;
            b_r <= b_w;
            // x_r <= x_w;
            // GSIM_start_r <= GSIM_start_w;
            // GSIM_rst_r <= GSIM_rst_w;
            o_r <= (state_r == S_OUT);
        end
    end

    // always @(negedge ac) begin
    //     a_r = {a_r[495:0], data_i};
    // end

    always @(negedge clk) begin
        if (out_valid) x_r <= x_r<<8;
        else if (finish)  x_r <= {x_r[1344:0], o_x[255-:24], o_x[223-:24], o_x[191-:24], o_x[159-:24], o_x[127-:24], o_x[95-:24], o_x[63-:24], o_x[31-:24]};
    end

endmodule
