require '../core_module/dat_to_txt.rb'
require '../core_module/field_mapping.rb'

dat = Dat_to_record.new 'WKD_GHR_ADDRESSES.DAT'
datoutput = dat.export_records
 
tocsv = Dat_to_csv.new datoutput, 'address.txt'
tocsv.to_csv