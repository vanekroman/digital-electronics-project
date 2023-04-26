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
    o_7seg  : out   std_logic_vector(6 downto 0)
  );
end entity morse_reciever;

------------------------------------------------------------
-- Architecture body for clock enable
------------------------------------------------------------

architecture behavioral of morse_reciever is

  -- Local counter
  --signal sig_row    : unsigned := 0;
  --signal sig_column : unsigned := 0;

begin

  --------------------------------------------------------
  -- p_clk_enable:
  -- Generate clock enable signal. By default, enable signal
  -- is low and generated pulse is always one clock long.
  --------------------------------------------------------
  p_morse_reciever : process (i_read, i_morse, i_read) is
  begin

    if rising_edge(i_read) then

      --sig_column <= unsigned(i_cnt);
      --sig_row <= unsigned(i_morse);

      case i_cnt is

        when "001" =>

          case i_morse is
            when "0000" =>
              o_char <= 'E';

            when "0001" =>
              o_char <= 'T';

            when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0111000"; -- F

          end case;

        when "010" =>

          case i_morse is
            when "0000" =>
              o_char <= 'I';
              o_7seg <= "1111001"; -- I

            when "0001" =>
              o_char <= 'A';
              o_7seg <= "0001000"; -- A

            when "0010" =>
              o_char <= 'N';

            when "0011" =>
              o_char <= 'M';

            when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0111000"; -- F

          end case;

        when "011" =>

          case i_morse is

            when "0000" =>
              o_char <= 'S';

            when "0001" =>
              o_char <= 'U';

            when "0010" =>
              o_char <= 'R';

            when "0011" =>
              o_char <= 'W';

            when "0100" =>
              o_char <= 'D';

            when "0101" =>
              o_char <= 'K';
              o_7seg <= "0101000"; -- K

            when "0110" =>
              o_char <= 'G';

            when "0111" =>
              o_char <= 'O';

            when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0111000"; -- F

          end case;
        
        when "100" =>
        
          case i_morse is

            when "0000" =>
              o_char <= 'H';

            when "0001" =>
              o_char <= 'V';

            when "0010" =>
              o_char <= 'F';

            when "0011" =>
              o_char <= '_';

            when "0100" =>
              o_char <= 'L';

            when "0101" =>
              o_char <= '_';

            when "0110" =>
              o_char <= 'P';

            when "0111" =>
              o_char <= 'J';

            when "1000" =>
              o_char <= 'B';

            when "1001" =>
              o_char <= 'X';
              o_7seg <= "1001000"; -- X

            when "1010" =>
              o_char <= 'C';

            when "1011" =>
              o_char <= 'Y';

            when "1100" =>
              o_char <= 'Z';

            when "1101" =>
              o_char <= 'Q';

            when "1110" =>
              o_char <= '_';

            when "1111" =>
              o_char <= '_';

            when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0111000"; -- F

          end case;

        when others =>
          o_char <= 'P';    -- ERROR
          o_7seg <= "0111000"; -- F

      end case;

    end if;

  end process p_morse_reciever;

end architecture behavioral;
