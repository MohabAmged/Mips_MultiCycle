`default_nettype none
`include "alu.v"
//`include "Alu_control.v"
`include "Control_unit.v"
`include "Counter.v"
//`include "main_decoder.v"
`include "Memory.v"
`include "mux.v"
`include "mux2x1.v"
`include "reg.v"
`include "Reg_file.v"
`include "sign_extend.v"
 


module MIPS  (
    input wire clk,
    input wire rst 
);

// Memory Parameters 
     localparam BUS_WIDTH=32;
     localparam DATA_WIDTH_MEM=8;
     wire MemWrite;
     wire [BUS_WIDTH-1:0]Adr;
     wire [BUS_WIDTH-1:0]MemoryRead_Data;

// Instruction Register Variables
 localparam  WIDTH = 32;
wire IRWrite ;
wire [WIDTH-1:0] Instr;
// Instruction Register Inst
Register #(
    .WIDTH(WIDTH)
) Instruction_Reg (
     .data_in(MemoryRead_Data),
     .load(IRWrite),
     .clk(clk),
     .rst(rst),
     .data_out(Instr)
);


// Data Register Variables
wire [WIDTH-1:0] Data;
// Data Register Inst
Register #(
    .WIDTH(WIDTH)
) DATA_Reg (
     .data_in(MemoryRead_Data),
     .load(1'b1),
     .clk(clk),
     .rst(rst),
     .data_out(Data)
);


// Read Register1 Variables
wire [WIDTH-1:0] A;
wire [WIDTH-1:0] RD1_out;
// Read Register1 Inst
Register #(
    .WIDTH(WIDTH)
) Read_Reg1 (
     .data_in(RD1_out),
     .load(1'b1),
     .clk(clk),
     .rst(rst),
     .data_out(A)
);


// Read Register2 Variables
wire [WIDTH-1:0] B;
wire [WIDTH-1:0] RD2_out;
// Read Register2 Inst
Register #(
    .WIDTH(WIDTH)
) Read_Reg2 (
     .data_in(RD2_out),
     .load(1'b1),
     .clk(clk),
     .rst(rst),
     .data_out(B)
);


// Register File Variables
 localparam  DEPTH = 5;
 localparam  DATA_WIDTH =32 ;
wire RegWrite;
wire [DEPTH-1:0]RegDest_out; 
wire [DATA_WIDTH-1:0]MemToReg_out; 
// Register File Inst
Register_File #(
    .DEPTH(DEPTH)
) Register_File1 (
     .WE3(RegWrite) ,            // Write Enable
     .clk(clk) ,        // Clock Pin 
     .A1(Instr[25:21]),      // First Address Port
     .A2(Instr[20:16]),      // 2nd Address Port
     .A3(RegDest_out),       // Third Address Port
     .WD3(MemToReg_out),     // Write Data Port
     .RD1(RD1_out),                 // First Read Port
     .RD2(RD2_out)                  // 2nd Read Port
);


// multiplexor A3 Variables
 localparam  mux_width=5;
wire RegDest;
// multiplexor A3 Inst
 multiplexor #(
   .Width(mux_width) // Address Parameter 
) 
 A3_Mux ( 
    .in0(Instr[20:16]),
    .in1(Instr[15:11]),
    .sel(RegDest),
    .mux_out(RegDest_out)  // Define Output
);


// multiplexor WD3_mux Variables
wire MemtoReg;
wire [BUS_WIDTH-1:0]ALUOut;
// multiplexor WD3_mux Inst
 multiplexor #(
   .Width(BUS_WIDTH) // Address Parameter 
)WD3_Mux
( 
    .in0(ALUOut),
    .in1(Data),
    .sel(MemtoReg),
    .mux_out(MemToReg_out)  // Define Output
);


// sign_extend Variables
 localparam  input_bus = 16 ;
 localparam  out_bus   = 32 ;
wire [out_bus-1:0]SignImm;
// sign_extend Inst
sign_extend #(
    .input_bus (input_bus),
    .output_bus(out_bus)
) sign_extend1(
    .immediate(Instr[15:0]) ,
    .SignImm(SignImm)
);
    

