----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment3
-- Locator Structural Model
----------------------------------------------------------------------
-- Student First Name : Richard 
-- Student Last Name : Magdaluyo
-- Student ID : 45993793
----------------------------------------------------------------------

---------- Components library ----------

---------- 8x16 Register File ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegFile IS
   PORT (R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
         R_en, W_en: IN std_logic;
         Reg_Data1 : OUT std_logic_vector(15 DOWNTO 0); 
			Reg_Data2 : OUT std_logic_vector(15 DOWNTO 0); 
         W_Data: IN std_logic_vector(15 DOWNTO 0); 
         Clk, Rst: IN std_logic);
END RegFile;

ARCHITECTURE Beh OF RegFile IS 
   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type;
BEGIN
   WriteProcess: PROCESS(Clk)    
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            regArray(0) <= X"0000" AFTER 6.0 NS;
            regArray(1) <= X"000A" AFTER 6.0 NS;
            regArray(2) <= X"0003" AFTER 6.0 NS;
            regArray(3) <= X"0002" AFTER 6.0 NS;
            regArray(4) <= X"0006" AFTER 6.0 NS;
            regArray(5) <= X"0000" AFTER 6.0 NS;
            regArray(6) <= X"0000" AFTER 6.0 NS;
            regArray(7) <= X"0000" AFTER 6.0 NS;
         ELSE
            IF (W_en = '1') THEN
                regArray(conv_integer(W_Addr)) <= W_Data AFTER 6.0 NS;
                END IF;
        END IF;
     END IF;
   END PROCESS;
            
   ReadProcess1: PROCESS(R_en, R_Addr1, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr1 IS
            WHEN "000" =>
                Reg_Data1 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data1 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data1 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data1 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data1 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data1 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data1 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data1 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
	
    ReadProcess2: PROCESS(R_en, R_Addr2, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr2 IS
            WHEN "000" =>
                Reg_Data2 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data2 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data2 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data2 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data2 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data2 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data2 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data2 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
END Beh;


---------- 16-Bit ALU ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY ALU IS
    PORT (Sel: IN std_logic;
            A: IN std_logic_vector(15 DOWNTO 0);
            B: IN std_logic_vector(15 DOWNTO 0);
            ALU_Out: OUT std_logic_vector (15 DOWNTO 0) );
END ALU;

ARCHITECTURE Beh OF ALU IS

BEGIN
    PROCESS (A, B)
         variable temp: std_logic_vector(31 DOWNTO 0):= X"00000000";
    BEGIN
        IF (Sel = '0') THEN
            ALU_Out <= A + B AFTER 12 NS;                
        ELSIF (Sel = '1') THEN
            temp := A * B ;
                ALU_Out <= temp(15 downto 0) AFTER 12 NS; 
        END IF;
          
    END PROCESS;
END Beh;


---------- 16-bit Shifter ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Shifter IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         sel: IN std_logic );
END Shifter;

ARCHITECTURE Beh OF Shifter IS 
BEGIN
   PROCESS (I,sel) 
   BEGIN
         IF (sel = '1') THEN 
            Q <= I(14 downto 0) & '0' AFTER 4.0 NS;
         ELSE
            Q <= '0' & I(15 downto 1) AFTER 4.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 2-to-1 Selector ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Selector IS
   PORT (sel: IN std_logic;
         x,y: IN std_logic_vector(15 DOWNTO 0);
         f: OUT std_logic_vector(15 DOWNTO 0));
END Selector;

ARCHITECTURE Beh OF Selector IS 
BEGIN
   PROCESS (x,y,sel)
   BEGIN
         IF (sel = '0') THEN
            f <= x AFTER 3.0 NS;
         ELSE
            f <= y AFTER 3.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 16-bit Register ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         Ld: IN std_logic; 
         Clk, Rst: IN std_logic );
END Reg;

ARCHITECTURE Beh OF Reg IS 
BEGIN
   PROCESS (Clk)
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            Q <= X"0000" AFTER 4.0 NS;
         ELSIF (Ld = '1') THEN
            Q <= I AFTER 4.0 NS;
         END IF;   
      END IF;
   END PROCESS; 
END Beh;

---------- 16-bit Three-state Buffer ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ThreeStateBuff IS
    PORT (Control_Input: IN std_logic;
          Data_Input: IN std_logic_vector(15 DOWNTO 0);
          Output: OUT std_logic_vector(15 DOWNTO 0) );
END ThreeStateBuff;

ARCHITECTURE Beh OF ThreeStateBuff IS
BEGIN
    PROCESS (Control_Input, Data_Input)
    BEGIN
        IF (Control_Input = '1') THEN
            Output <= Data_Input AFTER 2 NS;
        ELSE
            Output <= (OTHERS=>'Z') AFTER 2 NS;
        END IF;
    END PROCESS;
END Beh;

