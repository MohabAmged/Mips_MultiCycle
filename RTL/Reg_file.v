`default_nettype none
module Register_File #(
    parameter DEPTH =5,
    parameter DATA_WIDTH =32 
) (
    input  wire    WE3 ,            // Write Enable
    input  wire    clk ,            // Clock Pin 
    input  wire [DEPTH-1:0]A1,      // First Address Port
    input  wire [DEPTH-1:0]A2,      // 2nd Address Port
    input  wire [DEPTH-1:0]A3,      // Third Address Port
    input  wire [DATA_WIDTH-1:0]WD3,     // Write Data Port
    output wire [DATA_WIDTH-1:0]RD1,     // First Read Port
    output wire [DATA_WIDTH-1:0]RD2      // 2nd Read Port
);

// File Defination  
reg [DATA_WIDTH-1:0]file[2**DEPTH-1:0];

// Reading Data to RD1 Bus
assign RD1=file[A1];
// Reading Data to RD2 Bus
assign RD2=file[A2];

always @(posedge clk) begin
    if (WE3) begin
       // Writing the data into the reg file in the Address on the third bus 
        file[A3] <= WD3 ;     
    end
end
    
endmodule
