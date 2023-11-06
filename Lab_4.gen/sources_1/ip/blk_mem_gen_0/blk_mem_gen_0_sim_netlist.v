// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Sun Nov  5 14:10:29 2023
// Host        : BB305-01 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               z:/EENG498/Lab_4/Lab_4.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
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
  blk_mem_gen_0_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 28016)
`pragma protect data_block
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
nrT+xM5Ywe59Wh0R+HVZQPpr1XQSBELexd7IypQ=
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
