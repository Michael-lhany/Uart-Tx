module Mux (
input wire CLK,
input wire RST,
input wire [1:0] mux_sel,
input wire ser_data,
input wire par_bit,
output reg TX_OUT
);

/*
case (00) : stop bit
case (01) : start bit
case (10) : data bits
case (11) : parity bit
*/

localparam start_bit = 1'b0;
localparam stop_bit = 1'b1;


always @(posedge CLK or negedge RST) begin
	if(~RST) begin
		TX_OUT <= stop_bit;
	end else begin
		case(mux_sel)
			2'b00: begin
				TX_OUT <= stop_bit;
			end
			2'b01: begin
				TX_OUT <= start_bit;
			end
			2'b10: begin
				TX_OUT <= ser_data;
			end
			2'b11: begin
				TX_OUT <= par_bit;
			end	
		endcase
	end 
end

endmodule