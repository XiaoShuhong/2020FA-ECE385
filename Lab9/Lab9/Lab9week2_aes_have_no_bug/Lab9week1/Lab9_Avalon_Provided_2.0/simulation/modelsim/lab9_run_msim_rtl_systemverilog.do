transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0 {D:/OneDrive - International Campus, Zhejiang University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0/InvAddRoundKey.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0 {D:/OneDrive - International Campus, Zhejiang University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0/SubBytes.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0 {D:/OneDrive - International Campus, Zhejiang University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0/InvShiftRows.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0 {D:/OneDrive - International Campus, Zhejiang University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0/InvMixColumns.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0 {D:/OneDrive - International Campus, Zhejiang University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0/AES.sv}
vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0 {D:/OneDrive - International Campus, Zhejiang University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0/KeyExpansion.sv}
vlib nios_system
vmap nios_system nios_system

vlog -sv -work work +incdir+D:/OneDrive\ -\ International\ Campus,\ Zhejiang\ University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0 {D:/OneDrive - International Campus, Zhejiang University/ece385/Lab9/Lab9week2_aes_have_no_bug/Lab9week2_aes_have_no_bug/Lab9week1/Lab9_Avalon_Provided_2.0/testbench_week2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L nios_system -voptargs="+acc"  testbench_week2

add wave *
view structure
view signals
run 1000 us
