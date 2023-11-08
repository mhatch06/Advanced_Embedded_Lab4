--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE ieee.math_real.ALL;
USE work.acquireToHDMI_package.ALL; -- include your library here with added components ac97, ac97cmd

ENTITY an7606 IS
	PORT (
		clk : IN STD_LOGIC;
		an7606data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		an7606convst, an7606cs, an7606rd, an7606reset : IN STD_LOGIC;
		an7606od : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		an7606busy : OUT STD_LOGIC);
END an7606;

ARCHITECTURE behavior OF an7606 IS

	SIGNAL ch1Data : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"4321";
	SIGNAL ch2Data : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"6543";
	SIGNAL idleDataValue : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"FFFF";

	SIGNAL theta : REAL := 0.0;
	SIGNAL squareCounter : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

BEGIN

	-- Busy signal from AN7606 
	busy_process : PROCESS
	BEGIN
		an7606busy <= '0';
		WAIT UNTIL (an7606convst = '0');
		WAIT UNTIL (an7606convst = '1');
		WAIT FOR 40ns;
		an7606busy <= '1';
		WAIT FOR 4us;
		an7606busy <= '0';
	END PROCESS;

	-- This process simulates a 0V-centered sinwave coming into channel 1
	-- and a 0V-centered square wave coming into channel 2   
	AN7606_DATA_process : PROCESS
	BEGIN

		an7606data <= idleDataValue;

		WAIT UNTIL (an7606rd = '0');
		an7606data <= STD_LOGIC_VECTOR(to_signed(INTEGER(16384.0 * sin(theta) + 3.0), 16));
		theta <= theta + MATH_PI/8.0;

		WAIT UNTIL (an7606rd = '1');
		WAIT FOR clk_period;

		an7606data <= idleDataValue;

		WAIT UNTIL (an7606rd = '0');
		IF (squareCounter(1) = '0') THEN
			an7606data <= x"4000";
		ELSE
			an7606data <= x"C000";
		END IF;
		squareCounter <= squareCounter + 1;

		WAIT UNTIL (an7606rd = '1');
		WAIT FOR clk_period;

	END PROCESS;

END behavior;