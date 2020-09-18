/* Design Code --------> */

// Code your design here
module Adder(A,B,Z,carry,zero,sign,parity,overflow);
  input [15:0]A,B;
  output [15:0] Z;
  output carry,zero,sign,parity,overflow;
  wire [3:0] carryWire;
  
  // assign {carry,Z} = A+B; // Behavioural Method
  
  // Structural method
  
  adder4bit A1(.x(A[3:0]), .y(B[3:0]), .cin(1'b0), .sum(Z[3:0]), .cout(carryWire[0]));
  adder4bit A2(.x(A[7:4]), .y(B[7:4]), .cin(carryWire[0]), .sum(Z[7:4]), .cout(carryWire[1]));
  adder4bit A3(.x(A[11:8]), .y(B[11:8]), .cin(carryWire[1]), .sum(Z[11:8]), .cout(carryWire[2]));
  adder4bit A4(.x(A[15:12]), .y(B[15:12]), .cin(carryWire[2]), .sum(Z[15:12]), .cout(carryWire[3]));
  
  assign carry = carryWire[3];
  
  assign sign = Z[15];
  assign zero = ~|Z;
  assign parity = ~^Z;
  assign overflow = (A[15] & B[15] & ~Z[15]) | (~A[15] & ~B[15] & Z[15]);
endmodule

module adder4bit(x,y,cin,sum,cout);
  input [3:0] x,y; input cin;
  output [3:0]sum; output cout;
  wire [3:0] carry_wire;
  
  // assign {cout,sum} = x+y+cin; // Behavioural Method
  
  // Structural method
  
  fulladder F1(.in1(x[0]), .in2(y[0]), .c_in(cin), .fs(sum[0]), .c_out(carry_wire[0]));
  fulladder F2(.in1(x[1]), .in2(y[1]), .c_in(carry_wire[0]), .fs(sum[1]), .c_out(carry_wire[1]));
  fulladder F3(.in1(x[2]), .in2(y[2]), .c_in(carry_wire[1]), .fs(sum[2]), .c_out(carry_wire[2]));
  fulladder F4(.in1(x[3]), .in2(y[3]), .c_in(carry_wire[2]), .fs(sum[3]), .c_out(carry_wire[3]));
  
  assign cout = carry_wire[3];
  
endmodule  

module fulladder(in1,in2,c_in,fs,c_out);
  input in1,in2,c_in;
  output fs,c_out;
  wire s1,c1,c2;
  
  xor G1(s1,in1,in2), G2(fs,s1,c_in), G3(c_out,c1,c2);
  and G4(c1,in1,in2), G5(c2,s1,c_in);
  
endmodule

/* Code For TestBench --------> */

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
