----------------------------------------------------------------------------------
-- Include proper comment header block
-- ***Do not use mod operator in this code***
----------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.scopeToHdmi_package.all;

 
entity scopeFace is
    PORT ( 	clk: in  STD_LOGIC;
         resetn : in  STD_LOGIC;
         pixelHorz : in  STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS-1 downto 0);
         pixelVert : in  STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS-1 downto 0);
         triggerVolt: in STD_LOGIC_VECTOR (VIDEO_WIDTH_IN_BITS-1 downto 0);
         triggerTime: in STD_LOGIC_VECTOR (VIDEO_WIDTH_IN_BITS-1 downto 0);
         red : out  STD_LOGIC_VECTOR(7 downto 0);
         green : out  STD_LOGIC_VECTOR(7 downto 0);
         blue : out  STD_LOGIC_VECTOR(7 downto 0);
         ch1: in STD_LOGIC;
         ch1Enb: in STD_LOGIC;
         ch2: in STD_LOGIC;
         ch2Enb: in STD_LOGIC);
end scopeFace;


architecture Behavioral of scopeFace is


    -- Set these signals to '1' when the features should be drawn at the current pixelHorz, pixelVert 
    -- cordinate.  These act like Feature Booleans which you will use in the process(clk) to set the 
    -- correct RGB for this pixel location. Finish and add more.
    signal borderH, borderV, vLine, hLine, hHatch, vHatch, vTrig, tTrig, channel1, channel2 : STD_LOGIC;


begin


    ---------------------------------------------------------------------
    -- Use the Feature Booleans to set the RGB at this pixel location.
    -- The waveforms should sit "on top" of the grid.
    ---------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge (clk) then
            if resetn = '0' then
                red <= (others => '0');
                green <= (others => '0');
                blue <= (others => '0');
            else
                if ((borderH = '1') or (borderV = '1')) then
                    red <= BORDER_R;
                    green <= BORDER_G;
                    blue <= BORDER_B;
                    
                elsif ((vTrig = '1') or (tTrig = '1')) then
                    red <= TRIG_R;
                    green <= TRIG_G;
                    blue <= TRIG_B;
                    
                elsif (channel1 = '1') then
                    red <= CH1_R;
                    green <= CH1_G;
                    blue <= CH1_B;
                    
                elsif (channel2 = '1') then
                    red <= CH2_R;
                    green <= CH2_G;
                    blue <= CH2_B;
                    
                elsif ((vLine = '1') or (hLine = '1') or (hHatch = '1') or (vHatch = '1')) then
                    red <= GRID_R;
                    green <= GRID_G;
                    blue <= GRID_B;    
              
                else
                    red <= X"22";
                    green <= X"22";
                    blue <= X"22";
                end if;
            end if;
        end if;
    end process;


    borderH <=	'1' when(
        (pixelHorz > L_EDGE - WIDTH) and 
        (pixelHorz < R_EDGE + WIDTH) and
        (pixelVert > T_EDGE - WIDTH) and
        (pixelVert < T_EDGE))
        or(
        (pixelHorz > L_EDGE - WIDTH) and 
        (pixelHorz < R_EDGE + WIDTH) and
        (pixelVert > B_EDGE) and
        (pixelVert < B_EDGE + WIDTH))
    else '0';

    borderV <=	'1' when(
        (pixelHorz > L_EDGE - WIDTH) and 
        (pixelHorz < L_EDGE) and
        (pixelVert > T_EDGE - WIDTH) and
        (pixelVert < B_EDGE + WIDTH))
        or(
        (pixelHorz > R_EDGE ) and 
        (pixelHorz < R_EDGE + WIDTH) and
        (pixelVert > T_EDGE - WIDTH) and
        (pixelVert < B_EDGE + WIDTH))
    else '0';

hHatch <= '1' when
(
	((pixelHorz = 20 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 40 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 60 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 80 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 100 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 120 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 140 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 160 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 180 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 200 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 220 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 240 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 260 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 280 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 300 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 320 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 340 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 360 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 380 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 400 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 420 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 440 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 460 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 480 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 500 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 520 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 540 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 560 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 580 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 600 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 620 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 640 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 660 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 680 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 700 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 720 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 740 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 760 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 780 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 800 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 820 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 840 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 860 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 880 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 900 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 920 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 940 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 960 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE)) or
	((pixelHorz = 980 + L_EDGE) and (pixelVert > 297 + T_EDGE) and (pixelVert < 303 + T_EDGE))
)
else '0';

