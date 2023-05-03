# Entity: top 

- **File**: top.vhd
## Diagram

![Diagram](top.svg "Diagram")
## Ports

| Port name | Direction | Type                         | Description |
| --------- | --------- | ---------------------------- | ----------- |
| CLK100MHZ | in        | std_logic                    |             |
| BTNC      | in        | std_logic                    |             |
| CA        | out       | std_logic                    |             |
| CB        | out       | std_logic                    |             |
| CC        | out       | std_logic                    |             |
| CD        | out       | std_logic                    |             |
| CE        | out       | std_logic                    |             |
| CF        | out       | std_logic                    |             |
| CG        | out       | std_logic                    |             |
| AN        | out       | std_logic_vector(7 downto 0) |             |
| JA1       | in        | std_logic                    |             |
## Signals

| Name        | Type                         | Description |
| ----------- | ---------------------------- | ----------- |
| sig_clk     | std_logic                    |             |
| sig_o_morse | std_logic_vector(3 downto 0) |             |
| sig_o_cnt   | std_logic_vector(2 downto 0) |             |
| sig_o_read  | std_logic                    |             |
| sig_o_char  | character                    |             |
## Constants

| Name         | Type    | Value   | Description |
| ------------ | ------- | ------- | ----------- |
| c_clk_max    | natural | 1000000 |             |
| c_cnt_length | natural | 30      |             |
## Instantiations

- uut_period_cnt1: work.period_cnt
- uut_morse_reciever: work.morse_reciever
- uut_clock_enable: work.clock_enable
