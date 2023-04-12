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
    g_dot_length  : natural := 5 --! Number of clk pulses to generate one enable signal period
  );
  port (
    clk      : in  std_logic; --! Main clock
    i_space  : in  std_logic; -- Button
    i_logic  : in  std_logic; -- Button
    o_morse  : out std_logic_vector(3 downto 0); -- Full morse code according to o_cnt_n
    o_cnt    : out std_logic_vector(2 downto 0); -- Number of input signals 0 - 4
    o_read   : out std_logic
  );
end entity period_cnt;

------------------------------------------------------------
-- Architecture body for clock enable
------------------------------------------------------------

architecture behavioral of period_cnt is

  -- Local counter
  signal sig_counter : unsigned(31 downto 0) := (others => '0'); --! Local counter
  signal sig_morse   : unsigned(3 downto 0)  := (others => '0'); --! Local counter
  signal sig_cnt     : natural := 0; --! Local counter

begin

  --------------------------------------------------------
  -- p_clk_enable:
  -- Generate clock enable signal. By default, enable signal
  -- is low and generated pulse is always one clock long.
  --------------------------------------------------------
  p_clk_enable : process (clk) is
  begin

    if rising_edge(clk) then -- Synchronous process
      
      if (i_logic = '1') then
        o_read <= '0';                      -- Dont read yet
        sig_counter <= sig_counter + 1;
      elsif (sig_counter > 0) then -- end of logic signal
        -- asigh DASH or DOT to correct position
        if(sig_counter > g_dot_length) then -- DASH
            sig_morse(sig_cnt) <= '1';
        else                                -- DOT
            sig_morse(sig_cnt) <= '0';
        end if;
        -- include new bit definition (Dot / Dash) for whole letter
        sig_cnt <= sig_cnt + 1;    
        o_cnt <= std_logic_vector(to_unsigned(sig_cnt, 3)); 
                
      end if;
      
      if (i_space = '1') then
        o_morse <= std_logic_vector(sig_morse);
        o_read <= '1';                      -- LETTER is completed (init read stage)
        
        sig_counter <= (others => '0');     -- Reset all values
        sig_morse <= (others => '0');
        sig_cnt <= 0;
        -- TODO: use only o_cnt
        o_cnt <= std_logic_vector(to_unsigned(sig_cnt, 3)); 
      end if;
      
    end if;

  end process p_clk_enable;
end architecture behavioral;
