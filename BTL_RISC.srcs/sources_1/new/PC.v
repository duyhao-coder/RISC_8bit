`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2025 09:00:34 PM
// Design Name: 
// Module Name: PC
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

module Program_Counter (
    input clk, reset, load,enable,
    input [4:0] pc_in,
    output reg [4:0] pc_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) pc_out <= 5'b00000;
        else if (load) pc_out <= pc_in;
        else if(enable)   pc_out <= pc_out + 1;
    end
endmodule

module ADD_phase(
input clk, reset,enable,
output reg [4:0] phase_out
);
    always @(posedge clk or posedge reset) begin
    if (reset) phase_out <= 5'b00000;
    else if(enable)   phase_out <= phase_out + 1;
end
endmodule
   
   