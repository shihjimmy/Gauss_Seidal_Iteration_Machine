###################################################################

# Created by write_sdc on Fri May 19 01:54:09 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max WCCOM -max_library                               \
fsa0m_a_generic_core_ss1p62v125c\
                         -min BCCOM -min_library                               \
fsa0m_a_generic_core_ff1p98vm40c
set_wire_load_model -name G200K -library fsa0m_a_generic_core_tt1p8v25c
set_max_fanout 10 [current_design]
set_max_area 0
set_load -pin_load 10 [get_ports o_valid]
set_load -pin_load 10 [get_ports {x_next[31]}]
set_load -pin_load 10 [get_ports {x_next[30]}]
set_load -pin_load 10 [get_ports {x_next[29]}]
set_load -pin_load 10 [get_ports {x_next[28]}]
set_load -pin_load 10 [get_ports {x_next[27]}]
set_load -pin_load 10 [get_ports {x_next[26]}]
set_load -pin_load 10 [get_ports {x_next[25]}]
set_load -pin_load 10 [get_ports {x_next[24]}]
set_load -pin_load 10 [get_ports {x_next[23]}]
set_load -pin_load 10 [get_ports {x_next[22]}]
set_load -pin_load 10 [get_ports {x_next[21]}]
set_load -pin_load 10 [get_ports {x_next[20]}]
set_load -pin_load 10 [get_ports {x_next[19]}]
set_load -pin_load 10 [get_ports {x_next[18]}]
set_load -pin_load 10 [get_ports {x_next[17]}]
set_load -pin_load 10 [get_ports {x_next[16]}]
set_load -pin_load 10 [get_ports {x_next[15]}]
set_load -pin_load 10 [get_ports {x_next[14]}]
set_load -pin_load 10 [get_ports {x_next[13]}]
set_load -pin_load 10 [get_ports {x_next[12]}]
set_load -pin_load 10 [get_ports {x_next[11]}]
set_load -pin_load 10 [get_ports {x_next[10]}]
set_load -pin_load 10 [get_ports {x_next[9]}]
set_load -pin_load 10 [get_ports {x_next[8]}]
set_load -pin_load 10 [get_ports {x_next[7]}]
set_load -pin_load 10 [get_ports {x_next[6]}]
set_load -pin_load 10 [get_ports {x_next[5]}]
set_load -pin_load 10 [get_ports {x_next[4]}]
set_load -pin_load 10 [get_ports {x_next[3]}]
set_load -pin_load 10 [get_ports {x_next[2]}]
set_load -pin_load 10 [get_ports {x_next[1]}]
set_load -pin_load 10 [get_ports {x_next[0]}]
create_clock [get_ports i_clk]  -period 10  -waveform {0 5}
set_clock_latency 0.5  [get_clocks i_clk]
set_clock_uncertainty 0.1  [get_clocks i_clk]
set_input_delay -clock i_clk  -max 1  [get_ports i_clk]
set_input_delay -clock i_clk  -max 1  [get_ports i_reset]
set_input_delay -clock i_clk  -max 1  [get_ports {a[55]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[54]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[53]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[52]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[51]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[50]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[49]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[48]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[47]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[46]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[45]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[44]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[43]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[42]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[41]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[40]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[39]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[38]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[37]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[36]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[35]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[34]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[33]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[32]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[31]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[30]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[29]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[28]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[27]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[26]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[25]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[24]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[23]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[22]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[21]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[20]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[19]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[18]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[17]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[16]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[15]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[14]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[13]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[12]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[11]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[10]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[9]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[8]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[7]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[6]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[5]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[4]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[3]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[2]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[1]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a[0]}]
set_input_delay -clock i_clk  -max 1  [get_ports {b[7]}]
set_input_delay -clock i_clk  -max 1  [get_ports {b[6]}]
set_input_delay -clock i_clk  -max 1  [get_ports {b[5]}]
set_input_delay -clock i_clk  -max 1  [get_ports {b[4]}]
set_input_delay -clock i_clk  -max 1  [get_ports {b[3]}]
set_input_delay -clock i_clk  -max 1  [get_ports {b[2]}]
set_input_delay -clock i_clk  -max 1  [get_ports {b[1]}]
set_input_delay -clock i_clk  -max 1  [get_ports {b[0]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[31]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[30]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[29]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[28]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[27]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[26]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[25]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[24]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[23]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[22]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[21]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[20]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[19]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[18]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[17]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[16]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[15]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[14]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[13]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[12]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[11]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[10]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[9]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[8]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[7]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[6]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[5]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[4]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[3]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[2]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[1]}]
set_input_delay -clock i_clk  -max 1  [get_ports {a_down[0]}]
set_input_delay -clock i_clk  -max 1  [get_ports i_valid]
set_input_delay -clock i_clk  -max 1  [get_ports {x[223]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[222]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[221]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[220]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[219]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[218]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[217]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[216]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[215]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[214]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[213]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[212]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[211]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[210]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[209]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[208]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[207]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[206]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[205]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[204]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[203]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[202]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[201]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[200]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[199]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[198]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[197]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[196]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[195]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[194]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[193]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[192]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[191]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[190]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[189]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[188]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[187]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[186]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[185]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[184]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[183]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[182]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[181]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[180]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[179]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[178]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[177]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[176]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[175]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[174]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[173]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[172]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[171]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[170]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[169]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[168]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[167]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[166]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[165]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[164]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[163]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[162]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[161]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[160]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[159]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[158]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[157]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[156]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[155]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[154]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[153]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[152]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[151]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[150]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[149]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[148]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[147]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[146]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[145]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[144]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[143]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[142]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[141]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[140]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[139]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[138]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[137]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[136]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[135]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[134]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[133]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[132]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[131]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[130]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[129]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[128]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[127]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[126]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[125]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[124]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[123]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[122]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[121]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[120]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[119]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[118]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[117]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[116]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[115]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[114]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[113]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[112]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[111]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[110]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[109]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[108]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[107]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[106]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[105]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[104]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[103]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[102]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[101]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[100]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[99]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[98]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[97]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[96]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[95]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[94]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[93]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[92]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[91]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[90]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[89]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[88]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[87]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[86]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[85]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[84]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[83]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[82]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[81]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[80]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[79]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[78]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[77]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[76]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[75]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[74]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[73]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[72]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[71]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[70]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[69]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[68]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[67]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[66]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[65]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[64]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[63]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[62]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[61]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[60]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[59]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[58]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[57]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[56]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[55]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[54]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[53]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[52]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[51]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[50]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[49]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[48]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[47]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[46]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[45]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[44]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[43]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[42]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[41]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[40]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[39]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[38]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[37]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[36]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[35]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[34]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[33]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[32]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[31]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[30]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[29]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[28]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[27]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[26]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[25]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[24]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[23]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[22]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[21]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[20]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[19]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[18]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[17]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[16]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[15]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[14]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[13]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[12]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[11]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[10]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[9]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[8]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[7]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[6]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[5]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[4]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[3]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[2]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[1]}]
set_input_delay -clock i_clk  -max 1  [get_ports {x[0]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports o_valid]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[31]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[30]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[29]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[28]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[27]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[26]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[25]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[24]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[23]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[22]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[21]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[20]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[19]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[18]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[17]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[16]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[15]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[14]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[13]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[12]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[11]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[10]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[9]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[8]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[7]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[6]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[5]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[4]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[3]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[2]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[1]}]
set_output_delay -clock i_clk  -min 0.5  [get_ports {x_next[0]}]
set_drive 1  [get_ports i_clk]
set_drive 1  [get_ports i_reset]
set_drive 1  [get_ports {a[55]}]
set_drive 1  [get_ports {a[54]}]
set_drive 1  [get_ports {a[53]}]
set_drive 1  [get_ports {a[52]}]
set_drive 1  [get_ports {a[51]}]
set_drive 1  [get_ports {a[50]}]
set_drive 1  [get_ports {a[49]}]
set_drive 1  [get_ports {a[48]}]
set_drive 1  [get_ports {a[47]}]
set_drive 1  [get_ports {a[46]}]
set_drive 1  [get_ports {a[45]}]
set_drive 1  [get_ports {a[44]}]
set_drive 1  [get_ports {a[43]}]
set_drive 1  [get_ports {a[42]}]
set_drive 1  [get_ports {a[41]}]
set_drive 1  [get_ports {a[40]}]
set_drive 1  [get_ports {a[39]}]
set_drive 1  [get_ports {a[38]}]
set_drive 1  [get_ports {a[37]}]
set_drive 1  [get_ports {a[36]}]
set_drive 1  [get_ports {a[35]}]
set_drive 1  [get_ports {a[34]}]
set_drive 1  [get_ports {a[33]}]
set_drive 1  [get_ports {a[32]}]
set_drive 1  [get_ports {a[31]}]
set_drive 1  [get_ports {a[30]}]
set_drive 1  [get_ports {a[29]}]
set_drive 1  [get_ports {a[28]}]
set_drive 1  [get_ports {a[27]}]
set_drive 1  [get_ports {a[26]}]
set_drive 1  [get_ports {a[25]}]
set_drive 1  [get_ports {a[24]}]
set_drive 1  [get_ports {a[23]}]
set_drive 1  [get_ports {a[22]}]
set_drive 1  [get_ports {a[21]}]
set_drive 1  [get_ports {a[20]}]
set_drive 1  [get_ports {a[19]}]
set_drive 1  [get_ports {a[18]}]
set_drive 1  [get_ports {a[17]}]
set_drive 1  [get_ports {a[16]}]
set_drive 1  [get_ports {a[15]}]
set_drive 1  [get_ports {a[14]}]
set_drive 1  [get_ports {a[13]}]
set_drive 1  [get_ports {a[12]}]
set_drive 1  [get_ports {a[11]}]
set_drive 1  [get_ports {a[10]}]
set_drive 1  [get_ports {a[9]}]
set_drive 1  [get_ports {a[8]}]
set_drive 1  [get_ports {a[7]}]
set_drive 1  [get_ports {a[6]}]
set_drive 1  [get_ports {a[5]}]
set_drive 1  [get_ports {a[4]}]
set_drive 1  [get_ports {a[3]}]
set_drive 1  [get_ports {a[2]}]
set_drive 1  [get_ports {a[1]}]
set_drive 1  [get_ports {a[0]}]
set_drive 1  [get_ports {b[7]}]
set_drive 1  [get_ports {b[6]}]
set_drive 1  [get_ports {b[5]}]
set_drive 1  [get_ports {b[4]}]
set_drive 1  [get_ports {b[3]}]
set_drive 1  [get_ports {b[2]}]
set_drive 1  [get_ports {b[1]}]
set_drive 1  [get_ports {b[0]}]
set_drive 1  [get_ports {a_down[31]}]
set_drive 1  [get_ports {a_down[30]}]
set_drive 1  [get_ports {a_down[29]}]
set_drive 1  [get_ports {a_down[28]}]
set_drive 1  [get_ports {a_down[27]}]
set_drive 1  [get_ports {a_down[26]}]
set_drive 1  [get_ports {a_down[25]}]
set_drive 1  [get_ports {a_down[24]}]
set_drive 1  [get_ports {a_down[23]}]
set_drive 1  [get_ports {a_down[22]}]
set_drive 1  [get_ports {a_down[21]}]
set_drive 1  [get_ports {a_down[20]}]
set_drive 1  [get_ports {a_down[19]}]
set_drive 1  [get_ports {a_down[18]}]
set_drive 1  [get_ports {a_down[17]}]
set_drive 1  [get_ports {a_down[16]}]
set_drive 1  [get_ports {a_down[15]}]
set_drive 1  [get_ports {a_down[14]}]
set_drive 1  [get_ports {a_down[13]}]
set_drive 1  [get_ports {a_down[12]}]
set_drive 1  [get_ports {a_down[11]}]
set_drive 1  [get_ports {a_down[10]}]
set_drive 1  [get_ports {a_down[9]}]
set_drive 1  [get_ports {a_down[8]}]
set_drive 1  [get_ports {a_down[7]}]
set_drive 1  [get_ports {a_down[6]}]
set_drive 1  [get_ports {a_down[5]}]
set_drive 1  [get_ports {a_down[4]}]
set_drive 1  [get_ports {a_down[3]}]
set_drive 1  [get_ports {a_down[2]}]
set_drive 1  [get_ports {a_down[1]}]
set_drive 1  [get_ports {a_down[0]}]
set_drive 1  [get_ports i_valid]
set_drive 1  [get_ports {x[223]}]
set_drive 1  [get_ports {x[222]}]
set_drive 1  [get_ports {x[221]}]
set_drive 1  [get_ports {x[220]}]
set_drive 1  [get_ports {x[219]}]
set_drive 1  [get_ports {x[218]}]
set_drive 1  [get_ports {x[217]}]
set_drive 1  [get_ports {x[216]}]
set_drive 1  [get_ports {x[215]}]
set_drive 1  [get_ports {x[214]}]
set_drive 1  [get_ports {x[213]}]
set_drive 1  [get_ports {x[212]}]
set_drive 1  [get_ports {x[211]}]
set_drive 1  [get_ports {x[210]}]
set_drive 1  [get_ports {x[209]}]
set_drive 1  [get_ports {x[208]}]
set_drive 1  [get_ports {x[207]}]
set_drive 1  [get_ports {x[206]}]
set_drive 1  [get_ports {x[205]}]
set_drive 1  [get_ports {x[204]}]
set_drive 1  [get_ports {x[203]}]
set_drive 1  [get_ports {x[202]}]
set_drive 1  [get_ports {x[201]}]
set_drive 1  [get_ports {x[200]}]
set_drive 1  [get_ports {x[199]}]
set_drive 1  [get_ports {x[198]}]
set_drive 1  [get_ports {x[197]}]
set_drive 1  [get_ports {x[196]}]
set_drive 1  [get_ports {x[195]}]
set_drive 1  [get_ports {x[194]}]
set_drive 1  [get_ports {x[193]}]
set_drive 1  [get_ports {x[192]}]
set_drive 1  [get_ports {x[191]}]
set_drive 1  [get_ports {x[190]}]
set_drive 1  [get_ports {x[189]}]
set_drive 1  [get_ports {x[188]}]
set_drive 1  [get_ports {x[187]}]
set_drive 1  [get_ports {x[186]}]
set_drive 1  [get_ports {x[185]}]
set_drive 1  [get_ports {x[184]}]
set_drive 1  [get_ports {x[183]}]
set_drive 1  [get_ports {x[182]}]
set_drive 1  [get_ports {x[181]}]
set_drive 1  [get_ports {x[180]}]
set_drive 1  [get_ports {x[179]}]
set_drive 1  [get_ports {x[178]}]
set_drive 1  [get_ports {x[177]}]
set_drive 1  [get_ports {x[176]}]
set_drive 1  [get_ports {x[175]}]
set_drive 1  [get_ports {x[174]}]
set_drive 1  [get_ports {x[173]}]
set_drive 1  [get_ports {x[172]}]
set_drive 1  [get_ports {x[171]}]
set_drive 1  [get_ports {x[170]}]
set_drive 1  [get_ports {x[169]}]
set_drive 1  [get_ports {x[168]}]
set_drive 1  [get_ports {x[167]}]
set_drive 1  [get_ports {x[166]}]
set_drive 1  [get_ports {x[165]}]
set_drive 1  [get_ports {x[164]}]
set_drive 1  [get_ports {x[163]}]
set_drive 1  [get_ports {x[162]}]
set_drive 1  [get_ports {x[161]}]
set_drive 1  [get_ports {x[160]}]
set_drive 1  [get_ports {x[159]}]
set_drive 1  [get_ports {x[158]}]
set_drive 1  [get_ports {x[157]}]
set_drive 1  [get_ports {x[156]}]
set_drive 1  [get_ports {x[155]}]
set_drive 1  [get_ports {x[154]}]
set_drive 1  [get_ports {x[153]}]
set_drive 1  [get_ports {x[152]}]
set_drive 1  [get_ports {x[151]}]
set_drive 1  [get_ports {x[150]}]
set_drive 1  [get_ports {x[149]}]
set_drive 1  [get_ports {x[148]}]
set_drive 1  [get_ports {x[147]}]
set_drive 1  [get_ports {x[146]}]
set_drive 1  [get_ports {x[145]}]
set_drive 1  [get_ports {x[144]}]
set_drive 1  [get_ports {x[143]}]
set_drive 1  [get_ports {x[142]}]
set_drive 1  [get_ports {x[141]}]
set_drive 1  [get_ports {x[140]}]
set_drive 1  [get_ports {x[139]}]
set_drive 1  [get_ports {x[138]}]
set_drive 1  [get_ports {x[137]}]
set_drive 1  [get_ports {x[136]}]
set_drive 1  [get_ports {x[135]}]
set_drive 1  [get_ports {x[134]}]
set_drive 1  [get_ports {x[133]}]
set_drive 1  [get_ports {x[132]}]
set_drive 1  [get_ports {x[131]}]
set_drive 1  [get_ports {x[130]}]
set_drive 1  [get_ports {x[129]}]
set_drive 1  [get_ports {x[128]}]
set_drive 1  [get_ports {x[127]}]
set_drive 1  [get_ports {x[126]}]
set_drive 1  [get_ports {x[125]}]
set_drive 1  [get_ports {x[124]}]
set_drive 1  [get_ports {x[123]}]
set_drive 1  [get_ports {x[122]}]
set_drive 1  [get_ports {x[121]}]
set_drive 1  [get_ports {x[120]}]
set_drive 1  [get_ports {x[119]}]
set_drive 1  [get_ports {x[118]}]
set_drive 1  [get_ports {x[117]}]
set_drive 1  [get_ports {x[116]}]
set_drive 1  [get_ports {x[115]}]
set_drive 1  [get_ports {x[114]}]
set_drive 1  [get_ports {x[113]}]
set_drive 1  [get_ports {x[112]}]
set_drive 1  [get_ports {x[111]}]
set_drive 1  [get_ports {x[110]}]
set_drive 1  [get_ports {x[109]}]
set_drive 1  [get_ports {x[108]}]
set_drive 1  [get_ports {x[107]}]
set_drive 1  [get_ports {x[106]}]
set_drive 1  [get_ports {x[105]}]
set_drive 1  [get_ports {x[104]}]
set_drive 1  [get_ports {x[103]}]
set_drive 1  [get_ports {x[102]}]
set_drive 1  [get_ports {x[101]}]
set_drive 1  [get_ports {x[100]}]
set_drive 1  [get_ports {x[99]}]
set_drive 1  [get_ports {x[98]}]
set_drive 1  [get_ports {x[97]}]
set_drive 1  [get_ports {x[96]}]
set_drive 1  [get_ports {x[95]}]
set_drive 1  [get_ports {x[94]}]
set_drive 1  [get_ports {x[93]}]
set_drive 1  [get_ports {x[92]}]
set_drive 1  [get_ports {x[91]}]
set_drive 1  [get_ports {x[90]}]
set_drive 1  [get_ports {x[89]}]
set_drive 1  [get_ports {x[88]}]
set_drive 1  [get_ports {x[87]}]
set_drive 1  [get_ports {x[86]}]
set_drive 1  [get_ports {x[85]}]
set_drive 1  [get_ports {x[84]}]
set_drive 1  [get_ports {x[83]}]
set_drive 1  [get_ports {x[82]}]
set_drive 1  [get_ports {x[81]}]
set_drive 1  [get_ports {x[80]}]
set_drive 1  [get_ports {x[79]}]
set_drive 1  [get_ports {x[78]}]
set_drive 1  [get_ports {x[77]}]
set_drive 1  [get_ports {x[76]}]
set_drive 1  [get_ports {x[75]}]
set_drive 1  [get_ports {x[74]}]
set_drive 1  [get_ports {x[73]}]
set_drive 1  [get_ports {x[72]}]
set_drive 1  [get_ports {x[71]}]
set_drive 1  [get_ports {x[70]}]
set_drive 1  [get_ports {x[69]}]
set_drive 1  [get_ports {x[68]}]
set_drive 1  [get_ports {x[67]}]
set_drive 1  [get_ports {x[66]}]
set_drive 1  [get_ports {x[65]}]
set_drive 1  [get_ports {x[64]}]
set_drive 1  [get_ports {x[63]}]
set_drive 1  [get_ports {x[62]}]
set_drive 1  [get_ports {x[61]}]
set_drive 1  [get_ports {x[60]}]
set_drive 1  [get_ports {x[59]}]
set_drive 1  [get_ports {x[58]}]
set_drive 1  [get_ports {x[57]}]
set_drive 1  [get_ports {x[56]}]
set_drive 1  [get_ports {x[55]}]
set_drive 1  [get_ports {x[54]}]
set_drive 1  [get_ports {x[53]}]
set_drive 1  [get_ports {x[52]}]
set_drive 1  [get_ports {x[51]}]
set_drive 1  [get_ports {x[50]}]
set_drive 1  [get_ports {x[49]}]
set_drive 1  [get_ports {x[48]}]
set_drive 1  [get_ports {x[47]}]
set_drive 1  [get_ports {x[46]}]
set_drive 1  [get_ports {x[45]}]
set_drive 1  [get_ports {x[44]}]
set_drive 1  [get_ports {x[43]}]
set_drive 1  [get_ports {x[42]}]
set_drive 1  [get_ports {x[41]}]
set_drive 1  [get_ports {x[40]}]
set_drive 1  [get_ports {x[39]}]
set_drive 1  [get_ports {x[38]}]
set_drive 1  [get_ports {x[37]}]
set_drive 1  [get_ports {x[36]}]
set_drive 1  [get_ports {x[35]}]
set_drive 1  [get_ports {x[34]}]
set_drive 1  [get_ports {x[33]}]
set_drive 1  [get_ports {x[32]}]
set_drive 1  [get_ports {x[31]}]
set_drive 1  [get_ports {x[30]}]
set_drive 1  [get_ports {x[29]}]
set_drive 1  [get_ports {x[28]}]
set_drive 1  [get_ports {x[27]}]
set_drive 1  [get_ports {x[26]}]
set_drive 1  [get_ports {x[25]}]
set_drive 1  [get_ports {x[24]}]
set_drive 1  [get_ports {x[23]}]
set_drive 1  [get_ports {x[22]}]
set_drive 1  [get_ports {x[21]}]
set_drive 1  [get_ports {x[20]}]
set_drive 1  [get_ports {x[19]}]
set_drive 1  [get_ports {x[18]}]
set_drive 1  [get_ports {x[17]}]
set_drive 1  [get_ports {x[16]}]
set_drive 1  [get_ports {x[15]}]
set_drive 1  [get_ports {x[14]}]
set_drive 1  [get_ports {x[13]}]
set_drive 1  [get_ports {x[12]}]
set_drive 1  [get_ports {x[11]}]
set_drive 1  [get_ports {x[10]}]
set_drive 1  [get_ports {x[9]}]
set_drive 1  [get_ports {x[8]}]
set_drive 1  [get_ports {x[7]}]
set_drive 1  [get_ports {x[6]}]
set_drive 1  [get_ports {x[5]}]
set_drive 1  [get_ports {x[4]}]
set_drive 1  [get_ports {x[3]}]
set_drive 1  [get_ports {x[2]}]
set_drive 1  [get_ports {x[1]}]
set_drive 1  [get_ports {x[0]}]
