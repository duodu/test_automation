require 'oci8'

class Ora_driver
  def initialize username = "ASIAPACIFIC_ZHANWEND", pwd ="z04123028A!!", host = "16.197.48.177:1526/PHRTST"
    @username = username
    @pwd = pwd
    @host = host
  end
  def ora_records select_sql
    dbh = OCI8.new(@username,@pwd,@host)
    cursor = dbh.exec select_sql
    records = Array.new
    while record = cursor.fetch_hash
      records << record
    end
    dbh.logoff
    return records
  end
end
# 
# ora_record = Ora_driver.new
# res = ora_record.ora_records "select a.emplID,
       # a.address_type,
       # to_char(a.effdt, 'YYYYMMDD') effdt,
       # a.address1,
       # a.address2,
       # a.address3,
       # a.address4,
       # a.city,
       # a.country,
       # a.postal,
       # a.state
  # from ps_addresses a
  # join ps_job j
    # on a.emplID = j.emplID
 # where J.PER_ORG <> 'CWR'
   # AND J.EMPL_RCD = 0
   # AND J.EFFDT = (SELECT MAX(K.EFFDT)
                    # FROM PS_JOB K
                   # WHERE J.EMPLID = K.EMPLID
                     # AND J.EMPL_RCD = K.EMPL_RCD)
   # AND J.EFFSEQ = (SELECT MAX(L.EFFSEQ)
                     # FROM PS_JOB L
                    # WHERE J.EMPLID = L.EMPLID
                      # AND J.EMPL_RCD = L.EMPL_RCD
                      # AND J.EFFDT = L.EFFDT)
   # AND (J.HR_STATUS = 'A' OR
       # J.TERMINATION_DT > = to_date('20130115', 'YYYYMMDD'))
   # and a.effdt = (select max(b.effdt)
                    # from ps_addresses b
                   # where a.emplID = b.emplID
                     # and a.address_type = b.address_type)
   # and a.address_type in ('HOME', 'MAIL')
   # and a.emplid in ('00000015', '00000117') "
# puts res
# dbh = OCI8.new("ASIAPACIFIC_ZHANWEND","z04123028A!!","16.197.48.177:1526/PHRTST")
# 
# 
# # dbh = DBI.connect('DBI:OCI8:PHRTST','ASIAPACIFIC_ZHANWEND','z04123028A!!')
# sql = "select * from ps_job p where p.emplid='00000015' and rownum = 1"
# cursor = dbh.exec(sql)
# res = cursor.fetch_hash
# # res = dbh.do sql
# 
# dbh.logoff
# puts res
