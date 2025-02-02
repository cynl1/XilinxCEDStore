# ########################################################################
# Copyright (C) 2021, Xilinx Inc - All rights reserved
# 
# Licensed under the Apache License, Version 2.0 (the "License"). You may
# not use this file except in compliance with the License. A copy of the
# License is located at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
# ########################################################################


set currentFile [file normalize [info script]]
variable currentDir [file dirname $currentFile]
variable logStuff 1

source -notrace "$currentDir/gt_help.tcl"
source -notrace "$currentDir/logic_help.tcl"

#
#  required for CED, return all versal parts
#
proc getSupportedParts {} {
  return ""
}

#
#  Only allow latest VCK190/VMK180/VCK120
#
proc getSupportedBoards {} {
  set boards [list vck190 vmk180 vpk120 vhk158]
  set r [list]
  foreach b $boards {
    set p [lindex [get_board_parts *${b}:* -latest_file_version] 0]
    lappend r [get_boards -of $p]
  }

  return $r
}

#
#  Helper function to get  
#  
proc range {from to} {
   if {$to>$from} {concat [range $from [incr to -1]] $to}
}

#
#  Conditional puts
#
proc log {args} {
  variable logStuff
  if {$logStuff == 1} {
    puts [join $args " "]
  }
}


#
# Required by CED, will create dict of all the options needed to configure the CED, will be tied to 
# gui controls in addGUILayout
#
proc addOptions {DESIGNOBJ PROJECT_PARAM.PART PROJECT_PARAM.PACKAGE PROJECT_PARAM.SPEEDGRADE} {
  variable currentDir 
  
  set systemTime [clock seconds]
  log "addOptions:: [clock format $systemTime -format %H:%M:%S]"
  log "$DESIGNOBJ ${PROJECT_PARAM.PART} ${PROJECT_PARAM.PACKAGE} ${PROJECT_PARAM.SPEEDGRADE}"

}

#
#  Required by CED, create parameters, which are GUI controls to be displayed in the CED
#
proc addGUILayout {DESIGNOBJ PROJECT_PARAM.PART PROJECT_PARAM.PACKAGE PROJECT_PARAM.SPEEDGRADE} {


}

proc createDesign {design_name options} {
  variable currentDir
  puts $currentDir
  puts "createDesign options: $options"
  set board [lindex [split [get_property board_part [current_project]] ":"] 1]
  log "board: $board"
  source ${currentDir}/chipscopy_ex_bd.tcl
  set proj_name [lindex [get_projects] 0]
  set proj_dir [get_property DIRECTORY $proj_name]
  set_property TARGET_LANGUAGE Verilog $proj_name

  switch $board {
    vck190 -
    vmk180 {
      create_root_design_vck190 ""
      import_files -fileset constrs_1 -norecurse -flat "${currentDir}/xdc/versal_ibert_vck190.xdc"
      import_files -fileset constrs_1 -norecurse -flat "${currentDir}/timing_constraints/versal_ibert_vck190_timing.xdc"
      set_property used_in_synthesis false [get_files  ${proj_dir}/${proj_name}.srcs/constrs_1/imports/versal_ibert_vck190_timing.xdc]
    }
    vpk120 {
      create_root_design_vpk120 ""
      import_files -fileset constrs_1 -norecurse -flat "${currentDir}/xdc/versal_ibert_vpk120.xdc"
      import_files -fileset constrs_1 -norecurse -flat "${currentDir}/timing_constraints/versal_ibert_vpk120_timing.xdc"
      set_property used_in_synthesis false [get_files  ${proj_dir}/${proj_name}.srcs/constrs_1/imports/versal_ibert_vpk120_timing.xdc]
    }
    vhk158 {
      create_root_design_vhk158 ""
      import_files -fileset constrs_1 -norecurse -flat "${currentDir}/xdc/versal_ibert_vhk158.xdc"
      import_files -fileset constrs_1 -norecurse -flat "${currentDir}/timing_constraints/versal_ibert_vhk158_timing.xdc"
      set_property used_in_synthesis false [get_files  ${proj_dir}/${proj_name}.srcs/constrs_1/imports/versal_ibert_vhk158_timing.xdc]
    }
  }
  
  make_wrapper -files [get_files ${proj_dir}/${proj_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd] -top
  add_files -norecurse ${proj_dir}/${proj_name}.srcs/sources_1/bd/${design_name}/hdl/${design_name}_wrapper.v
  open_bd_design [get_bd_designs -filter {NAME == "chipscopy"}]
  # exec echo "PHASE_DONE" > ${proj_dir}/[current_project].srcs/[current_fileset]/bd/chipscopy/ip/chipscopy_noc_tg_0/chipscopy_noc_tg_0_synth_pattern.csv
}



