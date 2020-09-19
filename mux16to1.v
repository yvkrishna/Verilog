// Design  code
module mux16to1(in,sel,out);
  input [15:0] in;
  input [3:0] sel;
  output out;
  wire [3:0] mux4_out;
  
  // behavioural description
  // assign out = in[sel];
  
  // structutal description
  
  // 4 -> 1 MUX
  mux4to1 M1(.a(in[3:0]), .s(sel[1:0]), .out_func(mux4_out[0]));
  mux4to1 M2(.a(in[7:4]), .s(sel[1:0]), .out_func(mux4_out[1]));
  mux4to1 M3(.a(in[11:8]), .s(sel[1:0]), .out_func(mux4_out[2]));
  mux4to1 M4(.a(in[15:12]), .s(sel[1:0]), .out_func(mux4_out[3]));
  
  // 4 mux output to 5th mux
  mux4to1 M5(.a(mux4_out), .s(sel[3:2]), .out_func(out));
  
endmodule

module mux4to1(a,s,out_func);
  input [3:0]a;
  input [1:0]s;
  output out_func;
  wire [1:0] mux2_out;
  
  // behavioural description
  // assign out_func = a[s];
  
  // structural description
  // 2 -> 1 MUX
  mux2to1 M2_1_1(.inp(a[1:0]), .select_line(s[0]), .func(mux2_out[0]));
  mux2to1 M2_1_2(.inp(a[3:2]), .select_line(s[0]), .func(mux2_out[1]));
  
  // 2 mux output to 3td mux
  mux2to1 M2_1_3(.inp(mux2_out), .select_line(s[1]), .func(out_func));
  
endmodule

module mux2to1(inp,select_line,func);
  input [1:0]inp;
  input select_line;
  output func;
  wire [1:0] and_wires;
  // Structural behaviour
  and G1(and_wires[0],~select_line,inp[0]), G2(and_wires[1],select_line,inp[1]);
  or G3(func,and_wires[0],and_wires[1]);
  
endmodule

// Test Bench
// Code your testbench here
// or browse Examples
module MuxTest;
  reg [15:0] Data; reg [3:0] Select; wire F;
  
  mux16to1 MUX(.in(Data), .sel(Select), .out(F));
  
  initial
    begin
      $dumpfile("mux.vcd"); $dumpvars(0,MuxTest);
      $monitor($time, " Data = %h Select = %h Output = %b ",Data,Select,F);
      
      #5 Data = 16'h0f0f; Select =4'b0000;
      #5 Select =4'b0001;
      #5 Select =4'b0010;
      #5 Select =4'b0011;
      #5 Select =4'b0100;
      #5 Select =4'b0101;
      #5 Select =4'b1000;
      #5 $finish;
    end
endmodule
