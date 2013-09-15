require '../core_module/xls_driver.rb'
require '../core_module/dat_driver.rb'
require 'pathname'

class Dat_to_csv
  def initialize array = [{'k' => 'v'}], csvname = 'default.csv'
    path = Pathname.new(File.dirname(__FILE__)).realpath
    @file = "#{path}/output_file/#{csvname}"
    @array = array
  end
  def to_csv
     csv_file = File.new(@file,'w')
     # field_array = Array.new
     # value_array = Array.new
     @array[0].each do |k,v|
      csv_file.print "#{k}%"
     end
     csv_file.print "\r"
     @array.each do |array|
       array.each do |field,value|
        csv_file.print "#{value}%"
       end
       csv_file.print "\r"
     end
     csv_file.close
  end
end