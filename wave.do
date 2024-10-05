onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {UART TB SIGNALS} -color {Cornflower Blue} /UART_Tx_Top_tb/CLK_tb
add wave -noupdate -expand -group {UART TB SIGNALS} -color White /UART_Tx_Top_tb/RST_tb
add wave -noupdate -expand -group {UART TB SIGNALS} /UART_Tx_Top_tb/PAR_TYP_tb
add wave -noupdate -expand -group {UART TB SIGNALS} /UART_Tx_Top_tb/P_DATA_tb
add wave -noupdate -expand -group {UART TB SIGNALS} /UART_Tx_Top_tb/Data_Valid_tb
add wave -noupdate -expand -group {UART TB SIGNALS} /UART_Tx_Top_tb/PAR_EN_tb
add wave -noupdate -expand -group {UART TB SIGNALS} -color Gold /UART_Tx_Top_tb/TX_OUT_tb
add wave -noupdate -expand -group {UART TB SIGNALS} -color Pink /UART_Tx_Top_tb/Busy_tb
add wave -noupdate -expand -group FSM /UART_Tx_Top_tb/UART/FSM/ser_done
add wave -noupdate -expand -group FSM /UART_Tx_Top_tb/UART/FSM/mux_sel
add wave -noupdate -expand -group FSM /UART_Tx_Top_tb/UART/FSM/ser_en
add wave -noupdate -expand -group FSM /UART_Tx_Top_tb/UART/FSM/current_state
add wave -noupdate -expand -group FSM /UART_Tx_Top_tb/UART/FSM/next_state
add wave -noupdate -expand -group Serializer /UART_Tx_Top_tb/UART/serial/ser_en
add wave -noupdate -expand -group Serializer /UART_Tx_Top_tb/UART/serial/ser_done
add wave -noupdate -expand -group Serializer /UART_Tx_Top_tb/UART/serial/ser_data
add wave -noupdate -expand -group Serializer /UART_Tx_Top_tb/UART/serial/counter
add wave -noupdate -expand -group Serializer /UART_Tx_Top_tb/UART/serial/IN_data
add wave -noupdate -expand -group {Parity Calculator} /UART_Tx_Top_tb/UART/par_calc/par_bit
add wave -noupdate -expand -group MUX /UART_Tx_Top_tb/UART/mux/mux_sel
add wave -noupdate -expand -group MUX /UART_Tx_Top_tb/UART/mux/ser_data
add wave -noupdate -expand -group MUX /UART_Tx_Top_tb/UART/mux/par_bit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {78100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {227600 ps}
