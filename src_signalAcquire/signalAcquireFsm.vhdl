--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Feb 3, 2015 
-- Modified:	Fall 2022
-- File:	lab2_fsm.vhdl
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.signalAcquire_Package.ALL; -- include your library here with added components ac97, ac97cmd

ENTITY signalAcquire_Fsm IS
	PORT (
		clk : IN STD_LOGIC;
		resetn : IN STD_LOGIC;
		sw : IN STD_LOGIC_VECTOR(SW_WIDTH - 1 DOWNTO 0);
		cw : OUT STD_LOGIC_VECTOR (CW_WIDTH - 1 DOWNTO 0));
END signalAcquire_Fsm;

ARCHITECTURE Behavioral OF signalAcquire_Fsm IS

	SIGNAL state : state_type;

	SIGNAL SHORT_DELAY_DONE_SW, LONG_DELAY_DONE_SW, TRIGGER_SW, BUSY_SW, ALL_CHANNELS_READ_SW : STD_LOGIC;

BEGIN

	-- defining intuitive names for the status word bits to make interperting the
	-- logic in the state_process much easier and thus, you'll make fewer errors.
	ALL_CHANNELS_READ_SW <= sw(ALL_CHANNELS_HAVE_BEEN_READ_SW_BIT_INDEX);
	SHORT_DELAY_DONE_SW <= sw(SHORT_DELAY_DONE_SW_BIT_INDEX);
	LONG_DELAY_DONE_SW <= sw(LONG_DELAY_DONE_SW_BIT_INDEX);
	TRIGGER_SW <= sw(START_CONV_SW_BIT_INDEX); -- kinda weird
	BUSY_SW <= sw(BUSY_SW_BIT_INDEX);

	-------------------------------------------------------------------------------
	-------------------------------------------------------------------------------
	state_process : PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (resetn = '0') THEN
				state <= RESET_STATE;
			ELSE
				CASE state IS
					WHEN RESET_STATE =>
						state <= LONG_DELAY_STATE;

					WHEN LONG_DELAY_STATE =>
						IF (LONG_DELAY_DONE_SW = '1') THEN
							state <= RESET_AD7606_STATE;
						END IF;

					WHEN RESET_AD7606_STATE =>
						IF (SHORT_DELAY_DONE_SW = '1') THEN
							state <= WAIT_TRIGGER_STATE;
						END IF;

					WHEN WAIT_TRIGGER_STATE =>
						IF (TRIGGER_SW = '1') THEN
							state <= ASSERT_CONVST_STATE;
						END IF;

					WHEN ASSERT_CONVST_STATE =>
						IF (SHORT_DELAY_DONE_SW = '1') THEN
							state <= WAIT_BUSY_0_STATE;
						END IF;

					WHEN WAIT_BUSY_0_STATE =>
						IF (BUSY_SW = '1') THEN
							state <= WAIT_BUSY_1_STATE;
						END IF;

					WHEN WAIT_BUSY_1_STATE =>
						IF (BUSY_SW = '0') THEN
							state <= WAIT_VALID_DATA_STATE;
						END IF;

					WHEN WAIT_VALID_DATA_STATE =>
						IF (SHORT_DELAY_DONE_SW = '1') THEN
							state <= LATCH_STATE;
						END IF;

					WHEN LATCH_STATE =>
						state <= PAUSE_BETWEEN_CHANNELS_STATE;

					WHEN PAUSE_BETWEEN_CHANNELS_STATE =>
						IF (SHORT_DELAY_DONE_SW = '1') THEN
							state <= CLEAR_SHORT_COUNTER_STATE;
						END IF;

					WHEN CLEAR_SHORT_COUNTER_STATE =>
						IF (ALL_CHANNELS_READ_SW = '1') THEN
							state <= RESET_AD7606_STATE;
						ELSE
							state <= WAIT_VALID_DATA_STATE;
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS;

	-------------------------------------------------------------------------------
	-- LPT: List all the bits of your control word and define their purpose.
	--      cw              Purpose
	--
	-- LPT: Add the truth table for any BBB which are used in the datapath
	--  counter control     Function
	-- 	
	-------------------------------------------------------------------------------
	output_process : PROCESS (state)
	BEGIN
		CASE state IS
			WHEN RESET_STATE => cw <= "11101100000";
			WHEN LONG_DELAY_STATE => cw <= "11101011000";
			WHEN RESET_AD7606_STATE => cw <= "11111110000";
			WHEN WAIT_TRIGGER_STATE => cw <= "11100011000";
			WHEN ASSERT_CONVST_STATE => cw <= "01100010000";
			WHEN WAIT_BUSY_0_STATE => cw <= "11100000000";
			WHEN WAIT_BUSY_1_STATE => cw <= "11100011110";
			WHEN WAIT_VALID_DATA_STATE => cw <= "10000010000";
			WHEN LATCH_STATE => cw <= "10000011101";
			WHEN PAUSE_BETWEEN_CHANNELS_STATE => cw <= "11000010000";
			WHEN CLEAR_SHORT_COUNTER_STATE => cw <= "11000011000";
		END CASE;
	END PROCESS;

END Behavioral;