// ////////////////////////////////////////////////////////////////////////
// Copyright (C) 2019, Xilinx Inc - All rights reserved
//
// Licensed under the Apache License, Version 2.0 (the "License"). You may
// not use this file except in compliance with the License. A copy of the
// License is located at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations
// under the License.
// ////////////////////////////////////////////////////////////////////////

`timescale 1ps/1ps

module sys_clk_gen (sys_clk);

output	sys_clk;

reg		sys_clk;

parameter        offset = 0;
parameter        halfcycle = 500;

initial begin

	sys_clk = 0;
	#(offset);

	forever #(halfcycle) sys_clk = ~sys_clk;

end

endmodule // sys_clk_gen
