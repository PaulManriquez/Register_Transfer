// Code your testbench here
// or browse Enxamples
`timescale 1ns/1ps

module FileRegister_TB;
  parameter WORD_LENGTH_TB = 8;
  
  //------MuxA--------
  reg  [WORD_LENGTH_TB-1:0]DA;
  reg  Sel_A;
  
  //----Register A ---
  reg clk,rst,enable;
  //---TriState  A ---
  reg OE_A;
  
  //------MuxB--------
  reg  [WORD_LENGTH_TB-1:0]DB;
  reg  Sel_B;
  

  
  FileRegister DUT
  (.DA(DA),.Sel_A(Sel_A),/*<-MuxA*/
   .clk(clk),.rst(rst),.enable(enable),/*<-Register A*/
   .OE_A(OE_A),/*<-TriState*/
   .DB(DB),.Sel_B(Sel_B)
  );
  
  initial begin 
    $display("------Clk and reset starts------");
    clk=1'b0;//Initialize clk value
    rst=1'b0;#1;//Reset with negative logic
    rst=1'b1;#1;//Disable reset
    $display("Out_Bus:%b\tOutRegA:%b\tOutRegB:%b"
             ,DUT.BUS,DUT.Out_RA,DUT.Out_RB);//Reset Works
    $display("------------Start---------------");
    
    
    OE_A=1'b0;//Let pass the data in A section
    DA=2; DB=5; Sel_A=1'b0; Sel_B=1'b1;
    enable=1'b1;#2;
    $display("Bus:%b RegA:%b RegB:%b",
             DUT.BUS,DUT.Out_RA,DUT.Out_RB);#2;
    //Checking that transfer data from RA to RB is correct
    OE_A=1'b1;//Let pass the data  in B section
    Sel_A=1'b0; Sel_B=1'b1;
    enable=1'b1;#2;
    $display("Bus:%b RegA:%b RegB:%b\n",
             DUT.BUS,DUT.Out_RA,DUT.Out_RB);#2;
    
    //--------------------------------------------
    
    OE_A=1'b1;//Let pass the data  in B section
    Sel_A=1'b1; Sel_B=1'b0;//Sel_B let pass DB
    enable=1'b1;#2;
    $display("Bus:%b RegA:%b RegB:%b",
             DUT.BUS,DUT.Out_RA,DUT.Out_RB);#2;
    //Checking that transfer data from RB to RA is correct
    OE_A=1'b1;
    Sel_A=1'b1; Sel_B=1'b0;
    enable=1'b1;#2;
    $display("Bus:%b RegA:%b RegB:%b",
             DUT.BUS,DUT.Out_RA,DUT.Out_RB);#2;
    
   
    $finish;
  end
  
  always #1 clk= ~clk;
  
  initial begin 
    $dumpfile("FileRegister.vcd");
    $dumpvars(1,FileRegister_TB);
  end
endmodule