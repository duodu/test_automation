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

class Dat_to_hash < Dat_driver
  def initialize filename
    super filename
  end
  def output_records position
    records = Hash.new
    File.open("#{@path}/input_file/#{@file}",'r') do |file|
      while record = file.gets
        length = record.split('').length
        field = record.split('')[0...position].join('')
        value = record.split('')[position...length].join('')
        records[field] = value
      end
    end
    return records
  end
end