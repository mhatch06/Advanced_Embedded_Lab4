set_property PACKAGE_PIN U18 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -period 20.000 -waveform {0.000 10.000} [get_ports clk]

set_property PACKAGE_PIN N15 [get_ports resetn]
set_property IOSTANDARD LVCMOS33 [get_ports resetn]

set_property PACKAGE_PIN N16 [get_ports btn[0]]
set_property IOSTANDARD LVCMOS33 [get_ports btn[0]]

set_property PACKAGE_PIN T17 [get_ports btn[1]]
set_property IOSTANDARD LVCMOS33 [get_ports btn[1]]

set_property PACKAGE_PIN R17 [get_ports btn[2]]
set_property IOSTANDARD LVCMOS33 [get_ports btn[2]]


# NOT SURE IF THESE ARE RIGHT
# CURRENTLY SET TO TURN LEDs ON AND OFF
set_property PACKAGE_PIN M14 [get_ports triggerCh1]
set_property IOSTANDARD LVCMOS33 [get_ports triggerCh1]

set_property PACKAGE_PIN M15 [get_ports triggerCh2]
set_property IOSTANDARD LVCMOS33 [get_ports triggerCh2]

set_property PACKAGE_PIN K16 [get_ports conversionPlusReadoutTime]
set_property IOSTANDARD LVCMOS33 [get_ports conversionPlusReadoutTime]

set_property PACKAGE_PIN J16 [get_ports sampleTimerRollover]
set_property IOSTANDARD LVCMOS33 [get_ports sampleTimerRollover]

# Signal Acquire XDC STUFF
# ------------------------------------------------------------

# LED 0
# set_property PACKAGE_PIN M14 [get_ports reg0Magnitude[0]]
# set_property IOSTANDARD LVCMOS33 [get_ports reg0Magnitude[0]]

# # LED 1
# set_property PACKAGE_PIN M15 [get_ports reg0Magnitude[1]]
# set_property IOSTANDARD LVCMOS33 [get_ports reg0Magnitude[1]]

# # LED 2
# set_property PACKAGE_PIN K16 [get_ports reg0Magnitude[2]]
# set_property IOSTANDARD LVCMOS33 [get_ports reg0Magnitude[2]]

# # LED 3
# set_property PACKAGE_PIN J16 [get_ports reg0Magnitude[3]]
# set_property IOSTANDARD LVCMOS33 [get_ports reg0Magnitude[3]]

# convst
set_property PACKAGE_PIN R14 [get_ports an7606convst]
set_property IOSTANDARD LVCMOS33 [get_ports an7606convst]

# OS0
set_property PACKAGE_PIN W18 [get_ports an7606od[0]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606od[0]]

#OS1

set_property PACKAGE_PIN W19 [get_ports an7606od[1]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606od[1]]

#OS2
set_property PACKAGE_PIN P14 [get_ports an7606od[2]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606od[2]]

#rd
set_property PACKAGE_PIN Y17 [get_ports an7606rd]
set_property IOSTANDARD LVCMOS33 [get_ports an7606rd]

#busy
set_property PACKAGE_PIN W15 [get_ports an7606busy]
set_property IOSTANDARD LVCMOS33 [get_ports an7606busy]

#cs
set_property PACKAGE_PIN V15 [get_ports an7606cs]
set_property IOSTANDARD LVCMOS33 [get_ports an7606cs]

# ad7606 reset
set_property PACKAGE_PIN Y16 [get_ports an7606reset]
set_property IOSTANDARD LVCMOS33 [get_ports an7606reset]

# data pins
set_property PACKAGE_PIN U15 [get_ports an7606data[0]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[0]]

set_property PACKAGE_PIN U14 [get_ports an7606data[1]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[1]]

set_property PACKAGE_PIN P16 [get_ports an7606data[2]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[2]]

set_property PACKAGE_PIN P15 [get_ports an7606data[3]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[3]]

set_property PACKAGE_PIN U17 [get_ports an7606data[4]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[4]]

set_property PACKAGE_PIN T16 [get_ports an7606data[5]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[5]]

set_property PACKAGE_PIN V18 [get_ports an7606data[6]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[6]]

set_property PACKAGE_PIN V17 [get_ports an7606data[7]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[7]]

set_property PACKAGE_PIN T15 [get_ports an7606data[8]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[8]]

set_property PACKAGE_PIN T14 [get_ports an7606data[9]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[9]]

set_property PACKAGE_PIN V13 [get_ports an7606data[10]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[10]]

set_property PACKAGE_PIN U13 [get_ports an7606data[11]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[11]]

set_property PACKAGE_PIN W13 [get_ports an7606data[12]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[12]]

set_property PACKAGE_PIN V12 [get_ports an7606data[13]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[13]]

set_property PACKAGE_PIN U12 [get_ports an7606data[14]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[14]]

set_property PACKAGE_PIN T12 [get_ports an7606data[15]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[15]]





# SCOPE TO HDMI XDC FILE
# --------------------------------------------------

set_property IOSTANDARD TMDS_33 [get_ports {tmdsDataN[0]}]
set_property PACKAGE_PIN V20 [get_ports {tmdsDataP[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmdsDataP[0]}]

set_property IOSTANDARD TMDS_33 [get_ports {tmdsDataN[1]}]
set_property PACKAGE_PIN T20 [get_ports {tmdsDataP[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmdsDataP[1]}]

set_property IOSTANDARD TMDS_33 [get_ports {tmdsDataN[2]}]
set_property PACKAGE_PIN N20 [get_ports {tmdsDataP[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmdsDataP[2]}]

set_property IOSTANDARD TMDS_33 [get_ports tmdsClkN]
set_property PACKAGE_PIN N18 [get_ports tmdsClkP]
set_property IOSTANDARD TMDS_33 [get_ports tmdsClkP]

set_property PACKAGE_PIN V16 [get_ports hdmiOen]
set_property IOSTANDARD LVCMOS33 [get_ports hdmiOen]
