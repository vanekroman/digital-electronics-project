# Clock enable

- **File**: period_cnt.vhd
- **Copyright:** (c) 2023 Roman Vanek
 This work is licensed under the terms of the MIT license
- **Author:** Roman Vanek
## Diagram

![Diagram](period_cnt.svg "Diagram")
## Description


 


 


 Counting period of input signal i_logic then assigns it either '0' or '1'
 if it is shorter then g_dot_length respectively longer then g_dot_length.
 Output will be provided when i_space changes to '1' as n-bit value of o_morse.
 n (number of bits to read) is stored in o_cnt
 !! Read output values only when o_read is '1' !!
## Generics

| Generic name | Type    | Value | Description                                               |
| ------------ | ------- | ----- | --------------------------------------------------------- |
| g_dot_length | natural | 5     | Number of clk pulses to generate one enable signal period |
## Ports

| Port name | Direction | Type                         | Description |
| --------- | --------- | ---------------------------- | ----------- |
| clk       | in        | std_logic                    |             |
| i_space   | in        | std_logic                    |             |
| i_logic   | in        | std_logic                    |             |
| o_morse   | out       | std_logic_vector(3 downto 0) |             |
| o_cnt     | out       | std_logic_vector(2 downto 0) |             |
| o_read    | out       | std_logic                    |             |
## Signals

| Name        | Type                  | Description   |
| ----------- | --------------------- | ------------- |
| sig_counter | unsigned(31 downto 0) |               |
| sig_morse   | unsigned(3 downto 0)  |               |
| sig_cnt     | natural               | Local counter |
| sig_read    | std_logic             |               |
## Processes
- p_period_cnt: ( clk )
