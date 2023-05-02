# VHDL Projekt - Vysílač a přijímač Morseova kódu

### Členové týmu
* Filip Tůma (230896) 
* Viktor Vlček (240709) 
* Roman Vaněk (240707) 

## Teoretický úvod
:blue_square: 1 ČÁRKA     :yellow_square: 0 TEČKA

![image](https://github.com/vanekroman/digital-electronics-project/blob/main/Morse_abeceda.png)

V Morseově kódu jsme našli algoritmus podle kterého jsme postupovali. Z teček jsme udělali logickou 0, z čárek logickou 1. Dále jsme pak počítali počet stisknutí buttonu. Z daného binárního kódu jsme udělali dekadické číslo. Počet zmáčknutí číselně odpovídal abecednímu sloupci. Dekadický kód byl dále určitý znak, který jsme indexovali od 0. Jednotlivá písmena jsme zobrazovali na 7-segmentovém displeji. 

### 7-segment abeceda
![image](7_seg_alphabet.jpg)

## Popis hardwaru
![Period check](doc/period_cnt.svg)    

## Popis softwaru

```vhdl
  -- Local counter
  signal sig_counter : unsigned(31 downto 0) := (others => '0'); --! Local counter
  signal sig_morse   : unsigned(3 downto 0)  := (others => '0'); --! Local counter
  signal sig_cnt     : natural               := 0;               --! Local counter
  signal sig_read    : std_logic             := '0';

begin

  --------------------------------------------------------
  -- p_clk_enable:
  -- Generate clock enable signal. By default, enable signal
  -- is low and generated pulse is always one clock long.
  --------------------------------------------------------
  p_clk_enable : process (clk) is
  begin

    if rising_edge(clk) then                                   -- Synchronous process
      if (i_logic = '1') then
        sig_read    <= '0';
        o_read      <= '0';                                    -- Dont read yet
        sig_counter <= sig_counter + 1;
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
      end if;

      if (i_space = '1' and sig_read = '0') then
        -- LETTER is completed (init read stage)
        o_morse  <= std_logic_vector(sig_morse);
        o_cnt    <= std_logic_vector(to_unsigned(sig_cnt, 3));
        o_read   <= '1';
        sig_read <= '1';

        -- Reset all values
        sig_counter <= (others => '0');
        sig_morse   <= (others => '0');
        sig_cnt     <= 0;
      end if;
    end if;

  end process p_clk_enable;
```

### Simulace

## Reference

