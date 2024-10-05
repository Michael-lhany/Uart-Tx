module parity_calc (
input wire CLK,
input wire RST,
input wire [7:0] P_DATA,
input wire PAR_TYP,
input wire Data_Valid,
input wire Busy,
output reg par_bit
);

reg [7:0] IN_DATA; 

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		IN_DATA <= 'b0;
	end
	else if (Data_Valid && ~Busy) begin
		IN_DATA <= P_DATA;
	end
end

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		par_bit <= 0;
	end else begin
		if(Data_Valid) begin
			if (PAR_TYP == 0) begin
			 	par_bit <= ~^P_DATA ;
			end else begin
				par_bit <= ^P_DATA ;
			end
		end
	end
end
endmodule