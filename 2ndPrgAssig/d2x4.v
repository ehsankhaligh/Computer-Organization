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

module TestMod;
   reg [0:1] s;
   wire [0:3] o;

 DecoderMod my_decoder(s, o);

   initial begin
      $monitor("%0d\t%b\t%b",
      $time, s, o);
      $display("Time\ts\to"); 
     $display("----------------------");
   end

   initial begin
      s[1] = 0; s[0] = 0;
      #1;
      s[1] = 0; s[0] = 1;
      #1;
      s[1] = 1; s[0] = 0;
      #1;
      s[1] = 1; s[0] = 1;
   end
endmodule
