require '../core_module/field_mapping.rb'

job_done = Dat_to_record.new 'WKD_GHR_ADDRESSES.DAT'
job_done.export_records.each do |array|
  array.each do |k,v|
    print "#{k} = #{v},"
    
  end
  print "\r"
end