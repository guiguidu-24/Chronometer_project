----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2024 16:59:03
-- Design Name: 
-- Module Name: Compteur - Behavioral
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

entity Compteur is
    Port ( clock : in STD_LOGIC;
           CLR : in STD_LOGIC;
           RAZ_enable : in STD_LOGIC;
           Count_enable : in STD_LOGIC;
           time_dizaine : inout integer range 0 to 5;
           time_unite : inout integer range 0 to 9;
           time_dixieme : inout integer range 0 to 9;
           time_centieme : inout integer range 0 to 9;
           End_signal : out STD_LOGIC);
end Compteur;

architecture Behavioral of Compteur is
signal ctr_1kHz  : integer  range 0 to 99999;
begin
    process(clock, CLR)
    begin 
        if CLR = '1' then 
            time_dizaine <= 0;
            time_unite <= 0;
            time_dixieme <= 0;
            time_centieme <= 0;
            ctr_1kHz <=0;
        elsif rising_edge(clock)then
            if ctr_1kHz = 99999 then 
                ctr_1kHz <= 0;
                if (RAZ_enable = '1') then
                    time_dizaine <=0;
                    time_unite  <=0;
                    time_dixieme  <=0;
                    time_centieme  <=0;
                elsif time_dizaine = 5 and time_unite = 9 and time_dixieme = 9 and time_centieme = 9 then 
                    End_signal  <= '1';
                elsif (Count_enable = '1') then -- doit on mettre le else count enable = 0 ? 
                    End_signal <= '0';
                    if time_centieme = 9 then 
                        time_centieme <= 0;
                        if time_dixieme  = 9 then 
                            time_dixieme <= 0;
                            if time_unite = 9 then
                                time_unite <= 0;
                                time_dizaine <= time_dizaine + 1;
                            else
                                time_unite   <= time_unite  + 1;
                            end if;
                        else 
                            time_dixieme  <= time_dixieme + 1;
                        end if;
                    else
                        time_centieme <= time_centieme + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
