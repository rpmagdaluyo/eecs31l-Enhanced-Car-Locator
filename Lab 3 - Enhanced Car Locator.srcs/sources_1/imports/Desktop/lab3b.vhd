----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment3
-- Locator Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Your First Name
-- Student Last Name : Your Last Name
-- Student ID : Your Student ID
----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Locator_beh  is
    Port ( Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end Locator_beh;

architecture Behavioral of Locator_beh  is

   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type :=  (X"0000", X"000A", X"0003", X"0002", X"0006", X"0000", X"0000", X"0000");     

-- do not modify any code above this line
-- additional variables/signals can be declared if needed
-- add your code starting here
    type StateType is
        (Initial, CalcA, CalcTot, Final);
    signal CurrState, NextState: StateType; 
    signal t: std_logic_vector(15 downto 0);
    signal temp: std_logic_vector(31 downto 0); -- temp is used to store a 32-bit number that is the result of a multiplication of 2 16-bit numbers
    signal temp2: std_logic_vector(63 downto 0); -- temp 2 stores a 64-bit number;
begin
        -- Creates a process sensitive to Clk that serves as a clock
        StateReg: process(Clk)
        begin 
            if(Clk = '1' and Clk'event) then
                CurrState <= NextState;
            end if;
        end process;    

        -- Creates a process sensitive to input and decides on what to output based 
        -- on current state and input
        CombLogic: process(CurrState)
        begin
            case CurrState is    
                when Initial =>
                    if (Start = '0') then
                        NextState <= Initial;
                    end if;
                    NextState <= CalcA;
                when CalcA => -- Calculates 1/2at^2
                      temp <= regArray(4) * regArray(4); -- temp = t^2 (32-bit)
                      regArray(5) <=  temp(15 downto 0); -- regArray(5) = t^2 (16-bit)
                      temp <= regArray(5) * regArray(1); -- temp = at^2;
                      regArray(5) <= temp(15 downto 0); -- regArray(5) = at^2;
                      NextState <= CalcTot;
                when CalcTot => -- Calculates the location (1/2at^ + v0t + x0)
                      temp <= regArray(2)*regArray(4); -- temp is used to store v0t
                      regArray(6) <= regArray(5) + temp(15 downto 0) + regArray(3);
                      NextState <= Final;
                when Final => -- Sets Done = 1, Outputs Location;
                      Done <= '1';
                      Loc <= regArray(6);
                      NextState <= Initial;                      
            end case;
        end process;
end Behavioral;

