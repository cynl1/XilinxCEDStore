//-----------------------------------------------------------------------------
//
// (c) Copyright 2020-2024 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//-----------------------------------------------------------------------------
//
// Project    : Versal CPM5N BMD Test bench 
// File       : board_common.vh
// Version    : 1.1 
//-----------------------------------------------------------------------------

`timescale 1ps/1ps

`define IO_TRUE                      1
`define IO_FALSE                     0

`define TX_TASKS                     tx_usrapp

// Endpoint Sys clock clock frequency 100 MHz -> half clock -> 5000 pS
`define SYS_CLK_COR_HALF_CLK_PERIOD         5000

// Downstrean Port Sys clock clock frequency 250 MHz -> half clock -> 2000 pS
`define SYS_CLK_DSPORT_HALF_CLK_PERIOD      2000

`define RX_LOG                       0
`define TX_LOG                       1

// PCI Express TLP Types constants
`define  PCI_EXP_MEM_READ32          7'b0000000
`define  PCI_EXP_IO_READ             7'b0000010
`define  PCI_EXP_CFG_READ0           7'b0000100
`define  PCI_EXP_COMPLETION_WO_DATA  7'b0001010
`define  PCI_EXP_MEM_READ64          7'b0100000
`define  PCI_EXP_MSG_NODATA          7'b0110xxx
`define  PCI_EXP_MEM_WRITE32         7'b1000000
`define  PCI_EXP_IO_WRITE            7'b1000010
`define  PCI_EXP_CFG_WRITE0          7'b1000100
`define  PCI_EXP_COMPLETION_DATA     7'b1001010
`define  PCI_EXP_MEM_WRITE64         7'b1100000
`define  PCI_EXP_MSG_DATA            7'b1110xxx

`define  RC_RX_TIMEOUT               5000
`define  CQ_RX_TIMEOUT               5000

`define  SYNC_RQ_RDY                 0
`define  SYNC_CC_RDY                 1

// One and only one can be set. Define if it's Single controller PCIE0(x16) or Dual controller design PCIE0+1(x8x8)
`define SINGLE_CTRL
//`define DUAL_CTRL

`ifdef EP_NOC_SIM
`ifndef EP_WRAPPER
`define EP_WRAPPER board.EP.design_1_wrapper_i
`endif
`else
`ifndef EP_WRAPPER
`define EP_WRAPPER board.EP
`endif
`endif

`ifdef RP_NOC_SIM
`ifndef RP_WRAPPER
`define RP_WRAPPER board.RP.design_rp_wrapper_i
`endif
`else
`ifndef RP_WRAPPER
`define RP_WRAPPER board.RP
`endif
`endif

// IP path. Please update IP_PATH to match your design hierarchy
`ifndef EP_IP_PATH
`define EP_IP_PATH `EP_WRAPPER.design_1_i.versal_cips_0              // Path to the IP for Endpoint (DUT)
`endif

`ifdef SINGLE_CTRL
`ifndef RP_IP_PATH
`define RP_IP_PATH `RP_WRAPPER.Single_CTRL.design_rp_i.versal_cips_0 // Path to the IP for RP (Sim Testbench)
`endif
`elsif DUAL_CTRL
`ifndef RP_IP_PATH
`define RP_IP_PATH `RP_WRAPPER.Dual_Ctrl.design_rp_i.versal_cips_0   // Path to the IP for RP (Sim Testbench)
`endif
`endif

// Static path within the IP
`define EP_PMC_PATH  `EP_IP_PATH.inst.pspmc_0
`define EP_PS_PATH   `EP_PMC_PATH.inst.PS9_VIP_inst
`define EP_CPM_PATH  `EP_IP_PATH.inst.cpm_0
`define RP_PMC_PATH  `RP_IP_PATH.inst.pspmc_0
`define RP_PS_PATH   `RP_PMC_PATH.inst.PS9_VIP_inst
`define RP_CPM_PATH  `RP_IP_PATH.inst.cpm_0