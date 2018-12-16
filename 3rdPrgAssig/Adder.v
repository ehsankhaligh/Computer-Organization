// Ehsan Hosseinzadeh Khaligh
// Adder.v, 137 Verilog Programming Assignment #3
module TestMod; 
      parameter STDIN = 32'h8000_0000; // keyboard input

   reg [7:0] str [1:3]; // type in 3 chars (two decimal digits and Enter key)
   reg [4:0] X, Y;      // 5-bit X, Y
   wire C5;             // last carry
   wire [4:0] S;        //5-bit Sum to see as result

   BigAdder myadder(X, Y, S, C5);
      
    initial begin
      $display("Enter X (two digit 00~15 (since max is 01111): ");
      str[1] = $fgetc(STDIN); // ASCII # of 1st digit
      str[2] = $fgetc(STDIN); // ASCII # of 2nd digit
      str[3] = $fgetc(STDIN); // ENTER key
      X = (str[1] - 48) * 10 + str[2] - 48;

      $display("Enter Y (two digit 00~15 (since max is 01111): ");
      str[1] = $fgetc(STDIN); // ASCII # of 1st digit
      str[2] = $fgetc(STDIN); // ASCII # of 2nd digit
      str[3] = $fgetc(STDIN); // ENTER key
      Y = (str[1] - 48) * 10 + str[2] - 48;

      #1; // wait until add/sub done

      $display("X =%d (%b)  Y =%d (%b)", X, X, Y, Y);
      $display("Result =%d (%b)  C5 = %b", S, S, C5);
   end

endmodule

module BigAdder(X, Y, S, C5);
   input [4:0] X,Y;
   output [4:0] S;
   output C5;

   wire [0:5] C;
   assign C[0] = 0;   // 0 to do adding, 1 subtracting
   assign C5 = C[5];   // 0 to do adding, 1 subtracting

   FullAdderMod FA0( X[0], Y[0], C[0], S[0], C[1] ); // C0 is 0
   FullAdderMod FA1( X[1], Y[1], C[1], S[1], C[2] );
   FullAdderMod FA2( X[2], Y[2], C[2], S[2], C[3] );
   FullAdderMod FA3( X[3], Y[3], C[3], S[3], C[4] );
   FullAdderMod FA4( X[4], Y[4], C[4], S[4], C[5] );
     
endmodule

module FullAdderMod(X, Y, Cin, Sum ,Cout);
  input Cin, X, Y;
  output Cout, Sum;

  ParityMod my_parity(X, Y, Cin, Sum);
  MajorityMod my_majority(X, Y, Cin, Cout);
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

module ParityMod(Cin, X, Y, Sum);
   input Cin, X, Y;
   output Sum;

   wire xorXY;

   xor(xorXY, X, Y);
   xor(Sum, xorXY, Cin);
endmodule
