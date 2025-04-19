`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2025 07:07:29 PM
// Design Name: 
// Module Name: Memory_t
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


module Memory_t (
    input wire clk,
    input wire reset,
    input wire wr,
    input wire rd,
    input wire [4:0] addr,
    inout wire [7:0] data,  // Bus d? li?u hai chi?u
    output reg float_mode
);
    reg [7:0] mem [31:0];
    reg [7:0] mem_out;

          initial begin
// Ch??ng trình
// TEST11111111111111111111111111111111111111111111111
//          mem[0] = 8'b101_01010;  // LDA 10      (AC = 7)
//          mem[1] = 8'b010_01011;  // ADD 11      (AC = 7 + 5 = 12)
//          mem[2] = 8'b100_01100;  // XOR 12      (AC = 12 ^ 3 = 15)
//          mem[3] = 8'b011_01101;  // AND 13      (AC = 15 & 255 = 15)
//          mem[4] = 8'b001_00000;  // SKZ         (Không b? l?nh ti?p theo vì AC ? 0)
//          mem[5] = 8'b110_10100;  // STO 20      (mem[20] = 15)
//          mem[6] = 8'b111_01001;  // JMP 9       (nh?y t?i l?nh HLT)
//          mem[7] = 8'b110_10101;  // STO 21      (s? b? b? qua n?u JMP ?úng)
//          mem[8] = 8'b010_10101;  // ADD 21      (c?ng b? qua)
//          mem[9] = 8'b111_11000;  // HLT
          
//          // D? li?u
//          mem[10] = 8'd7;         // Cho LDA
//          mem[11] = 8'd5;         // Cho ADD
//          mem[12] = 8'd3;         // Cho XOR
//          mem[13] = 8'd255;       // Cho AND
//          mem[20] = 8'd0;         // Ch? l?u k?t qu? STO
//          mem[21] = 8'd0;         // Không b? ghi do JMP
//          mem[24] = 8'b010_11001;  // Float value: 9.0 (mem[25] ch?a giá tr? float)
//          mem[25] = 8'b01100010;  // Float value: 9.0 (mem[25] ch?a giá tr? float)
//          mem[26] = 8'b000_00000;  // Float value: 4.25 (mem[26] ch?a giá tr? float)
// L?u trong Memory_t kh?i `initial`
// === Test combo siêu l?n ===
// TEST22222222222222222222222222222222222222
mem[0]  = 8'b101_01101;  // LDA 13   ? AC = 3
mem[1]  = 8'b010_01110;  // ADD 14   ? AC = 3 + 4 = 7
mem[2]  = 8'b100_01111;  // XOR 15   ? AC = 7 ^ 1 = 6
mem[3]  = 8'b011_10000;  // AND 16   ? AC = 6 & 255 = 6
mem[4]  = 8'b110_10001;  // STO 17   ? mem[17] = 6
mem[5]  = 8'b101_10001;  // LDA 17   ? AC = 6
mem[6]  = 8'b010_10010;  // ADD 18   ? AC = 6 + (-6) = 0
mem[7]  = 8'b001_00000;  // SKZ      ? Skip n?u AC == 0 ? skip mem[8]
mem[8]  = 8'b010_10011;  // ADD 19   ? b? qua n?u skip
mem[9]  = 8'b101_10100;  // LDA 20   ? AC = 9
mem[10] = 8'b111_00010;  // JMP 2    ? quay l?i XOR
mem[11] = 8'b000_00000;  // HLT      ? không t?i n?u JMP l?p mãi
mem[13] = 8'd3;      // mem[13] ? 3
mem[14] = 8'd4;      // mem[14] ? 4
mem[15] = 8'd1;      // mem[15] ? 1
mem[16] = 8'd255;    // mem[16] ? 255
mem[17] = 8'd0;      // mem[17] ? n?i l?u k?t qu? STO
mem[18] = -8'd6;     // mem[18] ? -6 ?? c?ng ra 0 ? test SKZ
mem[19] = 8'd20;     // mem[19] ? n?u không skip s? c?ng thêm
mem[20] = 8'd9;      // mem[20] ? dùng sau ?? test vòng l?p LDA

//TEST333333333333333333333333333333333333333333333


// Ch??ng trình

      end    
      always @(posedge clk) begin
     if(addr>=24) begin
     float_mode=1;
     end else if(addr<24) begin
     float_mode=0;
     end

     if (wr && !rd) begin
        mem[addr] <= data;
    end
    else if (rd && !wr) begin
        mem_out <= mem[addr];
    end
end

assign data = (rd && !wr) ? mem_out : 8'bz;


endmodule
module device_bus (
    input wire [7:0] data_in,
    input wire data_en,
    output wire [7:0] data_outt
);
    assign data_outt = data_en ? data_in : 8'bz;
endmodule










//module Instruction_RAM (
//    input wire [4:0] addr,
//    output wire [7:0] instruction
//);
//    reg [7:0] rom [0:31];

//    initial begin
//        rom[0]  = 8'b101_01101;  // LDA 13
//        rom[1]  = 8'b010_01110;  // ADD 14
//        rom[2]  = 8'b100_01111;  // XOR 15
//        rom[3]  = 8'b011_10000;  // AND 16
//        rom[4]  = 8'b110_10001;  // STO 17
//        rom[5]  = 8'b101_10001;  // LDA 17
//        rom[6]  = 8'b010_10010;  // ADD 18
//        rom[7]  = 8'b001_00000;  // SKZ
//        rom[8]  = 8'b010_10011;  // ADD 19
//        rom[9]  = 8'b101_10100;  // LDA 20
//        rom[10] = 8'b111_00010;  // JMP 2
//        rom[11] = 8'b000_00000;  // HLT
//    end

//    assign instruction = rom[addr];
//endmodule
//module Data_RAM (
//    input wire clk,
//    input wire wr,
//    input wire rd,
//    input wire [4:0] addr,
//    inout wire [7:0] data,
//    output reg float_mode
//);
//    reg [7:0] mem [0:31];
//    reg [7:0] mem_out;

//    initial begin
//        mem[13] = 8'd3;
//        mem[14] = 8'd4;
//        mem[15] = 8'd1;
//        mem[16] = 8'd255;
//        mem[17] = 8'd0;
//        mem[18] = -8'd6;
//        mem[19] = 8'd20;
//        mem[20] = 8'd9;

//        // Float test
//        mem[24] = 8'b010_11001;
//        mem[25] = 8'b01100010;
//        mem[26] = 8'b000_00000;
//    end

//    // Xác ??nh vùng float
//    always @(*) begin
//        float_mode = (addr >= 24);
//    end

//    always @(posedge clk) begin
//        if (wr && !rd) mem[addr] <= data;
//        else if (rd && !wr) mem_out <= mem[addr];
//    end

//    assign data = (rd && !wr) ? mem_out : 8'bz;
//endmodule