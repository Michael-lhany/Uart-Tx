module UART_Tx_Top (
input wire CLK,
input wire RST,
input wire PAR_TYP,
input wire PAR_EN,
input wire Data_Valid,
input wire [7:0] P_DATA,
output TX_OUT, 
output Busy
);

wire 	ser_done, 
		ser_en, 
		ser_data,
		par_bit;

wire [1:0]	mux_sel;


UART_FSM FSM(
.CLK(CLK),
.RST(RST),
.Data_Valid(Data_Valid),
.PAR_EN(PAR_EN),
.ser_done(ser_done),
.mux_sel(mux_sel),
.Busy(Busy),
.ser_en(ser_en)
);


serializer serial(
.CLK(CLK),
.RST(RST),
.P_DATA(P_DATA),
.Data_Valid(Data_Valid),
.ser_en(ser_en),
.Busy(Busy),
.ser_done(ser_done),
.ser_data(ser_data)
);


parity_calc par_calc(
.CLK(CLK),
.RST(RST),
.P_DATA(P_DATA),
.PAR_TYP(PAR_TYP),
.Data_Valid(Data_Valid),
.Busy(Busy),
.par_bit(par_bit)
);


Mux mux(
.CLK(CLK),
.RST(RST),
.mux_sel(mux_sel),
.ser_data(ser_data),
.par_bit(par_bit),
.TX_OUT(TX_OUT)
);

endmodule