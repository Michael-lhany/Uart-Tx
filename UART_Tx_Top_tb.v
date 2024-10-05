`timescale 1ns/100ps

module UART_Tx_Top_tb();


///		Parameters		///
localparam CLK_PERIOD = 5.0 ;


///		integers		///
integer test_case;


///		DUT signals		///
reg CLK_tb;
reg RST_tb;
reg PAR_TYP_tb;
reg PAR_EN_tb;
reg Data_Valid_tb;
reg [7:0] P_DATA_tb;
wire TX_OUT_tb; 
wire Busy_tb;


////		DUT instantiation		////
UART_Tx_Top UART(
.CLK(CLK_tb),
.RST(RST_tb),
.PAR_TYP(PAR_TYP_tb),
.PAR_EN(PAR_EN_tb),
.Data_Valid(Data_Valid_tb),
.P_DATA(P_DATA_tb),
.TX_OUT(TX_OUT_tb),
.Busy(Busy_tb)
);


///		Initial block		///
initial
begin
	$dumpfile("LFSR_DUMP.vcd") ;       
	$dumpvars;

	init();
	reset();

	#(CLK_PERIOD)

	test_case = test_case + 1;
	data_send('b10111011,'b0,'b0);
	test_case = test_case + 1;
	data_send('b00011101,'b0,'b1);
	test_case = test_case + 1;
	data_send('b10001110,'b1,'b0);			//Even No. 0f bits
	test_case = test_case + 1;
	data_send('b00111011,'b1,'b0);			//ODD No. 0f bits
	test_case = test_case + 1;
	data_send('b10001110,'b1,'b1);			//Even No. 0f bits
	test_case = test_case + 1;
	data_send('b00111011,'b1,'b1);			//ODD No. 0f bits

	#(CLK_PERIOD)

	reset();

	if ((TX_OUT_tb == 1) && (Busy_tb == 0)) begin
		$display("Reset functionality works properly");
	end else begin
		$display("Reset functionality does not work properly");
	end

	#(3*CLK_PERIOD)
	if (TX_OUT_tb == 1 && Busy_tb == 0) begin
		$display("Test for staying in idle state works properly");	
	end else begin
		$display("Test for staying in idle state does not work properly");
	end



	$stop;
end


///		Clock Generator		///
always #(CLK_PERIOD/2.0) CLK_tb = ~CLK_tb;


///		Tasks		///

//Initialize
task init;	
 begin
 	CLK_tb = 'b0;
	RST_tb = 'b0;
	PAR_TYP_tb = 'b0;
	PAR_EN_tb = 'b0;
	Data_Valid_tb = 'b0;
	P_DATA_tb = 'b0;
	test_case = 0;
 end
endtask

//Reset
task reset;
 begin
	//RST_tb = 'b1;
	//#(CLK_PERIOD)
	RST_tb = 'b0;
	#(CLK_PERIOD)
	RST_tb = 'b1;
 end
endtask

//							Send Data
/***		Input (Data in, parity enable, parity type)			***/
task data_send;
input [7:0] IN_DATA;
input parity_enable;
input parity_type;

reg [7:0] out_temp;

integer i;
 begin
 	PAR_TYP_tb = parity_type;
 	PAR_EN_tb = parity_enable;
 	P_DATA_tb = IN_DATA;
 	Data_Valid_tb = 1'b1;
 	#(CLK_PERIOD)
 	Data_Valid_tb = 1'b0;
 	#(CLK_PERIOD)
 	if (TX_OUT_tb == 'b0) begin
 		$display("start bit for test 	%d is correct",test_case);
 	end else begin
 		$display("start bit for test 	%d is false",test_case);
 	end
 	for( i=0 ; i<8 ; i=i+1 )
 	begin
 		#(CLK_PERIOD)	out_temp[i] = TX_OUT_tb;
 	end
 	if (out_temp == P_DATA_tb) begin
 		$display("Data bits for test 		%d are correct",test_case);
 	end else begin
 		$display("Data bits for test 		%d are false",test_case);
 	end
 	if(PAR_EN_tb == 1) begin
 		#(CLK_PERIOD)
 		if (parity_type == 0) begin
	 		if (TX_OUT_tb == ~^IN_DATA) begin
	 		$display("Parity bit for test 		%d is correct",test_case);
	 		end else begin
	 		$display("Parity bit for test 		%d is false",test_case);
 			end
 		end else begin
 			if (TX_OUT_tb == ^IN_DATA) begin
	 		$display("Parity bit for test 		%d is correct",test_case);
	 		end else begin
	 		$display("Parity bit for test 		%d is false",test_case);
 			end
 		end
 	end
 	#(CLK_PERIOD)
 	if (TX_OUT_tb == 'b1) begin
 		$display("end bit for test 		%d is correct",test_case);
 	end else begin
 		$display("end bit for test 		%d is false",test_case);
 	end
 	#(CLK_PERIOD);
 end
endtask


endmodule