
----------------------------------------------------------
--
--! @title Clock enable
--! @author Roman Vanek
--!
--! @copyright (c) 2023 Roman Vanek
--! This work is licensed under the terms of the MIT license
--!
--! Counting period of input signal i_logic then assigns it either '0' or '1'
--! if it is shorter then g_dot_length respectively longer then g_dot_length.
--! Output will be provided when i_space changes to '1' as n-bit value of o_morse.
--! n (number of bits to read) is stored in o_cnt
--! !! Read output values only when o_read is '1' !!
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all; -- Package for arithmetic operations

----------------------------------------------------------
-- Entity declaration for period counter
----------------------------------------------------------

entity period_cnt is
  generic (
    g_dot_length : natural := 5 --! Number of clk pulses to generate one enable signal period
  );
  port (
    clk     : in    std_logic;                    -- Main clock
    i_space : in    std_logic;                    -- Button for next letter
    i_logic : in    std_logic;                    -- Button for morse code input
    o_morse : out   std_logic_vector(3 downto 0); -- Full morse code in respect to o_cnt!
    o_cnt   : out   std_logic_vector(2 downto 0); -- Number of o_morse bits to read 0 - 4
    o_read  : out   std_logic
  );
end entity period_cnt;

------------------------------------------------------------
-- Architecture body for period counter
------------------------------------------------------------

architecture behavioral of period_cnt is

  -- Local counter
  signal sig_counter_0 : natural               := 0;
  signal sig_counter   : unsigned(31 downto 0) := (others => '0');
  signal sig_morse     : unsigned(3 downto 0)  := (others => '0'); 
  signal sig_cnt       : natural               := 0;               --! Local counter
  signal sig_read      : std_logic             := '0';

begin

  --------------------------------------------------------
  -- p_period_cnt:
  -- Local counter is active high. When i_logic is released,
  -- DASH or DOT is assigned to sig_morse at coresponding index.
  -- Output variables o_morse, o_cnt are enabled when i_space is
  -- HIGH (representing space between characters), this event
  -- is signalized by o_read
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
        
        if (sig_counter_0 > 200 and sig_read = '0') then
            o_morse  <= std_logic_vector(sig_morse);
            o_cnt    <= std_logic_vector(to_unsigned(sig_cnt, 3));
            o_read   <= '1';
            sig_read <= '1';
            
            sig_morse   <= (others => '0');
            sig_cnt     <= 0;
        end if;
      end if;

--      if (i_space = '1' and sig_read = '0') then
--        -- LETTER is completed (init read stage)
--        o_morse  <= std_logic_vector(sig_morse);
--        o_cnt    <= std_logic_vector(to_unsigned(sig_cnt, 3));
--        o_read   <= '1';
--        sig_read <= '1';

--        -- Reset all values
--        sig_counter <= (others => '0');
--        sig_morse   <= (others => '0');
--        sig_cnt     <= 0;
--      end if;
    end if;

  end process p_period_cnt;

end architecture behavioral;
