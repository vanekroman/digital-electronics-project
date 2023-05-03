# Morse Code Reciever

- **File**: morse_reciever.vhd
- **Copyright:** (c) 2023 Roman Vanek
 This work is licensed under the terms of the MIT license
- **Author:** Roman Vanek
## Diagram

![Diagram](morse_reciever.svg "Diagram")
## Description

 On i_read, it assign defined segments on 7 segment
 display coresponding to i_morse and i_cnt.
 It assumes 7 segment with active zero logic.
## Ports

| Port name | Direction | Type                         | Description |
| --------- | --------- | ---------------------------- | ----------- |
| i_morse   | in        | std_logic_vector(3 downto 0) |             |
| i_cnt     | in        | std_logic_vector(2 downto 0) |             |
| i_read    | in        | std_logic                    |             |
| o_char    | out       | character                    |             |
| o_7seg    | out       | std_logic_vector(6 downto 0) |             |
## Processes
- p_morse_reciever: ( i_read, i_morse, i_cnt )
