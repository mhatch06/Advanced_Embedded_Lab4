--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.acquireToHDMI_package.ALL; -- include your library here with added components ac97, ac97cmd

ENTITY acquireToHDMI_tb IS
END acquireToHDMI_tb;

ARCHITECTURE behavior OF acquireToHDMI_tb IS

    --Inputs
    SIGNAL clk_t : STD_LOGIC;
    SIGNAL resetn_t : STD_LOGIC;
    SIGNAL btn_t : STD_LOGIC_VECTOR (2 DOWNTO 0);

    SIGNAL triggerCh1_t, triggerCh2_t : STD_LOGIC;
    SIGNAL conversionPlusReadoutTime_t : STD_LOGIC;
    SIGNAL sampleTimerRollover_t : STD_LOGIC;

    SIGNAL an7606data_t : STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL an7606convst_t : STD_LOGIC;
    SIGNAL an7606cs_t : STD_LOGIC;
    SIGNAL an7606rd_t : STD_LOGIC;
    SIGNAL an7606reset_t : STD_LOGIC;
    SIGNAL an7606od_t : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL an7606busy_t : STD_LOGIC;

    SIGNAL tmdsClkN_t, tmdsClkP_t : STD_LOGIC;
    SIGNAL hdmiOen_t : STD_LOGIC;
BEGIN

    an7606_inst : an7606
    PORT MAP(
        clk => clk_t,
        an7606data => an7606data_t,
        an7606convst => an7606convst_t,
        an7606cs => an7606cs_t,
        an7606rd => an7606rd_t,
        an7606reset => an7606reset_t,
        an7606od => an7606od_t,
        an7606busy => an7606busy_t);

    uut : acquireToHDMI
    PORT MAP(
        clk => clk_t,
        resetn => resetn_t,
        btn => btn_t,

        triggerCh1 => triggerCh1_t,
        triggerCh2 => triggerCh2_t,
        conversionPlusReadoutTime => conversionPlusReadoutTime_t,
        sampleTimerRollover => sampleTimerRollover_t,

        an7606data => an7606data_t,
        an7606convst => an7606convst_t,
        an7606cs => an7606cs_t,
        an7606rd => an7606rd_t,
        an7606reset => an7606reset_t,
        an7606od => an7606od_t,
        an7606busy => an7606busy_t,
        tmdsDataP => OPEN,
        tmdsDataN => OPEN,
        tmdsClkP => tmdsClkP_t,
        tmdsClkN => tmdsClkN_t,
        hdmiOen => hdmiOen_t);
    
    
        resetn_t <= '0', '1' AFTER clk_period;

    -- Clock process definitions
    clk_process : PROCESS
    BEGIN
        clk_t <= '0';
        WAIT FOR clk_period/2;
        clk_t <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- Button press from user after ad7606reset
    button_process : PROCESS
    BEGIN

        btn_t <= "000";
        WAIT UNTIL (resetn_t = '1');
        WAIT FOR clk_period;

        -- commment out the following for forced mode
         btn_t <= "010";     -- trigger mode

        WAIT UNTIL (an7606reset_t = '1');
        WAIT UNTIL (an7606reset_t = '0');
        WAIT FOR 100ns;

        -- Leave this line in regardless of the mode
        btn_t <= "001";

        WAIT FOR 4 * clk_period;
        btn_t <= "000";
        WAIT;
    END PROCESS;

END behavior;