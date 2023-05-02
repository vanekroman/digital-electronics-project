----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2023 11:28:28 AM
-- Design Name: 
-- Module Name: hex_7seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity char_7seg is
    Port ( i_blank : in STD_LOGIC;
           i_char : in character;
           o_seg : out STD_LOGIC_VECTOR (6 downto 0));
end char_7seg;

architecture Behavioral of char_7seg is

begin

  --------------------------------------------------------
  -- p_7seg_decoder:
  -- A combinational process for 7-segment display (Common
  -- Anode) decoder. Any time "hex" or "blank" is changed,
  -- the process is "executed". Output pin seg(6) controls
  -- segment A, seg(5) segment B, etc.
  --     segment A
  --      | segment B
  --      |  | segment C
  --      +-+|  |   ...   segment G
  --        ||+-+          |
  --        |||            |
  -- seg = "0000001"-------+
  --
  -- Display is clear/blank if signal blank = 1.
  --------------------------------------------------------

  p_7seg_decoder : process (i_blank, i_char) is

  begin

    if (i_blank = '1') then
      o_seg <= "1111111";     -- Blanking display
    else

      case i_char is

        when 'A' =>

          o_seg <= "0111000"; -- F
        
        when others =>

          --o_seg <= "0111000"; -- F
          o_seg <= "0001000"; -- A

      end case;

    end if;

  end process p_7seg_decoder;

end architecture behavioral;
