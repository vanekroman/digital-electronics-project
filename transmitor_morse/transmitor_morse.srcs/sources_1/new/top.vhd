----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2023 11:46:25 AM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port 
    ( 
        CLK100MHZ : in STD_LOGIC;
        BTNC : in STD_LOGIC;
        BTNU : in STD_LOGIC
    );
end top;
architecture Behavioral of top is

    signal sig_cnt_32bit : std_logic_vector(31 downto 0); --! Counter0

begin

  --------------------------------------------------------
  -- Instance (copy) of clock_enable entity
  --------------------------------------------------------
  period_cnt0 : entity work.period_cnt
      generic map(
          g_MAX => 5
      )
      port map(
          clk => CLK100MHZ,
          rst => BTNU,
          input => BTNC,
          cnt  => sig_cnt_32bit
      );

end Behavioral;
