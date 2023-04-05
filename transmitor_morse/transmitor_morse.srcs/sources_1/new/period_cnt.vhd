----------------------------------------------------------
--
--! @title Clock enable
--! @author Roman Vanek
--!
--! @copyright (c) 2023 Roman Vanek
--! This work is licensed under the terms of the MIT license
--!
--! Reads period of input pulse and output boolean value, if the period
--! is within defined value.
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all; -- Package for arithmetic operations

----------------------------------------------------------
-- Entity declaration for clock enable
----------------------------------------------------------

entity period_cnt is
  generic (
    g_MAX : natural := 5 --! Number of clk pulses to generate one enable signal period
  );
  port (
    clk    : in  std_logic; --! Main clock
    rst    : in  std_logic; -- Button
    input  : in  std_logic; -- Button
    output : out std_logic;  -- Button
    cnt    : out std_logic_vector(31 downto 0)
  );
end entity period_cnt;

------------------------------------------------------------
-- Architecture body for clock enable
------------------------------------------------------------

architecture behavioral of period_cnt is

  -- Local counter
  signal sig_cnt : unsigned(31 downto 0) := (others => '0'); --! Local counter

begin

  --------------------------------------------------------
  -- p_clk_enable:
  -- Generate clock enable signal. By default, enable signal
  -- is low and generated pulse is always one clock long.
  --------------------------------------------------------
  p_clk_enable : process (clk) is
  begin

    if rising_edge(clk) then              -- Synchronous process
      
      if (input = '1') then
        sig_cnt <= sig_cnt + 1;
     
      elsif (rst = '1') then
        sig_cnt <= (others => '0');
        
      end if;
      
    end if;

  end process p_clk_enable;
  
  cnt <= std_logic_vector(sig_cnt);
end architecture behavioral;
