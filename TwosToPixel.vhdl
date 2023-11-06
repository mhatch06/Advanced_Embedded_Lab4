
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.acquireToHDMI_package.all;


ENTITY twosToPixel IS   
    PORT (
        inputTwosComp : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        pixel : OUT STD_LOGIC_VECTOR(VIDEO_WIDTH_IN_BITS - 1 DOWNTO 0)
    );
END twosToPixel;

ARCHITECTURE behavior OF TwosToPixel IS
    signal inputSigned, sixHundred,  divideBy2toThe16_16, result : SIGNED(15 downto 0);
    signal timesSixHundred,  divideBy2toThe16_32 : SIGNED(31 downto 0);

BEGIN
    inputSigned <= SIGNED(inputTwosComp);
    
    sixHundred <= TO_SIGNED(-600, 16);

    timesSixHundred <= inputSigned * sixHundred;

    divideBy2toThe16_32 <= SHIFT_RIGHT(timesSixHundred, 16);

    divideBy2toThe16_16 <= divideBy2toThe16_32(15 downto 0);

    result <= divideBy2toThe16_16 + to_signed(359, 16);
    
    pixel <= STD_LOGIC_VECTOR(result(VIDEO_WIDTH_IN_BITS - 1 downto 0));

END behavior;