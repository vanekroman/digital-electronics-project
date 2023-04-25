-- vsg_off
----------------------------------------------------------
--
--! @title Morse Code Reciever
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
-- Entity declaration for clock enable
----------------------------------------------------------

entity morse_reciever is
  port (
    i_morse : in    std_logic_vector(3 downto 0); -- Full morse code in respect to o_cnt!
    i_cnt   : in    std_logic_vector(2 downto 0); -- Number of o_morse bits to read 0 - 4
    i_read  : in    std_logic;
    o_char  : out   character;
    o_ascii : out   std_logic_vector(7 downto 0)
  );
end entity morse_reciever;

------------------------------------------------------------
-- Architecture body for clock enable
------------------------------------------------------------

architecture behavioral of morse_reciever is

  -- Local counter
  signal sig_row    : natural := 0;
  signal sig_column : natural := 0;

begin

  --------------------------------------------------------
  -- p_clk_enable:
  -- Generate clock enable signal. By default, enable signal
  -- is low and generated pulse is always one clock long.
  --------------------------------------------------------
  p_morse_reciever : process (i_read, i_morse, i_read) is
  begin

    if rising_edge(i_read) then

      sig_column <= to_integer(unsigned(i_cnt));
      sig_row <= to_integer(unsigned(i_morse));

      case sig_column is

        when 1 =>

          case sig_row is
            when 0 =>
              o_char <= 'E';
              o_ascii <= std_logic_vector(to_unsigned(69, 7));

            when 1 =>
              o_char <= 'T';

            when others =>
              o_char <= 'e';    -- ERROR

          end case;

        when 2 =>

          case sig_row is
            when 0 =>
              o_char <= 'I';

            when 1 =>
              o_char <= 'A';

            when 2 =>
              o_char <= 'N';

            when 3 =>
              o_char <= 'M';

            when others =>
              o_char <= 'e';    -- ERROR

          end case;

        when 3 =>

          case sig_row is

            when 0 =>
              o_char <= 'S';

            when 1 =>
              o_char <= 'U';

            when 2 =>
              o_char <= 'R';

            when 3 =>
              o_char <= 'W';

            when 4 =>
              o_char <= 'D';

            when 5 =>
              o_char <= 'K';

            when 6 =>
              o_char <= 'G';

            when 7 =>
              o_char <= 'O';

            when others =>
              o_char <= 'e';    -- ERROR

          end case;
        
        when 4 =>
        
          case sig_row is

            when 0 =>
              o_char <= 'H';

            when 1 =>
              o_char <= 'V';

            when 2 =>
              o_char <= 'F';

            when 3 =>
              o_char <= '_';

            when 4 =>
              o_char <= 'L';

            when 5 =>
              o_char <= '_';

            when 6 =>
              o_char <= 'P';

            when 7 =>
              o_char <= 'J';

            when 8 =>
              o_char <= 'B';

            when 9 =>
              o_char <= 'X';
              o_ascii <= std_logic_vector(to_unsigned(88, 7));

            when 10 =>
              o_char <= 'C';

            when 11 =>
              o_char <= 'Y';

            when 12 =>
              o_char <= 'Z';

            when 13 =>
              o_char <= 'Q';

            when 14 =>
              o_char <= '_';

            when 15 =>
              o_char <= '_';

            when others =>
              o_char <= 'e';    -- ERROR

          end case;

        when others =>
          o_char <= 'e';    -- ERROR

      end case;

    end if;

  end process p_morse_reciever;

end architecture behavioral;
