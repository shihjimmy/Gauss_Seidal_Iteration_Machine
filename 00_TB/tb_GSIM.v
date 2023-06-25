`timescale 1ns/10ps
`define CYCLE    25
`default_nettype wire

`ifdef RTL
    `include "../verilog/01_RTL/GSIM.v"
    `include "../verilog/01_RTL/iteration_cell.v"
    `include "../verilog/01_RTL/reciprocal.v"
    `include "../verilog/01_RTL/Core.v"
`endif

module GSIM_tb;
reg clk;
reg rst;
integer patterns, cnta, cntb, cntx, cnt, i;
reg [511:0] a;
reg [63:0] b;
wire [7:0] b_tmp [0:7];
real b_calc [0:7];
real square_error,error;
wire [255:0] x;
real x_f [0:7];
reg [255:0] gol_x;
reg start;
wire finish;

GSIM GSIM(
    .i_clk(clk),
    .i_reset(rst),
    .i_valid(start),
    .i_a(a),
    .i_b(b),
    .o_valid(finish),
    .o_x(x)
);

always #(`CYCLE/2) clk=~clk;

initial begin
    $fsdbDumpfile("GSIM_tb.fsdb");
    $fsdbDumpvars(0, GSIM_tb, "+mda");
end

`ifdef SDF
   initial $sdf_annotate(`SDFFILE, GSIM);
`endif

assign b_tmp[0] = b[63:56];
assign b_tmp[1] = b[55:48];
assign b_tmp[2] = b[47:40];
assign b_tmp[3] = b[39:32];
assign b_tmp[4] = b[31:24];
assign b_tmp[5] = b[23:16];
assign b_tmp[6] = b[15:8];
assign b_tmp[7] = b[7:0];


initial begin
    clk = 1'b1;
    rst = 1'b0;
    start = 1'b0;
    #(`CYCLE*0.5) rst = 1'b1;
    #(`CYCLE*2.0) rst = 1'b0;
    cnt = 0;

    patterns = $fopen("./PATTERN/GSIM.dat", "r");
    while (!$feof(patterns)) begin
        cnt = cnt+1;
        cnta = $fscanf(patterns, "%b", a);
        cntb = $fscanf(patterns, "%b", b);
        cntx = $fscanf(patterns, "%b", gol_x);
        square_error =  0;

        start = 1'b1;
        #(`CYCLE) start = 1'b0;

        wait(finish);

        x_f[0] = (x[255]) ? (~x[255:224] + 1'b1) : x[255:224]; x_f[0]= (x[255]) ? -x_f[0]/65536 : x_f[0]/65536;
        x_f[1] = (x[223]) ? (~x[223:192] + 1'b1) : x[223:192]; x_f[1]= (x[223]) ? -x_f[1]/65536 : x_f[1]/65536;
        x_f[2] = (x[191]) ? (~x[191:160] + 1'b1) : x[191:160]; x_f[2]= (x[191]) ? -x_f[2]/65536 : x_f[2]/65536;
        x_f[3] = (x[159]) ? (~x[159:128] + 1'b1) : x[159:128]; x_f[3]= (x[159]) ? -x_f[3]/65536 : x_f[3]/65536;
        x_f[4] = (x[127]) ? (~x[127:96] + 1'b1) : x[127:96]; x_f[4]= (x[127]) ? -x_f[4]/65536 : x_f[4]/65536;
        x_f[5] = (x[95]) ? (~x[95:64] + 1'b1) : x[95:64]; x_f[5]= (x[95]) ? -x_f[5]/65536 : x_f[5]/65536;
        x_f[6] = (x[63]) ? (~x[63:32] + 1'b1) : x[63:32]; x_f[6]= (x[63]) ? -x_f[6]/65536 : x_f[6]/65536;
        x_f[7] = (x[31]) ? (~x[31:0] + 1'b1) : x[31:0]; x_f[7]= (x[31]) ? -x_f[7]/65536 : x_f[7]/65536;

        b_calc[0] = (a[511:504]*x_f[0] + a[503:496]*x_f[1] + a[495:488]*x_f[2] + a[487:480]*x_f[3] + a[479:472]*x_f[4] + a[471:464]*x_f[5] + a[463:456]*x_f[6] + a[455:448]*x_f[7]);
        b_calc[1] = (a[447:440]*x_f[0] + a[439:432]*x_f[1] + a[431:424]*x_f[2] + a[423:416]*x_f[3] + a[415:408]*x_f[4] + a[407:400]*x_f[5] + a[399:392]*x_f[6] + a[391:384]*x_f[7]);
        b_calc[2] = (a[383:376]*x_f[0] + a[375:368]*x_f[1] + a[367:360]*x_f[2] + a[359:352]*x_f[3] + a[351:344]*x_f[4] + a[343:336]*x_f[5] + a[335:328]*x_f[6] + a[327:320]*x_f[7]);
        b_calc[3] = (a[319:312]*x_f[0] + a[311:304]*x_f[1] + a[303:296]*x_f[2] + a[295:288]*x_f[3] + a[287:280]*x_f[4] + a[279:272]*x_f[5] + a[271:264]*x_f[6] + a[263:256]*x_f[7]);
        b_calc[4] = (a[255:248]*x_f[0] + a[247:240]*x_f[1] + a[239:232]*x_f[2] + a[231:224]*x_f[3] + a[223:216]*x_f[4] + a[215:208]*x_f[5] + a[207:200]*x_f[6] + a[199:192]*x_f[7]);
        b_calc[5] = (a[191:184]*x_f[0] + a[183:176]*x_f[1] + a[175:168]*x_f[2] + a[167:160]*x_f[3] + a[159:152]*x_f[4] + a[151:144]*x_f[5] + a[143:136]*x_f[6] + a[135:128]*x_f[7]);
        b_calc[6] = (a[127:120]*x_f[0] + a[119:112]*x_f[1] + a[111:104]*x_f[2] + a[103:96] *x_f[3] + a[95:88] * x_f[4] + a[87:80] * x_f[5] + a[79:72] * x_f[6] + a[71:64] * x_f[7]);
        b_calc[7] = (a[63:56] * x_f[0] + a[55:48] * x_f[1] + a[47:40] * x_f[2] + a[39:32] * x_f[3] + a[31:24] * x_f[4] + a[23:16] * x_f[5] + a[15:8] *  x_f[6] + a[7:0]  *  x_f[7]);

        for (i=0;i<8;i=i+1) begin
            error = b_calc[i] - b_tmp[i];
            square_error = square_error + error*error;
        end
        $display("# %d square error: %f", cnt, square_error);
        @(posedge clk) #(`CYCLE/2) rst = 1'b1;
        #(`CYCLE) rst = 1'b0;
    end
    #(`CYCLE*5)$finish;
    $fclose(patterns);
end

endmodule

