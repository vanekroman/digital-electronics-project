-- vsg_off
----------------------------------------------------------
--
--! @title Clock enable
--! @author Roman Vanek
--!
--! @copyright (c) 2023 Roman Vanek
--! This work is licensed under the terms of the MIT license
--!
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------


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
        CLK100MHZ   : in std_logic;
        BTNC        : in std_logic;
        CA          : out std_logic;
        CB          : out std_logic;
        CC          : out std_logic;
        CD          : out std_logic;
        CE          : out std_logic;
        CF          : out std_logic;
        CG          : out std_logic;
        AN          : out std_logic_vector(7 downto 0);
        JA1         : in std_logic;
        JA2         : out std_logic
    );
end top;
architecture Behavioral of top is

  -- Counter constants
  constant c_clk_max    : natural := 1000000;   -- 10 ms
  constant c_cnt_length : natural := 30; -- > 300 ms => DASH 

  signal sig_clk      : std_logic;                    -- Main clock

  signal sig_o_morse : std_logic_vector(3 downto 0); -- Full morse code in respect to o_cnt!
  signal sig_o_cnt   : std_logic_vector(2 downto 0); -- Number of o_morse bits to read 0 - 4
  signal sig_o_read  : std_logic;

  signal sig_o_char  : character;

begin

  uut_period_cnt1 : entity work.period_cnt
    generic map (
      g_dot_length => c_cnt_length
    )
    port map (
      clk     => sig_clk,
      i_space => BTNC,
      i_logic => JA1,
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
      o_7seg(6) => CA,
      o_7seg(5) => CB,
      o_7seg(4) => CC,
      o_7seg(3) => CD,
      o_7seg(2) => CE,
      o_7seg(1) => CF,
      o_7seg(0) => CG
    );

  uut_clock_enable : entity work.clock_enable
    generic map (
      g_max => c_clk_max
    )
    port map (
      clk => CLK100MHZ,
      rst => '0',
      ce  => sig_clk
    );
    
   AN <= b"1111_1110";
   
   JA2 <= sig_clk;


end Behavioral;
