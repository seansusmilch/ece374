view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue U -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/isa/clock 
wave create -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 300ps sim:/isa/reset 
wave modify -driver freeze -pattern constant -value 0 -starttime 80ps -endtime 1000ps Edit:/isa/reset 
wave modify -driver freeze -pattern constant -value 1 -starttime 80ps -endtime 125ps Edit:/isa/reset 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/isa/clock 
wave modify -driver freeze -pattern constant -value 0 -starttime 80ps -endtime 125ps Edit:/isa/reset 
WaveCollapseAll -1
wave clipboard restore
