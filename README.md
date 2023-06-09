# VHDL Projekt - Vysílač a přijímač Morseova kódu
transmitor_morse pro Vivado 2020,
transmitor_morse_2022 pro Vivado 2022

### Členové týmu
* Filip Tůma (230896) 
* Viktor Vlček (240709) 
* Roman Vaněk (240707) 

## Teoretický úvod
:blue_square: 1 ČÁRKA     :yellow_square: 0 TEČKA

![image](doc/Morse_abeceda.png)

V Morseově kódu jsme našli algoritmus podle kterého jsme postupovali. Z teček jsme udělali logickou 0, z čárek logickou 1. Dále jsme pak počítali počet impulzů. Z daného binárního kódu jsme udělali dekadické číslo. Počet impulzů číselně odpovídal abecednímu sloupci. Dekadický kód byl dále určitý znak, který jsme indexovali od 0. Jednotlivá písmena jsme zobrazovali na 7-segmentovém displeji. 

### 7-segment abeceda
![image](doc/7_seg_alphabet.jpg)

## Popis hardwaru

### Schéma
![image](doc/schema.png)

# Entity: top 

- **File**: top.vhd
## Diagram

![Diagram](doc/top.svg "Diagram")
## Porty

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
## Signály

| Name        | Type                         | Description |
| ----------- | ---------------------------- | ----------- |
| sig_clk     | std_logic                    |             |
| sig_o_morse | std_logic_vector(3 downto 0) |             |
| sig_o_cnt   | std_logic_vector(2 downto 0) |             |
| sig_o_read  | std_logic                    |             |
| sig_o_char  | character                    |             |
## Konstanty

| Name           | Type    | Value   | Description |
| -------------- | ------- | ------- | ----------- |
| c_clk_max      | natural | 1000000 |             |
| c_cnt_length   | natural | 30      |             |
| c_space_length | natural | 200     |             |
## Instance

- uut_period_cnt1: work.period_cnt
- uut_morse_reciever: work.morse_reciever
- uut_clock_enable: work.clock_enable

## Clock enable

- **File**: period_cnt.vhd
- **Copyright:** (c) 2023 Roman Vanek
 This work is licensed under the terms of the MIT license
- **Author:** Roman Vanek
## Diagram

![Diagram](doc/period_cnt.svg "Diagram")
## Popis
Počítání periody ze vstupního signálu i_logic, kterému jsme přiřadili logickou '0' nebo '1'.
Čárku jsme rozpoznávali podle délky a to tak, že když byl delší než g_got_length.
Výstup čeká do té doby, než vnitřní counter je vetší než g_space_length.
!! Výstup se zobrazí jedine, pokud je o_read v logické '1' !!

## Generics

| Generic name   | Type    | Value | Description      |
| -------------- | ------- | ----- | ---------------- |
| g_dot_length   | natural | 30    | dot pulse length |
| g_space_length | natural | 200   | space length     |
## Porty

| Port name | Direction | Type                         | Description |
| --------- | --------- | ---------------------------- | ----------- |
| clk       | in        | std_logic                    |             |
| i_logic   | in        | std_logic                    |             |
| o_morse   | out       | std_logic_vector(3 downto 0) |             |
| o_cnt     | out       | std_logic_vector(2 downto 0) |             |
| o_read    | out       | std_logic                    |             |
## Signály

| Name          | Type                  | Description   |
| ------------- | --------------------- | ------------- |
| sig_counter_0 | natural               |               |
| sig_counter   | unsigned(31 downto 0) |               |
| sig_morse     | unsigned(3 downto 0)  |               |
| sig_cnt       | natural               | Local counter |
| sig_read      | std_logic             |               |
## Procesy
- p_period_cnt: ( clk )



## Přijímač Morzeova kódu

- **File**: morse_reciever.vhd
- **Copyright:** (c) 2023 Roman Vanek
 This work is licensed under the terms of the MIT license
- **Author:** Roman Vanek
## Diagram

![Diagram](doc/morse_reciever.svg "Diagram")
## Popis
Jednotlivé segmenty nastavíme podle vstupních hodnot i_morse a i_cnt, když i_read je v aktivním stavu.
Pracujeme se 7-segmentovkou se společnou anodou.

## Porty

| Port name | Direction | Type                         | Description |
| --------- | --------- | ---------------------------- | ----------- |
| i_morse   | in        | std_logic_vector(3 downto 0) |             |
| i_cnt     | in        | std_logic_vector(2 downto 0) |             |
| i_read    | in        | std_logic                    |             |
| o_char    | out       | character                    |             |
| o_7seg    | out       | std_logic_vector(6 downto 0) |             |
## Procesy
- p_morse_reciever: ( i_read, i_morse, i_cnt )


