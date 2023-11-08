----------------------------------------------------------------------------------
-- Include proper comment header block
-- ***Do not use mod operator in this code***
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.acquireToHDMI_package.ALL;
ENTITY scopeFace IS
	PORT (
		clk : IN STD_LOGIC;
		resetn : IN STD_LOGIC;
		pixelHorz : IN STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);
		pixelVert : IN STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);
		triggerVolt : IN STD_LOGIC_VECTOR (VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);
		triggerTime : IN STD_LOGIC_VECTOR (VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0);
		red : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		green : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		blue : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		ch1 : IN STD_LOGIC;
		ch1Enb : IN STD_LOGIC;
		ch2 : IN STD_LOGIC;
		ch2Enb : IN STD_LOGIC);
END scopeFace;
ARCHITECTURE Behavioral OF scopeFace IS
	-- Set these signals to '1' when the features should be drawn at the current pixelHorz, pixelVert 
	-- cordinate.  These act like Feature Booleans which you will use in the process(clk) to set the 
	-- correct RGB for this pixel location. Finish and add more.
	SIGNAL borderH, borderV, vLine, hLine, hHatch, vHatch, vTrig, tTrig, channel1, channel2 : STD_LOGIC;
BEGIN
	---------------------------------------------------------------------
	-- Use the Feature Booleans to set the RGB at this pixel location.
	-- The waveforms should sit "on top" of the grid.
	---------------------------------------------------------------------
	PROCESS (clk)
	BEGIN
		IF rising_edge (clk) THEN
			IF resetn = '0' THEN
				red <= (OTHERS => '0');
				green <= (OTHERS => '0');
				blue <= (OTHERS => '0');
			ELSE
				IF ((borderH = '1') OR (borderV = '1')) THEN
					red <= BORDER_R;
					green <= BORDER_G;
					blue <= BORDER_B;

				ELSIF ((vTrig = '1') OR (tTrig = '1')) THEN
					red <= TRIG_R;
					green <= TRIG_G;
					blue <= TRIG_B;

				ELSIF (channel1 = '1') THEN
					red <= CH1_R;
					green <= CH1_G;
					blue <= CH1_B;

				ELSIF (channel2 = '1') THEN
					red <= CH2_R;
					green <= CH2_G;
					blue <= CH2_B;

				ELSIF ((vLine = '1') OR (hLine = '1') OR (hHatch = '1') OR (vHatch = '1')) THEN
					red <= GRID_R;
					green <= GRID_G;
					blue <= GRID_B;

				ELSE
					red <= X"22";
					green <= X"22";
					blue <= X"22";
				END IF;
			END IF;
		END IF;
	END PROCESS;
	borderH <= '1' WHEN(
		(pixelHorz > L_EDGE - WIDTH) AND
		(pixelHorz < R_EDGE + WIDTH) AND
		(pixelVert > T_EDGE - WIDTH) AND
		(pixelVert < T_EDGE))
		OR(
		(pixelHorz > L_EDGE - WIDTH) AND
		(pixelHorz < R_EDGE + WIDTH) AND
		(pixelVert > B_EDGE) AND
		(pixelVert < B_EDGE + WIDTH))
		ELSE
		'0';

	borderV <= '1' WHEN(
		(pixelHorz > L_EDGE - WIDTH) AND
		(pixelHorz < L_EDGE) AND
		(pixelVert > T_EDGE - WIDTH) AND
		(pixelVert < B_EDGE + WIDTH))
		OR(
		(pixelHorz > R_EDGE) AND
		(pixelHorz < R_EDGE + WIDTH) AND
		(pixelVert > T_EDGE - WIDTH) AND
		(pixelVert < B_EDGE + WIDTH))
		ELSE
		'0';

	hHatch <= '1' WHEN
		(
		((pixelHorz = 20 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 40 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 60 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 80 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 100 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 120 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 140 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 160 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 180 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 200 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 220 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 240 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 260 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 280 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 300 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 320 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 340 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 360 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 380 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 400 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 420 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 440 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 460 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 480 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 500 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 520 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 540 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 560 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 580 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 600 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 620 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 640 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 660 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 680 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 700 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 720 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 740 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 760 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 780 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 800 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 820 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 840 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 860 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 880 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 900 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 920 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 940 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 960 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE)) OR
		((pixelHorz = 980 + L_EDGE) AND (pixelVert > 297 + T_EDGE) AND (pixelVert < 303 + T_EDGE))
		)
		ELSE
		'0';

	hLine <= '1' WHEN
		(
		((pixelVert = 60 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE)) OR
		((pixelVert = 120 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE)) OR
		((pixelVert = 180 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE)) OR
		((pixelVert = 240 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE)) OR
		((pixelVert = 300 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE)) OR
		((pixelVert = 360 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE)) OR
		((pixelVert = 420 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE)) OR
		((pixelVert = 480 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE)) OR
		((pixelVert = 540 + T_EDGE) AND (pixelHorz > L_EDGE) AND (pixelHorz < R_EDGE))
		)
		ELSE
		'0';

	tTrig <= '1' WHEN
		(
		((pixelHorz =- 7 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 0 + T_EDGE)) OR
		((pixelHorz =- 6 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 1 + T_EDGE)) OR
		((pixelHorz =- 5 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 2 + T_EDGE)) OR
		((pixelHorz =- 4 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 3 + T_EDGE)) OR
		((pixelHorz =- 3 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 4 + T_EDGE)) OR
		((pixelHorz =- 2 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 5 + T_EDGE)) OR
		((pixelHorz =- 1 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 6 + T_EDGE)) OR
		((pixelHorz = 0 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 7 + T_EDGE)) OR
		((pixelHorz = 1 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 6 + T_EDGE)) OR
		((pixelHorz = 2 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 5 + T_EDGE)) OR
		((pixelHorz = 3 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 4 + T_EDGE)) OR
		((pixelHorz = 4 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 3 + T_EDGE)) OR
		((pixelHorz = 5 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 2 + T_EDGE)) OR
		((pixelHorz = 6 + triggerTime) AND (pixelVert > T_EDGE) AND (pixelVert < 1 + T_EDGE))
		)
		ELSE
		'0';

	vTrig <= '1' WHEN
		(
		((pixelVert =- 7 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 0 + L_EDGE)) OR
		((pixelVert =- 6 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 1 + L_EDGE)) OR
		((pixelVert =- 5 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 2 + L_EDGE)) OR
		((pixelVert =- 4 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 3 + L_EDGE)) OR
		((pixelVert =- 3 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 4 + L_EDGE)) OR
		((pixelVert =- 2 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 5 + L_EDGE)) OR
		((pixelVert =- 1 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 6 + L_EDGE)) OR
		((pixelVert = 0 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 7 + L_EDGE)) OR
		((pixelVert = 1 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 6 + L_EDGE)) OR
		((pixelVert = 2 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 5 + L_EDGE)) OR
		((pixelVert = 3 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 4 + L_EDGE)) OR
		((pixelVert = 4 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 3 + L_EDGE)) OR
		((pixelVert = 5 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 2 + L_EDGE)) OR
		((pixelVert = 6 + triggerVolt) AND (pixelHorz > L_EDGE) AND (pixelHorz < 1 + L_EDGE))
		)
		ELSE
		'0';

	vHatch <= '1' WHEN
		(
		((pixelVert = 12 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 24 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 36 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 48 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 60 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 72 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 84 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 96 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 108 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 120 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 132 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 144 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 156 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 168 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 180 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 192 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 204 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 216 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 228 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 240 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 252 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 264 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 276 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 288 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 300 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 312 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 324 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 336 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 348 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 360 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 372 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 384 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 396 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 408 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 420 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 432 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 444 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 456 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 468 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 480 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 492 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 504 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 516 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 528 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 540 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 552 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 564 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 576 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE)) OR
		((pixelVert = 588 + T_EDGE) AND (pixelHorz > 497 + L_EDGE) AND (pixelHorz < 503 + L_EDGE))
		)
		ELSE
		'0';

	vLine <= '1' WHEN
		(
		((pixelHorz = 100 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE)) OR
		((pixelHorz = 200 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE)) OR
		((pixelHorz = 300 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE)) OR
		((pixelHorz = 400 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE)) OR
		((pixelHorz = 500 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE)) OR
		((pixelHorz = 600 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE)) OR
		((pixelHorz = 700 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE)) OR
		((pixelHorz = 800 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE)) OR
		((pixelHorz = 900 + L_EDGE) AND (pixelVert > T_EDGE) AND (pixelVert < B_EDGE))
		)
		ELSE
		'0';

	channel1 <= '1' WHEN
		(
		ch1 = '1'
		)
		ELSE
		'0';

	channel2 <= '1' WHEN
		(
		ch2 = '1'
		)
		ELSE
		'0';

END Behavioral;