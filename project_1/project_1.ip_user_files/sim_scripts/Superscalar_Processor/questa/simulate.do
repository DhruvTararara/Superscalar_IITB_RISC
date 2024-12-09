onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Superscalar_Processor_opt

do {wave.do}

view wave
view structure
view signals

do {Superscalar_Processor.udo}

run -all

quit -force
