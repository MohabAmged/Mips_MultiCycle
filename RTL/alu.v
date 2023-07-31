`default_nettype none
module alu #(
    parameter DATA_WIDTH=32,
    parameter ALUControl_WIDTH=3
) (
    input wire [ALUControl_WIDTH-1:0]ALUControl,
    input wire [DATA_WIDTH-1:0]SrcA,
    input wire [DATA_WIDTH-1:0]SrcB,
    output wire zero,
    output reg [DATA_WIDTH-1:0]ALUResult

);

localparam alu_and = 3'b000 ;  
localparam alu_or  = 3'b001 ;
localparam alu_slt = 3'b111 ;
localparam alu_add = 3'b010 ;
localparam alu_sub = 3'b110 ;

assign zero = ALUResult?1'b0:1'b1;

always @(*) begin

case (ALUControl )
    alu_add  : ALUResult = SrcA + SrcB;
    alu_sub  : ALUResult = SrcA - SrcB;
    alu_and  : ALUResult = SrcA & SrcB; 
    alu_or   : ALUResult = SrcA | SrcB;
    alu_slt  : ALUResult = SrcA<SrcB?'b1:'b0;
    default  : ALUResult = SrcA + SrcB;     
endcase


end






endmodule