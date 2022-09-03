module fc3 (
	input [3:0] in [0:31],
	input clk,
	input rst,
	output [9:0] out
);

logic [9:0] weighted_sum [0:9];
logic [8:0] sharing0_r, sharing0_w;
logic [8:0] sharing1_r, sharing1_w;
logic [8:0] sharing2_r, sharing2_w;
logic [8:0] sharing3_r, sharing3_w;
logic [8:0] sharing4_r, sharing4_w;
logic [8:0] sharing5_r, sharing5_w;
logic [8:0] sharing6_r, sharing6_w;
logic [8:0] sharing7_r, sharing7_w;
logic [8:0] sharing8_r, sharing8_w;
logic [8:0] sharing9_r, sharing9_w;
logic [8:0] sharing10_r, sharing10_w;
logic [8:0] sharing11_r, sharing11_w;
logic [8:0] sharing12_r, sharing12_w;
logic [8:0] sharing13_r, sharing13_w;

always_comb begin
	sharing0_w = $signed({in[24],1'b0})+$signed(in[8])+$signed(in[16])+$signed(in[2])+$signed(in[3])+$signed(in[27])+$signed({in[5],1'b0})+$signed({in[22],1'b0})+$signed(in[30])+$signed(in[7])+$signed(-{in[0],2'b0})+$signed(-{in[27],2'b0});
	sharing1_w = $signed(-in[21])+$signed(-{in[29],1'b0})+$signed(-in[9]);
	sharing2_w = $signed({in[3],1'b0})+$signed({in[7],1'b0})+$signed(-{in[14],1'b0})+$signed(-{in[6],1'b0})+$signed(-in[5]);
	sharing3_w = $signed({in[17],1'b0})+$signed(-in[25])+$signed(-in[12])+$signed(-in[13])+$signed(-in[30])+$signed(-in[15]);
	sharing4_w = $signed({in[14],1'b0})+$signed({in[21],1'b0})+$signed(in[23])+$signed(-{in[24],1'b0})+$signed(-in[10])+$signed(-in[26])+$signed(-{in[13],1'b0})+$signed(-in[31]);
	sharing5_w = $signed(in[11])+$signed(-in[22])+$signed(-in[2]);
	sharing6_w = $signed({in[25],1'b0})+$signed(in[18])+$signed(in[28])+$signed(in[14])+$signed(in[15])+$signed(-{in[14],2'b0})+$signed(-{in[16],1'b0})+$signed(-{in[29],1'b0})+$signed(-in[21]);
	sharing7_w = $signed(in[1])+$signed(in[11])+$signed(in[7])+$signed(-in[24])+$signed(-in[20])+$signed(-in[19]);
	sharing8_w = $signed(in[17])+$signed(in[1])+$signed(-{in[28],1'b0})+$signed(-in[22])+$signed(-{in[23],2'b0});
	sharing9_w = $signed(in[8])+$signed(in[3])+$signed(-{in[16],1'b0})+$signed(-in[18])+$signed(-in[9])+$signed(-in[11]);
	sharing10_w = $signed({in[28],1'b0})+$signed(in[27])+$signed(in[17])+$signed(-{in[4],1'b0});
	sharing11_w = $signed(in[18])+$signed(in[29])+$signed(-{in[18],2'b0})+$signed(-{in[30],2'b0})+$signed(-in[31]);
	sharing12_w = $signed(-{in[4],1'b0})+$signed(-in[28])+$signed(-in[25]);
	sharing13_w = $signed(in[22])+$signed(in[19])+$signed(-{in[1],1'b0});
end

assign weighted_sum[0] = $signed(-{in[8],2'b0})+$signed(-in[17])+$signed(in[1])+$signed({in[26],1'b0})+$signed({in[11],1'b0})+$signed(-{in[7],2'b0})+$signed(-in[20])+$signed({in[6],1'b0})+$signed(-{in[15],2'b0})+$signed(in[15])+$signed(sharing0_r)+$signed(sharing1_r)+$signed(sharing12_r)+$signed(0);
assign weighted_sum[1] = $signed(-{in[0],1'b0})+$signed(in[7])+$signed({in[8],2'b0})+$signed(-{in[9],1'b0})+$signed(-{in[11],2'b0})+$signed(in[11])+$signed({in[16],1'b0})+$signed({in[18],1'b0})+$signed(-{in[20],2'b0})+$signed(in[20])+$signed(-{in[21],2'b0})+$signed(in[21])+$signed(-{in[22],2'b0})+$signed(in[23])+$signed(-{in[24],1'b0})+$signed(-{in[26],2'b0})+$signed(in[26])+$signed(-{in[27],2'b0})+$signed({in[29],2'b0})+$signed({in[31],2'b0})+$signed(sharing2_r)+$signed(sharing3_r)+$signed(sharing10_r)+$signed(sharing13_r)+$signed(3);
assign weighted_sum[2] = $signed(-{in[0],2'b0})+$signed({in[6],1'b0})+$signed({in[17],1'b0})+$signed(-in[9])+$signed(in[3])+$signed(-in[27])+$signed(-{in[5],2'b0})+$signed(-{in[29],1'b0})+$signed({in[30],1'b0})+$signed(-{in[15],1'b0})+$signed(sharing4_r)+$signed(sharing5_r)+$signed(-sharing12_r)+$signed(0);
assign weighted_sum[3] = $signed({in[8],1'b0})+$signed(in[0])+$signed({in[9],1'b0})+$signed(-{in[2],1'b0})+$signed(-in[26])+$signed({in[11],1'b0})+$signed(-{in[28],2'b0})+$signed(in[4])+$signed(-{in[13],1'b0})+$signed(-in[30])+$signed(-{in[23],2'b0})+$signed(in[23])+$signed(in[31])+$signed(sharing6_r)+$signed(sharing7_r)+$signed(-2);
assign weighted_sum[4] = $signed(-{in[8],1'b0})+$signed(in[0])+$signed({in[16],1'b0})+$signed(-{in[1],2'b0})+$signed({in[9],1'b0})+$signed(in[1])+$signed(-in[17])+$signed(-{in[25],1'b0})+$signed({in[18],1'b0})+$signed(-in[6])+$signed(-{in[12],2'b0})+$signed(in[12])+$signed(-in[5])+$signed(in[29])+$signed(in[30])+$signed(-{in[23],3'b0})+$signed({in[23],1'b0})+$signed(-in[7])+$signed(sharing4_r)+$signed(-sharing5_r)+$signed(0);
assign weighted_sum[5] = $signed(-in[16])+$signed(-in[8])+$signed(-{in[2],1'b0})+$signed(in[10])+$signed({in[26],1'b0})+$signed({in[11],1'b0})+$signed({in[20],1'b0})+$signed(in[4])+$signed(-in[28])+$signed(-{in[21],1'b0})+$signed({in[22],1'b0})+$signed(sharing2_r)+$signed(-sharing3_r)+$signed(sharing11_r)+$signed(0);
assign weighted_sum[6] = $signed(-{in[16],2'b0})+$signed(-{in[25],1'b0})+$signed(-in[10])+$signed(-{in[3],2'b0})+$signed(-{in[12],2'b0})+$signed(in[13])+$signed({in[14],1'b0})+$signed(-{in[15],1'b0})+$signed(-in[23])+$signed(sharing0_r)+$signed(-sharing1_r)+$signed(sharing11_r)+$signed(sharing13_r)+$signed(0);
assign weighted_sum[7] = $signed(-{in[24],2'b0})+$signed({in[0],1'b0})+$signed(-in[8])+$signed(-in[9])+$signed(-in[10])+$signed({in[27],1'b0})+$signed(-in[3])+$signed(in[12])+$signed(-{in[13],2'b0})+$signed({in[5],1'b0})+$signed(in[5])+$signed(in[13])+$signed({in[30],1'b0})+$signed(-in[22])+$signed(-{in[15],2'b0})+$signed(-{in[23],1'b0})+$signed(sharing6_r)+$signed(-sharing7_r)+$signed(sharing10_r)+$signed(1);
assign weighted_sum[8] = $signed({in[2],1'b0})+$signed(-in[10])+$signed({in[4],1'b0})+$signed(-in[12])+$signed(in[20])+$signed(-{in[5],1'b0})+$signed(in[29])+$signed(-{in[14],1'b0})+$signed(-in[30])+$signed({in[15],1'b0})+$signed(-in[7])+$signed(sharing8_r)+$signed(sharing9_r)+$signed(-2);
assign weighted_sum[9] = $signed({in[0],1'b0})+$signed(-{in[24],1'b0})+$signed(-{in[17],2'b0})+$signed(-{in[25],1'b0})+$signed(-in[2])+$signed(in[27])+$signed(-in[4])+$signed(-in[5])+$signed(-{in[7],1'b0})+$signed(in[13])+$signed(in[14])+$signed({in[31],1'b0})+$signed(sharing8_r)+$signed(-sharing9_r)+$signed(-1);
assign out[0] = ($signed(weighted_sum[0])>$signed(weighted_sum[1])) && ($signed(weighted_sum[0])>$signed(weighted_sum[2])) && ($signed(weighted_sum[0])>$signed(weighted_sum[3])) && ($signed(weighted_sum[0])>$signed(weighted_sum[4])) && ($signed(weighted_sum[0])>$signed(weighted_sum[5])) && ($signed(weighted_sum[0])>$signed(weighted_sum[6])) && ($signed(weighted_sum[0])>$signed(weighted_sum[7])) && ($signed(weighted_sum[0])>$signed(weighted_sum[8])) && ($signed(weighted_sum[0])>$signed(weighted_sum[9]));
assign out[1] = ($signed(weighted_sum[1])>$signed(weighted_sum[0])) && ($signed(weighted_sum[1])>$signed(weighted_sum[2])) && ($signed(weighted_sum[1])>$signed(weighted_sum[3])) && ($signed(weighted_sum[1])>$signed(weighted_sum[4])) && ($signed(weighted_sum[1])>$signed(weighted_sum[5])) && ($signed(weighted_sum[1])>$signed(weighted_sum[6])) && ($signed(weighted_sum[1])>$signed(weighted_sum[7])) && ($signed(weighted_sum[1])>$signed(weighted_sum[8])) && ($signed(weighted_sum[1])>$signed(weighted_sum[9]));
assign out[2] = ($signed(weighted_sum[2])>$signed(weighted_sum[0])) && ($signed(weighted_sum[2])>$signed(weighted_sum[1])) && ($signed(weighted_sum[2])>$signed(weighted_sum[3])) && ($signed(weighted_sum[2])>$signed(weighted_sum[4])) && ($signed(weighted_sum[2])>$signed(weighted_sum[5])) && ($signed(weighted_sum[2])>$signed(weighted_sum[6])) && ($signed(weighted_sum[2])>$signed(weighted_sum[7])) && ($signed(weighted_sum[2])>$signed(weighted_sum[8])) && ($signed(weighted_sum[2])>$signed(weighted_sum[9]));
assign out[3] = ($signed(weighted_sum[3])>$signed(weighted_sum[0])) && ($signed(weighted_sum[3])>$signed(weighted_sum[1])) && ($signed(weighted_sum[3])>$signed(weighted_sum[2])) && ($signed(weighted_sum[3])>$signed(weighted_sum[4])) && ($signed(weighted_sum[3])>$signed(weighted_sum[5])) && ($signed(weighted_sum[3])>$signed(weighted_sum[6])) && ($signed(weighted_sum[3])>$signed(weighted_sum[7])) && ($signed(weighted_sum[3])>$signed(weighted_sum[8])) && ($signed(weighted_sum[3])>$signed(weighted_sum[9]));
assign out[4] = ($signed(weighted_sum[4])>$signed(weighted_sum[0])) && ($signed(weighted_sum[4])>$signed(weighted_sum[1])) && ($signed(weighted_sum[4])>$signed(weighted_sum[2])) && ($signed(weighted_sum[4])>$signed(weighted_sum[3])) && ($signed(weighted_sum[4])>$signed(weighted_sum[5])) && ($signed(weighted_sum[4])>$signed(weighted_sum[6])) && ($signed(weighted_sum[4])>$signed(weighted_sum[7])) && ($signed(weighted_sum[4])>$signed(weighted_sum[8])) && ($signed(weighted_sum[4])>$signed(weighted_sum[9]));
assign out[5] = ($signed(weighted_sum[5])>$signed(weighted_sum[0])) && ($signed(weighted_sum[5])>$signed(weighted_sum[1])) && ($signed(weighted_sum[5])>$signed(weighted_sum[2])) && ($signed(weighted_sum[5])>$signed(weighted_sum[3])) && ($signed(weighted_sum[5])>$signed(weighted_sum[4])) && ($signed(weighted_sum[5])>$signed(weighted_sum[6])) && ($signed(weighted_sum[5])>$signed(weighted_sum[7])) && ($signed(weighted_sum[5])>$signed(weighted_sum[8])) && ($signed(weighted_sum[5])>$signed(weighted_sum[9]));
assign out[6] = ($signed(weighted_sum[6])>$signed(weighted_sum[0])) && ($signed(weighted_sum[6])>$signed(weighted_sum[1])) && ($signed(weighted_sum[6])>$signed(weighted_sum[2])) && ($signed(weighted_sum[6])>$signed(weighted_sum[3])) && ($signed(weighted_sum[6])>$signed(weighted_sum[4])) && ($signed(weighted_sum[6])>$signed(weighted_sum[5])) && ($signed(weighted_sum[6])>$signed(weighted_sum[7])) && ($signed(weighted_sum[6])>$signed(weighted_sum[8])) && ($signed(weighted_sum[6])>$signed(weighted_sum[9]));
assign out[7] = ($signed(weighted_sum[7])>$signed(weighted_sum[0])) && ($signed(weighted_sum[7])>$signed(weighted_sum[1])) && ($signed(weighted_sum[7])>$signed(weighted_sum[2])) && ($signed(weighted_sum[7])>$signed(weighted_sum[3])) && ($signed(weighted_sum[7])>$signed(weighted_sum[4])) && ($signed(weighted_sum[7])>$signed(weighted_sum[5])) && ($signed(weighted_sum[7])>$signed(weighted_sum[6])) && ($signed(weighted_sum[7])>$signed(weighted_sum[8])) && ($signed(weighted_sum[7])>$signed(weighted_sum[9]));
assign out[8] = ($signed(weighted_sum[8])>$signed(weighted_sum[0])) && ($signed(weighted_sum[8])>$signed(weighted_sum[1])) && ($signed(weighted_sum[8])>$signed(weighted_sum[2])) && ($signed(weighted_sum[8])>$signed(weighted_sum[3])) && ($signed(weighted_sum[8])>$signed(weighted_sum[4])) && ($signed(weighted_sum[8])>$signed(weighted_sum[5])) && ($signed(weighted_sum[8])>$signed(weighted_sum[6])) && ($signed(weighted_sum[8])>$signed(weighted_sum[7])) && ($signed(weighted_sum[8])>$signed(weighted_sum[9]));
assign out[9] = ($signed(weighted_sum[9])>$signed(weighted_sum[0])) && ($signed(weighted_sum[9])>$signed(weighted_sum[1])) && ($signed(weighted_sum[9])>$signed(weighted_sum[2])) && ($signed(weighted_sum[9])>$signed(weighted_sum[3])) && ($signed(weighted_sum[9])>$signed(weighted_sum[4])) && ($signed(weighted_sum[9])>$signed(weighted_sum[5])) && ($signed(weighted_sum[9])>$signed(weighted_sum[6])) && ($signed(weighted_sum[9])>$signed(weighted_sum[7])) && ($signed(weighted_sum[9])>$signed(weighted_sum[8]));

always_ff @ (posedge clk or posedge rst) begin
	if (rst) begin
		sharing0_r <= 0;
		sharing1_r <= 0;
		sharing2_r <= 0;
		sharing3_r <= 0;
		sharing4_r <= 0;
		sharing5_r <= 0;
		sharing6_r <= 0;
		sharing7_r <= 0;
		sharing8_r <= 0;
		sharing9_r <= 0;
		sharing10_r <= 0;
		sharing11_r <= 0;
		sharing12_r <= 0;
		sharing13_r <= 0;
	end
	else begin
		sharing0_r <= sharing0_w;
		sharing1_r <= sharing1_w;
		sharing2_r <= sharing2_w;
		sharing3_r <= sharing3_w;
		sharing4_r <= sharing4_w;
		sharing5_r <= sharing5_w;
		sharing6_r <= sharing6_w;
		sharing7_r <= sharing7_w;
		sharing8_r <= sharing8_w;
		sharing9_r <= sharing9_w;
		sharing10_r <= sharing10_w;
		sharing11_r <= sharing11_w;
		sharing12_r <= sharing12_w;
		sharing13_r <= sharing13_w;
	end
end
endmodule
