`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2025 09:18:48 PM
// Design Name: 
// Module Name: mux_add
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

 module Mux_Address  (
     input select,
     input [4:0] pc_in,
     input [4:0] operand_address,
     output reg [4:0] Mux_add_out
     
 );
     always @(*) begin
         if (select) begin

             Mux_add_out <= pc_in;
                      $display("Mux_Address | select = %b | pc_in = %b | operand_address = %b | Mux_add_out = %b", 
                      select, pc_in, operand_address, Mux_add_out);
         end
         else 
             Mux_add_out <= operand_address;
             
         
     end
 endmodule