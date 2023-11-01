----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  
use ieee.std_logic_unsigned.all;
use work.scopeToHdmi_package.all;

entity scopeToHdmi is
    PORT ( sysClk : in  STD_LOGIC;
         resetn : in  STD_LOGIC;
         btn: in	STD_LOGIC_VECTOR(2 downto 0);
         tmdsDataP : out  STD_LOGIC_VECTOR (2 downto 0);
         tmdsDataN : out  STD_LOGIC_VECTOR (2 downto 0);
         tmdsClkP : out STD_LOGIC;
         tmdsClkN : out STD_LOGIC;
         hdmiOen:    out STD_LOGIC);
end scopeToHdmi;


architecture structure of scopeToHdmi is


    signal red, green, blue: STD_LOGIC_VECTOR(7 downto 0);

    signal triggerTime, triggerVolt: STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS-1 downto 0);
    
    signal pixelHorz, pixelVert: STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS-1 downto 0);
	    
    signal ch1Wave, ch2Wave: STD_LOGIC;

    signal videoClk, videoClk5x, clkLocked: STD_LOGIC;
    
    signal btnPressed, btnLast: STD_LOGIC_VECTOR(2 downto 0);
    
    
    -- signal pixelH, pixelV: STD_LOGIC_VECTOR(11 downto 0);
    
    signal hsync, vsync, vde: STD_LOGIC;
    signal ch1, ch2: STD_LOGIC;
    
    signal reset: STD_LOGIC;


begin
    reset <= not resetn;

    vsg: videoSignalGenerator
        PORT MAP (
            clk => videoClk, 
            resetn => resetn,
            hs => hsync,
            vs => vsync,
            de => vde,
            pixelHorz => pixelHorz,
            pixelVert => pixelVert   	);
                 

    sf: scopeFace
        PORT MAP (clk => videoClk, 
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
                 

    hdmi_inst: hdmi_tx_0
        PORT MAP (
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
            

    vc: clk_wiz_0
	PORT MAP( 
	    clk_out1 => videoClk,
	    clk_out2 => videoClk5x,
	    resetn => resetn,
	    locked => clkLocked,
	    clk_in1 => sysClk);

    ------------------------------------------------------------------------------
    -- Create a process which generates a 3-bit vector which shows if button
    -- has change state.  Use this change vector to determine if you should 
    -- increment/decrement the triggerTime or triggerVolt values
    ------------------------------------------------------------------------------
    
    process(sysClk)
    begin
        if rising_edge(sysClk) then
            if resetn = '0' then
                btnPressed <= "000";
            else
                btnPressed <= (btnLast xor btn) and btn;
                
                if   ((btnPressed(0) = '1') and (btn(2) = '0')) then
                    triggerTime <= triggerTime + 100;
                elsif((btnPressed(0) = '1') and (btn(2) = '1')) then
                    triggerTime <= triggerTime - 100;
                elsif((btnPressed(1) = '1') and (btn(2) = '0')) then
                    triggerVolt <= triggerVolt + 100;
                elsif((btnPressed(1) = '1') and (btn(2) = '1')) then
                    triggerVolt <= triggerVolt - 100;
                end if;
            end if;
            
            btnLast <= btn;
        end if;
    end process;
 

    ch1Wave <= '1' when  (pixelHorz = pixelVert) else '0';
    ch2Wave <= '1' when  (pixelVert = triggerVolt) else '0';
    
    hdmiOen <= '1';

end structure;
