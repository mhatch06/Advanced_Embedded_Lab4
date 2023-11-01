--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Fall 2022
-- File:	signalAcquire.vhd
--
-- Purp: Tie the datapath and control unit together
--
-- Documentation:	No help
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.signalAcquire_Package.ALL;
use work.basicBuildingBlocks_Package.all;	

-- Include any packages that are instantiated
ENTITY signalAcquire IS
	PORT (
		clk : IN STD_LOGIC;
		resetn : IN STD_LOGIC;
		btn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		an7606data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		an7606convst, an7606cs, an7606rd, an7606reset : OUT STD_LOGIC;
		an7606od : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		an7606busy : IN STD_LOGIC;
		reg0Magnitude : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END signalAcquire;

ARCHITECTURE behavior OF signalAcquire IS
	-- output of cu
	SIGNAL cw : STD_LOGIC_VECTOR(CW_WIDTH - 1 DOWNTO 0);
	-- input to cu
	SIGNAL sw : STD_LOGIC_VECTOR(SW_WIDTH - 1 DOWNTO 0);

	-- 3/5 of sw
	SIGNAL sw_dp : STD_LOGIC_VECTOR(DATAPATH_SW_WIDTH - 1 DOWNTO 0);

	-- the other 2/5 of sw
	SIGNAL trigger : STD_LOGIC;
	SIGNAL busy : STD_LOGIC;

	-- rfData
	SIGNAL rfData : STD_LOGIC_VECTOR(15 DOWNTO 0);

	-- btn stuff
	SIGNAL btnLast, btnPressed : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    -- sw definition
    busy <= an7606busy;
    sw <= busy & trigger & sw_dp;

    -- cw assignments
    an7606convst <= cw(CONVST_CW_BIT_INDEX);
	an7606rd <= cw(RD_CW_BIT_INDEX);
	an7606cs <= cw(CS_CW_BIT_INDEX);
	an7606reset <= cw(RESET_AD7606_CW_BIT_INDEX);


	-- DP
	dpsw : signalAcquire_Datapath
	PORT MAP(
		clk => clk,
		resetn => resetn,
		cw => cw,
		sw => sw_dp,
		an7606data => an7606data,
		rfAddr => "000",
		rfData => rfData);

	-- CU
	cusw : signalAcquire_Fsm
	PORT MAP(
		clk => clk,
		resetn => resetn,
		cw => cw,
		sw => sw);

	-- comparators
	comp4 : genericCompare
	GENERIC MAP(16)
	PORT MAP(
		x => FOURTH_THRESHOLD_CONSTANT,
		y => rfData,
		g => reg0Magnitude(3),
		l => OPEN,
		e => OPEN);

	comp3 : genericCompare
	GENERIC MAP(16)
	PORT MAP(
		x => THIRD_THRESHOLD_CONSTANT,
		y => rfData,
		g => reg0Magnitude(2),
		l => OPEN,
		e => OPEN);

	comp2 : genericCompare
	GENERIC MAP(16)
	PORT MAP(
		x => SECOND_THRESHOLD_CONSTANT,
		y => rfData,
		g => reg0Magnitude(1),
		l => OPEN,
		e => OPEN);

	comp1 : genericCompare
	GENERIC MAP(16)
	PORT MAP(
		x => FIRST_THRESHOLD_CONSTANT,
		y => rfData,
		g => reg0Magnitude(0),
		l => OPEN,
		e => OPEN);

	PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF resetn = '0' THEN
				trigger <= '0';
			ELSE
				btnPressed <= (btnLast XOR btn) AND btn;
				trigger <= (btnPressed(0) or btnPressed(1) or btnPressed(2));
				btnLast <= btn;
			END IF;
        END IF;
    END PROCESS;
END behavior;
