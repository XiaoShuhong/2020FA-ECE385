transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/Synchronizers.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/memory_datapath.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/tristate.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/test_memory.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/SLC3_2.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/Mem2IO.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/ISDU.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/IR_datapath.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/HexDriver.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/Register_ALU.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/NZP.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/memory_contents.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/slc3.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/lab6_toplevel.sv}

vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/lab6/lab6 {D:/OneDrive - International Campus, Zhejiang University/ece385/lab6/lab6/testbench_week2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_week2

add wave *
view structure
view signals
run 280 us
