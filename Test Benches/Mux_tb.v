module tb ();

parameter width_tb =5;
reg      [width_tb-1:0]a_tb;
reg      [width_tb-1:0]b_tb;
reg      sel_tb            ;
wire     [width_tb-1:0]out;



multiplexor dut 
# (.Width(width_tb))
(  
    .in0(a_tb) ,
    .in1(b_tb),
    .sel(sel_tb),
    .mux_out(out)
);


task expect; 







endtask



endmodule