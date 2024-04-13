----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2024 10:04:04
-- Design Name: 
-- Module Name: Simulation_table - Behavioral
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

entity Simulation_table is
--  Port ( );
end Simulation_table;

architecture Behavioral of Simulation_table is
component Digital_function is 
     Port ( clock : in STD_LOGIC;
           CLR : in STD_LOGIC;
           BP_RAZ : in STD_LOGIC;
           BP_start_stop : in STD_LOGIC;
           anode_signal : out STD_LOGIC_VECTOR(3 downto 0);
           point_signal : out STD_LOGIC;
           afficheur_7_signal : out std_logic_vector ( 6 downto 0));
end component; 
signal clock : STD_LOGIC := '0';
signal CLR :  STD_LOGIC := '0';
signal BP_RAZ :  STD_LOGIC := '0';
signal BP_start_stop :  STD_LOGIC := '0';
signal anode_signal :  STD_LOGIC_VECTOR(3 downto 0);
signal point_signal :  STD_LOGIC;
signal afficheur_7_signal :  std_logic_vector ( 6 downto 0);

constant clk_period : time := 10ns;

begin

DF: Digital_function PORT MAP( 
           clock => clock, 
           CLR => CLR, 
           BP_RAZ => BP_RAZ , 
           BP_start_stop => BP_start_stop , 
           anode_signal=> anode_signal , 
           point_signal => point_signal , 
           afficheur_7_signal => afficheur_7_signal );

clk_process : process 
begin 
    clock <= '0';
    wait for clk_period /2;
    clock <= '1';
    wait for clk_period /2;
end process;

stim_proc: process 
begin 

    CLR <= '1'; 
    BP_RAZ <= '0'; 
    BP_start_stop <= '0';
    
    wait for 10 ms; 
  
    CLR <= '0'; 
    BP_RAZ <= '0'; 
    BP_start_stop <= '1';  
    
    wait for 10 ms;
    
    CLR <= '0'; 
    BP_RAZ <= '0'; 
    BP_start_stop <= '0'; 
    
    wait for 40 ms;
    
    CLR <= '0'; 
    BP_RAZ <= '1'; 
    BP_start_stop <= '0';
    
    wait for 10 ms;
    
    CLR <= '0'; 
    BP_RAZ <= '0'; 
    BP_start_stop <= '0';
    
    wait for 10 ms;
    
    CLR <= '0'; 
    BP_RAZ <= '0'; 
    BP_start_stop <= '1';
    
    wait for 10 ms;
    
    CLR <= '0'; 
    BP_RAZ <= '0'; 
    BP_start_stop <= '0';
    
    wait for 10 ms;
    
    CLR <= '0'; 
    BP_RAZ <= '1'; 
    BP_start_stop <= '0';
    
    wait for 10 ms;
    
    CLR <= '0'; 
    BP_RAZ <= '0'; 
    BP_start_stop <= '0';
    
    wait; 

end process; 

end Behavioral;
