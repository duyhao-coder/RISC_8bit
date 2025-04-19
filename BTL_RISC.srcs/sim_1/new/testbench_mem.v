`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2025 10:02:25 AM
// Design Name: 
// Module Name: testbench_mem
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
    reg clk, reset, wr, rd;
    reg [4:0] addr;
    reg  [7:0] data;
    wire [7:0] data_connected;  // Dây k?t n?i th?c t?


    Memory_t memory (
        .clk(clk),
        .reset(reset),
        .wr(wr),
        .rd(rd),
        .addr(addr),
        .data(data_connected)  // K?t n?i v?i module Memory_t
    );
    assign data_connected = (wr) ? data : 8'bz;

    initial begin
        clk = 0;
        reset = 1;  // Kích ho?t reset
        wr = 0;
        rd = 0;
        addr = 0;
        #20 reset = 0;  // T?t reset sau 20ns

        // Test ??c l?nh t?i ??a ch? 0
        #10 rd = 1; addr = 0;
        #10 rd = 0;

        // Test ghi d? li?u vào ??a ch? 2
        #10 wr = 1; addr = 2; data = 8'b10101010;
        #10 wr = 0;

        // Test ??c d? li?u t? ??a ch? 2
        #10 rd = 1; addr = 2;
        #10 rd = 0;

        #100 $finish;
    end

    always #5 clk = ~clk;  // Chu k? clock 10ns
endmodule