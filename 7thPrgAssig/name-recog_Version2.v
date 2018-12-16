//Ehsan Hosseinzadeh Khaligh
//6	5	4	3	2	1	0	 -	-
//———————————————————————————————————————————————————————————————
//1	0	0 	1	0	0	0	 H	q4
//1	1	0	1	1	1	1	 o	q3
//1	1	1 	0	0	1	1	 s	q2
//1	1	1 	0	0	1	1	 s	q1
//1	1	0 	0	1	0	1	 e	q0

module TestMod;
   parameter STDIN = 32'h8000_0000; // keyboard-input file-handle address

   reg clk;
   reg [6:0] str [1:6];  // to what's to be entered
   wire match;           // to be set 1 when matched
   reg [6:0] ascii;      // each input letter is an ASCII bitmap

   RecognizerMod my_recognizer(clk, ascii, match);

   initial begin
      $display("Enter the the magic sequence: Hosse ");
      str[1] = $fgetc(STDIN);  // 1st letter
      str[2] = $fgetc(STDIN);  // 2nd letter
      str[3] = $fgetc(STDIN);  // 3rd letter
      str[4] = $fgetc(STDIN);  // 4rd letter
      str[5] = $fgetc(STDIN);  // 5rd letter
      str[6] = $fgetc(STDIN);  // ENTER key

      $display("Time clk    ascii       match");
      $monitor("%4d   %b    %c %b   %b", $time, clk, ascii, ascii, match);

      clk = 0;

      ascii = str[1];
      #1 clk = 1; #1 clk = 0;

      ascii = str[2];
      #1 clk = 1; #1 clk = 0;

      ascii = str[3];
      #1 clk = 1; #1 clk = 0;

      ascii = str[4];
      #1 clk = 1; #1 clk = 0;
 
      ascii = str[5];
      #1 clk = 1; #1 clk = 0;

   end
endmodule

module RecognizerMod(clk, ascii, match);
   input clk;
   input [6:0] ascii;
   output match;

   wire [0:4] Q [0:6];   // 5-input sequence, 7 bits each
   wire [6:0] submatch;  // all bits matched (7 5-bit sequences)

   wire invQ54, invQ44, invQ43, invQ40, invQ32, invQ31, invQ30, invQ24, invQ22, invQ21, invQ14, invQ10, invQ04;


   RippleMod Ripple6(clk, ascii[6], Q[6]);
   RippleMod Ripple5(clk, ascii[5], Q[5]);
   RippleMod Ripple4(clk, ascii[4], Q[4]);
   RippleMod Ripple3(clk, ascii[3], Q[3]);
   RippleMod Ripple2(clk, ascii[2], Q[2]);  
   RippleMod Ripple1(clk, ascii[1], Q[1]);
   RippleMod Ripple0(clk, ascii[0], Q[0]);

   and(submatch[6], Q[6][4], Q[6][3], Q[6][2], Q[6][1], Q[6][0]);

   not(invQ54, Q[5][4]);
   and(submatch[5], invQ54, Q[5][3], Q[5][2], Q[5][1], Q[5][0]);

   not(invQ44, Q[4][4]);
   not(invQ43, Q[4][3]);
   not(invQ40, Q[4][0]);
   and(submatch[4], invQ44, invQ43, Q[4][2], Q[4][1], invQ40);

   not(invQ32, Q[3][2]);
   not(invQ31, Q[3][1]);
   not(invQ30, Q[3][0]);
   and(submatch[3], Q[3][4], Q[3][3], invQ32, invQ31, invQ30);

   not(invQ24, Q[2][4]);
   not(invQ22, Q[2][2]);
   not(invQ21, Q[2][1]);
   and(submatch[2], invQ24, Q[2][3], invQ22, invQ21, Q[2][0]);


   not(invQ14, Q[1][4]);
   not(invQ10, Q[1][0]);
   and(submatch[1], invQ14, Q[1][2], Q[1][2], Q[1][1], invQ10);


   not(invQ04, Q[0][4]);
   and(submatch[0], invQ04, Q[0][3], Q[0][2], Q[0][1], Q[0][0]);

   and(match, submatch[0], submatch[1], submatch[2], submatch[3], submatch[4], submatch[5], submatch[6]);


endmodule

module RippleMod(clk, ascii_bit, q);
   input clk, ascii_bit;
   output [0:4] q;

   reg [0:4] q;          // flipflops

   always @(posedge clk) begin
      q[0] <= ascii_bit;
      q[1] <= q[0];
      q[2] <= q[1];
      q[3] <= q[2];
      q[4] <= q[3];

   end

   initial q = 5'b00_000;
endmodule

