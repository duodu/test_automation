#encoding:utf-8
require 'win32ole'
require 'pathname'

class Excel_driver
  def initialize filename = 1
    path = Pathname.new(File.dirname(__FILE__)).realpath
    @path = "#{path}/input_file/#{filename}"
  end
  def new_file
    WIN32OLE.codepage = WIN32OLE::CP_UTF8
    @excel = WIN32OLE::new('excel.Application')
    @excel.visible = true
    @workbook = @excel.Workbooks.Add()
  end
  def sheetadd
    @worksheet = @workbook.Worksheets.Add()
    @worksheet.Activate
  end
  def open
    WIN32OLE.codepage = WIN32OLE::CP_UTF8
    @excel = WIN32OLE::new('excel.Application')
    @workbook = @excel.Workbooks.Open(@path)
  end
  def sheetselect num
    @worksheet = @workbook.Worksheets(num)
    @worksheet.Select
  end
  def end_row
    return @worksheet.UsedRange.rows.Count
  end
  def end_column
    return @worksheet.UsedRange.columns.Count
  end
  def cell column, row
    return @worksheet.Range("#{column}#{row}").value
  end
  def setColor row, result
    # endcolumn = end_column
    if result == 'Fail'
      @worksheet.Range("A#{row}:F#{row}").Interior.ColorIndex = 3
    elsif result == 'Pass'
      @worksheet.Range("A#{row}:F#{row}").Interior.ColorIndex = 50
    end
  end
  def save
    @workbook.save
  end
  def quit
    @workbook.close
    @excel.quit
  end
  def write cell, value
    @worksheet.Range(cell).value = value
  end
  def case_id_array
    id_array = Array.new
    for line in 2 .. end_row
      id_array << @worksheet.Range("A#{line}").value.to_i
    end
    return id_array
  end
end