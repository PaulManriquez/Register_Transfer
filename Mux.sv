module Mux
  #(parameter WORD_LENGTH = 8) //In this case we define of 8 bits
(
//Output Ports
  output [WORD_LENGTH-1 : 0]Out_Mux,//Last wire (Output) of the mux 

//Input Ports
  input Sel_A,/*Selector*/
  input [WORD_LENGTH-1 : 0]DA, /*Data*/
  input [WORD_LENGTH-1 : 0]BUS, /*Data*/
);

/*wire*/ reg [WORD_LENGTH-1 : 0]Mux_Output;

  always@(Sel_A, DA,BUS) begin
    if (Sel_A == 1'b0)
		Mux_Output = DA; //Blocking because it is a combinational logic 
	else 
		Mux_Output = BUS;
end 

assign Out_Mux = Mux_Output;

endmodule