require 'faraday'
require 'json'

URL = 'https://172.20.241.64:8089'
#URL = 'https://pinf-spl001.beachbody.local:8089'
url = "/servicesNS/admin/search/search/jobs/export"

#search = "search index=tbb sourcetype=tbb_server 'TBBRestResourceException' | head 1"
###search = "search index=soa as_cc*_resp.xml 'has been put on remote server :ftp1.productpartners.com' | head 1"
#search = "search index=dba (host=ebsapp01* OR host=ebsapp02* OR  host=ebsapp03*)  source='/appsw/EBSPRD/*/FMW_Home/user_projects/domains/EBS_domain_EBSPRD/servers/oacore_*/logs/*.log' 'OutOfMemoryError' | head 1"
#icentris
#search = "search File incoming/daily/stop_daily_*.dat 'has been put on remote server 172.18.17.28' | head 1"

###search = "search index=soa Success_Club_Levels_*.txt 'has been put on remote server :ftp1.productpartners.com' | head 1"
#search = "search index=soa Success_Club_Levels_20150504.txt  has been put on remote server :ftp1.productpartners.com | head 1"
###search = "search index=soa Success_Club_Levels" -d earliest_time="rt-120m" -d latest_time="rt" -d output_mode="json"

###search = "search index=soa 'scqualification*.dat' 'has been put on remote server 172.18.17.28' | head 1"
#search = "search index=soa been put on remote server 172.18.17.28 | head 1"
#search = "search index=soa scqualification*.dat | head 1"

#paymentech
###search = "search index=soa as_cc*_resp.xml 'has been put on remote server :ftp1.productpartners.com' | head 1"
#search = "search index=soa .xml has been put on remote server :ftp1.productpartners.com | head 1"
#search = "search index=soa as_cc*_resp.xml | head 1"

#ByDesign - File process
###search = "search index=tbb sourcetype=tbb_http 'soap:Fault' | head 1"
#search = "search index=tbb sourcetype=tbb_http soap:Fault | head 1"

#search = "search index=tbb sourcetype=tbb_http 'SqlClient' | head 1"
#search = "search index=tbb sourcetype=tbb_http SqlClient | head 1"

###search = "search index=tbb sourcetype=tbb_http <response> exception"

###search = "search index=tbb sourcetype=tbb_server 'BYDESIGN WS Failure' NOT 'Unable to process message {destination=bydesign/verify_rep' | head 1"
###search = "search index=tbb sourcetype=tbb_server BYDESIGN WS Failure | head 1"

#search  = "search Error in getUserIdByEmailAddress : | head 1"
#search  = "search Exception during RESTful coachLookup: | head 1"
#search = "search Exception during getting custType | head 1"
#search = "search TBB ByDesign user creation failed for user.  NetOps contact ByDesign immediately. | head 1"
#search = "search host='pinf-ftp1' Beachbody_OptinList_*.txt | head 1"

###search = "search index=soa as_cc*.asc 'has been put on remote server :orbitalbatch2.paymentech.net' | head 1"
#search = "search index=soa as_cc*.asc | head 1"

###search = "search index=soa IS*.csv* 'has been put on remote server :ftp.innotrac.com' | head 1"
#search = "search index=soa IS*.csv* | head 1"

#search = "search index=soa bonusrun_*.weekly 'has been put on remote server 172.18.17.28' | head 1"
#search = "search index=soa bonusrun_*.weekly | head 1"

conn = Faraday.new url: URL, ssl: {verify: false}
conn.basic_auth 'admin', 'bbody@3301'
response = conn.post url, {search: search, output_mode: 'json'}
res_body = JSON.parse(response.body)
puts res_body
