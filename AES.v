module AES #(parameter Nr=10)(in,key,out);
input [127:0] in;
input [127:0] key;
output [127:0] out;
wire [(128*(Nr+1))-1 :0] fullkeys;
wire [127:0] states [Nr+1:0] ;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;


keyExpansionGen #(Nr) keyExpansionGen_i (.initial_key(key) , .key_for_rounds(fullkeys));


addRoundKey addrk1 (in,states[0],fullkeys[((128*(Nr+1))-1)-:128]);

genvar i;
generate
	
	for(i=1; i<Nr ;i=i+1)begin 
		encryptRound er(states[i-1],fullkeys[(((128*(Nr+1))-1)-128*i)-:128],states[i]);
		
		end
		subBytes sb(states[Nr-1],afterSubBytes);
		shiftRows sr(afterSubBytes,afterShiftRows);
		addRoundKey addrk2(afterShiftRows,states[Nr],fullkeys[127:0]);
			assign out=states[Nr];

endgenerate
endmodule