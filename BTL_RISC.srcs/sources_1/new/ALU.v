`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2025 10:04:31 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
  input wire [7:0] inA,inB,
  input wire [2:0] opcode,
  input wire float_mode,  // tín hi?u ch?n ch? ?? float/integer
  output reg [7:0] out_ALU, 
  output reg a_is_zero
    );
function [7:0] float8_add;
      input [7:0] a, b;
      reg [2:0] exp_a, exp_b, result_exp;
      reg [4:0] frac_a, frac_b, frac_result; // 5 bit, ch?a bit ?n và 4 bit fraction
      reg carry;
      integer shift;
      reg round_bit;
      reg [4:0] shifted_frac;
      begin
          // Trích xu?t exponent và fraction (kèm bit ?n = 1)
          exp_a = a[6:4]; 
          frac_a = {1'b1, a[3:0]};
          exp_b = b[6:4]; 
          frac_b = {1'b1, b[3:0]};
    
          // C?n ch?nh exponent và làm tròn cho ph?n fraction th?p
          if (exp_a > exp_b) begin
              shift = exp_a - exp_b;
              // L?y bit guard: bit ngay sau khi d?ch (bit cu?i cùng m?t ?i khi d?ch)
              round_bit = frac_b >> (shift - 1); // vì shift >= 1 nên an toàn
              // Th?c hi?n d?ch ph?i
              shifted_frac = frac_b >> shift;
              // N?u bit guard = 1 thì làm tròn (c?ng thêm 1)
              if (round_bit)
                  frac_b = shifted_frac + 1;
              else
                  frac_b = shifted_frac;
              result_exp = exp_a;
          end else if (exp_b > exp_a) begin
              shift = exp_b - exp_a;
              round_bit = frac_a >> (shift - 1);
              shifted_frac = frac_a >> shift;
              if (round_bit)
                  frac_a = shifted_frac + 1;
              else
                  frac_a = shifted_frac;
              result_exp = exp_b;
          end else begin
              // N?u exponent b?ng nhau, không c?n c?n ch?nh
              result_exp = exp_a;
          end
    
          // C?ng ph?n fraction ?ã c?n ch?nh
          {carry, frac_result} = frac_a + frac_b;
    
          // Chu?n hóa n?u có bit carry
          if (carry) begin
              // ??y bit carry vào ph?n fraction (l?y 4 bit cao nh?t)
              frac_result = {carry, frac_result[4:1]};
              result_exp = result_exp + 1;
          end
    
          // Ghép l?i k?t qu? theo ??nh d?ng: 1 bit d?u, 3 bit exponent, 4 bit fraction
          float8_add = {1'b0, result_exp, frac_result[3:0]};
      end
    endfunction    
  always @(*) begin
  if (inA == 0)
      a_is_zero = 1 ;
      else
      a_is_zero = 0;
  case(opcode)
      3'b000: out_ALU = inA; //HLT
  3'b001: out_ALU = inA; //SKZ
  3'b010: out_ALU = float_mode ? float8_add(inA, inB) : inA + inB;
  3'b011: out_ALU = inA&inB;//AND
  3'b100: out_ALU = inA^inB;//XOR
  3'b101: out_ALU = inB;//LDA
  3'b110: out_ALU=inA; //STO
  3'b111: out_ALU=inA;//JMP
  endcase
  end
  
endmodule
