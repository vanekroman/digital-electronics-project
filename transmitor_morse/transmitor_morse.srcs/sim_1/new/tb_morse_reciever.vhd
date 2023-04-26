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

entity tb_morse_reciever is
-- Entity of testbench is always empty
end entity tb_morse_reciever;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------

architecture testbench of tb_morse_reciever is

  -- Counter constants
  constant c_clk_max    : natural := 10;   -- 10
  constant c_clk_period : time    := 1 ns; -- 10 ns

  constant c_cnt_length : natural := 20;
  -- Testbench local signals
  signal sig_clk_100mhz : std_logic;

  signal sig_clk     : std_logic;                    -- Main clock
  signal sig_i_space : std_logic;                    -- Button for next letter
  signal sig_i_logic : std_logic;                    -- Button for morse code input
  signal sig_o_morse : std_logic_vector(3 downto 0); -- Full morse code in respect to o_cnt!
  signal sig_o_cnt   : std_logic_vector(2 downto 0); -- Number of o_morse bits to read 0 - 4
  signal sig_o_read  : std_logic;

  signal sig_o_char  : character;
  signal sig_ascii   : std_logic_vector(7 downto 0); -- Recievered ASCII character

begin

  -- Connecting testbench signals with tb_period_cnt
  -- entity (Unit Under Test)
  uut_period_cnt : entity work.period_cnt
    generic map (
      g_dot_length => c_cnt_length
    )
    port map (
      clk     => sig_clk,
      i_space => sig_i_space,
      i_logic => sig_i_logic,
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
      o_ascii => sig_ascii
    );

  uut_clock_enable : entity work.clock_enable
    generic map (
      g_max => c_clk_max
    )
    port map (
      clk => sig_clk_100mhz,
      rst => '0',
      ce  => sig_clk
    );

  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 1000 ns loop

      sig_clk_100mhz <= '0';
      wait for c_clk_period / 2;
      sig_clk_100mhz <= '1';
      wait for c_clk_period / 2;

    end loop;

    wait; -- Process is suspended forever

  end process p_clk_gen;

  --------------------------------------------------------
  -- Data generation process
  --------------------------------------------------------
  p_stimulus : process is
  begin

    sig_i_space <= '0';
    sig_i_logic <= '0';

    -- 1 DASH
    wait for 20 ns;
    sig_i_logic <= '1';
    wait for 250 ns;
    sig_i_logic <= '0';

    -- 0 DOT
    wait for 90 ns;
    sig_i_logic <= '1';
    wait for 90 ns;
    sig_i_logic <= '0';

    -- 1 DASH
    wait for 20 ns;
    sig_i_logic <= '1';
    wait for 250 ns;
    sig_i_logic <= '0';

    -- 1 DASH
    --wait for 20 ns;
    --sig_i_logic <= '1';
    --wait for 250 ns;
    --sig_i_logic <= '0';

   

    -- FINISH
    wait for 40 ns;
    sig_i_space <= '1';
    wait for 40 ns;
    sig_i_space <= '0';


    wait;
  -- Data generation process is suspended forever

  end process p_stimulus;

end architecture testbench;

