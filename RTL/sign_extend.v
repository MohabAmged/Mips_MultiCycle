`default_nettype none
module sign_extend #(
    parameter input_bus =16,
    parameter output_bus=32
) (
    input wire [input_bus-1:0]immediate ,
    output wire [output_bus-1:0]SignImm
);
    
    assign SignImm=immediate[input_bus-1]?{{(output_bus-input_bus){1'b1}},immediate}:{{(output_bus-input_bus){1'b0}},immediate};

endmodule