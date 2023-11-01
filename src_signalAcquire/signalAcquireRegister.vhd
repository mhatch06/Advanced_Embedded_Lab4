-------------------------------------------------
-- Author:      Matt Hatch
-- Date:        Fall 2002
-- Purp:        A sweet register file
-------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.basicBuildingBlocks_package.all;

entity signalAcquireRegister is
        port (  clk, resetn, write: in STD_LOGIC;
                d: in STD_LOGIC_VECTOR(15 downto 0);
                rdAddr, wrAddr: in  STD_LOGIC_VECTOR(2 downto 0);
                q: out STD_LOGIC_VECTOR(15 downto 0) );
end signalAcquireRegister;

architecture behavior of signalAcquireRegister is
    signal y0, y1, y2, y3, y4, y5, y6, y7 : STD_LOGIC;
    signal q0, q1, q2, q3, q4, q5, q6, q7 : STD_LOGIC_VECTOR(15 downto 0);
    signal yAll : STD_LOGIC_VECTOR(7 downto 0);
begin
    yAll <= y7 & y6 & y5 & y4 & y3 & y2 & y1 & y0;

    decoderInstantiation : decode3x8
        PORT MAP(   dataIn => write,
                    sel => wrAddr,
                    y => yAll);

    reg0 : genericRegister
        GENERIC MAP(16)
        PORT MAP(   clk => clk,
                    resetn => resetn,
                    d => d,
                    load => y0,
                    q => q0);
	
    reg1 : genericRegister
        GENERIC MAP(16)
        PORT MAP(   clk => clk,
                    resetn => resetn,
                    d => d,
                    load => y1,
                    q => q1);

    reg2 : genericRegister
        GENERIC MAP(16)
        PORT MAP(   clk => clk,
                    resetn => resetn,
                    d => d,
                    load => y2,
                    q => q2);

    reg3 : genericRegister
        GENERIC MAP(16)
        PORT MAP(   clk => clk,
                    resetn => resetn,
                    d => d,
                    load => y3,
                    q => q3);

    reg4 : genericRegister
        GENERIC MAP(16)
        PORT MAP(   clk => clk,
                    resetn => resetn,
                    d => d,
                    load => y4,
                    q => q4);

    reg5 : genericRegister
        GENERIC MAP(16)
        PORT MAP(   clk => clk,
                    resetn => resetn,
                    d => d,
                    load => y5,
                    q => q5);
    
    reg6 : genericRegister
        GENERIC MAP(16)
        PORT MAP(   clk => clk,
                    resetn => resetn,
                    d => d,
                    load => y6,
                    q => q6);

    reg7 : genericRegister
        GENERIC MAP(16)
        PORT MAP(   clk => clk,
                    resetn => resetn,
                    d => d,
                    load => y7,
                    q => q7);

    muxInstantiation : genericMux8x1
        GENERIC MAP(16)
        PORT MAP(   y7 => q7,
                    y6 => q6,
                    y5 => q5,
                    y4 => q4,
                    y3 => q3,
                    y2 => q2,
                    y1 => q1,
                    y0 => q0,
                    s => rdAddr,
                    f => q
        );
        
end behavior;

