//Ehsan Hosseinzadeh Khaligh
module DecoderMod(s,o);
   input [0:1] s;
   output [0:3] o;
   wire [0:1] s_inv;

   not(s_inv[1], s[1]);
   not(s_inv[0], s[0]);
   and(o[0], s_inv[1], s_inv[0]);
   and(o[1], s_inv[1], s[0]);
   and(o[2], s[1], s_inv[0]);
   and(o[3],s[1], s[0]);

endmodule

module MuxMod(s, d, o);
   input [0:1] s;
   input [0:3] d;
   output o;

   wire [0:3] s_decoded, and_out; //s_decoded is the wire goes out from the box

   DecoderMod my_decoder(s, s_decoded); 

   and(and_out[0], d[0], s_decoded[0]);
   and(and_out[1], d[1], s_decoded[1]);
   and(and_out[2], d[2], s_decoded[2]);
   and(and_out[3], d[3], s_decoded[3]);
   or(o, and_out[0], and_out[1], and_out[2], and_out[3]);

endmodule

module TestMod;
   reg [0:1] s;
   reg [0:3] d;
   wire o;

   MuxMod my_mux(s, d, o);

   initial begin
      $display("Time  s     d    o");
      $display("---------------------------------");
      $monitor("%04d  %b  %b  %b", $time, s, d, o);

      #63 $finish;

   //Remember to use loop to not copy many lines 
   //make sure to stop the loop before end #number $finish

   end

   always begin d[3]=0; #1; d[3]=1; #1; end
   always begin d[2]=0; #2; d[2]=1; #2; end
   always begin d[1]=0; #4; d[1]=1; #4; end
   always begin d[0]=0; #8; d[0]=1; #8; end
   always begin s[0]=0; #16; s[0]=1; #16; end
   always begin s[1]=0; #32; s[1]=1; #32; end

endmodule
