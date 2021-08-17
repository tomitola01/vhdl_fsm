---------------------------------------
-- Sequential Comparator FSM
---------------------------------------
-- Author: Tolu Omitola
---------------------------------------

--library declarations
library ieee;
use ieee.std_logic_1164.all;


entity string_det is
Port ( 
clk 	: in std_logic;
reset 	: in std_logic;
x_in 	: in std_logic_vector(1 downto 0);--input for multi-bit numbers
z_out 	: out std_logic_vector(1 downto 0)--output comparing numbers
);

end string_det;

architecture bit_sequence of string_det is

type state_type is (eq, a, b); --States are either equal, A is bigger or B is bigger
signal current_state: state_type;
signal next_state 	: state_type;

begin
NextState : process(clk, reset, current_state)
begin
  case current_state is
    
  -- For the equal STATE if the state is equal
  when eq => -- every state will have 2 outgoing transitions 
  
   -------------- For STATE eq --------------
    if x_in = "00" then
       next_state <= eq;z_out <= "00";
    elsif x_in = "11" then
       next_state <= eq;z_out <= "00";
    elsif x_in = "10" then
       next_state <= a;z_out <= "10";
    else
    	next_state <= b;z_out <= "01";
    end if;
   -------------- For STATE a --------------
   when a =>
   	next_state <= a;z_out <= "10";
    
    -------------- For STATE b --------------
   when b =>
   	next_state <= b;z_out <= "01";
    
  end case;
  
end process NextState;

--rising edge triggered flip flop with active high, asynchronous reset 
StateFF :process (clk, next_state)
begin
  if reset = '1' then
  	current_State <= eq;
  elsif rising_edge(clk) then
  	current_State <= next_state;
  end if;
  
end process StateFF;

end bit_sequence;
