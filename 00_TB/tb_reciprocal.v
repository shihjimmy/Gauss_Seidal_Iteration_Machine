`timescale 1ns/10ps
`define CYCLE  10 
`define HCYCLE  5 
`define TIMEOUT  10000000000
`define INPUT_PATH  "./PATTERN/input_reciprocal.dat"
`define OUTPUT_PATH  "./PATTERN/golden_reciprocal.dat"

`ifdef RTL
    `include "../verilog/01_RTL/reciprocal.v"
`endif

module test;
    reg i_clk;
    reg i_reset;
    reg i_valid;
    reg [7:0] i_divisor;
    reg [7:0] i_divisor_array [0:399];
    wire o_valid;
    wire [31:0] o_quotient;

    reg [100:0] err;
    reg [100:0] count;
    reg finish;
    reg [31:0] golden [0:399];
    
    reciprocal div(
        i_clk,
        i_reset,
        i_valid,
        i_divisor,
        o_valid,
        o_quotient
    );

    initial begin
        $fsdbDumpfile("reciprocal.fsdb");
        $fsdbDumpvars(0,div,"+mda");
    end

    always #(`HCYCLE) begin
        i_clk = ~i_clk;
    end

    initial begin
        $readmemb(`INPUT_PATH, i_divisor_array);
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
            i_divisor = i_divisor_array[count];
            count = count + 1;
        end

        $display("--------------START SIMULATION--------------");
    end

    always@(posedge o_valid) begin
        if(golden[count-1] != o_quotient) begin
            err = err + 1;
            $display("------------------------");
            $display("Your answer is wrong at %d, yours: %b, golden: %b",count, o_quotient, golden[count-1]);
            $display("------------------------");
        end
        else begin
            $display("------------------------");
            $display("Your answer is right at %d, yours: %b, golden: %b",count, o_quotient, golden[count-1]);
            $display("------------------------");
        end

        #(`HCYCLE * 0.5) i_reset = 1; i_valid = 0;
        #(`HCYCLE * 0.5) begin
            i_reset = 0; 
            i_valid = 1; 
            i_divisor = i_divisor_array[count];
            count = count + 1;
        end
    end

    always@(*) begin
        if(count > 400)       finish = 1;
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
