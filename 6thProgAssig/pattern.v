//Ehsan Hosseinzadeh
/*
 	Q6       Q5	Q4	Q3	Q2	Q1	Q0

1. E	1	0	0	0	1	0	1
2.H	1	0	0	1	0	0	0
3.S	1	0	1	0	0	1	1
4A	1	0	0	0	0	0	1
5.N	1	0	0	1	1	1	0
6.SP	0	1	0	0	0	0	0
7.H	1	0	0	1	0	0	0
8.O	1	0	0	1	1	1	1
9.S   1	0	1	0	0	1	1
10.S	1	0	1	0	0	1	1
11.E	1	0	0	0	1	0	1
12.I	1	0	0	1	0	0	1
13.N	1	0	0	1	1	1	0
14.Z	1	0	1	1	0	1	0
15.A	1	0	0	0	0	0	1
16.D	1	0	0	0	1	0	0

17.E   1	0	0	0	1	0	1
18.H   1	0	0	1	0	0	0

 */

module TestMod;

   reg CLK;
   wire [0 : 18] Q;
   wire [6 : 0] ascii;


   always begin
          CLK = 0;
          #0;
          CLK = 1;
          #1;

    end

   RippleMod my_ripple(CLK, Q);
   CoderMod my_coder(Q, ascii);

   initial #36 $finish;

   initial begin
      $display("Time CLK Q \t          Name  HEX Binary");
      $monitor ("%4d %3b %b  %2c %4x %2b",
               $time, CLK, Q, ascii, ascii, ascii);
   end
endmodule

module CoderMod(Q, ascii);
   input [0 : 18] Q;
   output [6 : 0] ascii;

   or(ascii[6], Q[1], Q[2], Q[3], Q[4], Q[5], Q[7], Q[8], Q[9], Q[10], Q[11], Q[12], Q[13], Q[14], Q[15], Q[16], Q[17], Q[18]);
   or(ascii[5], Q[6]);
   or(ascii[4], Q[3], Q[9], Q[10], Q[14]);
   or(ascii[3], Q[2], Q[5], Q[7], Q[8], Q[12], Q[13], Q[14], Q[18]);
   or(ascii[2], Q[1], Q[5], Q[8], Q[11], Q[13], Q[16], Q[17]);
   or(ascii[1], Q[3], Q[5], Q[8], Q[9], Q[10], Q[13], Q[14]);
   or(ascii[0], Q[0], Q[1], Q[3], Q[4], Q[8], Q[9], Q[10], Q[11], Q[12], Q[15], Q[17]);

endmodule

module RippleMod(CLK, Q);
   input CLK;
   output [0 : 18] Q;

   reg [0 : 18] Q;

   always @(negedge CLK) begin
      Q[0] <= Q[18];
      Q[1] <= Q[0];
      Q[2] <= Q[1];
      Q[3] <= Q[2];
      Q[4] <= Q[3];
      Q[5] <= Q[4];
      Q[6] <= Q[5];
      Q[7] <= Q[6];
      Q[8] <= Q[7];
      Q[9] <= Q[8];
      Q[10] <= Q[9];
      Q[11] <= Q[10];
      Q[12] <= Q[11];
      Q[13] <= Q[12];
      Q[14] <= Q[13];
      Q[15] <= Q[14];
      Q[16] <= Q[15];
      Q[17] <= Q[16];
      Q[18] <= Q[17];
   end

   initial begin
      Q = 19'b1000000000000000000;
   end
endmodule
