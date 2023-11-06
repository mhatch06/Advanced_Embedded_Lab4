// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Sun Nov  5 14:10:25 2023
// Host        : BB305-01 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [15:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [15:0]dina;
  wire [15:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [15:0]NLW_U0_douta_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.7745 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_6 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[15:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
aMT3usC6uizzcwnzOCX4OsS16Ob+YxFcsGovFpFklbnaIaD1S0lVdxenTwHPp6ByIEi+ehwr6Rgg
z/3AlTheI5NFTM8ihiMA18/wmUxI7EbaftJACA1LykUKCuj5myy0T+DACuv3sGYIZS38TZTZnnBC
FGAlvTZmRWs+JzneH3o=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lR9ZerhYSAb39nzEkeYvhnwEs5t9y/+yTDf8KuoUtR1BGeHZq8pA/YxtjzQLtaOW1R1IQUb0FtSI
e3CYAb7WHYbIjcpw3vKHvW1SqcGn9CMGa556CYKmD2oF12Kow8xRaFvMSBUVxX7HsHxNWnRd+PU1
+C0YayU2KFIY/7Yl6cZ5luAzhw/6SW3PFYUIyyqWy5MCIXweHOwQR2IpQEdlDur5nluN7i7BeB+i
fxwwHh8TU/g7T4mhZFkiTuBKdLAtQOjxWxzqTMxgcuAjlTylY16FgMFOASdvvSbqBZJjbxMdVloU
rYjS8O/8rWktv8GXcaIdBJ2BRj01q7jsChsbwA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Qvl63GHz9mq2xOB7elt/vAQ7URLGdD1Lkcz7f3Wtw31dwjjjbP62Ny/Jr6OmBIheWlgejx38qxAT
TrHiiEyjKmGcnPn1Tn2n+cH4RAxCbOFnCI9n6+YsYMTe9JkplGhGGr39SkFgJz0I2IKpPsuqTjCj
rhf49TAryNMQeRpREJA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MA+9Ro+dh339m0iZrkKbqTKN8gQ5xkxN/SPCfhkOn+5jjgCTS5IOKLHil+HsZDjX333ebxnornwG
MOBxyEdFfLM8SA+bs2r41J/j0af2VVMmCM3hOh8JmZxB4X9Jg/glegNCbvwzqxMbOQNEy+zt7j5t
TFVD82RtPFmYVVYZZyll/WvAA+0aVpyjzLCIM1GznFky0RWLv65Wp4MJJnNRRrtG3muMznVO/u2s
tACsJ9jzv9M0IlMYjYH9BixhG6cZX02I4LEXXaPkhdOINlMMhsbArXtc9NphzmS4bY1/1yF1D6YD
EKLyS2Sr3HDl0O/lefN+jvfG8iKuVl55PNNrVQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
wpMTg7STjFkUDhOqdNPa0FHXTnHQgKmhvqDv+rRVBvMiQ8O7u8oj7ibITq3o+jugJsMJ60B410gQ
JFTcqCJKYmYJvqi8rPLLOYDmFG6ZLP/Ixr3n62IyIaCeDltBahi3yV009QN0X+iuzuFCL+Y7g9ff
IvAgyBly+Z3Itv2H9EJMZPMl17Sa7IkgjmWqzVXIKNMKn0iDVYsQw6ZgzQDYQ8N8IvTIEggU3/lh
6Nf0hV0ev3qOv/2P+4w0U766Ux3yLuzPJSI7bKm3/ip9NjhOytxOiKKqVXhKG8dzbbuS5u3EE/eq
q6YxkL7gpvNltVqqBnJB6vHSyWrD6+MqsCtR9A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q7Q4SSp70lxFryaopuic9VVP/Ire0pSsPEIMYdURBAczC7ShkuYeV02U7L3BlAiyBE4vBKcwYSQd
cWiaj8sVP7q4kxoRHKxLV1R5PIO6l4DsLWE2E+1MLyUPME0w5KTular/oX8EPCJ5n/8VCtW7x4Vf
dpeyki1/IAPJkAyi3zVZKHzgKhEwnZaZZtZYuMWoPZMt4V38sAcE42Raf+7yfFWG5HO74JY6iEnW
gJeRk58K+avB/XLF2/j2RQZfjTYizrprT2tUMBK6e7DRWZZtk8AOcsMhUikev44IFGNbNXjP8BXC
0J3y3P7pCFT6l+saU83nRwi/H25fSA34diJtNw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
a/8ooC+s+6nfvfa1+oBhsvYWLJjFgp83DI1kNyOi5Am+ugPbGRmgGZudfyo6yw6Yd5gGbLm5aToQ
5G4cGF5HaXD5TU6A0ZZFMTIbzFLE76JMjjIxX8JcaJIZpSmrXqlru8l5gDINUEAmwUY3mRQnjcGJ
0Z+kMRH8iAEF+gEviPiFZSBbJeOPqivIS217kimQJX3BeNbNPQTP+GUidcRywpGMh5avxtA0kDRO
F9SoCSyTm9hr2v9hsK1IUAYQLb7n2/R+z5YNKNzt1oN4qgJH1wZfdI8if2K8+ohyOdnxrrgJOWdj
cOqr7cGqEOYfBMTIQeHVZzb7NGWVN+9B8XSUaQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
FLPvOUNRWNW2GU+FEGmt2XWthOT5bY/31DRbol2cUmEGNF6b2XzpCosNKGx/o2n6sQvGP39KRFCs
nJu0ihe2dUGee9nEZZUcpwPjnEfXVI3yJaRVYy8iL+rm59lXq0jX4sjAPieDvv8shgAnoXLTZGlq
K+2c1JhaHt+nFi27TDrYar/+P8nP1MhocOS7BjzCvSs0foEXj92/qD+71Sm/LqGr8cjlH2qTJJ8B
ynxoH6iT+bksVA2VbtPT9o6h1kJ/zwP4wcsL9l+qSlJhd4GI11JPux26DlNyIi41WmufQcfiT0PB
r6O9+0E9lV9ODwKdjaxfZRK29rjKeq2yr0jWhMV38XKKqHAJli7MIypGRXcCo+u89H87KgYt+ebw
s3foIqCe0JKR57WzI8VD6XdNtOL8eBxK539oemx4vkE0cGYECZKYru6A2hPeZOYDD5eyWSUlQl1R
EciK49WM8HnssyRVcmE6di6bISMbVi0TZG/v98bz+9UZa8DtqMVYH0tz

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fphquQOeFuqByo36Gh2C1zEC1J6u9swSMbMzsKldIvLm+SZ6/hr/N8KJ/G2vBABzX6UtbVuP1ZXx
AxdftP4Aqis1B3Bs6989aQG9eo0SOHA7r6aFLtFb3qoD5Pvqw4aVNU4z4EtTpFpn/jCWD21lKROf
q5X32HRfFq1jwqod+9vIbUNRRzz5y9VHvXfacZlxDazSPmcCF4hxB1KqWqT44KmYVkDedgkgnYgb
ZGidHnTb3W7C8tSqC9ac4kNJCL429QndtddweESJNlpX+65pt9Irok9pkOodwoj0QScswOIFjhBZ
/GrzZLQcFWiD3gXRU4DazzxQnGdRH4qEIRWziw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
1lUYYHPCt1BUJOvcBbgMU2GSQiqfxItz4ntieMaenjrtsE9SLwaU6xB0tBl8Atw5yP/RRNww1kX/
9uZbTz5He3r9mPVt+mGxB4N3f9BbCrQRb4USVPgKO/+vWUfMQERGklScy0+fz75WuxH74CjRUoDI
8iyssb2cUNnfDe13jIoI8gM1w4w/Pkxkmb6Mef53QMxacHAWEZeytcH3fuL/adO263D8P90U3XJv
vBXJmbjkRVi9qzjBzfMxuOy2KbZaZgR3BLzaffIfFnMwg/Rb8sGls5pQsZv5jL2wk3+Bj3OXBYdd
pDyjGoalJBzObKzd/t15kNHwY4FXYFcZLQPncw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YRmSEzaa2WFVvMH1BwWc1TIUpVbzSEIP0VbI6n0sEgct/X4PiTfMQmK1jBVCaISIzwBxscKQwZOt
mb/nmINGg6I7ih39LSbBMtx6cdCUiyaLkPeRbqfyPpKhvnUIFmdKVvTd1dYzxeOeuDnhSVaBaAcN
3lngSg7lIbmhLIGjC29yQrBTiLArbVZi6IRGronMK51e3UrYa6GspsznhiuRcXjEb4bHKrJ2CM5Z
BUwA+E9949sQgyOagFZbLVle2ESbwBaoxcAPn2gxfRHlT0leqyLgUGDZLsfArzGzw9BTGzyEG2TR
XOrKFNYRfMXMrnGsBM7acIelY4LdAMgsKgDH/A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28032)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
