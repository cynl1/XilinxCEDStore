// ////////////////////////////////////////////////////////////////////////
// Copyright (C) 2019, Xilinx Inc - All rights reserved
//
// Licensed under the Apache License, Version 2.0 (the "License"). You may
// not use this file except in compliance with the License. A copy of the
// License is located at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations
// under the License.
// ////////////////////////////////////////////////////////////////////////

module dsc_byp_h2c
  (
   input h2c_dsc_bypass,
   input h2c_mm_marker_req,
   input h2c_st_marker_req,
   output h2c_mm_marker_rsp,
   output h2c_st_marker_rsp,
   // Descriptor Bypass Out for mdma
   input  logic [255:0]                                                   h2c_byp_out_dsc,
   input  logic [2:0]                                                     h2c_byp_out_fmt,
   input  logic                                                           h2c_byp_out_st_mm,
   input  logic [1:0]                                                     h2c_byp_out_dsc_sz,
   input  logic [10:0]                                                    h2c_byp_out_qid,
   input  logic                                                           h2c_byp_out_error,
   input  logic [11:0]                                                    h2c_byp_out_func,
   input  logic [15:0]                                                    h2c_byp_out_cidx,
   input  logic [2:0]                                                     h2c_byp_out_port_id,
   input  logic                                                           h2c_byp_out_vld,
   output logic                                                           h2c_byp_out_rdy,
   
   // Desciptor Bypass for mdma 
   output   logic [63:0]                                                    h2c_byp_in_mm_radr,
   output   logic [63:0]                                                    h2c_byp_in_mm_wadr,
   output   logic [15:0]                                                    h2c_byp_in_mm_len,
   output   logic                                                           h2c_byp_in_mm_mrkr_req,
   output   logic                                                           h2c_byp_in_mm_sdi,
   output   logic [10:0]                                                    h2c_byp_in_mm_qid,
   output   logic                                                           h2c_byp_in_mm_error,
   output   logic [11:0]                                                    h2c_byp_in_mm_func,
   output   logic [15:0]                                                    h2c_byp_in_mm_cidx,
   output   logic [2:0]                                                     h2c_byp_in_mm_port_id,
   output   logic                                                           h2c_byp_in_mm_no_dma,
   output   logic                                                           h2c_byp_in_mm_vld,
   input    logic                                                           h2c_byp_in_mm_rdy,

   // Desciptor Bypass for mdma 
   output   logic [63:0]                                                    h2c_byp_in_st_addr,
   output   logic [15:0]                                                    h2c_byp_in_st_len,
   output   logic                                                           h2c_byp_in_st_eop,
   output   logic                                                           h2c_byp_in_st_sop,
   output   logic                                                           h2c_byp_in_st_mrkr_req,
   output   logic                                                           h2c_byp_in_st_sdi,
   output   logic [10:0]                                                    h2c_byp_in_st_qid,
   output   logic                                                           h2c_byp_in_st_error,
   output   logic [11:0]                                                    h2c_byp_in_st_func,
   output   logic [15:0]                                                    h2c_byp_in_st_cidx,
   output   logic [2:0]                                                     h2c_byp_in_st_port_id,
   output   logic                                                           h2c_byp_in_st_no_dma,
   output   logic                                                           h2c_byp_in_st_vld,
   input    logic                                                           h2c_byp_in_st_rdy

   );

   //h2c_byp_out_fmt == 3'b1 : is marker responce, all other values are reserved
   
   assign h2c_mm_marker_rsp = (h2c_byp_out_fmt == 3'b1) & h2c_byp_out_vld & h2c_byp_out_st_mm;
   assign h2c_st_marker_rsp = (h2c_byp_out_fmt == 3'b1) & h2c_byp_out_vld & ~h2c_byp_out_st_mm;

   assign h2c_byp_out_rdy        =  (h2c_byp_out_fmt == 3'b1) ? 1'b1 :
				    h2c_dsc_bypass & h2c_byp_out_st_mm ? h2c_byp_in_mm_rdy : 
				    h2c_dsc_bypass & ~h2c_byp_out_st_mm ? h2c_byp_in_st_rdy : 1'b1;
// MM
   assign h2c_byp_in_mm_mrkr_req = h2c_mm_marker_req;
   assign h2c_byp_in_mm_radr     = h2c_byp_out_dsc[63:0];
   assign h2c_byp_in_mm_wadr     = h2c_byp_out_dsc[191:128];
   assign h2c_byp_in_mm_len      = h2c_byp_out_dsc[79:64];
   assign h2c_byp_in_mm_sdi      = h2c_byp_out_dsc[94];  // eop. send sdi at last discriptor;
   assign h2c_byp_in_mm_qid      = h2c_byp_out_qid;
   assign h2c_byp_in_mm_error    = h2c_byp_out_error;
   assign h2c_byp_in_mm_func     = h2c_byp_out_func;
   assign h2c_byp_in_mm_cidx     = h2c_byp_out_cidx;
   assign h2c_byp_in_mm_port_id  = h2c_byp_out_port_id;
   assign h2c_byp_in_mm_no_dma   = 1'b0;

   assign h2c_byp_in_mm_vld      = h2c_mm_marker_req | (h2c_dsc_bypass & ~h2c_byp_out_fmt[0] ? h2c_byp_out_st_mm & h2c_byp_out_vld : 1'b0);

// ST
   assign h2c_byp_in_st_mrkr_req = h2c_st_marker_req;
   assign h2c_byp_in_st_addr     = h2c_byp_out_dsc[127:64];
   assign h2c_byp_in_st_len      = h2c_byp_out_dsc[47:32];
   assign h2c_byp_in_st_eop      = h2c_byp_out_dsc[49];
   assign h2c_byp_in_st_sop      = h2c_byp_out_dsc[48];
   assign h2c_byp_in_st_sdi      = h2c_byp_out_dsc[49]; // eop. send sdi at last discriptor;
   assign h2c_byp_in_st_qid      = h2c_byp_out_qid;
   assign h2c_byp_in_st_error    = h2c_byp_out_error;
   assign h2c_byp_in_st_func     = h2c_byp_out_func;
   assign h2c_byp_in_st_cidx     = h2c_byp_out_cidx;
   assign h2c_byp_in_st_port_id  = h2c_byp_out_port_id;
   assign h2c_byp_in_st_no_dma   = 1'b0;

   assign h2c_byp_in_st_vld      = h2c_dsc_bypass & ~h2c_byp_out_fmt[0] ? ~h2c_byp_out_st_mm & h2c_byp_out_vld : 1'b0;

endmodule // dsc_bypass

