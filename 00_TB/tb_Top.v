`timescale 1ns/10ps
`default_nettype wire
`define CYCLE    6.0
`define SDFFILE  "../CHIP.sdf"
`define TIMEOUT 10000000

`ifdef RTL
    `include "../verilog/RTL/Top.v"
    `include "../verilog/RTL/GSIM.v"
    `include "../verilog/RTL/iteration_cell.v"
    `include "../verilog/RTL/reciprocal.v"
    `include "../verilog/RTL/Core.v"
    `include "../verilog/RTL/IAS.v"
`endif

`ifdef SDF
    `include "../CHIP.v"
`endif


module Top_tb;
    reg clk;
    reg rst;
    reg mode;
    integer patterns, cnta, cntb, cntx, cntAT, cntm, cnt, i, j, counter;
    integer f_w;
    integer f_g;
    wire [32:0] x_temp [0:7];
    wire [32:0] x_golden [0:7];
    reg [511:0] a;
    reg [63:0] b;
    // real I_calc [0:7][0:7];
    // real I[0:7][0:7];
    reg [255:0] x_out;
    reg [2047:0] AT;
    real x_f [0:7];
    real AT_f [0:7][0:7];
    reg [255:0] gol_x;
    reg [2047:0] gol_AT;
    reg in_en;
    wire finish;
    reg [15:0] data_i;
    wire [7:0] data_o;
    reg [1:0] state_r;
    wire [1:0] state_w;
    
    CHIP TOP(
        .clk(clk),
        .reset(rst),
        .in_en(in_en),
        .mode(mode),
        .data_i(data_i),
        .out_valid(finish),
        .data_o(data_o)
    );

    assign x_temp[7] = x_out[31-:32];
    assign x_temp[6] = x_out[63-:32];
    assign x_temp[5] = x_out[95-:32];
    assign x_temp[4] = x_out[127-:32];
    assign x_temp[3] = x_out[159-:32];
    assign x_temp[2] = x_out[191-:32];
    assign x_temp[1] = x_out[223-:32];
    assign x_temp[0] = x_out[255-:32];

    assign x_golden[7] = gol_x[31-:32];
    assign x_golden[6] = gol_x[63-:32];
    assign x_golden[5] = gol_x[95-:32];
    assign x_golden[4] = gol_x[127-:32];
    assign x_golden[3] = gol_x[159-:32];
    assign x_golden[2] = gol_x[191-:32];
    assign x_golden[1] = gol_x[223-:32];
    assign x_golden[0] = gol_x[255-:32];

always #(`CYCLE/2) clk=~clk;

initial begin
    `ifdef SDF
        $sdf_annotate(`SDFFILE, TOP);
    `endif 
    $fsdbDumpfile("Top_tb.fsdb");
    $fsdbDumpvars(0, Top_tb, "+mda");
end

initial begin
    #(`TIMEOUT) $finish;
end

initial begin
    clk = 1'b1;
    rst = 1'b0;
    in_en = 1'b0;
    mode = 0;
    #(`CYCLE*0.5) rst = 1'b1;
    #(`CYCLE*5.0) rst = 1'b0;
    cnt = 0;
    

    
    if (~mode) begin
        patterns = $fopen("./PATTERN/GSIM.dat", "r");
        f_w = $fopen("./PATTERN/GSIM_ANS0.txt", "w");
        f_g = $fopen("./PATTERN/GSIM_GOL0.txt", "w");
        while (!$feof(patterns)) begin
            cnta = $fscanf(patterns, "%b", a);
            cntb = $fscanf(patterns, "%b", b);
            cntx = $fscanf(patterns, "%b", gol_x);
            cnt = cnt+1;
            in_en = 1'b1;
            counter = 0;
            while (counter<32) begin
                data_i = a[511-counter*16-:16];
                #(`CYCLE) counter = counter+1;
            end
            counter = 0;
            while (counter<4) begin
                data_i = b[63-counter*16-:16];
                #(`CYCLE) counter = counter+1;
            end
            counter = 0;
            in_en = 0;

            x_out = 0;

            wait(finish);
            @(negedge clk);
            while (finish) begin
                x_out = {x_out[247:0], data_o}; 
                #(`CYCLE);
            end
            for (i=0; i<8; i=i+1) begin
                $fwrite(f_w, "%b ", x_out[255-32*i-:32]);
                $fwrite(f_g, "%b ", gol_x[255-32*i-:32]);
            end
            $fwrite(f_w, "\n");
            $fwrite(f_g, "\n");
            @(posedge clk) #(`CYCLE/2) rst = 1'b1;
            #(`CYCLE) rst = 1'b0;
        end
    end
    else begin
        patterns = $fopen("./PATTERN/GSIM_inv.dat", "r");
        f_w = $fopen("./PATTERN/GSIM_ANS1.txt", "w");
        f_g = $fopen("./PATTERN/GSIM_GOL1.txt", "w");
        // for (i=0; i<8; i=i+1) begin
        //     for (j=0; j<8; j=j+1) begin
        //         if (i==j) I[i][j] = 1;
        //         else I[i][j] = 0;
        //     end
        // end
        while (!$feof(patterns)) begin
            cnta = $fscanf(patterns, "%b", a);
            cntAT = $fscanf(patterns, "%b", gol_AT);
            cnt = cnt+1;
            in_en = 1'b1;
            counter = 0;
            while (counter<32) begin
                data_i = a[511-counter*16-:16];
                #(`CYCLE) counter = counter+1;
            end
            counter = 0;
            in_en = 0;
            AT = 0;
            wait(finish);
            @(negedge clk);
            while (finish) begin
                AT = {AT[2040:0], data_o}; 
                #(`CYCLE);
            end
            for (i=0; i<64; i=i+1) begin
                $fwrite(f_w, "%b ", AT[2047-32*i-:32]);
                $fwrite(f_g, "%b ", gol_AT[2047-32*i-:32]);
            end
            $fwrite(f_w, "\n");
            $fwrite(f_g, "\n");
            @(posedge clk) #(`CYCLE/2) rst = 1'b1;
            #(`CYCLE) rst = 1'b0;
        end
    end
    #(`CYCLE*5)$finish;
    $fclose(patterns);
    $fclose(f_w);
    $fclose(f_g);
end

endmodule

