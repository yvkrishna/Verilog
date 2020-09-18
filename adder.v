// Code your design here
module Adder(A,B,Z,carry,zero,sign,parity,overflow);
  input [15:0]A,B;
  output [15:0] Z;
  output carry,zero,sign,parity,overflow;
  
  assign {carry,Z} = A+B;
  assign sign = Z[15];
  assign zero = ~|Z;
  assign parity = ~^Z;
  assign overflow = (X[15] & Y[15] & ~Z[15]) | (~X[15] & ~Y[15] & z[15]);
endmodule

// Code your testbench here
// or browse Examples
module AdderTest;
  reg [15:0]A,B;
  wire [15:0]Z;
  wire C,Zero,S,P,O;
  
  Adder Add(.A(A), .B(B), .Z(Z), .carry(C), .zero(Zero), .sign(S), .parity(P), .overflow(O));
  
  initial
    begin
      $dumpfile("adder.vcd"); $dumpvars(0,AdderTest);
      $monitor($time, " A = %h B = %h Z = %h carry = %b zero = %b sign = %b parity = %b overflow = %b",A,B,Z,C,Zero,S,P,O);
      
      #5 A = 16'h8fff; B = 16'h8000;
      #5 A = 16'hfffe; B = 16'h0002;
      #5 A = 16'hAAAA; B = 16'h5555;
      #5 $finish;
    end
endmodule
