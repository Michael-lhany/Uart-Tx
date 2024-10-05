module serializer_tb();

parameter CLOCK_PERIOD = 10;


reg CLK_tb;
reg RST_tb;
reg [7:0] P_DATA_tb;
reg Data_Valid_tb;
reg ser_enb_tb;
wire ser_done_tb;
wire ser_data_tb;

serializer dut(
.CLK(CLK_tb),
.RST(RST_tb),
.P_DATA(P_DATA_tb),
.Data_Valid(Data_Valid_tb),
.ser_en(ser_enb_tb),
.ser_done(ser_done_tb),
.ser_data(ser_data_tb)
);

initial
begin
	CLK_tb = 0;
	P_DATA_tb = 8'b11101101;
	Data_Valid_tb = 0;
	ser_enb_tb = 0;

	RST_tb = 1;
	#(CLOCK_PERIOD)
	RST_tb = 0;
	#(CLOCK_PERIOD)
	RST_tb = 1;

	Data_Valid_tb = 1;

	#(CLOCK_PERIOD)
	Data_Valid_tb = 0;
	ser_enb_tb = 1;

	#(CLOCK_PERIOD*10)

	$stop;
end


always #(CLOCK_PERIOD/2) CLK_tb = ~CLK_tb;

endmodule