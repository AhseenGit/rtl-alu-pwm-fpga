onerror {resume}
add list -width 15 /tb_top/clk_i
add list /tb_top/enable_i
add list /tb_top/reset_i
add list /tb_top/Y_i
add list /tb_top/X_i
add list /tb_top/ALUFN_i
add list /tb_top/PWM_o
add list /tb_top/ALUout_o
add list /tb_top/Nflag_o
add list /tb_top/Cflag_o
add list /tb_top/Zflag_o
add list /tb_top/Vflag_o
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta collapse
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
