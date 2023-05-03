-- vsg_off
----------------------------------------------------------
--
--! @title Morse Code Reciever
--! @author Roman Vanek
--!
--! @copyright (c) 2023 Roman Vanek
--! This work is licensed under the terms of the MIT license
--!
--! On rising edge of i_read, it assign defined segments on 7 segment
--! display coresponding to i_morse and i_cnt.
--! It assumes 7 segment with active zero logic.
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

  p_morse_reciever : process (i_read, i_morse, i_cnt) is
  begin

    if rising_edge(i_read) then

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

        when "010" =>

          case i_morse is
            when "0000" =>
              o_char <= 'I';
              o_7seg <= "1111001"; -- I

            when "0010" =>
              o_char <= 'A';
              o_7seg <= "0001000"; -- A

            when "0010" =>
              o_char <= 'N';
              o_7seg <= "0001001"; -- N

            when "0011" =>
              o_char <= 'M';
              o_7seg <= "0101011"; -- M

            when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0010010"; -- 2 

          end case;

        when "011" =>

          case i_morse is

            when "0000" =>
              o_char <= 'S';
              o_7seg <= "0100100"; -- S

            when "0100" =>
              o_char <= 'U';
              o_7seg <= "1000001"; -- U

            when "0010" =>
              o_char <= 'R';
              o_7seg <= "0011001"; -- R

            when "0110" =>
              o_char <= 'W';
              o_7seg <= "1010101"; -- W

            when "0001" =>
              o_char <= 'D';
              o_7seg <= "1000010"; -- D

            when "0101" =>
              o_char <= 'K';
              o_7seg <= "0101000"; -- K

            when "0011" =>
              o_char <= 'G';
              o_7seg <= "0100001"; -- G

            when "0111" =>
              o_char <= 'O';
              o_7seg <= "0000001"; -- O

            when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0010010"; -- 2 

          end case;
        
        when "100" =>
        
          case i_morse is

            when "0000" =>
              o_char <= 'H';
              o_7seg <= "1101000"; -- H

            when "1000" =>
              o_char <= 'V';
              o_7seg <= "1000101"; -- V

            when "0100" =>
              o_char <= 'F';
              o_7seg <= "0111000"; -- F

            when "1100" =>
              o_char <= '_';
              o_7seg <= "1110111"; -- _ 

            when "0010" =>
              o_char <= 'L';
              o_7seg <= "1110001"; -- L

            when "1010" =>
              o_char <= '_';
              o_7seg <= "1110111"; -- _ 

            when "0110" =>
              o_char <= 'P';
              o_7seg <= "0011000"; -- P

            when "1110" =>
              o_char <= 'J';
              o_7seg <= "1000011"; -- J

            when "0001" =>
              o_char <= 'B';
              o_7seg <= "1100000"; -- B

            when "1001" =>
              o_char <= 'X';
              o_7seg <= "1001000"; -- X

            when "1010" =>
              o_char <= 'C';
              o_7seg <= "0110001"; -- C

            when "1101" =>
              o_char <= 'Y';
              o_7seg <= "1000100"; -- Y

            when "0011" =>
              o_char <= 'Z';
              o_7seg <= "0010110"; -- Z

            when "1011" =>
              o_char <= 'Q';
              o_7seg <= "0001100"; -- Q

            when "0111" =>
              o_char <= '_';
              o_7seg <= "1110111"; -- _ 

            when "1111" =>
              o_char <= '_';
              o_7seg <= "1110111"; -- _ 

            when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0010010"; -- 2 

          end case;

        when others =>
              o_char <= 'e';    -- ERROR
              o_7seg <= "0010010"; -- 2 

      end case;

    end if;

  end process p_morse_reciever;

end architecture behavioral;
