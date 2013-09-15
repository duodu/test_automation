require 'dbi'
require 'oci8'

dbh = DBI.connect('DBI:OCI8:PHRTST','ASIAPACIFIC_ZHANWEND','z04123028A!!')
sql = "select * from ps_job p where p.emplid='00000015' and rownum = 1"
res = dbh.do sql

dbh.disconnect
puts res