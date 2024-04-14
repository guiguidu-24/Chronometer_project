----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2024 16:28:29
-- Design Name: 
-- Module Name: Control_bloc - Behavioral
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

entity Control_bloc is
    Port ( CLR : in STD_LOGIC;
           BP_RAZ : in STD_LOGIC;
           BP_start_stop : in STD_LOGIC;
           clock : in STD_LOGIC;
           End_signal : in STD_LOGIC;
           Count_enable : out STD_LOGIC;
           RAZ_enable : out STD_LOGIC);
end Control_bloc;

architecture Behavioral of Control_bloc is
    type state is (comptage, comptage_to_pause, pause, RAZ_state, pause_to_comptage);
    signal pr_state, nx_state: state ;
begin
    process (CLR, clock)
    begin 
        if (CLR = '1') then 
            pr_state <= pause;
         elsif (clock'event and clock='1') then
            pr_state <= nx_state ;
        end if;
     end process;
     
     process(BP_start_stop , BP_RAZ, CLR, End_signal)
     begin 
        case pr_state is 
            when pause => 
                if (BP_start_stop = '1' and End_signal = '0') then 
                    nx_state <= pause_to_comptage ;
                 elsif (BP_RAZ = '1' ) then 
                    nx_state <= RAZ_state ;
                 else 
                    nx_state <= pause ;
                 end if;
             when pause_to_comptage => 
                if (BP_start_stop = '0') then
                    nx_state <= comptage ;
                else 
                    nx_state <= pause_to_comptage ;
                end if;
             when comptage => 
                if (BP_start_stop = '1') then
                    nx_state <= comptage_to_pause  ;
                elsif (End_signal = '1') then
                    nx_state <= pause;   
                else
                    nx_state <= comptage ;
                end if;
             when comptage_to_pause  => 
                if (BP_start_stop = '0') then
                    nx_state <= pause   ;
                else 
                    nx_state <= comptage_to_pause  ;
                end if;
             when RAZ_state  => 
                if (BP_RAZ  = '0') then
                    nx_state <= pause  ;
                else 
                    nx_state <= RAZ_state   ;
                end if;
         end case;
    end process;
    
    
    Count_enable <= '1' when pr_state = pause_to_comptage or pr_state = comptage
        else '0';
    RAZ_enable <= '1' when pr_state = RAZ_state
        else '0';   
end Behavioral;
