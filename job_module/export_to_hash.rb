require '../core_module/dat_driver.rb'

datfile = Dat_to_hash.new 'WKD_GHR_ADDRESSES.DAT'
output_hash = datfile.output_records 8
puts output_hash.class
puts output_hash.length
output_hash.each do |k,v|
  puts "#{k}: #{v}"
end
