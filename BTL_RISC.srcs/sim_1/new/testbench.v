`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 09:01:25 AM
// Design Name: 
// Module Name: testbench
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
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;

  reg clk;
  reg reset;

  // K?t n?i module chính
   RISC_CPU risc_inst(clk, reset);


  // T?o xung clock (chu k? 2ns)
  always #1 clk = ~clk;

  // Reset ??u mô ph?ng
  initial begin
    clk = 0;
    reset = 1;
    #4 reset = 0;
  end


  initial begin

    $monitor("time=%0t | PC=%0d ", $time, risc_inst.pc_addr);
//    $display("Time: %0t | HALT = %b", $time, halt);

  end

endmodule