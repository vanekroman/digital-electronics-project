-- vsg_off
------------------------------------------------------------
--
-- Testbench for 2-bit binary comparator.
-- TerosHDL, Vivado 2020.2, EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all; -- Package for arithmetic operations

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------

entity tb_top is
-- Entity of testbench is always empty
end entity tb_top;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------

architecture testbench of tb_top is

    signal CLK100MHZ   : std_logic;
    signal CA          : std_logic;
    signal CB          : std_logic;
    signal CC          : std_logic;
    signal CD          : std_logic;
    signal CE          : std_logic;
    signal CF          : std_logic;
    signal CG          : std_logic;
    signal AN          : std_logic_vector(7 downto 0);
    signal JA1         : std_logic; 

    -- Counter constants
    --constant c_clk_max    : natural := 1000000; -- 10 ms
    --constant c_clk_period : time    := 10 ns; -- 100 MHz
    constant c_clk_max    : natural := 10; -- 10 ms
    constant c_clk_period : time    := 1 ms;
    
    constant c_cnt_length : natural := 30; -- > 300 ms => DASH 
    
    signal sig_clk     : std_logic;                    -- Main clock
    
    signal sig_o_morse : std_logic_vector(3 downto 0); -- Full morse code in respect to o_cnt!
    signal sig_o_cnt   : std_logic_vector(2 downto 0); -- Number of o_morse bits to read 0 - 4
    signal sig_o_read  : std_logic;
    
    signal sig_asdasdad    : std_logic_vector(6 downto 0);
    
    signal sig_o_char  : character;

begin

  -- Connecting testbench signals with tb_period_cnt
  -- entity (Unit Under Test)
  uut_period_cnt : entity work.period_cnt
    generic map (
      g_dot_length => c_cnt_length
    )
    port map (
      clk     => sig_clk,
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
    
  
  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 20000 ms loop

      CLK100MHZ <= '0';
      wait for c_clk_period / 2;
      CLK100MHZ <= '1';
      wait for c_clk_period / 2;

    end loop;

    wait; -- Process is suspended forever

  end process p_clk_gen;
  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin
  
    AN <= b"1111_1110";
    
    JA1 <= '0';

    -- 1 DASH
    JA1 <= '1';
    wait for 600 ms;
    JA1 <= '0';

    -- 0 DOT
    wait for 200 ms;
    JA1 <= '1';
    wait for 200 ms;
    JA1 <= '0';

    -- 1 DASH
    wait for 200 ms;
    JA1 <= '1';
    wait for 600 ms;
    JA1 <= '0';

    -- 1 DASH
    --wait for 20 ns;
    --JA1 <= '1';
    --wait for 250 ns;
    --JA1 <= '0';

   

    -- FINISH
    wait for 2000 ms;

    wait;
  -- Data generation process is suspended forever

  end process p_stimulus;

end architecture testbench;

