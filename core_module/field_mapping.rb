require '../core_module/xls_driver.rb'
require '../core_module/dat_driver.rb'

class Read_field_mapping
  def initialize sheets
    @sheet = sheets
  end
  def output
    begin
      @field_mapping_excel = Excel_driver.new 'INT10004F_WD_Backfeed_to_GHRMS_Outbound EIB_Field_Mapping.xlsx'
      @field_mapping_excel.open
      @field_mapping_excel.sheetselect @sheet

      field_mapping = Array.new
      end_row = @field_mapping_excel.end_row
      for row in 8 .. end_row
        each_field = Hash.new
        field = @field_mapping_excel.cell 'A',row
        position = @field_mapping_excel.cell('E',row).split(' - ')
        each_field[field] = position
        field_mapping << each_field
      end
    ensure
      @field_mapping_excel.quit
    end
    return field_mapping
  end
end

class Dat_to_record
  def initialize filename
    num = 1 if filename.include? "ADDRESS"
    num = 2 if filename.include? "JOB"
    num = 3 if filename.include? "NAME"
    num = 4 if filename.include? "ID"
    num = 5 if filename.include? "PSSPRT"
    @field = Read_field_mapping.new num
    @dat = Dat_driver.new filename
  end
  def export_records
    records = Array.new
    field_output = @field.output
    @dat.output_records.each do |record|
      each_record = Hash.new
      record_array = record.split ''
      #puts record_array.length
      
      field_output.each do |array|
        array.each do |k,v|          
          each_record[k] = record_array[v[0].to_i-1...v[1].to_i].join('').rstrip
        end
      end
      records << each_record
    end
    return records
  end
end