module Register #(parameter WORD_LENGTH = 8)(
// Output Ports
  output [WORD_LENGTH-1 : 0] Data_Output,
  
// Input Ports
	input clk,
	input rst,
	input enable,
	input [WORD_LENGTH-1 : 0] Data_Input
);

reg  [WORD_LENGTH-1 : 0] Data_reg;

  always@(posedge clk or negedge rst) begin
    if(rst == 1'b0) //Reset active on LOW
		Data_reg <= 0;
	else 
	if(enable == 1'b1)
	   Data_reg <= Data_Input;
end
  
assign Data_Output = Data_reg;  

endmodule