hLine <= '1' when
(
	((pixelVert = 60 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)) or
	((pixelVert = 120 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)) or
	((pixelVert = 180 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)) or
	((pixelVert = 240 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)) or
	((pixelVert = 300 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)) or
	((pixelVert = 360 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)) or
	((pixelVert = 420 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)) or
	((pixelVert = 480 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)) or
	((pixelVert = 540 + T_EDGE) and (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE))
)
else '0';

tTrig <= '1' when
(
	((pixelHorz = -7 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 0 + T_EDGE)) or
	((pixelHorz = -6 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 1 + T_EDGE)) or
	((pixelHorz = -5 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 2 + T_EDGE)) or
	((pixelHorz = -4 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 3 + T_EDGE)) or
	((pixelHorz = -3 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 4 + T_EDGE)) or
	((pixelHorz = -2 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 5 + T_EDGE)) or
	((pixelHorz = -1 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 6 + T_EDGE)) or
	((pixelHorz = 0 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 7 + T_EDGE)) or
	((pixelHorz = 1 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 6 + T_EDGE)) or
	((pixelHorz = 2 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 5 + T_EDGE)) or
	((pixelHorz = 3 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 4 + T_EDGE)) or
	((pixelHorz = 4 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 3 + T_EDGE)) or
	((pixelHorz = 5 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 2 + T_EDGE)) or
	((pixelHorz = 6 + triggerTime) and (pixelVert > T_EDGE) and (pixelVert < 1 + T_EDGE))
)
else '0';

vTrig <= '1' when
(
	((pixelVert = -7 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 0 + L_EDGE)) or
	((pixelVert = -6 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 1 + L_EDGE)) or
	((pixelVert = -5 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 2 + L_EDGE)) or
	((pixelVert = -4 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 3 + L_EDGE)) or
	((pixelVert = -3 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 4 + L_EDGE)) or
	((pixelVert = -2 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 5 + L_EDGE)) or
	((pixelVert = -1 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 6 + L_EDGE)) or
	((pixelVert = 0 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 7 + L_EDGE)) or
	((pixelVert = 1 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 6 + L_EDGE)) or
	((pixelVert = 2 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 5 + L_EDGE)) or
	((pixelVert = 3 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 4 + L_EDGE)) or
	((pixelVert = 4 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 3 + L_EDGE)) or
	((pixelVert = 5 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 2 + L_EDGE)) or
	((pixelVert = 6 + triggerVolt) and (pixelHorz > L_EDGE) and (pixelHorz < 1 + L_EDGE))
)
else '0';

vHatch <= '1' when
(
	((pixelVert = 12 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 24 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 36 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 48 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 60 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 72 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 84 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 96 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 108 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 120 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 132 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 144 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 156 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 168 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 180 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 192 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 204 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 216 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 228 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 240 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 252 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 264 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 276 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 288 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 300 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 312 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 324 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 336 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 348 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 360 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 372 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 384 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 396 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 408 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 420 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 432 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 444 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 456 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 468 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 480 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 492 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 504 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 516 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 528 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 540 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 552 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 564 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 576 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE)) or
	((pixelVert = 588 + T_EDGE) and (pixelHorz > 497 + L_EDGE) and (pixelHorz < 503 + L_EDGE))
)
else '0';

vLine <= '1' when
(
	((pixelHorz = 100 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE)) or
	((pixelHorz = 200 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE)) or
	((pixelHorz = 300 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE)) or
	((pixelHorz = 400 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE)) or
	((pixelHorz = 500 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE)) or
	((pixelHorz = 600 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE)) or
	((pixelHorz = 700 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE)) or
	((pixelHorz = 800 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE)) or
	((pixelHorz = 900 + L_EDGE) and (pixelVert > T_EDGE) and (pixelVert < B_EDGE))
)
else '0';

channel1 <= '1' when
(
    (pixelHorz - L_EDGE = pixelVert - T_EDGE) and
    (pixelVert > T_EDGE) and (pixelVert < B_EDGE) and
    (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)
)
else '0';

channel2 <= '1' when
(
    (pixelVert = triggerVolt) and
    (pixelVert > T_EDGE) and (pixelVert < B_EDGE) and
    (pixelHorz > L_EDGE) and (pixelHorz < R_EDGE)
)
else '0';

end Behavioral;


