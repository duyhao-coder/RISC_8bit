`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2025 08:39:51 PM
// Design Name: 
// Module Name: controler
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


//module controler(
//    input  [2:0] opcode,phase,
//    input reset,clk,zero,
//    output reg sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,date_e
//    );
//    reg ALUOP,SKZ,JMP,STO,HALT;
//    always @(*) begin
//    if (opcode == 2 || opcode == 3 || opcode == 4 || opcode == 5) begin
//        ALUOP = 1;
//    end
////    else begin
////        ALUOP = 0;
////    end
//    if (opcode == 3'b001) 
//        SKZ = 1;
    
//    if (opcode == 3'b000) 
//        HALT = 1;
    
//    if (opcode == 3'b110) 
//        STO = 1;
                                                            
//    if (opcode == 3'b111) 
//        JMP = 1;
//    end
//    always @( *) begin
//    if(reset) begin
//    sel = 1;
//    rd = 0;
//    ld_ir = 0;
//    halt = 0;
//    inc_pc = 0;
//    ld_ac = 0;
//    ld_pc = 0;
//    wr = 0;
//    date_e = 0;
//    end else begin
//    case(phase)
//    3'b000: begin  // INST_ADDR
//        sel = 1; rd = 0; ld_ir = 0; halt = 0;
//        inc_pc = 0; ld_ac = 0; ld_pc = 0; wr = 0; date_e = 0;
//    end
//// Trong module controller, phase INST_FETCH (3'b001)
//    3'b001: begin  // INST_FETCH
//        sel = 1; rd = 1; ld_ir = 0; halt = 0;
//        inc_pc = 0; ld_ac = 0; ld_pc = 0; wr = 0; date_e = 0;
//    end
//    3'b010: begin  // INST_LOAD
//        sel = 1; rd = 1; ld_ir = 1; halt = 0;
//        inc_pc = 0; ld_ac = 0; ld_pc = 0; wr = 0; date_e = 0;
//    end
//    3'b011: begin  // IDLE
//        sel = 1; rd = 1; ld_ir = 1; halt = 0;
//        inc_pc = 0; ld_ac = 0; ld_pc = 0; wr = 0; date_e = 0;
//    end
//    3'b100: begin  // OP_ADDR
//        sel = 0; rd = 0; ld_ir = 0; halt = HALT;
//        inc_pc = 1; ld_ac = 0; ld_pc = 0; wr = 0; date_e = 0;
//    end
//    3'b101: begin  // OP_FETCH
//        sel = 0; rd = ALUOP; ld_ir = 0; halt = 0;
//        inc_pc = 0; ld_ac = 0;
//        ld_pc = 0; wr = 0; date_e = 0;
//    end
//    3'b110: begin  // ALU_OP
//        sel = 0; rd = ALUOP; ld_ir = 0; halt = 0;
//        inc_pc = SKZ&zero; ld_ac = 0; ld_pc = JMP;  // JUMP
//        wr = 0; date_e = STO;  // STORE
//    end
//    3'b111: begin  // STORE
//        sel = 0; rd = ALUOP; ld_ir = 0; halt = 0;
//        inc_pc = 0; ld_ac = ALUOP; ld_pc = JMP;
//        wr = STO; date_e = STO;
//    end  
//    default:  begin rd = 0; wr = 0; end

//    endcase
//    end
//    end
    
//endmodule
module controler (
    input wire [2:0] phase,opcode,
    input wire zero,reset, clk ,
    output reg sel , rd , ld_ir , inc_pc , halt , ld_ac , data_e , ld_pc , wr
);
    reg ALUOP , SKZ ,JMP , STO ,HALT;

always @(*)begin
    ALUOP = (opcode == 2) || (opcode == 3) || (opcode == 4) || (opcode == 5);
    SKZ = (opcode == 3'b001);
    HALT = (opcode == 3'b000);
    STO = (opcode == 3'b110);
    JMP = (opcode == 3'b111);

end


always@(*) begin
 if (reset) begin
     sel=1;rd=0;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0; 
     end   
case (phase)
3'b000: begin sel=1;rd=0;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0; end
3'b001: begin sel=1;rd=1;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;  end
3'b010 , 3'b011: begin sel=1;rd=1;ld_ir=1;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;  end
3'b100: begin sel=0;rd=0;ld_ir=0;inc_pc=1;halt=HALT;ld_pc=0;data_e=0;ld_ac=0;wr=0;  end
3'b101: begin sel=0;rd=ALUOP;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;  end
3'b110: begin sel=0;rd=ALUOP;ld_ir=0;inc_pc=SKZ&zero ;halt=0;ld_pc=JMP;data_e=STO;ld_ac=0;wr=0;  end
3'b111: begin sel=0;rd=ALUOP;ld_ir=0;inc_pc=0;halt=0;ld_pc=JMP;data_e=STO;ld_ac=ALUOP;wr=STO;  end
endcase

end



endmodule