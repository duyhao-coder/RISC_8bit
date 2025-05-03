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
// TEST   14
//mem[0]  = 8'b101_11000;  // LDA 24   : Load mem[24]=8'b011_1000 (1.5 * 2^0) to AC (AC=1.5)
//mem[1]  = 8'b010_11001;  // ADD 25   : Add mem[25]=8'b011_1000 (1.5 * 2^0), AC=1.5+1.5=3.0 (8'b100_1000)
//mem[2]  = 8'b110_11100;  // STO 28   : Store AC=8'b100_1000 to mem[28]
//mem[3]  = 8'b101_11010;  // LDA 26   : Load mem[26]=8'b100_1000 (1.5 * 2^1) to AC (AC=3.0)
//mem[4]  = 8'b010_11011;  // ADD 27   : Add mem[27]=8'b011_0100 (1.25 * 2^0), AC=3.0+1.25=4.25 (8'b101_0010)
//mem[5]  = 8'b110_11101;  // STO 29   : Store AC=8'b101_0010 to mem[29]
//mem[6]  = 8'b000_00000;  // HLT      : Halt program
//// Data (float8 format)
//mem[24] = 8'b011_1000;   // mem[24] = 1.1000 * 2^3 (exp=011=3, frac=1000=0.5, value=1.5 * 2^0)
//mem[25] = 8'b011_1000;   // mem[25] = 1.1000 * 2^3 (exp=011=3, frac=1000=0.5, value=1.5 * 2^0)
//mem[26] = 8'b100_1000;   // mem[26] = 1.1000 * 2^4 (exp=100=4, frac=1000=0.5, value=1.5 * 2^1=3.0)
//mem[27] = 8'b011_0100;   // mem[27] = 1.0100 * 2^3 (exp=011=3, frac=0100=0.25, value=1.25 * 2^0)
//mem[28] = 8'b000_0000;   // mem[28] = 0.0 (initially, will store result 3.0 = 8'b100_1000)
//mem[29] = 8'b000_0000;   // mem[29] = 0.0 (initially, will store result 4.25 = 8'b101_0010)


// TEST DEMO KHONG SIMULATION CAI NAY
//mem[0]  = 8'b101_01101;  // LDA 13   ? AC = 3
//mem[1]  = 8'b010_01110;  // ADD 14   ? AC = 3 + 4 = 7
//mem[2]  = 8'b100_01111;  // XOR 15   ? AC = 7 ^ 1 = 6
//mem[3]  = 8'b011_10000;  // AND 16   ? AC = 6 & 255 = 6
//mem[4]  = 8'b110_10001;  // STO 17   ? mem[17] = 6
//mem[5]  = 8'b101_10001;  // LDA 17   ? AC = 6
//mem[6]  = 8'b010_10010;  // ADD 18   ? AC = 6 + (-6) = 0
//mem[7]  = 8'b001_00000;  // SKZ      ? Skip n?u AC == 0 ? skip mem[8]
//mem[8]  = 8'b010_10011;  // ADD 19   ? b? qua n?u skip
//mem[9]  = 8'b101_10100;  // LDA 20   ? AC = 9
//mem[10] = 8'b111_00010;  // JMP 2    ? quay l?i XOR
//mem[11] = 8'b000_00000;  // HLT      ? không t?i n?u JMP l?p mãi
//mem[13] = 8'd3;      // mem[13] ? 3
//mem[14] = 8'd4;      // mem[14] ? 4
//mem[15] = 8'd1;      // mem[15] ? 1
//mem[16] = 8'd255;    // mem[16] ? 255
//mem[17] = 8'd0;      // mem[17] ? n?i l?u k?t qu? STO
//mem[18] = -8'd6;     // mem[18] ? -6 ?? c?ng ra 0 ? test SKZ
//mem[19] = 8'd20;     // mem[19] ? n?u không skip s? c?ng thêm
//mem[20] = 8'd9;      // mem[20] ? dùng sau ?? test vòng l?p LDA




//TEST       1 - >  18 tru test 14 ra 
mem[0]  = 8'b101_10111;  // LDA 23   : Load mem[23]=10 to AC (AC=10) [Test #2 LDA, #11 memory boundary]
mem[1]  = 8'b010_10110;  // ADD 22   : Add mem[22]=245 to AC (10+245=255) [Test #3 ADD, #10 overflow]
mem[2]  = 8'b010_10101;  // ADD 21   : Add mem[21]=1 to AC (255+1=0, wrap-around) [Test #3 ADD, #10 overflow]
mem[3]  = 8'b001_00000;  // SKZ      : Skip next if AC=0 (AC=0, skip mem[4]) [Test #8 SKZ with AC=0]
mem[4]  = 8'b101_10100;  // LDA 20   : Skipped (would load mem[20]=100) [Test #8 SKZ skip]
mem[5]  = 8'b011_10011;  // AND 19   : AND AC=0 with mem[19]=255 (0&255=0) [Test #5 AND]
mem[6]  = 8'b101_10010;  // LDA 18   : Load mem[18]=1 to AC (AC=1) [Test #2 LDA]
mem[7]  = 8'b001_00000;  // SKZ      : Skip next if AC=0 (AC=1, no skip) [Test #8 SKZ with AC!=0]
mem[8]  = 8'b100_10001;  // XOR 17   : XOR AC=1 with mem[17]=3 (1^3=2) [Test #5 XOR]
mem[9]  = 8'b110_10000;  // STO 16   : Store AC=2 to mem[16] (mem[16]=2) [Test #6 STO]
mem[10] = 8'b101_10000;  // LDA 16   : Load mem[16]=2 to AC (AC=2) [Test #2 LDA, verify STO]
mem[11] = 8'b111_00001;  // JMP 1    : Jump to mem[1] (loop once, then exit) [Test #7 JMP, #14 looping]
mem[12] = 8'b101_01111;  // LDA 15   : Load mem[15]=5 to AC (AC=5) [Test #2 LDA after loop]
mem[13] = 8'b000_00000;  // HLT      : Halt program [Test #9 HLT]
// Data
mem[15] = 8'd5;         // mem[15] = 5   : Data for LDA after loop
mem[16] = 8'd0;         // mem[16] = 0   : Initially 0, will store STO result
mem[17] = 8'd3;         // mem[17] = 3   : Data for XOR
mem[18] = 8'd1;         // mem[18] = 1   : Data for LDA to test SKZ with AC!=0
mem[19] = 8'd255;       // mem[19] = 255 : Data for AND
mem[20] = 8'd100;       // mem[20] = 100 : Data for skipped LDA
mem[21] = 8'd1;         // mem[21] = 1   : Data for ADD (causes overflow)
mem[22] = 8'd245;       // mem[22] = 245 : Data for ADD (near max)
mem[23] = 8'd10;        // mem[23] = 10  : Data for LDA, test memory boundary


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










