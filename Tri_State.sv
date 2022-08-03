module Tri_State #(parameter WORD_LENGTH = 8)
(
  output wire [WORD_LENGTH-1:0]Output,
  input  wire [WORD_LENGTH-1:0]Input,
  input  wire OE
);
                   //Diagram sketch run by negative logic
  assign Output = (~OE) ? Input: {WORD_LENGTH{1'bZ}};
endmodule                        //ZZConcat n Z , 
                                //depending on wordlength  