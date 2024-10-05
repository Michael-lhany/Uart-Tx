vlib work
vlog *.*v
vsim -gui -voptargs=+acc work.UART_Tx_Top_tb
do wave.do
run -all