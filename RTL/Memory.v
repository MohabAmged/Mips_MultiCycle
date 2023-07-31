`default_nettype none
module memory #(
    parameter BUS_WIDTH=32,
    parameter DATA_WIDTH=8
) (
    input wire WE,
    input wire clk,
    input wire [BUS_WIDTH-1:0]A,
    input wire [BUS_WIDTH-1:0]WD,
    output wire [BUS_WIDTH-1:0]RD
);
reg [DATA_WIDTH-1:0] mem [2**16-1:0];

assign RD = {mem[A+3],mem[A+2],mem[A+1],mem[A]} ;

always @(posedge clk ) begin
    if (WE) begin
        {mem[A+3],mem[A+2],mem[A+1],mem[A]}=WD;
    end
end 
endmodule

