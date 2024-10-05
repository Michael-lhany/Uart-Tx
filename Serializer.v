module serializer (
input wire CLK,
input wire RST,
input wire [7:0] P_DATA,
input wire Data_Valid,
input wire ser_en,
input wire Busy,
output wire ser_done,
output wire ser_data
);


reg [3:0] counter;
reg [7:0] IN_data;

//isolate input 
always @ (posedge CLK or negedge RST) begin
	if(!RST) begin
    	IN_data <= 'b0 ;
	end 
	else if(Data_Valid && !Busy) begin
    IN_data <= P_DATA ;
	end	
	else if(ser_en) begin
    IN_data <= IN_data >> 1 ;         // shift register
    end
 end
 


//counter
always @ (posedge CLK or negedge RST)
 begin
  if(!RST)
   begin
    counter <= 'b0 ;
   end
  else
   begin
    if (ser_en)
	 begin
      counter <= counter + 'b1 ;		 
	 end
	else 
	 begin
      counter <= 'b0 ;		 
	 end	
   end
 end 

assign ser_done = (counter == 'b111) ? 1'b1 : 1'b0 ;

assign ser_data = IN_data[0] ;


endmodule