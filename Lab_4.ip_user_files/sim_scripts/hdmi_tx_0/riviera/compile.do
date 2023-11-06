transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {Z:/EENG498/Lab_4/Lab_4.cache/compile_simlib/riviera}
vlib riviera/xpm
vlib riviera/xil_defaultlib

vlog -work xpm  -l xpm -l xil_defaultlib \
"C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 -l xpm -l xil_defaultlib \
"../../../../Lab_4.gen/sources_1/ip/hdmi_tx_0/hdl/encode.v" \
"../../../../Lab_4.gen/sources_1/ip/hdmi_tx_0/hdl/serdes_10_to_1.v" \
"../../../../Lab_4.gen/sources_1/ip/hdmi_tx_0/hdl/srldelay.v" \
"../../../../Lab_4.gen/sources_1/ip/hdmi_tx_0/hdl/hdmi_tx_v1_0.v" \
"../../../../Lab_4.gen/sources_1/ip/hdmi_tx_0/sim/hdmi_tx_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

