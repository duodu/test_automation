require 'pathname'

class Dat_driver
  def initialize filename
    @path = Pathname.new(File.dirname(__FILE__)).realpath
    @file = filename
  end
  def output_records
    records = Array.new
    File.open("#{@path}/input_file/#{@file}",'r') do |file|
      while record = file.gets
        records << record
      end
    end
    return records
  end
end