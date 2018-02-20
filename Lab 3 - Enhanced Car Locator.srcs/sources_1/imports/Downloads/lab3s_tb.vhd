--------------------------------------------------------------------------------
-- Company: UCI Super Awesome Coding Team
-- Engineer: QV (template only) and <your name here>
--
-- Create Date:   
-- Design Name:   
-- Module Name:   
-- Project Name:  
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Integrator_struct
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL; -- for write, writelin
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY lab3s_tb IS
END lab3s_tb;
 
ARCHITECTURE behavior OF lab3s_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Lab3s
    PORT(
         Start : IN  std_logic;
         Rst : IN  std_logic;
         Clk : IN  std_logic;
         Loc : OUT  std_logic_vector(15 downto 0);
         Done : OUT  std_logic
        );
    END COMPONENT;
    


   --Inputs
   signal Start : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';

    --Outputs
   signal Loc : std_logic_vector(15 downto 0);
   signal Done : std_logic;


   -- Clock period definitions
   constant Clk_period : time := 37 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   
   uut: Lab3s PORT MAP (
          Start => Start,
          Rst => Rst,
          Clk => Clk,
          Loc => Loc,
          Done => Done
        );


   -- Clock process definitions
   Clk_process :process
   begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   variable stringbuff : LINE;
   begin        
        WRITE (stringbuff, string'("Simulation starts at "));
        WRITE (stringbuff, now);
        WRITELINE (output, stringbuff);

        Rst <= '1';
        WAIT FOR 100 NS; -- allow time for everything to rst
        Rst <= '0';
		
		-- your stimulus here
		Start <= '1';
		wait;

        wait; -- will wait forever
   end process;

END;