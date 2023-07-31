module Alu_contorol ;


    localparam op_width_tb =2;
    localparam Funct_width_tb=6;
    localparam Alu_control_width_tb=3;
    reg   [op_width_tb-1:0]ALUOp_tb;
    reg   [Funct_width_tb-1:0]Funct_tb;
    wire  [Alu_control_width_tb-1:0]ALUControl_tb;
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
    reg clk;

 Alu_control_unit #(
     .op_width(op_width_tb),
     .Funct_width(Funct_width_tb),
     .Alu_control_width(Alu_control_width_tb)
 ) control_unit(
    .ALUOp(ALUOp_tb),
    .Funct(Funct_tb),
    .ALUControl(ALUControl_tb)
);

task expect;
input [Alu_control_width_tb-1:0] exp;
    if (exp !== ALUControl_tb) begin
        $display("Time : %d , ALUop : %d , Funct : %d , ALU Control : %d , expect : %d ",$time,ALUOp_tb,Funct_tb,ALUControl_tb,exp);
        $display ("Test Failed");
        //$finish; 
    end
    else begin
        $display("Time : %d , ALUop : %d , Funct : %d , ALU Control : %d , expect : %d ",$time,ALUOp_tb,Funct_tb,ALUControl_tb,exp);
    end
endtask


initial begin
clk=0;
    forever begin
      clk=~clk; 
      #10;  
    end
end


initial begin
            ALUOp_tb=00;
            @(negedge clk)
            expect(alu_add);
            #5;
            ALUOp_tb=01;
            @(negedge clk)
            expect(alu_sub);
            #5;
            ALUOp_tb=11;
            @(negedge clk)
            expect(alu_sub);
            #5;
            ALUOp_tb=10;
            Funct_tb=Funct_ADD;
            @(negedge clk)
            expect(alu_add);
            #5;
            ALUOp_tb=10;
            Funct_tb=Funct_SUB;
            @(negedge clk)
            expect(alu_sub);
            #5;         
            ALUOp_tb=10;
            Funct_tb=Funct_AND;
            @(negedge clk)
            expect(alu_and);
            #5;  
            ALUOp_tb=10;
            Funct_tb=Funct_OR;
            @(negedge clk)
            expect(alu_or);
            #5;            
            ALUOp_tb=10;
            Funct_tb=Funct_SLT;
            @(negedge clk)
            expect(alu_slt);
            #5;            

end

    
endmodule