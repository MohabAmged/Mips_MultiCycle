module Reg_tb;
    
      localparam DEPTH =5 ;
      localparam DATA_WIDTH =32 ;
      integer count=0;
      reg    WE3_tb ;            // Write Enable
      reg    clk_tb ;            // Clock Pin 
      reg  [DEPTH-1:0]A1_tb;      // First Address Port
      reg  [DEPTH-1:0]A2_tb;      // 2nd Address Port
      reg  [DEPTH-1:0]A3_tb;      // Third Address Port
      reg  [DEPTH-1:0]WD3_tb;     // Write Data Port
      wire [DEPTH-1:0]RD1_tb;     // First Read Port
      wire [DEPTH-1:0]RD2_tb;     // 2nd Read Port

Register_File #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
) file1(
             .    WE3(WE3_tb) ,            // Write Enable
             .    clk(clk_tb) ,            // Clock Pin 
             .    A1(A1_tb),      // First Address Port
             .    A2(A2_tb),      // 2nd Address Port
             .    A3(A3_tb),      // Third Address Port
             .    WD3(WD3_tb),     // Write Data Port
             .    RD1(RD1_tb),     // First Read Port
             .    RD2(RD2_tb)      // 2nd Read Port
);

initial begin
    clk_tb=0;
    forever begin
        clk_tb=~clk_tb; 
        #10;
    end
end

initial begin
    for ( count=0 ;count<=2**DEPTH-1;count=count+1 ) begin
        WE3_tb=1;
        A3_tb=count;
        WD3_tb=count*10;
        @(negedge clk_tb)
        WE3_tb=0;
        #2;
    end
       WE3_tb=0;
    for ( count=0 ;count<=15;count=count+1 ) begin
        A1_tb=count;
        A2_tb=31-count;
        @(negedge clk_tb)
        #2;
    end



end




endmodule