module multiplexor #(
   parameter Width = 5 // Address Parameter 
)
 ( 
     // Define Inputs
    input [Width-1:0] in0 , in1,
    input sel,
    output reg [Width-1:0] mux_out  // Define Output
);
    
always @(*) begin
    if (sel) begin
        mux_out=in1;
    end
    else begin
        mux_out=in0;
    end
end
endmodule