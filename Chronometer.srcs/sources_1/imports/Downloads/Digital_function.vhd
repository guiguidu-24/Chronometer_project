----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2024 09:23:13
-- Design Name: 
-- Module Name: Digital_function - Behavioral
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

entity Digital_function is
    Port ( clock : in STD_LOGIC;
           CLR : in STD_LOGIC;
           BP_RAZ : in STD_LOGIC;
           BP_start_stop : in STD_LOGIC;
           anode_signal : out STD_LOGIC_VECTOR(3 downto 0);
           point_signal : out STD_LOGIC;
           afficheur_7_signal : out std_logic_vector ( 6 downto 0));
end Digital_function;

architecture structural of Digital_function is
signal End_signal, Count_enable, RAZ_enable : STD_LOGIC;
signal time_dizaine : integer range 0 to 5;
signal time_unite, time_dixieme, time_centieme : integer range 0 to 9;
component Control_bloc is 
    Port ( CLR : in STD_LOGIC;
           BP_RAZ : in STD_LOGIC;
           BP_start_stop : in STD_LOGIC;
           clock : in STD_LOGIC;
           End_signal : in STD_LOGIC;
           Count_enable : out STD_LOGIC;
           RAZ_enable : out STD_LOGIC);
end component ;


component Compteur is 
    Port ( clock : in STD_LOGIC;
           CLR : in STD_LOGIC;
           RAZ_enable : in STD_LOGIC;
           Count_enable : in STD_LOGIC;
           time_dizaine : out integer range 0 to 5;
           time_unite : out integer range 0 to 9;
           time_dixieme : out integer range 0 to 9;
           time_centieme : out integer range 0 to 9;
           End_signal : out STD_LOGIC);
end component;


component Affichage_block is 
    Port ( clock : in STD_LOGIC;
           CLR : in std_logic ;
           time_dizaine : in integer range 0 to 5;
           time_unite : in integer range 0 to 9;
           time_dixieme : in integer range 0 to 9;
           time_centieme : in integer range 0 to 9;
           anode_signal : out STD_LOGIC_VECTOR(3 downto 0);
           point_signal : out STD_LOGIC;
           afficheur_7_signal : out std_logic_vector ( 6 downto 0));
end component ;


begin
CB: Control_bloc PORT MAP( CLR => CLR,
           BP_RAZ => BP_RAZ ,
           BP_start_stop => BP_start_stop ,
           clock => clock ,
           End_signal => End_signal ,
           Count_enable => Count_enable ,
           RAZ_enable => RAZ_enable );
           
C: Compteur PORT MAP (clock => clock, 
           CLR => CLR, 
           RAZ_enable=> RAZ_enable , 
           Count_enable=> Count_enable ,
           time_dizaine => time_dizaine , 
           time_unite=> time_unite ,
           time_dixieme=> time_dixieme ,
           time_centieme => time_centieme , 
           End_signal => End_signal );
                            
AB: Affichage_block PORT MAP( clock => clock , 
           CLR=> CLR , 
           time_dizaine=> time_dizaine , 
           time_unite => time_unite , 
           time_dixieme => time_dixieme , 
           time_centieme => time_centieme , 
           anode_signal=> anode_signal , 
           point_signal=> point_signal , 
           afficheur_7_signal=> afficheur_7_signal ); 
           
           
end structural ;
