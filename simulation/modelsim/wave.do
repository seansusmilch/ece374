view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 50ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/isa_pipeline/clock 
wave create -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps sim:/isa_pipeline/reset 
wave modify -driver freeze -pattern constant -value 0 -starttime 40ps -endtime 1000ps Edit:/isa_pipeline/reset 
WaveCollapseAll -1
wave clipboard restore
