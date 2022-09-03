module model(
	input [6271:0] data,
	output [9:0] out
);
wire [6271:0] conv1_in;
wire [2027:0] conv1_out;
wire [2027:0] fc1_in;
wire [127:0] fc1_out;
wire [127:0] fc2_in;
wire [127:0] fc2_out;
wire [127:0] fc3_in;
genvar idx;
generate
	for (idx=1; idx<=784; idx=idx+1) begin
		assign conv1_in[(8*idx-1)-:8] = $signed({1'b0,data[(8*idx-1)-:7]})-$signed(8'd64);
	end
endgenerate
conv1 conv1_inst(.in(conv1_in),.out(conv1_out));
fc1 fc1_inst(.in(fc1_in),.out(fc1_out));
fc2 fc2_inst(.in(fc2_in),.out(fc2_out));
fc3 fc3_inst(.in(fc3_in),.out(out));

assign fc1_in = conv1_out;
assign fc2_in = fc1_out;
assign fc3_in = fc2_out;

endmodule
