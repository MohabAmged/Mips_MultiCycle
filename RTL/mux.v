module multiplexor4x1 #(
   parameter Width = 5 // Address Parameter 
)
 ( 
     // Define Inputs
    input wire [Width-1:0] in0 , in1,in2,in3,
    input wire [1:0]sel,
    output reg [Width-1:0] mux_out  // Define Output
);
    
always @(*) begin
    case (sel)
       2'b00 :mux_out=in0;
       2'b01 :mux_out=in1;
       2'b10 :mux_out=in2;
       2'b11 :mux_out=in3;
        default:mux_out=in0;
    endcase
end
endmodule