## Popis softwaru
```vhdl
entity top is
    Port 
    ( 
        CLK100MHZ   : in std_logic;
        BTNC        : in std_logic;
        CA          : out std_logic;
        CB          : out std_logic;
        CC          : out std_logic;
        CD          : out std_logic;
        CE          : out std_logic;
        CF          : out std_logic;
        CG          : out std_logic;
        AN          : out std_logic_vector(7 downto 0);
        JA1         : in std_logic;
        JA2         : out std_logic
    );
end top;
architecture Behavioral of top is

  -- Counter constants
  constant c_clk_max    : natural := 1000000;   -- 10 ms
  constant c_cnt_length : natural := 30; -- > 300 ms => DASH 
  constant c_space_length : natural := 200; -- > 2 s => SPACE 

  signal sig_clk      : std_logic;                    -- Main clock

  signal sig_o_morse : std_logic_vector(3 downto 0); -- Full morse code in respect to o_cnt!
  signal sig_o_cnt   : std_logic_vector(2 downto 0); -- Number of o_morse bits to read 0 - 4
  signal sig_o_read  : std_logic;

  signal sig_o_char  : character;

begin

  -- Connecting testbench signals with tb_period_cnt
  -- entity (Unit Under Test)
  uut_period_cnt1 : entity work.period_cnt
    generic map (
      g_dot_length => c_cnt_length,
      g_space_length => c_space_length
    )
    port map (
      clk     => sig_clk,
      i_space => BTNC,
      i_logic => JA1,
      o_morse => sig_o_morse,
      o_cnt   => sig_o_cnt,
      o_read  => sig_o_read
    );

  uut_morse_reciever : entity work.morse_reciever
    port map (
      i_morse => sig_o_morse,
      i_cnt   => sig_o_cnt,
      i_read  => sig_o_read,
      o_char  => sig_o_char,
      o_7seg(6) => CA,
      o_7seg(5) => CB,
      o_7seg(4) => CC,
      o_7seg(3) => CD,
      o_7seg(2) => CE,
      o_7seg(1) => CF,
      o_7seg(0) => CG
    );

  uut_clock_enable : entity work.clock_enable
    generic map (
      g_max => c_clk_max
    )
    port map (
      clk => CLK100MHZ,
      rst => '0',
      ce  => sig_clk
    );
    
   AN <= b"1111_1110";
   --AN <= (b"1111_1110" and (sig_clk_7seg)) or (b"1111_1110");
   
   JA2 <= sig_clk;


end Behavioral;

```

### Rozlišování periody
```vhdl
  --------------------------------------------------------
  -- p_period_cnt:
  -- Local counter is active high. When i_logic is released,
  -- DASH or DOT is assigned to sig_morse at coresponding index.
  -- Output variables o_morse, o_cnt are enabled when i_logic is
  -- LOW after g_space_length clock cycles (representing space between characters)
  -- this event is signalized by o_read
  --------------------------------------------------------
  p_period_cnt : process (clk) is
  begin

    if rising_edge(clk) then                                   -- Synchronous process
      if (i_logic = '1') then
        sig_read    <= '0';
        o_read      <= '0';                                    -- Dont read yet
        sig_counter <= sig_counter + 1;
        sig_counter_0 <= 0;
      elsif (sig_counter > 0) then                             -- end of logic signal
        -- asigh DASH or DOT to correct position
        if (sig_counter > g_dot_length) then
          sig_morse(sig_cnt) <= '1';                           -- DASH
        else
          sig_morse(sig_cnt) <= '0';                           -- DOT
        end if;
        -- next index if sig_morse (whole letter)
        sig_cnt     <= sig_cnt + 1;
        sig_counter <= (others => '0');
      else
        sig_counter_0 <= sig_counter_0 + 1;
        
        if (sig_counter_0 > g_space_length and sig_read = '0') then
            o_morse  <= std_logic_vector(sig_morse);
            o_cnt    <= std_logic_vector(to_unsigned(sig_cnt, 3));
            o_read   <= '1';
            sig_read <= '1';
            
            sig_morse   <= (others => '0');
            sig_cnt     <= 0;
        end if;
      end if;
```
### Přijímač Morzeova kódu
```vhdl
  p_morse_reciever : process (i_read, i_morse, i_cnt) is
  begin

    if (i_read = '1') then

      --sig_column <= unsigned(i_cnt);
      --sig_row <= unsigned(i_morse);

      case i_cnt is

        when "001" =>

          case i_morse is
            when "0000" =>
              o_char <= 'E';
              o_7seg <= "0110000"; -- E

            when "0001" =>
              o_char <= 'T';
              o_7seg <= "1110000"; -- T

            when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0010010"; -- 2

          end case;
  .
  .
  .
    else
      o_char <= '_';    -- waiting transmittion to complete
      o_7seg <= "1110111"; -- _
    end if;
```
### Simulace
Na simulaci můžeme vidět JA1 jako tlačítko (morseúv kód), sig_clk je časový signál pro čítač periody daný z hlavního poděleného 100 MHz časového signálu. Samotný výstup se rozliší po stisknutí BTNC, reprezentující "mezeru" mezi písmeny.
Konečná impementace bere 2s za poslední sestupnou hranou jako mezeru mezi písmeny.

![image](doc/sim_top.png)

Implementace pomocí NEXYS A7-50T jako přijímače a Arduino UNO jako vysílače Morzeova kódu

![image](doc/FPGA_new.jpeg)

Průběh písmena P zobrazen na osciloskopu

![image](doc/scope_1.png)