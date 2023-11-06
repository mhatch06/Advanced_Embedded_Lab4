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

    SIGNAL cw : STD_LOGIC_VECTOR(CW_WIDTH - 1 DOWNTO 0) := (others => '0');
    SIGNAL sw : STD_LOGIC_VECTOR(SW_WIDTH - 1 DOWNTO 0) := (others => '0');
    SIGNAL forcedMode : STD_LOGIC;

    SIGNAL ch1data : STD_LOGIC_VECTOR(15 downto 0);
    SIGNAL ch2data : STD_LOGIC_VECTOR(15 downto 0);

    -- HDMI:
    signal red, green, blue: STD_LOGIC_VECTOR(7 downto 0);

    signal triggerTime, triggerVolt: STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS-1 downto 0);
    
    signal pixelHorz, pixelVert: STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS-1 downto 0);
	    
    signal ch1Wave, ch2Wave: STD_LOGIC;

    signal videoClk, videoClk5x, clkLocked: STD_LOGIC;
    
    signal btnPressed, btnLast: STD_LOGIC_VECTOR(2 downto 0);
    
    signal hsync, vsync, vde: STD_LOGIC;
    signal ch1, ch2: STD_LOGIC;
    
    signal reset: STD_LOGIC;
    -- END HDMI


BEGIN
    -- Signal Acquire



    ------------------------------------------------------------------------------
    -- Button Process
    ------------------------------------------------------------------------------

    -- i hate buttons
    sw(FORCED_SW_INDEX) <= '0';
    -- is forcedMode assigned to the actual MODE??
    process(clk)
    begin
        if rising_edge(clk) then
            if resetn = '0' then
                btnPressed <= "000";
                -- triggerTime <= std_logic_vector(to_unsigned(650, VIDEO_WIDTH_IN_BITS));
                -- triggerVolt <= std_logic_vector(to_unsigned(360, VIDEO_WIDTH_IN_BITS));
            else
                btnPressed <= (btnLast xor btn) and btn;
                
--                if   ((btnPressed(1) = '1')) then
--                    if (sw(FORCED_SW_INDEX) = '0') then
--                        sw(FORCED_SW_INDEX) <= '1';
--                    else
--                        sw(FORCED_SW_INDEX) <= '0';
--                    end if;
--                end if;
                
                if((btnPressed(0) = '1')) then
                    sw(SINGLE_SW_INDEX) <= '1';
                end if;
            end if;
            
            btnLast <= btn;
        end if;
    end process;

    -- TODO: Edit this to take data from boofers
    ch1Wave <= '1' when  (pixelHorz = pixelVert) else '0';
    ch2Wave <= '1' when  (pixelVert = triggerVolt) else '0';

    hdmiOen <= '1';

    -- SHOULD THIS BE COMMENTED OUT???
    --sw(SINGLE_FORCED_TRIGGER_SW_BIT_INDEX) <= buttonActivity(0);
    --triggerCh2 <= sw(CH2_TRIGGER_SW_BIT_INDEX);

    
     -- NOT SURE IF THIS IS ZERO
    triggerTime <= std_logic_vector(to_unsigned(650, VIDEO_WIDTH_IN_BITS));
    -- triggerVolt <= std_logic_vector(to_unsigned(360, VIDEO_WIDTH_IN_BITS));

    
    datapath_inst : acquireToHDMI_datapath
        PORT MAP(
            clk => clk,
            resetn => resetn,
            cw => cw,
            sw => sw(DATAPATH_SW_WIDTH - 1 downto 0),
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