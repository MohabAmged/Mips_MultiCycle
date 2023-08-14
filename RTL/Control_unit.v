`default_nettype none
`include "main_decoder.v"
`include "Alu_control.v"
module Control_unit (
    input wire [5:0]Opcode    ,
    input wire [5:0]Funct     ,
    input wire rst            ,
    input wire clk            ,    
    output wire  MemtoReg       ,
    output wire  RegDst         ,    
    output wire  lord           ,
    output wire  PCSrc          ,
    output wire  [1:0]ALUSrcB   ,
    output wire  ALUSrcA        ,
    output wire  IRWrite        ,
    output wire  MemWrite       ,
    output wire  PCWrite        ,
    output wire  Branch         ,
    output wire  RegWrite       ,
    output wire  [2:0]ALUControl
    );


localparam  op_width =2;
localparam  Funct_width=6;
localparam  Alu_control_width=3;
wire  [1:0]ALUOp;

Alu_control_unit #(
     .op_width (op_width),
     .Funct_width(Funct_width),
     .Alu_control_width(Alu_control_width)
) ALu_Cont(
    .ALUOp(ALUOp),
    .Funct(Funct),
    .ALUControl(ALUControl)
);

main_decoder Controller
( 
    .Opcode (Opcode)   ,
    .clk (clk)           ,
    . rst(rst)            ,
    . MemtoReg(MemtoReg)       ,
    . RegDst(RegDst)         ,    
    . lord (lord)         ,
    . PCSrc (PCSrc)          ,
    . ALUSrcB (ALUSrcB)   ,
    . ALUSrcA  (ALUSrcA)        ,
    . IRWrite (IRWrite)       ,
    . MemWrite (MemWrite)      ,
    . PCWrite  (PCWrite)      ,
    . Branch  (Branch)       ,
    . RegWrite (RegWrite)      ,
    . ALUOp(ALUOp)
);

  /*  input wire [5:0]Opcode    ,
    input wire clk            ,
    input wire rst            ,
    output reg MemtoReg       ,
    output reg RegDst         ,    
    output reg lord           ,
    output reg PCSrc          ,
    output reg [1:0]ALUSrcB   ,
    output reg ALUSrcA        ,
    output reg IRWrite        ,
    output reg MemWrite       ,
    output reg PCWrite        ,
    output reg Branch         ,
    output reg RegWrite       ,
    output reg [1:0]ALUOp     ,
);
*/




endmodule




 
