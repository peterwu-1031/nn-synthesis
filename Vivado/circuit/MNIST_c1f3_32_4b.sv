module MNIST_c1f3_32_4b(
	input clk,
	input rst,
	input [7:0] data [0:783],
	output [9:0] out
);

logic [3:0] conv1_out [0:506];
logic [3:0] fc1_in [0:506];
logic [3:0] fc1_out [0:31];
logic [3:0] fc2_in [0:31];
logic [3:0] fc2_out [0:31];
logic [3:0] fc3_in [0:31];

conv1 conv1_inst(.in(data),.clk(clk),.rst(rst),.out(conv1_out));
fc1 fc1_inst(.in(fc1_in),.clk(clk),.rst(rst),.out(fc1_out));
fc2 fc2_inst(.in(fc2_in),.clk(clk),.rst(rst),.out(fc2_out));
fc3 fc3_inst(.in(fc3_in),.clk(clk),.rst(rst),.out(out));

always_comb begin
end

always_ff @ (posedge clk or posedge rst) begin
	if (rst) begin
		for (int i=0;i<507;i++) begin
			fc1_in[i] <= 0;
		end
		for (int i=0;i<32;i++) begin
			fc2_in[i] <= 0;
		end
		for (int i=0;i<32;i++) begin
			fc3_in[i] <= 0;
		end
	end
	else begin
		fc1_in <= conv1_out;
		fc2_in <= fc1_out;
		fc3_in <= fc2_out;
	end
end
endmodule
