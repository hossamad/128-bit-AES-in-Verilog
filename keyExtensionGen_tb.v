`timescale 1ns / 1ps

module keyExpansionGen_tb;


reg [0:127] initial_key;
reg clk, reset;
wire [0:( (10+1)*128 ) - 1] key_for_rounds;


keyExpansionGen DUT (.clk(clk), .reset(reset), 
.initial_key(initial_key), .key_for_rounds(key_for_rounds));
always 
begin
    clk = 1'b1; 
    #5; 

    clk = 1'b0;
    #5; 
end
wire [0:(11*128)-1] expected_output = 1408'h0f1571c947d9e8590cb7add6af7f6798dc9037b09b49dfe997fe723f388115a7d2c96bb74980b45ede7ec661e6ffd3c6c0afdf39892f6b675751ad06b1ae7ec02c5c65f1a5730e96f222a390438cdd50589d36ebfdee387d0fcc9bed4c4046bd71c74cc28c2974bf83e5ef52cfa5a9ef37149348bb3de7f738d808a5f77da14a48264520f31ba2d7cbc3aa723cbe0b38fd0d42cb0e16e01cc5d54a6ef96b4156b48ef352ba98134e7f4d592086261876;
initial begin

reset=1'b1;
#10;
reset=1'b0;
initial_key=128'h0f1571c947d9e8590cb7add6af7f6798;
#2000;
$monitor("w[0] =  %h ",key_for_rounds[0:31]);
$monitor("w[1] =  %h ",key_for_rounds[32:63]);
$monitor("w[2] =  %h ",key_for_rounds[64:95]);
$monitor("w[3] =  %h ",key_for_rounds[96:127]);
$monitor("w[4] =  %h ",key_for_rounds[128:159]);
$monitor("w[5] =  %h ",key_for_rounds[160:191]);
$monitor("w[6] =  %h ",key_for_rounds[192:223]);
$monitor("w[7] =  %h ",key_for_rounds[224:255]);
$monitor("w[8] =  %h ",key_for_rounds[256:287]);
$monitor("w[9] =  %h ",key_for_rounds[288:319]);
$monitor("w[10] =  %h ",key_for_rounds[320:351]);
$monitor("w[11] =  %h ",key_for_rounds[352:383]);
$monitor("w[12] =  %h ",key_for_rounds[384:415]);
$monitor("w[13] =  %h ",key_for_rounds[416:447]);
$monitor("w[14] =  %h ",key_for_rounds[448:479]);
$monitor("w[15] =  %h ",key_for_rounds[480:511]);
$monitor("w[16] =  %h ",key_for_rounds[512:543]);
$monitor("w[17] =  %h ",key_for_rounds[544:575]);
$monitor("w[18] =  %h ",key_for_rounds[576:607]);
$monitor("w[19] =  %h ",key_for_rounds[608:639]);
$monitor("w[20] =  %h ",key_for_rounds[640:671]);
$monitor("w[21] =  %h ",key_for_rounds[672:703]);
$monitor("w[22] =  %h ",key_for_rounds[704:735]);
$monitor("w[23] =  %h ",key_for_rounds[736:767]);
$monitor("w[24] =  %h ",key_for_rounds[768:799]);
$monitor("w[25] =  %h ",key_for_rounds[800:831]);
$monitor("w[26] =  %h ",key_for_rounds[832:863]);
$monitor("w[27] =  %h ",key_for_rounds[864:895]);
$monitor("w[28] =  %h ",key_for_rounds[896:927]);
$monitor("w[29] =  %h ",key_for_rounds[928:959]);
$monitor("w[30] =  %h ",key_for_rounds[960:991]);
$monitor("w[31] =  %h ",key_for_rounds[992:1023]);
$monitor("w[32] =  %h ",key_for_rounds[1024:1055]);
$monitor("w[33] =  %h ",key_for_rounds[1056:1087]);
$monitor("w[34] =  %h ",key_for_rounds[1088:1119]);
$monitor("w[35] =  %h ",key_for_rounds[1120:1151]);
$monitor("w[36] =  %h ",key_for_rounds[1152:1183]);
$monitor("w[37] =  %h ",key_for_rounds[1184:1215]);
$monitor("w[38] =  %h ",key_for_rounds[1216:1247]);
$monitor("w[39] =  %h ",key_for_rounds[1248:1279]);
$monitor("w[40] =  %h ",key_for_rounds[1280:1311]);
$monitor("w[41] =  %h ",key_for_rounds[1312:1343]);
$monitor("w[42] =  %h ",key_for_rounds[1344:1375]);
$monitor("w[43] =  %h ",key_for_rounds[1376:1407]);

#10;
if (expected_output == key_for_rounds ) $display( "==================the out and expected out are identical======================"); 
else $display( "===========the out and expected out are different !===================");

$finish(); 
 
 

end






endmodule
