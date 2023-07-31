`default_nettype none
module memory_test;


localparam  bus=32;
localparam  data_w=32;
integer count;
reg clk ;
reg we_tb;
reg [bus-1:0]A_tb;
reg [bus-1:0]WD_tb;
wire [bus-1:0]RD_tb;


memory #(
// .BUS_WIDTH(bus),
// .DATA_WIDTH(data_w)
) memo( .WE(we_tb),
        .clk(clk),
        .A(A_tb),
        .WD(WD_tb),
        .RD(RD_tb)
);



initial begin
  clk=0;
  forever begin
      clk=~clk; #10;
  end

end

initial begin
  for ( count=0 ;count<=100 ;count=count+1 ) begin
    WD_tb=32'd200+count;
    we_tb=1;
    A_tb=count;
    @( negedge clk  )
     begin
      $display("RD_tb %d , WD_tb %d , A_tb " ,RD_tb,WD_tb,A_tb );
      we_tb=0;
      #3;
     end
        
  end
end



endmodule
