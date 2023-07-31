`default_nettype none
module main_decoder (
    input wire [5:0]Opcode    ,
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
    output reg [1:0]ALUOp
);

reg [3:0] STATE = 4'b0000 ;
reg [3:0] NEXT_STATE = 4'b0000 ;
 
// R type op code
localparam RType = 6'b000000;
// Immediate op code
localparam lw = 6'b100011;
localparam sw = 6'b101011;
// Branch op Code 
localparam beq = 6'b000100;
// Other Instructions
localparam addi = 6'b001000;
localparam j    = 6'b000010;

// Finite State Machine States
localparam FETCH_STATE          = 4'b0000 ;  
localparam DECODE_STATE         = 4'b0001 ;  
localparam MemAdr_STATE         = 4'b0010 ; 
localparam MemRead_STATE        = 4'b0011 ;
localparam MemWriteback_STATE   = 4'b0100 ;
localparam MemWrite_STATE       = 4'b0101 ;
localparam Execute_STATE        = 4'b0111 ;
localparam ALUWriteback_STATE   = 4'b1000 ;
localparam BRANCH_STATE         = 4'b1001 ;
localparam ADDI_Execute_STATE   = 4'b1010 ;
localparam ADDI_WriteBack_STATE = 4'b1011 ;
localparam JUMB_STATE           = 4'b1100 ;


// Sequential Block 
always @(posedge clk) begin
      if (rst) begin
        STATE <= FETCH_STATE;
      end  
      else begin
        STATE<= NEXT_STATE;
      end
end



// combinational Block
always @( STATE , Opcode , clk , rst ) begin
    
        case (STATE)
           FETCH_STATE :  begin
            NEXT_STATE  = DECODE_STATE;            
            lord        = 1'b0 ;
            ALUSrcA     = 1'b0 ;
            ALUSrcB     = 2'b01;
            ALUOp       = 2'b00;
            PCSrc       = 1'b0 ;
            IRWrite     = 1'b1 ;
            PCWrite     = 1'b1 ;
            MemWrite    = 1'b0 ;
            Branch      = 1'b0 ;
            RegWrite    = 1'b0 ;
           end
           DECODE_STATE :  begin
               if (Opcode == sw || Opcode == lw) begin
                NEXT_STATE = MemAdr_STATE;
                end   
                if ( Opcode == RType ) begin
                    NEXT_STATE = Execute_STATE;
                end
                if (Opcode == beq) begin
                    NEXT_STATE = BRANCH_STATE;
                end
                /*if (Opcode == addi) begin
                    NEXT_STATE = ADDI_Execute_STATE;
                end*/
                ALUSrcA  = 1'b0;
                ALUSrcB  = 2'b11;
                ALUOp    = 2'b00;
                IRWrite  = 1'b0;
                MemWrite = 1'b0;
                PCWrite  = 1'b0;
                Branch   = 1'b0;
                RegWrite = 1'b0;
           end 
           Execute_STATE :  begin
            NEXT_STATE = ALUWriteback_STATE;
            ALUSrcA  = 1'b1 ;
            ALUOp    = 2'b10;
            ALUSrcB  = 2'b00;
            IRWrite  =1'b0;
            MemWrite =1'b0;
            PCWrite  =1'b0;
            Branch   =1'b0;
            RegWrite =1'b0;             
           end            
           ALUWriteback_STATE :  begin
            NEXT_STATE = FETCH_STATE;
            RegDst   =1'b1;
            MemtoReg =1'b0;
            IRWrite  =1'b0;
            MemWrite =1'b0;
            PCWrite  =1'b0;
            Branch   =1'b0;
            RegWrite =1'b1;             
           end                 
           MemAdr_STATE :  begin
            if (Opcode == lw) begin
                NEXT_STATE = MemRead_STATE;
            end
            if (Opcode == sw) begin
                NEXT_STATE = MemWrite_STATE;
            end
            IRWrite  =1'b0;
            MemWrite =1'b0;
            PCWrite  =1'b0;
            Branch   =1'b0;
            RegWrite =1'b0;            
            ALUSrcA = 1'b1;
            ALUSrcB = 2'b10;
            ALUOp   = 2'b00;
           end 
           MemWrite_STATE :  begin
            NEXT_STATE = FETCH_STATE;
            lord=1;
            IRWrite  =1'b0;
            MemWrite =1'b1;
            PCWrite  =1'b0;
            Branch   =1'b0;
            RegWrite =1'b0;    
           end
           MemRead_STATE :  begin
            NEXT_STATE = MemWriteback_STATE;
            lord=1;
            IRWrite  =1'b0;
            MemWrite =1'b0;
            PCWrite  =1'b0;
            Branch   =1'b0;
            RegWrite =1'b0;                
           end 
           MemWriteback_STATE :  begin
            NEXT_STATE = FETCH_STATE;
            RegDst   =1'b0;
            MemtoReg =1'b1;
            IRWrite  =1'b0;
            MemWrite =1'b0;
            PCWrite  =1'b0;
            Branch   =1'b0;
            RegWrite =1'b1;              
           end 
           BRANCH_STATE :  begin
            NEXT_STATE = FETCH_STATE;
            ALUSrcA  = 1'b1;
            ALUSrcB  = 2'b00;
            ALUOp    = 2'b01;
            PCSrc    = 1'b1;
            IRWrite  = 1'b0;
            MemWrite = 1'b0;
            PCWrite  = 1'b0;
            Branch   = 1'b1;
            RegWrite = 1'b0;              
           end 
            default: NEXT_STATE = FETCH_STATE;
        endcase
end 












endmodule