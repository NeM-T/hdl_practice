`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/14 16:01:50
// Design Name: 
// Module Name: sim_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
////////////////////////////////////////////////////////////


module sim_test();
logic clk, reset;
logic a, b, c, y, yexpected;
logic [31:0] vectornum, errors;
logic [3:0] testvectors[10000:0];

test dut(a, b, c, y);
always 
    begin
        clk = 1; #5; clk = 0; #5;
    end
    
initial
    begin 
        $display ("start test");
        $readmemb("./test.tv", testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #27; reset = 0;
    end
    
always @(posedge clk)
    begin
        #1; {a, b, c, yexpected} = testvectors[vectornum];
    end 

always @(negedge clk)
    if (~reset) begin
      if (y !== yexpected) begin
        $display("Error: inputs = %b", {a,b,c});
        $display("outputs = %b (%b expected)", y, yexpected);
        errors = errors + 1;
      end 
      vectornum = vectornum + 1;
      if (testvectors[vectornum] === 4'bx) begin
        $display("%d tests completed with %d errors", vectornum, errors);
        $finish ;
      end
    end
endmodule
