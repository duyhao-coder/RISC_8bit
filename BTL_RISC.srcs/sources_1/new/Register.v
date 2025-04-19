`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2025 07:08:17 PM
// Design Name: 
// Module Name: Register
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


module Register (
    input wire clk,            // clock
    input wire reset,          // synchronous reset, active high
    input wire load,           // load enable
    input wire [7:0] reg_in,   // input data
    output reg [7:0] reg_out   // output data (register content)
);

always @(posedge clk) begin
    if (reset) begin
        reg_out <= 8'b0;        // reset to 0
    end else if (load) begin
        reg_out <= reg_in;      // load input
    end
    // else gi? nguyên giá tr?, không c?n vi?t gì thêm
end

endmodule

