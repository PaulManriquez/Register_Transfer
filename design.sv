// Design of a file register transfer
// Programmer: Paul Manriquez
// Date: 12/07/22

`include  "Mux.sv"
`include  "Register.sv"
`include  "Tri_State.sv"
module FileRegister #(parameter WORD_LENGTH = 8) (
  //--------MUX_A-----------		
  input  wire [WORD_LENGTH-1:0]DA,
  input  wire Sel_A,
  //--------Register A ------
  input  wire clk,rst,enable,
  //--------Tri_State A------
  input  wire OE_A,
  
  //--------MUX_B-----------		
  input  wire [WORD_LENGTH-1:0]DB,
  input  wire Sel_B,
  //--------Register B ------
  //input  wire clk,rst,enable, Share this signals with Register A<<<<<<<<<<
  //--------Tri_State B------
  //input  wire OE_B = ~OE_A
);
  
  wire [WORD_LENGTH-1:0]BUS;//General Bus now it is only a simple wire
  
  //-----Left Part, A conection-----------------
  wire [WORD_LENGTH-1:0]Out_MuxU0;//Mux Output A
  Mux 		U0(Out_MuxU0,Sel_A,DA,BUS);
  
  wire [WORD_LENGTH-1:0]Out_RA;//Out Register A
  Register  U1(Out_RA,clk,rst,enable,Out_MuxU0);
 
  Tri_State U2(BUS,Out_RA,OE_A);
  //-----END Left Part, A conection-------------
  
  //-----Right Part, B conection-----------------
  wire [WORD_LENGTH-1:0]Out_MuxU3;//Mux Output B
  Mux 		U3(Out_MuxU3,Sel_B,DB,BUS);
  
  wire [WORD_LENGTH-1:0]Out_RB;//Out Register B
  Register  U4(Out_RB,clk,rst,enable,Out_MuxU3);
 
  Tri_State U5(BUS,Out_RB,~OE_A);//<<----
  						  //This enables to don't strike 
                         //the signals and commit an error
  //-----END right Part, B conection-------------
  
endmodule