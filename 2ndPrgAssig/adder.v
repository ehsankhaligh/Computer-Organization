module ParityMod(Cin, X, Y, Sum);
   input Cin, X, Y;
   output Sum;

   wire xorXY;

   xor(xorXY, X, Y);
   xor(Sum, xorXY, Cin);
endmodule

module MajorityMod(Cin, X, Y, Cout);
   input Cin, X, Y;
   output Cout;

   wire [0:2] and_out;

   and(and_out[0], X, Y);
   and(and_out[1], X, Cin);
   and(and_out[2], Y, Cin);
   or(Cout, and_out[0], and_out[1], and_out[2]);
endmodule

module FullAdderInside(X, Y, Cin, Cout, Sum);

  input Cin, X, Y;
  output Cout, Sum;

  ParityMod my_parity(X, Y, Cin, Sum);
  MajorityMod my_majority(X, Y, Cin, Cout);
 
endmodule

module TestMod;
   reg Cin, X, Y;
   wire Cout, Sum;

   FullAdderInside my_adder(Cin, X, Y, Cout, Sum);

   initial begin
      $display("Time Cin X  Y Cout Sum");
      $display("------------------------------");
      $monitor("%3d   %b  %b %b   %b   %b", $time, Cin, X, Y, Cout, Sum);
   end

   initial begin
      Cin=0; X=0; Y=0; #1;
      Cin=0; X=0; Y=1; #1;
      Cin=0; X=1; Y=0; #1;
      Cin=0; X=1; Y=1; #1;
      Cin=1; X=0; Y=0; #1;
      Cin=1; X=0; Y=1; #1;
      Cin=1; X=1; Y=0; #1;
      Cin=1; X=1; Y=1; #1;
   end
endmodule 
