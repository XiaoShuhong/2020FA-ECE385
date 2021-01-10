transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/Synchronizers.sv}
vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/Router.sv}
vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/Reg_4.sv}
vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/HexDriver.sv}
vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/Control.sv}
vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/compute.sv}
vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/Register_unit.sv}
vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/Processor.sv}

vlog -sv -work work +incdir+D:/2020FA/ECE385/IQT {D:/2020FA/ECE385/IQT/testbench_8.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
