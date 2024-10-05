# UART_Tx project
## Description
* There are many serial communication protocol as I2C, UART and SPI.
* A Universal Asynchronous Receiver/Transmitter (UART) is a block of circuitry responsible for implementing serial communication.
* UART is Full Duplex protocol (data transmission in both directions
simultaneously)
* Transmitting UART converts parallel data from the master device (eg. CPU) into serial form and transmit in serial to receiving UART.
* Receiving UART will then convert the serial data back into parallel data for the receiving device.
* On this project we will focusing on the transmitting UART
## Specifications:
* UART TX receive the new data on P_DATA Bus only when
Data_Valid Signal is high.
* Registers are cleared using asynchronous active low reset
* Data_Valid is high for only 1 clock cycle
* Busy signal is high as long as UART_TX is transmitting the frame,
otherwise low.
* UART_TX couldn't accept any data on P_DATA during UART_TX
processing, however Data_Valid get high.
* S_DATA is high in the IDLE case (No transmission).
* PAR_EN (Configuration)
  0: To disable frame parity bit
  1: To enable frame parity bit
*  PAR_TYP (Configuration)
0: Even parity bit
1: Odd parity bit
## Block diagram
(https://github.com/Michael-lhany/Uart-Tx/blob/ca213d07d9d876be1879c81c8fbf4532dd28d21d/Block%20Diagram.png)
##
* I have added a run.do and a wave.do so it can be easier for you to try the project out on questasim
