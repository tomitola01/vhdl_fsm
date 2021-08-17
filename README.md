# Sequential Comparator Circuit FSM

Sequential comparator circuit designed to determine which of two multi-bit numbers, named A and B, is larger.<br>
Numbers are assumed to be unsigned and of equal length, input into the FSM one bit at a time from MSB to LSB.<br>
<br>
The output (z_out) of the FSM will remain at 0 unless one of the numbers are determined to be larger:
1. If A is larger, z_out will remain at 2
2. If B is larger, z_out will remain at 1

A testbench is included, comparing the multi-bit numbers A = 011001111010 and B = 010001111010