// multiplexor ALUSrcA Variables
wire [BUS_WIDTH-1:0]PC;
wire ALUSrcA;
wire [BUS_WIDTH-1:0]SrcA;
// multiplexor ALUSrcA Inst
 multiplexor #(
   .Width(BUS_WIDTH) // Address Parameter 
) ALUSrcA_mux
 ( 
    .in0(PC),
    .in1(A),
    .sel(ALUSrcA),
    .mux_out(SrcA)  // Define Output
);


// multiplexor ALUSrcB Variables
 localparam  Selection =2 ;
wire [Selection-1:0]ALUSrcB;
wire [BUS_WIDTH-1:0]SrcB;
// multiplexor ALUSrcB Inst
multiplexor4x1 #(
   .Width(BUS_WIDTH) // Address Parameter 
)
multiplexor4x1_inst ( 
     // Define Inputs
    .in0(B) ,
    .in1(32'd4),
    .in2(SignImm),
    .in3((SignImm<<2)),
    .sel(ALUSrcB),
    .mux_out(SrcB) // Define Output
);


// ALU Variables
 localparam  ALUControl_WIDTH =3;
wire [ALUControl_WIDTH-1:0]ALUControl;
wire zero ;
wire [BUS_WIDTH-1:0]ALUResult;
// ALU Inst
alu #(
     .DATA_WIDTH(BUS_WIDTH),
     .ALUControl_WIDTH(ALUControl_WIDTH)
) ALU1(
    .ALUControl(ALUControl),
    .SrcA(SrcA),
    .SrcB(SrcB),
    .zero(zero),
    .ALUResult(ALUResult)
);


// ALU Register Variables

// ALU Register Inst
Register #(
    .WIDTH(BUS_WIDTH)
) ALU_Register (
     .data_in(ALUResult),
     .load(1'b1),
     .clk(clk),
     .rst(rst),
     .data_out(ALUOut)
);


// multiplexor ALUout Variables
wire  PCSrc ;
wire  [BUS_WIDTH-1:0] PC1;
// multiplexor ALUout Inst
 multiplexor #(
   .Width(BUS_WIDTH) // Address Parameter 
) ALUout_mux
 ( 
    .in0(ALUResult),
    .in1(ALUOut),
    .sel(PCSrc),
    .mux_out(PC1)  // Define Output
);


// PC Register Variables
wire PCEn;
wire Branch;
wire PCWrite;
assign PCEn = PCWrite | (Branch & zero);
// PC Register Inst
Register #(
    .WIDTH(BUS_WIDTH)
) PC_Register (
     .data_in(PC1),
     .load(PCEn),
     .clk(clk),
     .rst(rst),
     .data_out(PC)
);


// multiplexor Memory Address Variables
wire lord;
// multiplexor Memory Address Inst
 multiplexor #(
   .Width(BUS_WIDTH) // Address Parameter 
) Memory_Address_mux
 ( 
    .in0(PC),
    .in1(ALUOut),
    .sel(lord),
    .mux_out(Adr)  // Define Output
);


// Control Unit Variables
    //wire [5:0]Funct;
// Control Unit Inst
Control_unit control(
     .Opcode(Instr[31:26])    ,
     .Funct (Instr[5:0])    ,
     .rst (rst)           ,
     .clk (clk)           ,    
    . MemtoReg(MemtoReg)       ,
    . RegDst(RegDest)         ,    
    . lord(lord)           ,
    . PCSrc(PCSrc)          ,
    . ALUSrcB(ALUSrcB)        ,
    . ALUSrcA(ALUSrcA)        ,
    . IRWrite(IRWrite)        ,
    . MemWrite(MemWrite)       ,
    . PCWrite(PCWrite)        ,
    . Branch(Branch)         ,
    . RegWrite(RegWrite)      ,
    . ALUControl(ALUControl)
);  

// Memory Inst
memory #(
        .BUS_WIDTH(BUS_WIDTH),
        .DATA_WIDTH(DATA_WIDTH_MEM)
)Instr_Data_Memory (
    .WE(MemWrite),
    .clk(clk),
    .A(Adr),
    .WD(B),
    .RD(MemoryRead_Data)
);


endmodule
