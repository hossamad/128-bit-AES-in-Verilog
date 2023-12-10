`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Description: 
// -                 -     -            -
// |b_0 b_4 b_8 b_12  |    | 03 02 01 01 |
// |b_1 b_5 b_9 b_13  |    | 01 02 03 01 |
// |b_2 b_6 b_10 b_14 | *  | 01 01 02 03 | = 4*4 matrix
// |b_3 b_7 b_11 b_15 |    | 03 01 01 02 |
// -                 -      -           -
  
// each element in the above 2 matrices are polynomial in 
//  finite field of 8 degree ( GF(2^8) ) with  bin coeffs (0or1)

// 03 = x + 1 and 02 = x

//irreducible polynomail in AES is X^8+X^4+X^3+X+1 = {01}{1b} in hex notation
// it use to maintain a result that fits in 8 bits

//For more illustration see this video:
//https://www.youtube.com/watch?v=dRYHSf5A4lw  
  
  //////////////////////////////////////////////////////////////////////////////////



module mixColumns(state_in,state_out);

input [127:0] state_in;
output[127:0] state_out;


function [7:0] mb2; //multiply by 2
	input [7:0] x;
	begin 
			/* multiplication by 2 is shifting on bit to the left, and if the original 8 bits had a 1 @ MSB,
			xor the result with {1b} (irreducible polynomail in AES) because if the MSB in the ip is 1 that means that 
			the multiplication result by 2 won't fit in 8 bit and we must use the irreducible polynomail.*/
			
			if(x[7] == 1) mb2 = ((x << 1) ^ 8'h1b);
			else mb2 = x << 1; 
	end 	
endfunction


/* 
	multiplication by 3 is done by:
		multiplication by {02} xor(the original x)
		so that 2+1=3. where xor is the addition of elements in finite fields
*/
function [7:0] mb3; //multiply by 3
	input [7:0] x;
	begin 
			
			mb3 = mb2(x) ^ x;
	end 
endfunction




genvar i;

generate 
for(i=0;i< 4;i=i+1) begin : m_col

	assign state_out[(i*32 + 24)+:8]= mb2(state_in[(i*32 + 24)+:8]) ^ mb3(state_in[(i*32 + 16)+:8]) ^ state_in[(i*32 + 8)+:8] ^ state_in[i*32+:8];
	assign state_out[(i*32 + 16)+:8]= state_in[(i*32 + 24)+:8] ^ mb2(state_in[(i*32 + 16)+:8]) ^ mb3(state_in[(i*32 + 8)+:8]) ^ state_in[i*32+:8];
	assign state_out[(i*32 + 8)+:8]= state_in[(i*32 + 24)+:8] ^ state_in[(i*32 + 16)+:8] ^ mb2(state_in[(i*32 + 8)+:8]) ^ mb3(state_in[i*32+:8]);
   assign state_out[i*32+:8]= mb3(state_in[(i*32 + 24)+:8]) ^ state_in[(i*32 + 16)+:8] ^ state_in[(i*32 + 8)+:8] ^ mb2(state_in[i*32+:8]);

end

endgenerate

endmodule
