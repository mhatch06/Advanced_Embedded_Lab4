--//////////Top Level for signal Acquisition /////////////////////////////--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.acquireToHDMI_package.ALL;
USE work.hdmi_package.ALL;
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

    SIGNAL cw : STD_LOGIC_VECTOR(CW_WIDTH - 1 DOWNTO 0);
    SIGNAL sw : STD_LOGIC_VECTOR(SW_WIDTH - 1 DOWNTO 0);
    SIGNAL forcedMode : STD_LOGIC;



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

    -- HDMI Out

    vsg : videoSignalGenerator
    PORT MAP(
        clk => videoClk,
        resetn => resetn,
        hs => hsync,
        vs => vsync,
        de => vde,
        pixelHorz => pixelHorz,
        pixelVert => pixelVert);
    sf : scopeFace
    PORT MAP(
        clk => videoClk,
        resetn => resetn,
        pixelHorz => pixelHorz,
        pixelVert => pixelVert,
        triggerTime => triggerTime,
        triggerVolt => triggerVolt,
        ch1 => ch1,
        ch1enb => '1',
        ch2 => ch2,
        ch2enb => '1',
        red => red,
        green => green,
        blue => blue);
    hdmi_inst : hdmi_tx_0
    PORT MAP(
        pix_clk => videoClk,
        pix_clkx5 => videoClk5x,
        rst => reset,
        hsync => hsync,
        vsync => vsync,
        vde => vde,
        pix_clk_locked => clkLocked,
        red => red,
        green => green,
        blue => blue,
        TMDS_DATA_P => tmdsDataP,
        TMDS_DATA_N => tmdsDataN,
        TMDS_CLK_P => tmdsClkP,
        TMDS_CLK_N => tmdsClkN,
        aux0_din => "0000",
        aux1_din => "0000",
        aux2_din => "0000",
        ade => '0'
    );

    vc : clk_wiz_0
    PORT MAP(
        clk_out1 => videoClk,
        clk_out2 => videoClk5x,
        resetn => resetn,
        locked => clkLocked,
        clk_in1 => sysClk);

    conversionPlusReadoutTime <= cw(CONVERSION_PLUS_READOUT_CW_BIT_INDEX);
    sampleTimerRollover <= cw(SAMPLE_TIMER_ROLLOVER_CW_BIT_INDEX);

    an7606convst <= cw(CONVST_CW_BIT_INDEX);
    an7606od <= "000";
    
    -- END HDMI OUT


    ------------------------------------------------------------------------------
    -- Button Process
    ------------------------------------------------------------------------------


    -- TODO: Add forced button stuff here (currently just HDMI trigger moving)

    process(sysClk)
    begin
        if rising_edge(sysClk) then
            if resetn = '0' then
                btnPressed <= "000";
                triggerTime <= std_logic_vector(to_unsigned(650, VIDEO_WIDTH_IN_BITS));
                triggerVolt <= std_logic_vector(to_unsigned(360, VIDEO_WIDTH_IN_BITS));
            else
                btnPressed <= (btnLast xor btn) and btn;
                
                if   ((btnPressed(0) = '1') and (btn(2) = '0')) then
                    triggerTime <= triggerTime + 10;
                elsif((btnPressed(0) = '1') and (btn(2) = '1')) then
                    triggerTime <= triggerTime - 10;
                elsif((btnPressed(1) = '1') and (btn(2) = '0')) then
                    triggerVolt <= triggerVolt + 10;
                elsif((btnPressed(1) = '1') and (btn(2) = '1')) then
                    triggerVolt <= triggerVolt - 10;
                end if;
            end if;
            
            btnLast <= btn;
        end if;
    end process;

    -- TODO: Edit this to take data from boofers
    ch1Wave <= '1' when  (pixelHorz = pixelVert) else '0';
    ch2Wave <= '1' when  (pixelVert = triggerVolt) else '0';

    hdmiOen <= '1';

    sw(SINGLE_FORCED_TRIGGER_SW_BIT_INDEX) <= buttonActivity(0);
    triggerCh2 <= sw(CH2_TRIGGER_SW_BIT_INDEX);

    datapath_inst : acquireToHDMI_datapath
    ch1Data16bitSLV => OPEN,
    );

    control_inst : acquireToHDMI_fsm
    PORT MAP(
        clk => clk,
        resetn => resetn,
        sw => sw,
        cw => cw);

END behavior;