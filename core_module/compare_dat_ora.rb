require '../core_module/field_mapping.rb'
require '../core_module/ora_driver.rb'

class Compare_dat_ora
  def initialize filename
    @file = filename
  end
  def result
    dat = Dat_to_record.new @file
    dat_records = dat.export_records
    dat_records.each do |record|
      # puts record
      ora_driver = Ora_driver.new
      ora_records = ora_driver.ora_records "
select b.emplID, b.passport_nbr, b.country_passport from ps_citizen_pssprt b
join ps_job j on b.emplID = j.emplID
where
 J.PER_ORG <> 'CWR' 
 AND
    J.EMPL_RCD = 0 
   AND J.EFFDT = ( 
 SELECT MAX(K.EFFDT) 
  FROM PS_JOB K 
 WHERE J.EMPLID = K.EMPLID 
   AND J.EMPL_RCD = K.EMPL_RCD) 
   AND J.EFFSEQ = ( 
 SELECT MAX(L.EFFSEQ) 
  FROM PS_JOB L 
 WHERE J.EMPLID = L.EMPLID 
   AND J.EMPL_RCD = L.EMPL_RCD
   AND J.EFFDT = L.EFFDT)
   AND (J.HR_STATUS = 'A' OR J.TERMINATION_DT > = to_date('20130115', 'YYYYMMDD'))
  AND b.dependent_id = ' ' AND b.passport_nbr <> '0'
  and b.emplID = #{record["EMPLID"]}"
      # puts ora_records.class
      emplid = String.new
      field = String.new
      dat_v = String.new
      db_v = String.new
      mark_of_output = 0
      
      ora_records.each do |ora_record|
        num_of_match_field = 0
        ora_record.each do |k,v|
        # puts "#{k}:#{record[k]}"
          
          if record[k].to_s == v.to_s
            num_of_match_field += 1
          end
          if record[k].to_s != v.to_s
            # puts "emplid = #{record["EMPLID"]}: #{k} = #{record[k]}; but DB is #{v}"
            emplid = record['EMPLID']
            field = k
            dat_v = record[k]
            db_v = v
          end
          puts "num of match field: #{num_of_match_field}"
          puts "length: #{ora_record.length}"
          if num_of_match_field == ora_record.length
            mark_of_output += 1
          end
          # puts mark_of_output
        end
        puts mark_of_output

      end
      if mark_of_output == 0
        # puts "emplid = #{emplid}: #{field} = #{dat_v}; but DB is #{db_v}"
        puts "differences:"
        puts "db: #{ora_records}"
        puts "dat: #{record}"
        puts "================================================================="
      end
    end
  end
end

new_compare = Compare_dat_ora.new "WKD_GHR_CITIZEN_PSSPRT_FULL.DAT"
new_compare.result
