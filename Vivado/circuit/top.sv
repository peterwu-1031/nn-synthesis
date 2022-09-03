`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2020 11:17:47 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input btnc,
    input btnu,
    input btnd,
    output [7:0] LED
    );


reg [7:0] data_r [0:783];
reg [7:0] data_w [0:783];
wire [7:0] bramOut [0:391];
reg [2:0] state_r;
reg [2:0] state_w;
reg [10:0] addr_r;
reg [10:0] addr_w;
reg [9:0] ntkOut_r;
reg [9:0] ntkOut_w;
reg [9:0] imgInd_r;
reg [9:0] imgInd_w;

wire dBtnC;
wire dBtnU;
wire dBtnD;

debouncer #(
    .COUNT_MAX(65535),
    .COUNT_WIDTH(16)
) get_dBtnC (
    .clk(clk),
    .A(btnc),
    .B(dBtnC)
);
debouncer #(
    .COUNT_MAX(65535),
    .COUNT_WIDTH(16)
) get_dBtnU (
    .clk(clk),
    .A(btnu),
    .B(dBtnU)
);
debouncer #(
    .COUNT_MAX(65535),
    .COUNT_WIDTH(16)
) get_dBtnD (
    .clk(clk),
    .A(btnd),
    .B(dBtnD)
);

parameter STATE_IDLE = 3'b000;
parameter STATE_BUTUDOWN = 3'b001;
parameter STATE_BUTDDOWN = 3'b010;
parameter STATE_READ1 = 3'b011;
parameter STATE_READ2 = 3'b100;
parameter STATE_READ3 = 3'b101;
parameter STATE_READ4 = 3'b110;


blk_mem_gen_0 bram( .clka(clk), .ena(1'b1), .addra(addr_r), .douta({bramOut[0],bramOut[1],bramOut[2],bramOut[3],bramOut[4],bramOut[5],bramOut[6],bramOut[7],bramOut[8],bramOut[9],bramOut[10],bramOut[11],bramOut[12],bramOut[13],bramOut[14],bramOut[15],bramOut[16],bramOut[17],bramOut[18],bramOut[19],bramOut[20],bramOut[21],bramOut[22],bramOut[23],bramOut[24],bramOut[25],bramOut[26],bramOut[27],bramOut[28],bramOut[29],bramOut[30],bramOut[31],bramOut[32],bramOut[33],bramOut[34],bramOut[35],bramOut[36],bramOut[37],bramOut[38],bramOut[39],bramOut[40],bramOut[41],bramOut[42],bramOut[43],bramOut[44],bramOut[45],bramOut[46],bramOut[47],bramOut[48],bramOut[49],bramOut[50],bramOut[51],bramOut[52],bramOut[53],bramOut[54],bramOut[55],bramOut[56],bramOut[57],bramOut[58],bramOut[59],bramOut[60],bramOut[61],bramOut[62],bramOut[63],bramOut[64],bramOut[65],bramOut[66],bramOut[67],bramOut[68],bramOut[69],bramOut[70],bramOut[71],bramOut[72],bramOut[73],bramOut[74],bramOut[75],bramOut[76],bramOut[77],bramOut[78],bramOut[79],bramOut[80],bramOut[81],bramOut[82],bramOut[83],bramOut[84],bramOut[85],bramOut[86],bramOut[87],bramOut[88],bramOut[89],bramOut[90],bramOut[91],bramOut[92],bramOut[93],bramOut[94],bramOut[95],bramOut[96],bramOut[97],bramOut[98],bramOut[99],bramOut[100],bramOut[101],bramOut[102],bramOut[103],bramOut[104],bramOut[105],bramOut[106],bramOut[107],bramOut[108],bramOut[109],bramOut[110],bramOut[111],bramOut[112],bramOut[113],bramOut[114],bramOut[115],bramOut[116],bramOut[117],bramOut[118],bramOut[119],bramOut[120],bramOut[121],bramOut[122],bramOut[123],bramOut[124],bramOut[125],bramOut[126],bramOut[127],bramOut[128],bramOut[129],bramOut[130],bramOut[131],bramOut[132],bramOut[133],bramOut[134],bramOut[135],bramOut[136],bramOut[137],bramOut[138],bramOut[139],bramOut[140],bramOut[141],bramOut[142],bramOut[143],bramOut[144],bramOut[145],bramOut[146],bramOut[147],bramOut[148],bramOut[149],bramOut[150],bramOut[151],bramOut[152],bramOut[153],bramOut[154],bramOut[155],bramOut[156],bramOut[157],bramOut[158],bramOut[159],bramOut[160],bramOut[161],bramOut[162],bramOut[163],bramOut[164],bramOut[165],bramOut[166],bramOut[167],bramOut[168],bramOut[169],bramOut[170],bramOut[171],bramOut[172],bramOut[173],bramOut[174],bramOut[175],bramOut[176],bramOut[177],bramOut[178],bramOut[179],bramOut[180],bramOut[181],bramOut[182],bramOut[183],bramOut[184],bramOut[185],bramOut[186],bramOut[187],bramOut[188],bramOut[189],bramOut[190],bramOut[191],bramOut[192],bramOut[193],bramOut[194],bramOut[195],bramOut[196],bramOut[197],bramOut[198],bramOut[199],bramOut[200],bramOut[201],bramOut[202],bramOut[203],bramOut[204],bramOut[205],bramOut[206],bramOut[207],bramOut[208],bramOut[209],bramOut[210],bramOut[211],bramOut[212],bramOut[213],bramOut[214],bramOut[215],bramOut[216],bramOut[217],bramOut[218],bramOut[219],bramOut[220],bramOut[221],bramOut[222],bramOut[223],bramOut[224],bramOut[225],bramOut[226],bramOut[227],bramOut[228],bramOut[229],bramOut[230],bramOut[231],bramOut[232],bramOut[233],bramOut[234],bramOut[235],bramOut[236],bramOut[237],bramOut[238],bramOut[239],bramOut[240],bramOut[241],bramOut[242],bramOut[243],bramOut[244],bramOut[245],bramOut[246],bramOut[247],bramOut[248],bramOut[249],bramOut[250],bramOut[251],bramOut[252],bramOut[253],bramOut[254],bramOut[255],bramOut[256],bramOut[257],bramOut[258],bramOut[259],bramOut[260],bramOut[261],bramOut[262],bramOut[263],bramOut[264],bramOut[265],bramOut[266],bramOut[267],bramOut[268],bramOut[269],bramOut[270],bramOut[271],bramOut[272],bramOut[273],bramOut[274],bramOut[275],bramOut[276],bramOut[277],bramOut[278],bramOut[279],bramOut[280],bramOut[281],bramOut[282],bramOut[283],bramOut[284],bramOut[285],bramOut[286],bramOut[287],bramOut[288],bramOut[289],bramOut[290],bramOut[291],bramOut[292],bramOut[293],bramOut[294],bramOut[295],bramOut[296],bramOut[297],bramOut[298],bramOut[299],bramOut[300],bramOut[301],bramOut[302],bramOut[303],bramOut[304],bramOut[305],bramOut[306],bramOut[307],bramOut[308],bramOut[309],bramOut[310],bramOut[311],bramOut[312],bramOut[313],bramOut[314],bramOut[315],bramOut[316],bramOut[317],bramOut[318],bramOut[319],bramOut[320],bramOut[321],bramOut[322],bramOut[323],bramOut[324],bramOut[325],bramOut[326],bramOut[327],bramOut[328],bramOut[329],bramOut[330],bramOut[331],bramOut[332],bramOut[333],bramOut[334],bramOut[335],bramOut[336],bramOut[337],bramOut[338],bramOut[339],bramOut[340],bramOut[341],bramOut[342],bramOut[343],bramOut[344],bramOut[345],bramOut[346],bramOut[347],bramOut[348],bramOut[349],bramOut[350],bramOut[351],bramOut[352],bramOut[353],bramOut[354],bramOut[355],bramOut[356],bramOut[357],bramOut[358],bramOut[359],bramOut[360],bramOut[361],bramOut[362],bramOut[363],bramOut[364],bramOut[365],bramOut[366],bramOut[367],bramOut[368],bramOut[369],bramOut[370],bramOut[371],bramOut[372],bramOut[373],bramOut[374],bramOut[375],bramOut[376],bramOut[377],bramOut[378],bramOut[379],bramOut[380],bramOut[381],bramOut[382],bramOut[383],bramOut[384],bramOut[385],bramOut[386],bramOut[387],bramOut[388],bramOut[389],bramOut[390],bramOut[391]}));
MNIST_c1f3_32_4b ntk(
    .clk(clk),
    .rst(dBtnC),
    .data(data_r),
    .out(ntkOut_w));

assign LED[0] = (ntkOut_r==10'b0000000010) || (ntkOut_r==10'b0000001000) || (ntkOut_r==10'b0000100000) || (ntkOut_r==10'b0010000000) || (ntkOut_r==10'b1000000000);
assign LED[1] = (ntkOut_r==10'b0000000100) || (ntkOut_r==10'b0000001000) || (ntkOut_r==10'b0001000000) || (ntkOut_r==10'b0010000000);
assign LED[2] = (ntkOut_r==10'b0000010000) || (ntkOut_r==10'b0000100000) || (ntkOut_r==10'b0001000000) || (ntkOut_r==10'b0010000000);
assign LED[3] = (ntkOut_r==10'b0100000000) || (ntkOut_r==10'b1000000000);
assign LED[4] = dBtnC;
assign LED[7:5] = state_r;

always_comb begin
    case (state_r)
        STATE_IDLE: begin
            if (dBtnU) begin
                state_w = STATE_BUTUDOWN;
            end
            else if (dBtnD) begin
                state_w = STATE_BUTDDOWN;
            end
            else begin
                state_w = state_r;
            end
            data_w = data_r;
            addr_w = addr_r;
            imgInd_w = imgInd_r;
        end
        STATE_BUTUDOWN: begin
            if (dBtnU) begin
                state_w = state_r;
                addr_w = addr_r;
                imgInd_w = imgInd_r;
            end
            else begin
                state_w = STATE_READ1;
                addr_w = addr_r<=1 ? 1998 : addr_r-3;
                imgInd_w = imgInd_r==0 ? 999 : imgInd_r-1;
            end
            data_w = data_r;
        end
        STATE_BUTDDOWN: begin
            if (dBtnD) begin
                state_w = state_r;
                addr_w = addr_r;
                imgInd_w = imgInd_r;
            end
            else begin
                state_w = STATE_READ1;
                addr_w = addr_r==1999? 0 : addr_r+1;
                imgInd_w = imgInd_r==999 ? 0 : imgInd_r+1;
            end
            data_w = data_r;
        end
        STATE_READ1: begin
            state_w = STATE_READ2;
            data_w = data_r;
            addr_w = addr_r+1;
            imgInd_w = imgInd_r;
        end
        STATE_READ2: begin
            state_w = STATE_READ3;
            data_w = data_r;
            addr_w = addr_r;
            imgInd_w = imgInd_r;
        end
        STATE_READ3: begin
            state_w = STATE_READ4;
            for(int i=0;i<392;i++) begin
                data_w[i] = bramOut[i];
                data_w[i+392] = data_r[i+392];
            end
            addr_w = addr_r;
            imgInd_w = imgInd_r;
        end
        STATE_READ4: begin
            state_w = STATE_IDLE;
            for(int i=0;i<392;i++) begin
                data_w[i] = data_r[i];
                data_w[i+392] = bramOut[i];
            end
            addr_w = addr_r;
            imgInd_w = imgInd_r;
        end
        default: begin
            data_w = data_r;
            state_w = state_r;
            addr_w = addr_r;
            imgInd_w = imgInd_r;
        end
    endcase
end

always_ff @(posedge clk or posedge dBtnC) begin
	if (dBtnC) begin
		state_r <= STATE_READ1;
		addr_r <= 11'd0;
		data_r <= data_r;
        ntkOut_r <= 10'd0;
        imgInd_r <= 10'd0;
	end
	else begin
	    state_r <= state_w;
	    addr_r <= addr_w;
        data_r <= data_w;
        ntkOut_r <= ntkOut_w;
        imgInd_r <= imgInd_w;
	end
end
    
    
endmodule