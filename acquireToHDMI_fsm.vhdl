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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.acquireToHDMI_package.ALL; -- include your library here with added components ac97, ac97cmd

ENTITY acquireToHDMI_fsm IS
	PORT (
		clk : IN STD_LOGIC;
		resetn : IN STD_LOGIC;
		sw : IN STD_LOGIC_VECTOR(SW_WIDTH - 1 DOWNTO 0);
		cw : OUT STD_LOGIC_VECTOR (CW_WIDTH - 1 DOWNTO 0));
END acquireToHDMI_fsm;

ARCHITECTURE Behavioral OF acquireToHDMI_fsm IS

	SIGNAL state : state_type; -- define the state_type in your package file	

	-- status words
	SIGNAL
	AD7606_BUSY_SW,
	STORE_TO_BRAM_SW,
	CH2_TRIGGER_SW,
	CH1_TRIGGER_SW,
	LONG_DELAY_SW,
	SHORT_DELAY_SW,
	FULL_SW,
	SAMPLE_SW,
	TRIGGER_SW,
	STORE_SW,
	FORCED_SW,
	SINGLE_SW : STD_LOGIC;

BEGIN

	-- status words
	AD7606_BUSY_SW <= sw(AD7606_BUSY_SW_INDEX);
	STORE_TO_BRAM_SW <= sw(STORE_TO_BRAM_SW_INDEX);
	CH2_TRIGGER_SW <= sw(CH2_TRIGGER_SW_INDEX);
	CH1_TRIGGER_SW <= sw(CH1_TRIGGER_SW_INDEX);
	LONG_DELAY_SW <= sw(LONG_DELAY_SW_INDEX);
	SHORT_DELAY_SW <= sw(SHORT_DELAY_SW_INDEX);
	FULL_SW <= sw(FULL_SW_INDEX);
	SAMPLE_SW <= sw(SAMPLE_SW_INDEX);
	TRIGGER_SW <= sw(TRIGGER_SW_INDEX);
	STORE_SW <= sw(STORE_SW_INDEX);
	FORCED_SW <= sw(FORCED_SW_INDEX);
	SINGLE_SW <= sw(SINGLE_SW_INDEX);

	-------------------------------------------------------------------------------
	-------------------------------------------------------------------------------
	state_proces : PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (resetn = '0') THEN
				state <= RESET_STATE;
				ELSE
				CASE state IS
					WHEN RESET_STATE =>
						state <= LONG_DELAY_STATE;

					WHEN LONG_DELAY_STATE =>
						IF (LONG_DELAY_SW = '1') THEN
							state <= RESET_AD7606_STATE;
						END IF;

					WHEN RESET_AD7606_STATE =>
						IF (SHORT_DELAY_SW = '1') THEN
							state <= WAIT_FORCED_STATE;
						END IF;

					WHEN WAIT_FORCED_STATE =>
						IF (FORCED_SW = '0') THEN
							state <= SET_STORE_FLAG_STATE;
						ELSIF (SINGLE_SW = '1' AND FORCED_SW = '1') THEN
							state <= SET_STORE_FLAG_STATE;
						END IF;

					WHEN SET_STORE_FLAG_STATE => --
						state <= BEGIN_CONVERSION_STATE;

					WHEN BEGIN_CONVERSION_STATE => --
						state <= ASSERT_CONVST_STATE;

					WHEN ASSERT_CONVST_STATE => --
						IF (SHORT_DELAY_SW = '1') THEN
							state <= WAIT_BUSY_0_STATE;
						END IF;

					WHEN WAIT_BUSY_0_STATE => --
						IF (AD7606_BUSY_SW = '1') THEN
							state <= WAIT_BUSY_1_STATE;
						END IF;

					WHEN WAIT_BUSY_1_STATE => --
						IF (AD7606_BUSY_SW = '0') THEN
							state <= READ_CH1_LOW_STATE;
						END IF;

					WHEN READ_CH1_LOW_STATE =>
						IF (STORE_SW = '1' AND SHORT_DELAY_SW = '1') THEN
							state <= WRITE_CH1_BRAM_STATE;
						ELSIF (STORE_SW = '0' AND SHORT_DELAY_SW = '1') THEN
							state <= WRITE_CH1_TRIGGER_STATE;
						END IF;

					WHEN WRITE_CH1_TRIGGER_STATE => --
						state <= READ_CH1_HIGH_STATE;

					WHEN WRITE_CH1_BRAM_STATE => --
						state <= READ_CH1_HIGH_STATE;

					WHEN READ_CH1_HIGH_STATE =>
						IF (SHORT_DELAY_SW = '1') THEN
							state <= RESET_SHORT_STATE;
						END IF;

					WHEN RESET_SHORT_STATE => --
						state <= READ_CH2_LOW_STATE;

					WHEN READ_CH2_LOW_STATE =>
						IF (STORE_SW = '1' AND SHORT_DELAY_SW = '1') THEN
							state <= WRITE_CH2_BRAM_STATE;
						ELSIF (STORE_SW = '0' AND SHORT_DELAY_SW = '1') THEN
							state <= WRITE_CH2_TRIGGER_STATE;
						END IF;
					WHEN WRITE_CH2_TRIGGER_STATE => --
						state <= READ_CH2_HIGH_STATE;

					WHEN WRITE_CH2_BRAM_STATE => --
						state <= READ_CH2_HIGH_STATE;

					WHEN READ_CH2_HIGH_STATE =>
						IF (SHORT_DELAY_SW = '1') THEN
							state <= WAIT_SAMPLE_INT_STATE;
						END IF;

					WHEN WAIT_SAMPLE_INT_STATE =>
						IF (SAMPLE_SW = '1') THEN
							IF (FULL_SW = '1') THEN
								state <= BRAM_FULL_STATE;
							ELSIF (FORCED_SW = '0' AND TRIGGER_SW = '1' AND STORE_SW = '0') THEN
								state <= SET_STORE_FLAG_STATE;
							ELSE
								state <= BEGIN_CONVERSION_STATE;
							END IF;
						END IF;

					WHEN BRAM_FULL_STATE =>
						IF (FORCED_SW = '1') THEN
							state <= WAIT_FORCED_STATE;
						ELSE
							state <= CLEAR_STORE_FLAG_STATE;
						END IF;

					WHEN CLEAR_STORE_FLAG_STATE =>
						state <= BEGIN_CONVERSION_STATE;

				END CASE;
			END IF;
		END IF;
	END PROCESS;

	-------------------------------------------------------------------------------
	-- Dedicated Control Word spreadsheet
	-------------------------------------------------------------------------------
	output_process : PROCESS (state)
	BEGIN
		CASE state IS
			WHEN RESET_STATE =>              cw <= '1' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "11" & "11" & "00" & "11" & "11";
			WHEN LONG_DELAY_STATE =>         cw <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "11" & "11" & "00" & "10" & "11";
			WHEN RESET_AD7606_STATE =>       cw <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '1' & '1' & '1' & '1' & "11" & "11" & "00" & "11" & "10";
			WHEN WAIT_FORCED_STATE =>        cw <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "11" & "11" & "00" & "11" & "11";
			WHEN SET_STORE_FLAG_STATE =>     cw <= '0' & '1' & '0' & '0' & '0' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "11" & "11" & "00" & "11" & "11";
			WHEN BEGIN_CONVERSION_STATE =>   cw <= '0' & '0' & '0' & '0' & '0' & '1' & '0' & '0' & '1' & '1' & '1' & '0' & "00" & "11" & "00" & "11" & "11";
			WHEN ASSERT_CONVST_STATE =>      cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & '0' & '1' & '1' & '0' & "00" & "10" & "00" & "11" & "10";
			WHEN WAIT_BUSY_0_STATE =>        cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "00" & "10" & "00" & "11" & "11";
			WHEN WAIT_BUSY_1_STATE =>        cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "00" & "10" & "00" & "11" & "11";
			WHEN READ_CH1_LOW_STATE =>       cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & "00" & "10" & "00" & "11" & "10";
			WHEN WRITE_CH1_TRIGGER_STATE =>  cw <= '0' & '0' & '0' & '1' & '1' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & "00" & "10" & "00" & "11" & "11";
			WHEN WRITE_CH1_BRAM_STATE =>     cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '1' & '1' & '0' & '0' & '0' & "00" & "10" & "00" & "11" & "11";
			WHEN READ_CH1_HIGH_STATE =>      cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & '1' & '1' & '0' & '0' & "00" & "10" & "00" & "11" & "10";
			WHEN RESET_SHORT_STATE =>        cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & '1' & '1' & '0' & '0' & "00" & "10" & "00" & "11" & "11";
			WHEN READ_CH2_LOW_STATE =>       cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & "00" & "10" & "00" & "11" & "10";
			WHEN WRITE_CH2_TRIGGER_STATE =>  cw <= '0' & '0' & '1' & '0' & '1' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & "00" & "10" & "00" & "11" & "11";
			WHEN WRITE_CH2_BRAM_STATE =>     cw <= '0' & '0' & '0' & '0' & '1' & '0' & '1' & '0' & '1' & '0' & '0' & '0' & "10" & "10" & "00" & "11" & "11";
			WHEN READ_CH2_HIGH_STATE =>      cw <= '0' & '0' & '0' & '0' & '1' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "00" & "10" & "00" & "11" & "10";
			WHEN WAIT_SAMPLE_INT_STATE =>    cw <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "00" & "10" & "00" & "11" & "11";
			WHEN BRAM_FULL_STATE =>          cw <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "11" & "11" & "00" & "11" & "11";
			WHEN CLEAR_STORE_FLAG_STATE =>   cw <= '1' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '1' & '1' & '1' & '0' & "00" & "11" & "00" & "11" & "11";
		END CASE;
	END PROCESS;

END Behavioral;