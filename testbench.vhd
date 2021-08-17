---------------------------------------
-- Sequential comparator Testbench
---------------------------------------
-- Testbench to test the
-- circuit:
--
-- 1) FSM is reset
--    > Guarantee initial equal state
-- 2) 2 inputs are entered into the FSM and compared
-- 3) if inputs are equal (11 or 00) FSM stays in equal state
-- 4) if one input is larger than the other then the FSM will stay in 		> state a if number A is bigger - z_out will remain at 2
--	  > state b if number B is bigger - z_out will remain at 1
---------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity testbench is
-- always empty
end entity;

architecture behaviour of testbench is
  
---------------------------------------
-- 1. Signals
---------------------------------------

  -- Main interface
  signal clk            : std_logic:= '0';
  signal reset          : std_logic:= '1';
  signal x_in           : std_logic_vector(1 downto 0);
  signal z_out          : std_logic_vector(1 downto 0);

begin
  
---------------------------------------
-- 2. DUT
---------------------------------------  
  DUT: entity work.string_det
  port map (
    clk         => clk,
    reset       => reset,
    x_in        => x_in,
    z_out       => z_out
  );
---------------------------------------
-- 3. Support processes
---------------------------------------
  
  -- Clock toggling every 5ns
  ProcClock: process
  begin
    loop
      wait for 5 ns;
      clk <= not clk;
    end loop;
  end process;
  
  -- Reset on start up
  ProcReset: process
  begin
    wait until rising_edge(clk);
    wait for 5 ns;
    reset <= '0';
    wait;
  end process;

  
---------------------------------------
-- 4. Stimulus
---------------------------------------

  ProcStimulus: process
  begin
    
    -- 0) Initialization of inputs
     x_in     <= "00";
    
    -- 1) Reset FSM
    wait until falling_edge(reset);
    
    -- 2) Compare A = 011001111010 and B = 010001111010
    wait until falling_edge(clk);
   	x_in     <= "00";
   	wait until falling_edge(clk);
   	x_in     <= "11";
   	wait until falling_edge(clk);
   	x_in     <= "10";
    wait until falling_edge(clk);
   	x_in     <= "00";
   	wait until falling_edge(clk);
   	x_in     <= "00";
    wait until falling_edge(clk);
   	x_in     <= "11";
   	wait until falling_edge(clk);
   	x_in     <= "11";
    wait until falling_edge(clk);
   	x_in     <= "11";
   	wait until falling_edge(clk);
   	x_in     <= "11";
    wait until falling_edge(clk);
   	x_in     <= "00";
   	wait until falling_edge(clk);
   	x_in     <= "11";
    wait until falling_edge(clk);
   	x_in     <= "00";

    report "Simulation finished" severity failure;
    
  end process;
  
end behaviour;
