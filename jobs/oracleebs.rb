SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	oracleebsFlag = "green"
	threads = []
	flags = []

	CONFIG['oracle_ebs_hosts'].each do |host|
		threads << Thread.new do
			services = NagiosStatusChecker.get_services(host)
			req_services = CONFIG["oracle_ebs_services_1"]
			flags << NagiosStatusChecker.check_status(services, req_services)
		end
	end

  # OracleEBS splunk data
	threads << Thread.new do
    search_param = "search index=dba (host=ebsapp01* OR host=ebsapp02* OR  host=ebsapp03*)  source='/appsw/EBSPRD/*/FMW_Home/user_projects/domains/EBS_domain_EBSPRD/servers/oacore_*/logs/*.log' 'OutOfMemoryError' | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads.map(&:join)

	oracleebsFlag = RuleBinding.set_flag(*flags)

	p "oracleebsFlag----------: #{oracleebsFlag}"

   send_event('oracleebsFlag_status' , { flag: oracleebsFlag } )

end
