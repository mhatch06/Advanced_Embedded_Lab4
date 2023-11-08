--------------------------------------------------------------------
-- Name:	Chris Coulston
-- Date:	Feb 3, 2015
-- Modified:	Sept 2022
-- File:	acquireToHDMI_Datapath.vhdl
-- HW:		Lab 3
-- Crs:		ECE 383 and EENG 498
--
-- Purp: The complete datapath for the audio O'scope
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
USE IEEE.NUMERIC_STD.ALL;


USE work.acquireToHDMI_Package.ALL;
USE work.basicBuildingBlocks_package.ALL;
-- USE work.hdmi_package.ALL;
--USE work.TwosToPixel;

ENTITY acquireToHDMI_datapath IS
    PORT (
        clk : IN STD_LOGIC;
        resetn : IN STD_LOGIC;
        cw : IN STD_LOGIC_VECTOR(CW_WIDTH - 1 DOWNTO 0);
        sw : OUT STD_LOGIC_VECTOR(DATAPATH_SW_WIDTH - 1 DOWNTO 0);
        an7606data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        triggerVolt16bitSigned : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        triggerTimePixel : IN STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);
        ch1Data16bitSLV, ch2Data16bitSLV : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);

        tmdsDataP : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        tmdsDataN : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        tmdsClkP : OUT STD_LOGIC;
        tmdsClkN : OUT STD_LOGIC;
        hdmiOen : OUT STD_LOGIC
    );
END acquireToHDMI_datapath;

ARCHITECTURE behavior OF acquireToHDMI_datapath IS

    SIGNAL red, green, blue: STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL videoClk, videoClk5x, clkLocked: STD_LOGIC;
    SIGNAL triggerTime, triggerVolt: STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS-1 downto 0);
    
    signal doutb_2sComp : STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 downto 0);
    
    signal bram_addr_b : STD_LOGIC_VECTOR(10 downto 0);
    
    signal conversionPlusReadoutTime  : STD_LOGIC;
    signal sampleTimerRollover : STD_LOGIC;
    signal an7606convst : STD_LOGIC;
    signal an7606od : STD_LOGIC_VECTOR(2 downto 0);
    
    signal ch1_last_signed : SIGNED(15 downto 0);
    signal ch2_last_signed : SIGNED(15 downto 0);
    signal ch1_curr_signed : SIGNED(15 downto 0);
    signal ch2_curr_signed : SIGNED(15 downto 0);
    
    signal sample_counter_inst_cw : STD_LOGIC_VECTOR(1 downto 0);

    SIGNAL storeIntoBramFlag : STD_LOGIC;

    SIGNAL addr_counter_inst_c, short_counter_inst_cw : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL wrAddr : STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);
    SIGNAL ch1_curr, ch2_curr, ch1_last, ch2_last : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL shortCounterCount : STD_LOGIC_VECTOR(SHORT_DELAY_50Mhz_CONST_WIDTH - 1 downto 0);

    SIGNAL hsync, vsync, vde : STD_LOGIC;
    SIGNAL pixelHorz : STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 downto 0);
    SIGNAL pixelVert : STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 downto 0);

    SIGNAL shortCounterDone, longCounterDone : STD_LOGIC;

    SIGNAL trigVscr : STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);

    SIGNAL ch1_ram_output : STD_LOGIC_VECTOR(15 DOWNTO 0); 
    SIGNAL ch2_ram_output : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL sampleCounterCount : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal reset : STD_LOGIC;
    signal ch2_doutb_2sComp : STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 downto 0);
    
    signal long_counter_inst_cw : STD_LOGIC_VECTOR(1 downto 0);
    
    signal longCounterCount : STD_LOGIC_VECTOR(23 downto 0);
    
    signal ch2_curr_trig_G, ch1_curr_trig_G, ch1_last_trig_G, ch1_curr_trig_L, ch2_last_trig_G, ch2_curr_trig_L  : STD_LOGIC;
    
    signal sampleCounterDone, ch1, ch2 : STD_LOGIC;
    
