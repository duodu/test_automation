require '../core_module/dat_driver.rb'
require 'pathname'

class Compare_dat
  def initialize fileA, fileB  
    @fileA = fileA
    @fileB = fileB
  end
  def result_to_txt txtfile = 'compare_dat_result.txt', position
    path = Pathname.new(File.dirname(__FILE__)).realpath
    res_file = "#{path}/output_file/#{txtfile}"
    dat_A = Dat_to_hash.new @fileA
    dat_B = Dat_to_hash.new @fileB
    dat_A_records = dat_A.output_records position
    dat_B_records = dat_B.output_records position
    result_file = File.new res_file, 'w'
    dat_A_records.each do |k,v|
      if dat_B_records[k] != v
        result_file.puts "========================================================================="
        result_file.puts "#{@fileA}: #{k} = #{v}"
        result_file.puts "#{@fileB}: #{k} = #{dat_B_records[k]}"
      end
    end
    result_file.close
  end
end