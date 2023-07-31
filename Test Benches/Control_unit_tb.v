
module controller_tb;

    localparam op_width_tb =2;
    localparam Funct_width_tb=6;
    localparam Alu_control_width_tb=3;
    //reg   [op_width_tb-1:0]ALUOp_tb;
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
    reg [5:0]Opcode_tb        ;
    reg rst                   ;
    wire MemtoReg_tb          ;
    wire RegDst_tb            ;    
    wire lord_tb              ;
    wire PCSrc_tb             ;
    wire [1:0]ALUSrcB_tb      ;
    wire ALUSrcA_tb           ;
    wire IRWrite_tb           ;
    wire MemWrite_tb          ;
    wire PCWrite_tb           ;
    wire Branch_tb            ;
    wire RegWrite_tb          ;
    //wire [1:0]ALUOp_tb        ;

Control_unit cont(
     .Opcode(Opcode_tb)    ,
     .Funct (Funct_tb)    ,
     .rst (rst)           ,
     .clk (clk)           ,    
    . MemtoReg(MemtoReg_tb)       ,
    . RegDst(RegDst_tb)         ,    
    . lord(lord_tb)           ,
    . PCSrc(PCSrc_tb)          ,
    . ALUSrcB(ALUSrcB_tb)        ,
    . ALUSrcA(ALUSrcA_tb)        ,
    . IRWrite(IRWrite_tb)        ,
    . MemWrite(MemWrite_tb)       ,
    . PCWrite(PCWrite_tb)        ,
    . Branch(Branch_tb)         ,
    . RegWrite(RegWrite_tb)      ,
    . ALUControl(ALUControl_tb)
);    

/* Alu_control_unit #(
     .op_width(op_width_tb),
     .Funct_width(Funct_width_tb),
     .Alu_control_width(Alu_control_width_tb)
 ) control_unit(
    .ALUOp(ALUOp_tb),
    .Funct(Funct_tb),
    .ALUControl(ALUControl_tb)
);*/

task expect;
input [Alu_control_width_tb-1:0] exp;
    if (exp !== ALUControl_tb) begin
        $display("Time : %d ,    , Funct : %d , ALU Control : %d , expect : %d ",$time,Funct_tb,ALUControl_tb,exp);
        $display ("Test Failed");
        //$finish; 
    end
    else begin
        $display("Time : %d ,    , Funct : %d , ALU Control : %d , expect : %d ",$time,Funct_tb,ALUControl_tb,exp);
    end
endtask


initial begin
clk=0;
    forever begin
      clk=~clk; 
      #10;  
    end
end


/*initial begin
            @(negedge clk)
            expect(alu_add);
            #5;
            @(negedge clk)
            expect(alu_sub);
            #5;
            @(negedge clk)
            expect(alu_sub);
            #5;
            Funct_tb=Funct_ADD;
            @(negedge clk)
            expect(alu_add);
            #5;
            Funct_tb=Funct_SUB;
            @(negedge clk)
            expect(alu_sub);
            #5;         
            Funct_tb=Funct_AND;
            @(negedge clk)
            expect(alu_and);
            #5;  
            Funct_tb=Funct_OR;
            @(negedge clk)
            expect(alu_or);
            #5;            
            Funct_tb=Funct_SLT;
            @(negedge clk)
            expect(alu_slt);
            #5;            

end*/



/*main_decoder Control_tb 
( 
    .Opcode (Opcode_tb)   ,
    .clk (clk)           ,
    . rst(rst)            ,
    . MemtoReg(MemtoReg_tb)       ,
    . RegDst(RegDst_tb)         ,    
    . lord (lord_tb)         ,
    . PCSrc (PCSrc_tb)          ,
    . ALUSrcB (ALUSrcB_tb)   ,
    . ALUSrcA  (ALUSrcA_tb)        ,
    . IRWrite (IRWrite_tb)       ,
    . MemWrite (MemWrite_tb)      ,
    . PCWrite  (PCWrite_tb)      ,
    . Branch  (Branch_tb)       ,
    . RegWrite (RegWrite_tb)      ,
    . ALUOp(ALUOp_tb)
);
 */



/*initial begin
clk=0;
    forever begin
      clk=~clk; 
      #10;  
    end
end*/


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


