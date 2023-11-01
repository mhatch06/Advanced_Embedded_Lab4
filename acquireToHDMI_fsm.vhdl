--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Feb 3, 2015
-- File:	acquireToHDMI_fsm.vhdl
-- HW:	Lab2
--	Crs:	ECE 383
--
-- Purp: The control unit for the audio O'scope
--
-- Documentation:	No help, though I used an example from my Digital
--						Design text book.
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
------------------------------------------------------------------------- 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.acquireToHDMI_package.all;					-- include your library here with added components ac97, ac97cmd


entity acquireToHDMI_fsm is
    PORT (  clk : in  STD_LOGIC;
            resetn : in  STD_LOGIC;
            sw: in STD_LOGIC_VECTOR(SW_WIDTH - 1 downto 0);
            cw: out STD_LOGIC_VECTOR (CW_WIDTH - 1 downto 0));
end acquireToHDMI_fsm;

architecture Behavioral of acquireToHDMI_fsm is

	signal state: state_type;	-- define the state_type in your package file	
	signal SHORT_DELAY_DONE_SW,: STD_LOGIC; 
    	signal FORCED_MODE_SW, STORE_INTO_BRAM_SW, CH1_TRIGGER_SW: STD_LOGIC; ADD MORE STATUS WORDS
begin

    SHORT_DELAY_DONE_SW <= sw(SHORT_DELAY_DONE_SW_BIT_INDEX);
	NEED TO DO THE REST OF THE SWS!
    
	-------------------------------------------------------------------------------
	-------------------------------------------------------------------------------
	state_proces: process(clk)  
	begin
		if (rising_edge(clk)) then
			if (resetn = '0') then 
				state <= RESET_STATE;
			else 
				case state is				
					when RESET_STATE =>
						  state <= LONG_DELAY_STATE;

					when LONG_DELAY_STATE =>
						IF (LONG_DELAY_DONE_SW ='1') THEN 
							state <= RESET_AD7606_STATE;
						END IF;

					WHEN RESET_AD7606_STATE =>
						IF (SHORT_DELAY_DONE_SW = '1') THEN
							state <= WAIT_FORCED_STATE;
						END IF;

					WHEN WAIT_FORCED_STATE =>
						IF (SINGLE_SW = '1' AND ) THEN
							state <= SET_STORE_FLAG_STATE; --THIS RIGHT? POSSIBLY ADD IF FOR TRIGGER 
						END IF;
						IF ()

					WHEN SET_STORE_FLAG_STATE =>
						state <= BEGIN_CONVERSION_STATE;

					WHEN BEGIN_CONVERSION_STATE =>
						state <= ASSERT_CONVST_STATE;

					WHEN ASSERT_CONVST_STATE =>
						state <= BUSY
					 TODO

					
						  
				end case;
			end if;
		end if;
	end process;

	-------------------------------------------------------------------------------
    -- Dedicated Control Word spreadsheet
    -------------------------------------------------------------------------------
	output_process: process (state)
	begin
		case state is		
            when RESET_STATE  =>  cw <= '0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'1'&'1'&'1'&'0'&"11"&"11"&"00"&"11"&"11";
		end case;
	end process;	                       

end Behavioral;



