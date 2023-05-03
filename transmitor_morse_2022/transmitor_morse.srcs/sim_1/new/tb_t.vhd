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

entity tb_t is
-- Entity of testbench is always empty
end entity tb_t;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------

architecture testbench of tb_t is

    signal CLK100MHZ   : std_logic;
    signal BTNC        : std_logic;
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
    constant c_clk_period : time    := 10 ns; -- 10 ms
    signal s_clk_coutner : std_logic;


begin

  -- Connecting testbench signals with tb_period_cnt
  -- entity (Unit Under Test)
  uut_top : entity work.top
    port map (
        CLK100MHZ => CLK100MHZ,
        BTNC      => BTNC,
        CA        => CA,
        CB        => CB,
        CC        => CC,
        CD        => CD,
        CE        => CE,
        CF        => CF,
        CG        => CG,
        AN        => AN,
        JA1       => JA1
    );
  
  --------------------------------------------------------
  -- Clock generation process
  --------------------------------------------------------
  p_clk_gen : process is
  begin

    while now < 3000 ms loop

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

    BTNC <= '0';
    JA1 <= '0';

    -- 1 DASH
    wait for 200 ms;
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
    wait for 200 ms;
    BTNC <= '1';
    wait for 600 ms;
    BTNC <= '0';


    wait;
  -- Data generation process is suspended forever

  end process p_stimulus;

end architecture testbench;