// Fetch Test
task FETCH_expect;
 @(negedge clk) begin
                 if ( (lord_tb == 1'b0) && (ALUSrcA_tb == 1'b0) && (ALUSrcB_tb ==2'b01)  
                    && (PCSrc_tb == 1'b0) && (IRWrite_tb == 1'b1) && (PCWrite_tb == 1'b1) && (MemWrite_tb == 1'b0) && 
                    (Branch_tb == 1'b0) && (RegWrite_tb == 1'b0 )) begin
            $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b ,  RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",
                            $time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
endtask


// Decode Test
task DECODE_expect;
@(negedge clk) begin
                 if (ALUSrcA_tb == 1'b0 && ALUSrcB_tb ==2'b11   
                    && IRWrite_tb == 1'b0 && PCWrite_tb == 1'b0 && MemWrite_tb == 1'b0 && 
                    Branch_tb == 1'b0 && RegWrite_tb == 1'b0 ) begin
            $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",
                            $time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
endtask


// Execute Test
task EXECUTE_expect;
@(negedge clk) begin
                 if (ALUSrcA_tb == 1'b1 && ALUSrcB_tb ==2'b00   
                    && IRWrite_tb == 1'b0 && PCWrite_tb == 1'b0 && MemWrite_tb == 1'b0 && 
                    Branch_tb == 1'b0 && RegWrite_tb == 1'b0 ) begin
            $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",
                            $time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
endtask


// ALU_write_Back Test
task ALU_WB_expect;
@(negedge clk) begin
                 if (RegDst_tb == 1'b1 && MemtoReg_tb ==1'b0 
                    && IRWrite_tb == 1'b0 && PCWrite_tb == 1'b0 && MemWrite_tb == 1'b0 && 
                    Branch_tb == 1'b0 && RegWrite_tb == 1'b1 ) begin
            $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",
                            $time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
endtask


// Memory_ADDR Test
task Memory_ADDR_expect;
@(negedge clk) begin
                 if (ALUSrcA_tb == 1'b1 && ALUSrcB_tb ==2'b10   
                    && IRWrite_tb == 1'b0 && PCWrite_tb == 1'b0 && MemWrite_tb == 1'b0 && 
                    Branch_tb == 1'b0 && RegWrite_tb == 1'b0 ) begin
            $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",
                            $time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
endtask


  // MemWrite Stage 
  task MemWrite_expect;
         @(negedge clk) begin
                 if (lord_tb == 1'b1 
                    && IRWrite_tb == 1'b0 && PCWrite_tb == 1'b0 && MemWrite_tb == 1'b1 && 
                    Branch_tb == 1'b0 && RegWrite_tb == 1'b0 ) begin
            $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",
                            $time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
         endtask


     // MemRead Stage 
  task MemRead_expect; 

         @(negedge clk) begin
                 if (lord_tb == 1'b1 
                    && IRWrite_tb == 1'b0 && PCWrite_tb == 1'b0 && MemWrite_tb == 1'b0 && 
                    Branch_tb == 1'b0 && RegWrite_tb == 1'b0 ) begin
            $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",
                            $time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
        endtask


    task MemWrite_back_expect ;
     @(negedge clk) begin
                 if (RegDst_tb == 1'b0 && MemtoReg_tb == 1'b1 &&
                     IRWrite_tb == 1'b0 && PCWrite_tb == 1'b0 && MemWrite_tb == 1'b0 
                    && Branch_tb == 1'b0 && RegWrite_tb == 1'b1 ) begin
            $display("Time : %d , MemtoReg : %b ,  RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , "
            ,$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,
                           ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , "
                          ,$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
            endtask

    task BRANCH_expect;
            @(negedge clk) begin
                 if (ALUSrcA_tb == 1'b1 && ALUSrcB_tb ==2'b00   && PCSrc_tb == 1'b1 
                    && IRWrite_tb == 1'b0 && PCWrite_tb == 1'b0 && MemWrite_tb == 1'b0 && 
                    Branch_tb == 1'b1 && RegWrite_tb == 1'b0 ) begin
            $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",$time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                        end 
               else begin
                          $display("Time : %d , MemtoReg : %b , RegDst : %b ,  lord : %b , PCSrc_tb : %b , ALUSrcB_tb : %b , ALUSrcA_tb : %b , IRWrite_tb : %b , MemWrite_tb : %b , PCWrite_tb : %b , Branch_tb : %b , RegWrite_tb : %b ,   , ",
                            $time,MemtoReg_tb, RegDst_tb,lord_tb, PCSrc_tb,ALUSrcB_tb, ALUSrcA_tb,IRWrite_tb,MemWrite_tb,
                            PCWrite_tb,Branch_tb,RegWrite_tb  );
                            $display ("Test Failed");
                        end
         end
    endtask


initial begin

    //**********************************************************R type operation**********************************************************//
        Opcode_tb =RType;
        // Fetch Cycle 
        FETCH_expect();
        expect(alu_add);
         #5; // Delay
        // Decode Stage 
        DECODE_expect();
        expect(alu_add);
         #5;
        // execution State 
       EXECUTE_expect();
         #5;
         // Alu Write Back Stage
         ALU_WB_expect();
         #5;
    //**********************************************************Store operation**********************************************************//
        Opcode_tb =sw;
        // Fetch Cycle 
        FETCH_expect();
        #5; // Delay
        // Decode Stage
        DECODE_expect(); 
         #5;      
        // MemAdr Stage 
        Memory_ADDR_expect();
         #5; 
        // MemWrite Stage 
        MemWrite_expect();
         #5;
    //********************************************************** Load operation**********************************************************//
        Opcode_tb =lw;
        // Fetch Cycle 
         FETCH_expect();
         #5; // Delay
        // Decode Stage 
        DECODE_expect();
         #5;      
        // MemAdr Stage 
        Memory_ADDR_expect();
         #5; 
        // MemRead Stage 
        MemRead_expect();
         #5; 
        // Mem WriteBack Stage             
        MemWrite_back_expect();
         #5; 
    //**********************************************************BEQ operation**********************************************************//
        Opcode_tb =beq;
        // Fetch Cycle 
        FETCH_expect();
         #5; // Delay
        // Decode Stage 
        DECODE_expect();
         #5;      
        // Branch Stage 
        BRANCH_expect();
         #5;
    //**********************************************************Reset operation**********************************************************//
         rst=1;
         FETCH_expect();
end


endmodule