BEGIN
    reset <= not resetn;
    
    
    hdmiOen <= '1';
    

    sw(STORE_TO_BRAM_SW_INDEX) <= storeIntoBramFlag;

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
        triggerTime => triggerTimePixel,
        triggerVolt => trigVscr,
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

    conversionPlusReadoutTime <= cw(CONVERSION_PLUS_READOUT_CW_BIT_INDEX);
    sampleTimerRollover <= cw(SAMPLE_TIMER_ROLLOVER_CW_BIT_INDEX);

    an7606convst <= cw(CONVST_CW_BIT_INDEX);
    an7606od <= "000";

    -- END HDMI OUT

    -- CH1 BRAM
    addr_counter_inst_c <= cw(DATA_STORAGE_COUNTER_CW_BIT1_INDEX) & cw(DATA_STORAGE_COUNTER_CW_BIT0_INDEX);

    addr_counter_inst : genericCounter
    GENERIC MAP (11)
    PORT MAP(
        clk => clk,
        resetn => resetn,
        c => addr_counter_inst_c,
        d => "00000000000",
        q => wrAddr
    );

    addr_comp_inst : genericCompare
    GENERIC MAP (11)
    PORT MAP(
        x =>STD_LOGIC_VECTOR(to_unsigned(1000, 11)),
        y => wrAddr,
        g => OPEN,
        l => OPEN,
        e => sw(FULL_SW_INDEX)
    );

    ch1_2sToPixel_inst : TwosToPixel
    PORT MAP (
        inputTwosComp => ch1_ram_output,
        pixel => doutb_2sComp
    );

    ch1_pixel_comp : genericCompare
    GENERIC MAP (11)
    PORT MAP(
        x => doutb_2sComp,
        y => pixelVert,
        g => OPEN,
        l => OPEN,
        e => ch1
    );
    
    bram_addr_b <= std_logic_vector(unsigned(pixelHorz) - unsigned(L_EDGE));

    bram_ch1_inst : blk_mem_gen_0
    PORT MAP (
        clka => clk,
        ena => '1',
        wea => cw(DATA_STORAGE_CH1_WRITE_CW_BIT_INDEX downto DATA_STORAGE_CH1_WRITE_CW_BIT_INDEX),
        addra => wrAddr,
        dina => an7606data,
        clkb => videoClk,
        enb => '1',
        addrb => bram_addr_b,
        doutb => ch1_ram_output
    );

    ch1_curr_reg_inst : genericRegister
    GENERIC MAP (16)
    PORT MAP (
        clk => clk,
        resetn => resetn,
        load => cw(TRIG_CH1_WRITE_CW_BIT_INDEX),
        d => an7606data,
        q => ch1_curr
    );

    ch1_last_signed <= SIGNED(ch1_last);
    ch1_curr_signed <= SIGNED(ch1_curr);

    ch1Data16bitSLV <= ch1_curr;
   
    ch1_curr_trig_G <= '1'
    when ch1_curr_signed > SIGNED(triggerVolt16bitSigned)  
    else '0';

    ch1_curr_trig_L <= '1'
    when ch1_last_signed < SIGNED(triggerVolt16bitSigned)  
    else '0';

    ch1_last_reg_inst : genericRegister
    GENERIC MAP(16)
    PORT MAP(
        clk => clk,
        resetn => resetn,
        load => cw(TRIG_CH2_WRITE_CW_BIT_INDEX),
        d => ch1_curr,
        q => ch1_last
    );
    
    ch1_last_trig_G <= '1' when ch1_last_signed > SIGNED(triggerVolt16bitSigned) else '0';

    sw(CH1_TRIGGER_SW_INDEX) <= ch1_curr_trig_L AND ch1_curr_trig_G;
    sw(TRIGGER_SW_INDEX) <=  ch1_curr_trig_L AND ch1_curr_trig_G;

    -- END CH1 BRAM

    -- CH2 BRAM

    ch2_2sToPixel_inst : TwosToPixel
    PORT MAP(
        inputTwosComp => ch1_ram_output,
        pixel => ch2_doutb_2sComp
    );

    ch2_pixel_comp : genericCompare
    GENERIC MAP(11)
    PORT MAP(
        x => ch2_doutb_2sComp,
        y => pixelVert,
        g => OPEN,
        l => OPEN,
        e => ch2
    );
    
    
    bram_ch2_inst : blk_mem_gen_0
    PORT MAP (
        clka => clk,
        ena => '1',
        wea => cw(DATA_STORAGE_CH2_WRITE_CW_BIT_INDEX downto DATA_STORAGE_CH2_WRITE_CW_BIT_INDEX),
        addra => wrAddr,
        dina => an7606data,
        clkb => videoClk,
        enb => '1',
        addrb => bram_addr_b,
        doutb => ch2_ram_output
    );


    ch2_curr_reg_inst : genericRegister
    GENERIC MAP(16)
    PORT MAP(
        clk => clk,
        resetn => resetn,
        load => cw(TRIG_CH2_WRITE_CW_BIT_INDEX),
        d => an7606data,
        q => ch2_curr
    );

    
    ch2_last_reg_inst : genericRegister
    GENERIC MAP(16)
    PORT MAP(
        clk => clk,
        resetn => resetn,
        load => cw(TRIG_CH2_WRITE_CW_BIT_INDEX),
        d => ch2_curr,
        q => ch2_last
    );

    ch2Data16bitSLV <= ch2_curr;

    -- compare G ch2
    ch2_curr_signed <= SIGNED(ch2_curr);

    ch2_curr_trig_G <= '1' 
    when ch2_curr_signed > SIGNED(triggerVolt16bitSigned) 
    else '0';

    -- compare L ch2

    ch2_last_signed <= SIGNED(ch2_last);

    ch2_curr_trig_L <= '1' 
    when ch2_last_signed < SIGNED(triggerVolt16bitSigned) 
    else '0';

    -- ch2 AND gate




    
    ch2_last_trig_G <= '1' when ch2_last_signed > SIGNED(triggerVolt16bitSigned) else '0';
    sw(CH2_TRIGGER_SW_INDEX) <= ch2_curr_trig_L AND ch2_curr_trig_G;


    -- END CH2 BRAM

    -- SHORT COUNTER

    short_counter_inst_cw <= cw(SHORT_DELAY_COUNTER_CW_BIT1_INDEX) & cw(SHORT_DELAY_COUNTER_CW_BIT0_INDEX);

    short_counter_inst : genericCounter
    GENERIC MAP(SHORT_DELAY_50Mhz_CONST_WIDTH)
    PORT MAP(
        clk => clk,
        resetn => resetn,
        c => short_counter_inst_cw,
        d => "00000000",
        q => shortCounterCount
    );

    short_counter_comp_inst : genericCompare
    GENERIC MAP(SHORT_DELAY_50Mhz_CONST_WIDTH)
    PORT MAP(
        x => shortCounterCount,
        y => SHORT_DELAY_50Mhz_COUNTS,
        g => OPEN,
        l => OPEN,
        e => shortCounterDone
    );

    sw(SHORT_DELAY_SW_INDEX) <= shortCounterDone;

    -- END SHORT COUNTER

    -- LONG COUNTER

    long_counter_inst_cw <= cw(LONG_DELAY_COUNTER_CW_BIT1_INDEX) & cw(LONG_DELAY_COUNTER_CW_BIT0_INDEX);

    long_counter_inst : genericCounter
    GENERIC MAP(LONG_DELAY_50Mhz_CONST_WIDTH)
    PORT MAP(
        clk => clk,
        resetn => resetn,
        c => LONG_counter_inst_cw,
        d => "000000000000000000000000",
        q => longCounterCount
    );

    long_counter_comp_inst : genericCompare
    GENERIC MAP(LONG_DELAY_50Mhz_CONST_WIDTH)
    PORT MAP(
        x => longCounterCount,
        y => LONG_DELAY_50Mhz_COUNTS,
        g => OPEN,
        l => OPEN,
        e => longCounterDone
    );

    sw(LONG_DELAY_SW_INDEX) <= longCounterDone;

    -- END LONG COUNTER
    triggerVolt2sToPixel : TwosToPixel
        PORT MAP(
            inputTwosComp => triggerVolt16bitSigned,
            pixel => trigVscr
        );

    -- SAMPLING COUNTER STUFF

    sample_counter_inst_cw <= cw(SAMPLING_COUNTER_CW_BIT1_INDEX) & cw(SAMPLING_COUNTER_CW_BIT0_INDEX);

    sample_counter_inst : genericCounter
    GENERIC MAP(32)
    PORT MAP(
        clk => clk,
        resetn => resetn,
        c => sample_counter_inst_cw,
        d => "00000000000000000000000000000000",
        q => sampleCounterCount
    );

    sample_counter_comp_inst : genericCompare
    GENERIC MAP(32)
    PORT MAP(
        x => sampleCounterCount,
        y => HIGHEST_RATE,
        g => OPEN,
        l => OPEN,
        e => sampleCounterDone
    );
    
    sw(SAMPLE_SW_INDEX) <= sampleCounterDone;
    
    -- SR Latch
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (cw(SET_STORE_FLAG_CW_BIT_INDEX) = '1') THEN
                sw(STORE_SW_INDEX) <= '1';
                ELSIF (cw(CLEAR_STORE_FLAG_CW_BIT_INDEX) = '1') THEN
                sw(STORE_SW_INDEX) <= '0';
            END IF;
        END IF;
    END PROCESS;
    
    -- Simple SR Latch to assist FSM
    PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (resetn = '0') THEN
                storeIntoBramFlag <= '0';
                ELSIF (cw(SET_STORE_FLAG_CW_BIT_INDEX) = '1') THEN
                storeIntoBramFlag <= '1';
                ELSIF (cw(CLEAR_STORE_FLAG_CW_BIT_INDEX) = '1') THEN
                storeIntoBramFlag <= '0';
            END IF;
        END IF;
    END PROCESS;

--    -- Simulation Clock process definition for 74.25Mhz  videoClk
--    -- We are assuming that clk_period = 20ns is defined in acquireToHDMI_Package
--    -- 74.25Mhz has a period of 13.5ns   
--        videoClk_process :process
--        begin
--     		videoClk <= '0';
--     		wait for videoClk_period/2;
--     		videoClk <= '1';
--     		wait for videoClk_period/2;
--        end process;   

--    -- -- Simulation Clock process definition for 371.25Mhz  videoClk5x
--    -- -- We are assuming that clk_period = 20ns is defined in acquireToHDMI_Package
--    -- -- 371.25Mhz has a period of 2.6936ns
--        videoClk5x_process :process
--        begin
--     		videoClk5x <= '0';
--     		wait for videoClk5x_period/2;
--     		videoClk5x <= '1';
--     		wait for videoClk5x_period/2;
--        end process;

--        clkLocked <= '1';

   vc : clk_wiz_0
   PORT MAP(
       clk_in1 => clk,
       clk_out1 => videoClk,
       reset => reset,
       clk_out2 => videoClk5x,
       locked => clkLocked);
        
        
    

END behavior;