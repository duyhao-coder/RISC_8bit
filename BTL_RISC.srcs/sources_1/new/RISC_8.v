`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2025 10:48:56 PM
// Design Name: 
// Module Name: RISC_8
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

module RISC_CPU(
    input wire clk, 
    input wire reset
);
    // Khai báo các tín hi?u k?t n?i
    wire [2:0] phase;
    wire [4:0] pc_addr;          // ??a ch? t? Program Counter
    wire [4:0] mux_address_out;  // ??u ra t? Address Mux
    wire [7:0] data_bus;         // Bus d? li?u
    wire [7:0] instruction;      // L?nh t? Memory
    wire [2:0] opcode;           // Opcode trích xu?t t? l?nh
    wire [4:0] operand;          // Toán h?ng t? l?nh
    wire [7:0] alu_out;          // K?t qu? t? ALU
    wire [7:0] ac_out;           // Giá tr? t? Accumulator
    wire is_zero;                // Tín hi?u zero t? ALU
    wire sel, rd, wr, ld_ir, halt, inc_pc, ld_ac, ld_pc, data_e,float_modee; // Tín hi?u ?i?u khi?n

    assign opcode = instruction[7:5];
    assign operand = instruction[4:0];

    Program_Counter pc (.clk(clk), .reset(reset), .load(ld_pc), .enable(inc_pc), .pc_in(operand), .pc_out(pc_addr));
    ADD_phase phases (.clk(clk), .reset(reset), .enable(1'b1), .phase_out(phase));
    Mux_Address addr_mux (.select(sel), .pc_in(pc_addr), .operand_address(operand), .Mux_add_out(mux_address_out));
    Memory_t memory (.clk(clk), .wr(wr), .rd(rd), .addr(mux_address_out), .data(data_bus),.float_mode(float_modee));
    Register ir (.clk(clk), .reset(reset), .load(ld_ir), .reg_in(data_bus), .reg_out(instruction));
    Register ac (.clk(clk), .reset(reset), .load(ld_ac), .reg_in(alu_out), .reg_out(ac_out));
    ALU alu (.inA(ac_out), .inB(data_bus), .opcode(opcode), .out_ALU(alu_out), .a_is_zero(is_zero),.float_mode(float_modee));
    controler ctrl (.phase(phase), .opcode(opcode), .zero(is_zero), .sel(sel), .data_e(data_e), .halt(halt), .inc_pc(inc_pc), .ld_pc(ld_pc), .ld_ac(ld_ac), .ld_ir(ld_ir), .wr(wr), .rd(rd));
    device_bus bus (.data_in(alu_out), .data_en(data_e), .data_outt(data_bus));
endmodule

