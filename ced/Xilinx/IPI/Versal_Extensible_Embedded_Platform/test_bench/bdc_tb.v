//////////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2023, Advanced Micro Devices Inc - All rights reserved

// Licensed under the Apache License, Version 2.0 (the "License"). You may
// not use this file except in compliance with the License. A copy of the
// License is located at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations
// under the License.
//////////////////////////////////////////////////////////////////////////////////

    `timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // Company: 
    // Engineer: 
    // 
    // Create Date: 01/06/2023 12:08:36 PM
    // Design Name: 
    // Module Name: tb
    // Project Name: 
    // Target Devices: 
    // Tool Versions: 
    // Description: 
    // 
    // Dependencies: 
    // 
    // Revision:
    // Revision 0.01 - File Created
    // Additional Comments:

    // 

    //////////////////////////////////////////////////////////////////////////////////

module tb();

    integer clk_in1_1_cnt=0;
    integer reset_cnt=0;
    integer clk_wiz_out1_cnt=0;
    ext_platform_wrapper_sim_wrapper DUT ();
    // Cross Language Boundary interaction is not supported in Questa.
    // Therefore, using Veilog Signals in the testbench
     // process  to poll the pl_resetn
      always @ (posedge DUT.ext_platform_wrapper_i.ext_platform_i.ext_bdc.clk_in1_1) begin
      clk_in1_1_cnt = clk_in1_1_cnt + 1;
        if (DUT.ext_platform_wrapper_i.ext_platform_i.ext_bdc.CIPS_0_pl_resetn1) 
        begin 
          if(reset_cnt < 10)
          begin
            $display("CIPS pl_clk0 count: %0d ,CIPS pl0_resetn: De-asserted",clk_in1_1_cnt);
            reset_cnt = reset_cnt+1;
          end
        end
        else $display("CIPS pl_clk0 count: %0d ,CIPS pl0_resetn: Asserted",clk_in1_1_cnt);
      end

      // process  to poll the clock_wiz output 1
      always @ (posedge DUT.ext_platform_wrapper_i.ext_platform_i.ext_bdc.clk_wizard_0_clk_out1) begin
          if(clk_wiz_out1_cnt<10)
         begin
            $display("clk_wiz_out1 count: %0d ,CIPS pl0_resetn: De-asserted",clk_wiz_out1_cnt);
            clk_wiz_out1_cnt = clk_wiz_out1_cnt + 1;
         end
      end

endmodule

