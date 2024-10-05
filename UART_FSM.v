module UART_FSM (
input wire CLK,
input wire RST,
input wire Data_Valid,
input wire PAR_EN,
input wire ser_done,
output reg [1:0] mux_sel,
output reg Busy,
output reg ser_en
); 

parameter [2:0] 	IDLE = 3'b000,
					START = 3'b001,
					DATA = 3'b011,
					PARITY = 3'b010,
					STOP = 3'b110;


localparam [1:0]	sel_start_bit = 2'b01,
					sel_stop_bit = 2'b00,
					sel_data_bits = 2'b10,
					sel_parity_bit = 2'b11;

reg	[2:0]	current_state,
			next_state ;

reg Busy_c;

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		current_state <= IDLE;
	end
	else begin
		current_state <= next_state;
	end
end

always @(*) begin
	case(current_state)
	IDLE : begin
		if (Data_Valid) begin
			next_state = START;
		end else begin
			next_state = IDLE;
		end
	end
	START : begin
		next_state = DATA;
	end
	DATA : begin
		if (ser_done && PAR_EN) begin
			next_state = PARITY;
		end else if (ser_done && ~PAR_EN) begin
			next_state = STOP;
		end else begin
			next_state = current_state;
		end
	end
	PARITY : begin
		next_state = STOP;
	end
	STOP : begin
		next_state = IDLE;
	end
	default : begin
		next_state = IDLE;
	end
	endcase
end

always @(*) begin
	ser_en = 1'b0;
	Busy_c = 1'b0;
	mux_sel = sel_stop_bit;
	case(current_state)
	IDLE  : begin
		ser_en = 1'b0;
		Busy_c = 1'b0;
		mux_sel = sel_stop_bit;
	end
	START : begin
		ser_en = 1'b0;
		Busy_c = 1'b1;
		mux_sel = sel_start_bit;
	end
	DATA : begin
		ser_en = 1'b1;
		Busy_c = 1'b1;
		mux_sel = sel_data_bits;
	end
	PARITY : begin
		ser_en = 1'b0;
		Busy_c = 1'b1;
		mux_sel = sel_parity_bit;
	end
	STOP : begin
		ser_en = 1'b0;
		Busy_c = 1'b1;
		mux_sel = sel_stop_bit;
	end
	default  : begin
    	ser_en = 1'b0;
		Busy_c = 1'b0; 
		mux_sel = sel_stop_bit;
	end
	endcase
end




//register output 
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    Busy <= 1'b0 ;
   end
  else
   begin
    Busy <= Busy_c ;
   end
 end


 endmodule