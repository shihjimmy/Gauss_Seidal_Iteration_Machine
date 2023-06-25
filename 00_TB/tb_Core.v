`timescale 1ns/10ps
`define CYCLE  10 
`define HCYCLE  5 
`define TIMEOUT  10000000
`define INPUT_PATH  "./PATTERN/input_Core.dat"
`define OUTPUT_PATH  "./PATTERN/golden_Core.dat"

`ifdef RTL
    `include "../verilog/01_RTL/Core.v"
`endif

module test;
    reg i_clk;
    reg i_reset;
    reg i_valid;
    reg [55:0] a;
    reg [7:0] b;
    reg [31:0] a_down;
    reg [223:0] x;
    wire o_valid;
    wire [31:0] x_next;

    reg [20:0] err;
    reg [20:0] count;
    reg finish;
    reg [31:0]  golden [0:6399];
    reg [223:0] matrix [0:25599];
    
    Core core(
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

    initial begin
        $fsdbDumpfile("Core.fsdb");
        $fsdbDumpvars(0,test,"+mda");
    end

    always #(`HCYCLE) begin
        i_clk = ~i_clk;
    end

    initial begin
        $readmemb(`INPUT_PATH,  matrix);
        $readmemb(`OUTPUT_PATH, golden);
        i_clk = 0;
        i_reset = 0;
        i_valid = 0;
        err = 0;
        count = 0;
        finish = 0;
        
        #(`HCYCLE * 0.5) i_reset = 1; i_valid = 0;
        #(`HCYCLE * 0.5) begin
            i_reset = 0; 
            i_valid = 1; 
            a = matrix[0][55:0];
            b = matrix[1][7:0];
            a_down = matrix[2][31:0];
            x = matrix[3];
            count = count + 1;
        end

        $display("--------------START SIMULATION--------------");
    end

    always@(posedge o_valid) begin
        if(golden[count-1] !== x_next) begin
            err = err + 1;
            $display("------------------------");
            $display("Your answer is wrong at %d, yours: %b, golden: %b",count, x_next, golden[count-1]);
            $display("------------------------");
        end
        else begin
            // $display("------------------------");
            // $display("Your answer is right at %d, yours: %b, golden: %b",count, x_next, golden[count-1]);
            // $display("------------------------");
        end

        #(`HCYCLE * 2.5) i_reset = 1; i_valid = 0;
        #(`HCYCLE * 0.5) begin
            i_reset = 0; 
            i_valid = 1; 
            a = matrix[count*4 + 0][55:0];
            b = matrix[count*4 + 1][7:0];
            a_down = matrix[count*4 + 2][31:0];
            x = matrix[count*4 + 3];
            count = count + 1;
        end
    end

    always@(*) begin
        if(count > 6400)      finish = 1;
        else                  finish = 0;
    end

    always @(posedge finish) begin
        if(!err) begin
            $display("------------------------");
            $display("You passed all testcases!!");
            $display("------------------------");
        end
        else begin
            $display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            $display("You failed!! You have %d errors",err);
            $display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        end
        $finish;
    end

    initial begin
        #(`TIMEOUT) 
        $display("Error! Runtime exceeded!"); 
        $finish;
    end

endmodule
