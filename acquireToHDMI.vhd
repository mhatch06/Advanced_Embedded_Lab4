--//////////Top Level for signal Acquisition /////////////////////////////--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.acquireToHDMI_package.ALL;
-- USE work.hdmi_package.ALL;
USE work.basicBuildingBlocks_package.ALL;
-- TODO:  include your library here with added components ac97, ac97cmd

ENTITY acquireToHDMI IS
    PORT (
        clk : IN STD_LOGIC;
        resetn : IN STD_LOGIC;
        btn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        triggerCh1, triggerCh2 : OUT STD_LOGIC;
        conversionPlusReadoutTime : OUT STD_LOGIC;
        sampleTimerRollover : OUT STD_LOGIC;

        an7606data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        an7606convst, an7606cs, an7606rd, an7606reset : OUT STD_LOGIC;
        an7606od : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        an7606busy : IN STD_LOGIC;

        tmdsDataP : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        tmdsDataN : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        tmdsClkP : OUT STD_LOGIC;
        tmdsClkN : OUT STD_LOGIC;
        hdmiOen : OUT STD_LOGIC
    );
END acquireToHDMI;

ARCHITECTURE behavior OF acquireToHDMI IS

    SIGNAL cw : STD_LOGIC_VECTOR(CW_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sw : STD_LOGIC_VECTOR(SW_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL forcedMode : STD_LOGIC := '1';

    SIGNAL ch1data : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ch2data : STD_LOGIC_VECTOR(15 DOWNTO 0);

    -- HDMI:
    SIGNAL red, green, blue : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL triggerTime, triggerVolt : STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);

    SIGNAL pixelHorz, pixelVert : STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);

    SIGNAL ch1Wave, ch2Wave : STD_LOGIC;

    SIGNAL videoClk, videoClk5x, clkLocked : STD_LOGIC;

    SIGNAL btnPressed, btnLast : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL hsync, vsync, vde : STD_LOGIC;
    SIGNAL ch1, ch2 : STD_LOGIC;

    SIGNAL reset : STD_LOGIC;
    -- END HDMI
BEGIN
    -- Signal Acquire

    ------------------------------------------------------------------------------
    -- Button Process
    ------------------------------------------------------------------------------

    -- i hate buttons
    sw(FORCED_SW_INDEX) <= forcedMode;
    -- is forcedMode assigned to the actual MODE??
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF resetn = '0' THEN
                btnPressed <= "000";
                -- triggerTime <= STD_LOGIC_VECTOR(to_unsigned(650, VIDEO_WIDTH_IN_BITS));
                -- triggerVolt <= STD_LOGIC_VECTOR(to_unsigned(360, VIDEO_WIDTH_IN_BITS));
            ELSE
                btnPressed <= (btnLast XOR btn) AND btn;

                IF ((btnPressed(1) = '1')) THEN
                    IF (forcedMode = '0') THEN
                        forcedMode <= '1';
                    ELSE
                        forcedMode <= '0';
                    END IF;
                END IF;

                IF ((btnPressed(0) = '1')) THEN
                    sw(SINGLE_SW_INDEX) <= '1';
                END IF;
            END IF;

            btnLast <= btn;
        END IF;
    END PROCESS;

    -- TODO: Edit this to take data from boofers
    -- DELETEch1Wave <= '1' WHEN (pixelVert = pixelVert) ELSE
        --'0';

    -- DELETE ch2Wave <= '1' WHEN (pixelVert = triggerVolt) ELSE
        --'0';

    an7606convst <= cw(CONVST_CW_BIT_INDEX);
    an7606rd <= cw(RD_CW_BIT_INDEX);
    an7606cs <= cw(CS_CW_BIT_INDEX);
    an7606reset <= cw(RESET_AD76076_CW_BIT_INDEX);

    sw(AD7606_BUSY_SW_INDEX) <= an7606busy;

    -- SHOULD THIS BE COMMENTED OUT???
    --sw(SINGLE_FORCED_TRIGGER_SW_BIT_INDEX) <= buttonActivity(0);
    -- DELETE triggerCh1 <= sw(CH1_TRIGGER_SW_INDEX);
    -- DELETE triggerCh2 <= sw(CH2_TRIGGER_SW_INDEX);
    
    -- NOT SURE IF THIS IS ZERO
    triggerTime <= STD_LOGIC_VECTOR(to_unsigned(650, VIDEO_WIDTH_IN_BITS));
    triggerVolt <= std_logic_vector(to_unsigned(360, VIDEO_WIDTH_IN_BITS));
    
    datapath_inst : acquireToHDMI_datapath
    PORT MAP(
        clk => clk,
        resetn => resetn,
        cw => cw,
        sw => sw(DATAPATH_SW_WIDTH - 1 DOWNTO 0),
        an7606data => an7606data,

        triggerVolt16bitSigned => "0000000000000000",
        triggerTimePixel => triggerTime,
        ch1Data16bitSLV => ch1data,
        ch2Data16bitSLV => ch2data,

        tmdsDataP => tmdsDataP,
        tmdsDataN => tmdsDataN,
        tmdsClkP => tmdsClkP,
        tmdsClkN => tmdsClkN,
        hdmiOen => hdmiOen
    );
    control_inst : acquireToHDMI_fsm
    PORT MAP(
        clk => clk,
        resetn => resetn,
        sw => sw,
        cw => cw);

END behavior;