onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Superscalar_Processor -L xil_defaultlib -L xlconstant_v1_1_6 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Superscalar_Processor xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Superscalar_Processor.udo}

run -all

endsim

quit -force
