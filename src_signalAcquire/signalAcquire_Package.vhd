--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Fall 2023
-- File:	signalAcquire_Package.vhd
--
-- Purp: Defines signalAcquire specific components and defines constants
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
USE work.signalAcquireRegister;
PACKAGE signalAcquire_Package IS
    -- Clock period definitions
    CONSTANT clk_period : TIME := 20 ns; -- 50Mhz crystal input (XTL_IN).

    -- CW definitions (CU to DP)
    CONSTANT CONVST_CW_BIT_INDEX : NATURAL := 10;
    CONSTANT RD_CW_BIT_INDEX : NATURAL := 9;
    CONSTANT CS_CW_BIT_INDEX : NATURAL := 8;
    CONSTANT RESET_AD7606_CW_BIT_INDEX : NATURAL := 7;
    CONSTANT CW_LONG_COUNTER_BIT_1 : NATURAL := 6;
    CONSTANT CW_LONG_COUNTER_BIT_0 : NATURAL := 5;
    CONSTANT CW_SHORT_COUNTER_BIT_1 : NATURAL := 4;
    CONSTANT CW_SHORT_COUNTER_BIT_0 : NATURAL := 3;
    CONSTANT CW_RF_COUNTER_BIT_1 : NATURAL := 2;
    CONSTANT CW_RF_COUNTER_BIT_0 : NATURAL := 1;
    CONSTANT REF_FILE_WRITE_CW_BIT_INDEX : NATURAL := 0;

    -- SW definitions (DP to CU)
    CONSTANT ALL_CHANNELS_HAVE_BEEN_READ_SW_BIT_INDEX : NATURAL := 2;
    CONSTANT SHORT_DELAY_DONE_SW_BIT_INDEX : NATURAL := 1;
    CONSTANT LONG_DELAY_DONE_SW_BIT_INDEX : NATURAL := 0;
    CONSTANT DATAPATH_SW_WIDTH : NATURAL := 3;

    -- SW definitions (outside to CU)
    CONSTANT START_CONV_SW_BIT_INDEX : NATURAL := 3; -- trigger
    CONSTANT BUSY_SW_BIT_INDEX : NATURAL := 4; -- busy

    CONSTANT SW_WIDTH : NATURAL := 5;
    CONSTANT CW_WIDTH : NATURAL := 11;

    CONSTANT LONG_DELAY_50Mhz_CONST_WIDTH : NATURAL := 24;
    CONSTANT LONG_DELAY_50Mhz_COUNTS : STD_LOGIC_VECTOR(LONG_DELAY_50Mhz_CONST_WIDTH - 1 DOWNTO 0) := x"00FFFF";

    CONSTANT SHORT_DELAY_50Mhz_CONST_WIDTH : NATURAL := 8;
    CONSTANT SHORT_DELAY_50Mhz_COUNTS : STD_LOGIC_VECTOR(SHORT_DELAY_50Mhz_CONST_WIDTH - 1 DOWNTO 0) := x"10";

    -- You need to determine the 16-bit 2's complement ADC values for these voltages
    CONSTANT FOURTH_THRESHOLD_CONSTANT : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"21CB"; -- 2.64V
    CONSTANT THIRD_THRESHOLD_CONSTANT : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"1958"; -- 1.98V
    CONSTANT SECOND_THRESHOLD_CONSTANT : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"10E5"; -- 1.32V
    CONSTANT FIRST_THRESHOLD_CONSTANT : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0872"; -- 0.66V

    COMPONENT signalAcquire_Fsm IS
        PORT (
            clk : IN STD_LOGIC;
            resetn : IN STD_LOGIC;
            sw : IN STD_LOGIC_VECTOR(SW_WIDTH - 1 DOWNTO 0);
            cw : OUT STD_LOGIC_VECTOR(CW_WIDTH - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT signalAcquire_Datapath IS
        PORT (
            clk : IN STD_LOGIC;
            resetn : IN STD_LOGIC;
            cw : IN STD_LOGIC_VECTOR(CW_WIDTH - 1 DOWNTO 0);
            sw : OUT STD_LOGIC_VECTOR(DATAPATH_SW_WIDTH - 1 DOWNTO 0);
            an7606data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            rfAddr : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            rfData : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    TYPE state_type IS (RESET_STATE, LONG_DELAY_STATE, RESET_AD7606_STATE, WAIT_TRIGGER_STATE,
        ASSERT_CONVST_STATE, WAIT_BUSY_0_STATE, WAIT_BUSY_1_STATE, WAIT_VALID_DATA_STATE,
        LATCH_STATE, PAUSE_BETWEEN_CHANNELS_STATE, CLEAR_SHORT_COUNTER_STATE);

    COMPONENT signalAcquire IS
        PORT (
            clk : IN STD_LOGIC;
            resetn : IN STD_LOGIC;
            btn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            an7606data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            an7606convst, an7606cs, an7606rd, an7606reset : OUT STD_LOGIC;
            an7606od : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            an7606busy : IN STD_LOGIC;
            reg0Magnitude : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    COMPONENT an7606_tb IS
        PORT (
            clk : IN STD_LOGIC;
            an7606data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            an7606convst, an7606cs, an7606rd, an7606reset : IN STD_LOGIC;
            an7606od : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            an7606busy : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT signalAcquireRegister IS
        PORT (
            clk, resetn, write : IN STD_LOGIC;
            d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            rdAddr, wrAddr : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

END PACKAGE;