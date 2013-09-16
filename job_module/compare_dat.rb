require '../core_module/compare_dat.rb'

compare1 = Compare_dat.new 'addr1.dat', 'addr2.dat'
compare1.result_to_txt 'addr_compare_res1.txt', 8

compare2 = Compare_dat.new 'addr2.dat', 'addr1.dat'
compare2.result_to_txt 'addr_compare_res2.txt', 8