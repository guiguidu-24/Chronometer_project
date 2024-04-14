----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2024 08:16:09
-- Design Name: 
-- Module Name: Affichage_block - Behavioral
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

entity Affichage_block is
    Port ( clock : in STD_LOGIC;
           CLR : in std_logic ;
           time_dizaine : in integer range 0 to 5;
           time_unite : in integer range 0 to 9;
           time_dixieme : in integer range 0 to 9;
           time_centieme : in integer range 0 to 9;
           anode_signal : out STD_LOGIC_VECTOR(3 downto 0);
           point_signal : out STD_LOGIC;
           afficheur_7_signal : out std_logic_vector ( 6 downto 0));
end Affichage_block;

architecture Behavioral of Affichage_block is
signal selected_chiffre : integer range 0 to 9;
signal anode_selected : integer range 0 to 3;
signal counter_1khz : integer range 0 to 99999;
begin

    process (clock, CLR)
    begin 
        if (CLR = '1') then
            anode_selected  <= 0;
            counter_1khz <= 0;
        elsif (clock'event and clock = '1') then
            if (counter_1khz = 99999) then 
                counter_1khz <= 0;
                if (anode_selected  = 3) then
                    anode_selected  <= 0;
                else 
                    anode_selected  <= anode_selected + 1 ;
                end if;
            else 
                counter_1khz <= counter_1khz + 1;
            end if;
        end if;
    end process ;
        
    anode_signal <= "0111" when anode_selected  = 0 else 
        "1011" when anode_selected = 1 else 
        "1101" when anode_selected = 2 else 
        "1110" when anode_selected = 3  else "1111"; 

    point_signal  <= '1' when anode_selected = 1 else '0';
    
    selected_chiffre  <= time_dizaine  when anode_selected  = 0 else 
        time_unite  when anode_selected = 1 else 
        time_dixieme  when anode_selected = 2 else 
        time_centieme  when anode_selected = 3  else 0; 
    
    afficheur_7_signal <= "1001111" when selected_chiffre = 1 else 
        "0010010" when selected_chiffre = 2 else
        "0000110" when selected_chiffre = 3 else
        "1001100" when selected_chiffre = 4 else
        "0100100" when selected_chiffre = 5 else
        "0100000" when selected_chiffre = 6 else
        "0001111" when selected_chiffre = 7 else
        "0000000" when selected_chiffre = 8 else
        "0000100" when selected_chiffre = 9 else
        "0000001" when selected_chiffre = 0 else "1111111";
    
end Behavioral;

