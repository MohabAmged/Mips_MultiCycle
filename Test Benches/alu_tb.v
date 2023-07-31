module ALU_tb ;


localparam opcode_width=3 ;
localparam Dwidth =32 ;
reg [Dwidth-1:0]data_a_tb;
reg [Dwidth-1:0]data_b_tb;
reg [opcode_width-1:0]opcode_tb;
wire [Dwidth-1:0]data_out_tb;
wire zero_tb;
reg clk;


alu #(
.DATA_WIDTH(Dwidth),
.ALUControl_WIDTH(opcode_width)
) alu1(
    .ALUControl(opcode_tb),
    .SrcA(data_a_tb),
    .SrcB(data_b_tb),
    .zero(zero_tb),
    .ALUResult(data_out_tb)
);


task expect;
input [Dwidth-1:0] exp;
    if (exp !== data_out_tb) begin
        $display("Time : %d , opcode : %d , opA : %d , opB : %d, data_out : %d  , expect : %d ",$time,opcode_tb,data_a_tb, data_b_tb,data_out_tb,exp);
        $display ("Test Failed");
        //$finish; 
    end
    else begin
        $display("Time : %d , opcode : %d , opA : %d , opB : %d, data_out : %d  , expect : %d ",$time,opcode_tb,data_a_tb, data_b_tb,data_out_tb,exp);
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
            opcode_tb=0;
            data_a_tb=100;
            data_b_tb=50;
            @(negedge clk)
            expect(data_a_tb&data_b_tb);
            #5;
            opcode_tb=1;
            data_a_tb=100;
            data_b_tb=50;
            @(negedge clk)
            expect(data_a_tb|data_b_tb);
            #5;
            opcode_tb=2;
            data_a_tb=100;
            data_b_tb=50;
            @(negedge clk)
            expect(data_a_tb+data_b_tb);
            #5;
             opcode_tb=6;
            data_a_tb=100;
            data_b_tb=100;
            @(negedge clk)
            expect(data_a_tb-data_b_tb);
            #5;
            opcode_tb=3;
            data_a_tb=100;
            data_b_tb=50;
            @(negedge clk)
            expect(data_a_tb+data_b_tb);
            #5;
            opcode_tb=6;
            data_a_tb=100;
            data_b_tb=50;
            @(negedge clk)
            expect(data_a_tb-data_b_tb);
            #5;
            opcode_tb=3'b111;
            data_a_tb=50;
            data_b_tb=70;
            @(negedge clk)
            expect('b1);
            #5;
            opcode_tb=3'b111;
            data_a_tb=50;
            data_b_tb=50;
            @(negedge clk)
            $display("ZERO flag : %b" , zero_tb);
            #5;
    
end





endmodule

