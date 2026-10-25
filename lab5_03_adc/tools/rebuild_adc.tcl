set root [file normalize [file join [file dirname [info script]] ..]]
open_project [file join $root vivado lab5_03_adc.xpr]
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] ne "100%"} {error "Synthesis failed"}
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] ne "100%"} {error "Implementation failed"}
open_run impl_1
report_timing_summary -file [file join $root evidence adc_fix timing_summary.rpt]
report_drc -file [file join $root evidence adc_fix drc.rpt]
puts "ADC_REBUILD_COMPLETE"
close_project
exit