---------- Controller ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Controller IS
    PORT(R_en: OUT std_logic;
         W_en: OUT std_logic;
         R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
			R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
         W_Addr: OUT std_logic_vector(2 DOWNTO 0);
         Shifter_sel: OUT std_logic;
         Selector_sel: OUT std_logic;
         ALU_sel : OUT std_logic;
         OutReg_Ld: OUT std_logic;
         Oe: OUT std_logic;
         Done: OUT std_logic;
         Start, Clk, Rst: IN std_logic); 
END Controller;


ARCHITECTURE Beh OF Controller IS

-------------------------------------------------------
-- Hint:
-- Controller shall consist of a CombLogic process 
-- containing case-statement and a StateReg process.
--      
-------------------------------------------------------

 -- add your code here
    
    type StateType is
        (Initial, CalcA, CalcB, CalcC, CalcD, CalcE, CalcF, Final);
    signal CurrState, NextState: StateType;
    
begin
    ControllerStateReg: process(Clk, CurrState)
    begin
		if(Clk = '1' and Clk'event) then
            CurrState <= NextState after 5ns;
        end if;
    end process;  
        
	ControllerCombLogic: process(CurrState, Start)
	begin
		case CurrState is
			when Initial =>
			    if(Rst = '1') then
                    NextState <= Initial after 5ns;
                else
                    NextState <= CalcA after 5ns;
                            end if; 
				Done <= '0';
				
				R_en <= '1';
				R_Addr1 <= "000";
				R_Addr2 <= "000";
				W_en <= '0';
				W_Addr <= "000";
				
				ALU_sel <= '0';
				
				Shifter_sel <= '0';
				
				Selector_sel <= '0';
				
				OutReg_Ld <= '0';
				
				Oe <= '0';				
			when CalcA =>
			    NextState <= CalcB after 5ns;
				Done <= '0';
            
                R_en <= '1';
                R_Addr1 <= "100";
                R_Addr2 <= "100";
                W_en <= '1' after 22ns;
                W_Addr <= "101";
            
                ALU_sel <= '1';
            
                Shifter_sel <= '0';
            
                Selector_sel <= '1';
            
                OutReg_Ld <= '0';
			when CalcB =>
				NextState <= CalcC after 5ns;			
				Done <= '0';
            
                R_en <= '1';
                R_Addr1 <= "001";
                R_Addr2 <= "101";
                W_en <= '1' after 22ns;
                W_Addr <= "101";
            
                ALU_sel <= '1';
            
                Shifter_sel <= '0';
            
                Selector_sel <= '1';
            
                OutReg_Ld <= '0';
			when CalcC =>
			    NextState <= CalcD after 5ns;
				Done <= '0';
            
                R_en <= '1';
                R_Addr1 <= "000";
                R_Addr2 <= "101";
                W_en <= '1' after 22ns;
                W_Addr <= "101";
            
                ALU_sel <= '0';
            
                Shifter_sel <= '0';
            
                Selector_sel <= '0';
            
                OutReg_Ld <= '0';
			when CalcD =>
			    NextState <= CalcE after 5ns;
				Done <= '0';
            
                R_en <= '1';
                R_Addr1 <= "010";
                R_Addr2 <= "100";
                W_en <= '1' after 22ns;
                W_Addr <= "110";
            
                ALU_sel <= '1';
            
                Shifter_sel <= '0';
            
                Selector_sel <= '1';
            
                OutReg_Ld <= '0';
			when CalcE =>
			    NextState <= CalcF after 5ns; 
				Done <= '0';
            
                R_en <= '1';
                R_Addr1 <= "101";
                R_Addr2 <= "110";
                W_en <= '1' after 22ns;
                W_Addr <= "101";
            
                ALU_sel <= '0';
            
                Shifter_sel <= '0';
            
                Selector_sel <= '1';
            
                OutReg_Ld <= '0';
			when CalcF =>
			    NextState <= Final after 5ns; 
				Done <= '0';
            
                R_en <= '1';
                R_Addr1 <= "101";
                R_Addr2 <= "000";
                W_en <= '0';
                W_Addr <= "000";
            
                ALU_sel <= '0';
            
                Shifter_sel <= '0';
            
                Selector_sel <= '1';
            
                OutReg_Ld <= '1';
			when Final =>
			    NextState <= Initial after 5ns; 
				Done <= '1';
            
                R_en <= '0';
                R_Addr1 <= "000";
                R_Addr2 <= "000";
                W_en <= '0';
                W_Addr <= "000";
            
                ALU_sel <= '0';
            
                Shifter_sel <= '0';
            
                Selector_sel <= '0';
            
                OutReg_Ld <= '1';
                Oe <= '1';
		end case;
	end process;
END Beh;


---------- Locator (with clock cycle =  37 NS )----------
--         INDICATE YOUR CLOCK CYCLE TIME ABOVE      ----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity lab3s is
    Port ( Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end lab3s;

architecture Struct of lab3s is
    COMPONENT RegFile IS
        PORT (  R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
                R_en, W_en: IN std_logic;
                Reg_Data1: OUT std_logic_vector(15 DOWNTO 0); 
			    Reg_Data2: OUT std_logic_vector(15 DOWNTO 0);
                W_Data: IN std_logic_vector(15 DOWNTO 0); 
                Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ALU IS
        PORT (Sel: IN std_logic;
                A: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                ALU_Out: OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
    END COMPONENT;

    COMPONENT Shifter IS
         PORT (I: IN std_logic_vector(15 DOWNTO 0);
               Q: OUT std_logic_vector(15 DOWNTO 0);
               sel: IN std_logic );
    END COMPONENT;

    COMPONENT Selector IS
        PORT (sel: IN std_logic;
              x,y: IN std_logic_vector(15 DOWNTO 0);
              f: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
   
    COMPONENT Reg IS
        PORT (I: IN std_logic_vector(15 DOWNTO 0);
              Q: OUT std_logic_vector(15 DOWNTO 0);
              Ld: IN std_logic; 
              Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ThreeStateBuff IS
        PORT (Control_Input: IN std_logic;
              Data_Input: IN std_logic_vector(15 DOWNTO 0);
              Output: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
    
    COMPONENT Controller IS
       PORT(R_en: OUT std_logic;
            W_en: OUT std_logic;
            R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
			R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
            W_Addr: OUT std_logic_vector(2 DOWNTO 0);
            Shifter_sel: OUT std_logic;
            Selector_sel: OUT std_logic;
            ALU_sel : OUT std_logic;
            OutReg_Ld: OUT std_logic;
            Oe: OUT std_logic;
            Done: OUT std_logic;
            Start, Clk, Rst: IN std_logic); 
     END COMPONENT;

-- do not modify any code above this line
-- add signals needed below. hint: name them something you can keep track of while debugging/testing
-- add your code starting here

	-- Input signals for each component
	-- RegFile Inputs
	signal R_en: std_logic;
    signal W_en: std_logic;
	signal R_Addr1: std_logic_vector(2 DOWNTO 0);
	signal R_Addr2: std_logic_vector(2 DOWNTO 0);
	signal W_Addr: std_logic_vector(2 DOWNTO 0);

	-- Shifter Input
	signal Shifter_sel: std_logic;

	-- Selector Input
	signal Selector_sel: std_logic;
	
	-- ALU Input
	signal ALU_sel : std_logic;

	-- OutReg Input
	signal OutReg_Ld: std_logic;

	-- TriStateBuffer Input
	signal Oe: std_logic;

	-- Output signals from each component;
	-- RegFile Outputs
	signal Reg_Data1: std_logic_vector(15 downto 0);
	signal Reg_Data2: std_logic_vector(15 downto 0);
	signal W_Data: std_logic_vector(15 downto 0);
	
	-- ALU Output
	signal ALU_Out: std_logic_vector(15 downto 0);

    -- Shifter Output
	signal Shifter_Out: std_logic_vector(15 downto 0);

    -- Selector Output
	signal Selector_Out: std_logic_vector(15 downto 0);

    -- OutReg Output
	signal OutReg_Out: std_logic_vector(15 downto 0);
	
begin	
	-- Map each signal to the corresponding components
	-- Controller
	Controller_1: Controller port map(
		Start => Start,
		Rst => Rst,
		Clk => Clk,
		R_en => R_en,
		W_en => W_en,
		R_Addr1 => R_Addr1,
		R_Addr2 => R_Addr2,
		Shifter_sel => Selector_sel,
        Selector_sel => Selector_sel,
        ALU_sel => ALU_sel,
        OutReg_Ld => OutReg_Ld,
        Oe => Oe,
        Done => Done);
	
	-- DataPath
	RegFile_1: RegFile port map(
		R_Addr1 => R_Addr1, 
		R_Addr2 => R_Addr2, 
		W_Addr => W_Addr, 
		R_en => R_en, 
		W_en => W_en, 
		Reg_Data1 => Reg_Data1, 
		Reg_Data2 => Reg_Data2, 
		W_Data => W_Data, 
		Clk => Clk, 
		Rst => Rst);
	ALU_1: ALU port map(
		Sel => ALU_sel,
		A => Reg_Data1,
		B => Reg_Data2,
		ALU_Out => ALU_Out);
	Shifter_1: Shifter port map(
	    I => ALU_Out,
	    Q => Shifter_Out,
	    sel => Shifter_sel);
	Selector_1: Selector port map(
	    sel => Selector_sel,
	    x => ALU_Out,
	    y => Shifter_Out,
	    f => Selector_Out);
	OutReg_1: Reg port map(
	    I => Selector_Out,
	    Q => OutReg_Out,
	    Ld => OutReg_Ld,
		Clk => Clk, 
		Rst => Rst);
	TriStateBuffer_1: ThreeStateBuff port map(
	    Control_Input => Oe,
	    Data_Input => OutReg_Out,
	    Output => Loc);	
end Struct;
