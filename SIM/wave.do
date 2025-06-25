onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/clk_i
add wave -noupdate /tb_top/enable_i
add wave -noupdate /tb_top/reset_i
add wave -noupdate -radix hexadecimal /tb_top/Y_i
add wave -noupdate -radix hexadecimal /tb_top/X_i
add wave -noupdate /tb_top/ALUFN_i
add wave -noupdate /tb_top/PWM_o
add wave -noupdate /tb_top/ALUout_o
add wave -noupdate /tb_top/Nflag_o
add wave -noupdate /tb_top/Cflag_o
add wave -noupdate /tb_top/Zflag_o
add wave -noupdate /tb_top/Vflag_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {120000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {26944208896 ps}
