`default_nettype none
module Alu_control_unit #(
    parameter op_width =2,
    parameter Funct_width=6,
    parameter Alu_control_width=3
) (
    input  wire [op_width-1:0]ALUOp,
    input  wire [Funct_width-1:0]Funct,
    output reg  [Alu_control_width-1:0]ALUControl
);

localparam alu_and = 3'b000 ;  
localparam alu_or  = 3'b001 ;
localparam alu_slt = 3'b111 ;
localparam alu_add = 3'b010 ;
localparam alu_sub = 3'b110 ;
localparam Funct_ADD =6'b100000 ;
localparam Funct_SUB =6'b100010 ;
localparam Funct_AND =6'b100100 ;
localparam Funct_OR  =6'b100101 ;
localparam Funct_SLT =6'b101010 ;

    always @(*) begin
        
        if (ALUOp==2'b00) begin
            ALUControl=alu_add;
        end
        else begin
            if (ALUOp[0]==1'b1) begin
                ALUControl=alu_sub;
            end
                else begin
                    case (Funct)
                            Funct_ADD :  ALUControl = alu_add;
                            Funct_SUB :  ALUControl = alu_sub;
                            Funct_AND :  ALUControl = alu_and;
                            Funct_OR  :  ALUControl = alu_or ;
                            Funct_SLT :  ALUControl = alu_slt;
                            default: ALUControl = alu_add;
                    
                    endcase
                end
        end
    end
endmodule