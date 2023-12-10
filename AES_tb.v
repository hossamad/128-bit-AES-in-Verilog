`timescale 1ns / 1ps


module AES_tb;

reg [127:0] in;
reg [127:0] key;
wire [127:0] out;




 AES DUT (.in(in), .key(key), .out(out));
 
 
 wire [127:0] expected_output = 128'h3925841d02dc09fbdc118597196a0b32;
 initial begin
 
 in=128'h_3243f6a8_885a308d_313198a2_e0370734;
key=128'h_2b7e1516_28aed2a6_abf71588_09cf4f3c;


$monitor("in128= %h, \n key128= %h ,\n out128= %h\n, expected_output= %h",in,key,out,expected_output);
#10;
if (expected_output == out ) $display( "==================the out and expected out are identical======================"); 
else $display( "===========the out and expected out are different !===================");

$finish(); 
 
 
 end

endmodule
