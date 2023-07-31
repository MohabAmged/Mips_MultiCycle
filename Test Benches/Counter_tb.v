module Counter_tb;

localparam width =8 ;
reg [width-1:0]in_tb;
reg load_tb;
reg clk_tb;
reg rst_tb;
reg En_tb;
wire [width-1:0]out_tb;

Counter # (.WIDTH(width))
reg1 (
.data_in(in_tb),
.data_out(out_tb),
.clk(clk_tb),
.load(load_tb),
.rst(rst_tb),
.En(En_tb)
);
    

initial begin
    clk_tb=0;
    forever begin
          clk_tb= #10 ~clk_tb;  
    end
end


task expect;
input [width-1:0]exp;

if (out_tb !== exp) begin
    $display("Test Failed");
    $display("at time %d rst_tb %b load_tb %b out_tb %h in_tb %h " , $time ,rst_tb,load_tb,out_tb,in_tb );
    $display("Expected %b" ,exp );
    $finish;
end
else begin
        $display("at time %d rst_tb %b load_tb %b out_tb %h in_tb %h " , $time ,rst_tb,load_tb,out_tb,in_tb );
end
endtask

initial@(negedge clk_tb) begin
rst_tb=0;
En_tb=0;
in_tb=8'h55; 
load_tb=1;
@(negedge clk_tb) expect(8'h55);
rst_tb=0;
in_tb=8'h10; 
load_tb=1;
@(negedge clk_tb) expect(8'h10);
rst_tb=0;
in_tb=8'h70; 
load_tb=1;
@(negedge clk_tb) expect(8'h70);
in_tb=8'h60; 
load_tb=0;
rst_tb=1;
@(negedge clk_tb) expect(8'h0);


load_tb=0;
rst_tb=0;
En_tb=1;
@(negedge clk_tb) expect(8'h0+1);
En_tb=0;
#2;
load_tb=0;
rst_tb=0;
En_tb=1;
@(negedge clk_tb) expect(8'h0+2);



$finish;

end


endmodule
