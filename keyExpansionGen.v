`timescale 1ns / 1ps


module keyExpansionGen #(
parameter n_round = 10
)(
input [0:127] initial_key,
output [0:(n_round+1)*128-1] key_for_rounds
    );
    //re-arrenge bits in word terms
    wire [0:32-1] round_keys [0:44-1];


	assign round_keys[0] = initial_key[0*32 : (0+1)*32-1];
    assign round_keys[1] = initial_key[1*32 : (1+1)*32-1];
	assign round_keys[2] = initial_key[2*32 : (2+1)*32-1];
	assign round_keys[3] = initial_key[3*32 : (3+1)*32-1];
        
    //genrate n_round g functions
    wire [0:32-1] g_output_words [0:n_round-1];
    genvar i;
    generate 
        for (i=0; i<n_round; i=i+1) begin
            g  #(i+1,32) g_inst ( .in_word(round_keys[3+i*4]),
            .out_word(g_output_words[i]));
        
            //addition for the 1st word
		      word_addition first_word (.in_word1(g_output_words[i]),
		      .in_word2( round_keys[i*4]  ),
		      .out_word( round_keys[4+i*4]   ));  
            //addition for the 2nd word
		      word_addition second_word (.in_word1( round_keys[4+i*4] ),
		      .in_word2( round_keys[1+i*4]  ),
		      .out_word( round_keys[5+i*4]   )); 
            //addition for the 3rd word
		      word_addition third_word (.in_word1( round_keys[5+i*4]),
		      .in_word2( round_keys[2+i*4]  ),
		      .out_word( round_keys[6+i*4]   )); 
            //addition for the 4th word
		      word_addition fourth_word (.in_word1(round_keys[6+i*4]),
		      .in_word2( round_keys[3+i*4]  ),
		      .out_word( round_keys[7+i*4]   )); 		      		      		          
        end
    endgenerate
    
assign key_for_rounds[0: 31] = round_keys[0];
assign key_for_rounds[32: 63] = round_keys[1];
assign key_for_rounds[64: 95] = round_keys[2];
assign key_for_rounds[96: 127] = round_keys[3];
assign key_for_rounds[128: 159] = round_keys[4];
assign key_for_rounds[160: 191] = round_keys[5];
assign key_for_rounds[192: 223] = round_keys[6];
assign key_for_rounds[224: 255] = round_keys[7];
assign key_for_rounds[256: 287] = round_keys[8];
assign key_for_rounds[288: 319] = round_keys[9];
assign key_for_rounds[320: 351] = round_keys[10];
assign key_for_rounds[352: 383] = round_keys[11];
assign key_for_rounds[384: 415] = round_keys[12];
assign key_for_rounds[416: 447] = round_keys[13];
assign key_for_rounds[448: 479] = round_keys[14];
assign key_for_rounds[480: 511] = round_keys[15];
assign key_for_rounds[512: 543] = round_keys[16];
assign key_for_rounds[544: 575] = round_keys[17];
assign key_for_rounds[576: 607] = round_keys[18];
assign key_for_rounds[608: 639] = round_keys[19];
assign key_for_rounds[640: 671] = round_keys[20];
assign key_for_rounds[672: 703] = round_keys[21];
assign key_for_rounds[704: 735] = round_keys[22];
assign key_for_rounds[736: 767] = round_keys[23];
assign key_for_rounds[768: 799] = round_keys[24];
assign key_for_rounds[800: 831] = round_keys[25];
assign key_for_rounds[832: 863] = round_keys[26];
assign key_for_rounds[864: 895] = round_keys[27];
assign key_for_rounds[896: 927] = round_keys[28];
assign key_for_rounds[928: 959] = round_keys[29];
assign key_for_rounds[960: 991] = round_keys[30];
assign key_for_rounds[992: 1023] = round_keys[31];
assign key_for_rounds[1024: 1055] = round_keys[32];
assign key_for_rounds[1056: 1087] = round_keys[33];
assign key_for_rounds[1088: 1119] = round_keys[34];
assign key_for_rounds[1120: 1151] = round_keys[35];
assign key_for_rounds[1152: 1183] = round_keys[36];
assign key_for_rounds[1184: 1215] = round_keys[37];
assign key_for_rounds[1216: 1247] = round_keys[38];
assign key_for_rounds[1248: 1279] = round_keys[39];
assign key_for_rounds[1280: 1311] = round_keys[40];
assign key_for_rounds[1312: 1343] = round_keys[41];
assign key_for_rounds[1344: 1375] = round_keys[42];
assign key_for_rounds[1376: 1407] = round_keys[43];
   
endmodule

module g #( parameter [0:31] round_number = 0,
            parameter word = 32 )
( input [0:word-1] in_word,
output [0:word-1] out_word );

    //rotation
	wire [0: word-1] rotated_word;
    assign rotated_word = {in_word[8:31],in_word[0:7]};
	
	//subatitution	
	wire [0:word-1] subitiuted_word ;
	genvar i;
	generate
	for (i=0; i<4; i=i+1) begin
		sbox sbox_inst (.addr(rotated_word[ i*8 : i*8+7 ]),
		.dout(subitiuted_word[ i*8 : i*8+7]));
		
	end
	endgenerate
    
    
	function [0:31] rconx;
		input [0:4] r; 
		begin
			case(r)
				4'h1: rconx=32'h01000000;
				4'h2: rconx=32'h02000000;
				4'h3: rconx=32'h04000000;
				4'h4: rconx=32'h08000000;
				4'h5: rconx=32'h10000000;
				4'h6: rconx=32'h20000000;
				4'h7: rconx=32'h40000000;
				4'h8: rconx=32'h80000000;
				4'h9: rconx=32'h1b000000;
				4'ha: rconx=32'h36000000;
				default: rconx=32'h00000000;
			endcase
		end
	endfunction

    //addition
    wire [0:word-1] rconv = rconx (round_number);

    assign out_word = subitiuted_word ^ rconv ;
    
endmodule









module word_addition (
input [0:31] in_word1,
input [0:31] in_word2,
output [0:31] out_word );

assign out_word= in_word1 ^ in_word2;

endmodule