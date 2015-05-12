SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	oracleebsFlag = "green"
	threads = []
	flags = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["oracle_esb_host_1"])
		req_services = CONFIG["oracle_esb_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["oracle_esb_host_2"])
		req_services = CONFIG["oracle_esb_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["oracle_esb_host_3"])
		req_services = CONFIG["oracle_esb_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["oracle_esb_host_4"])
		req_services = CONFIG["oracle_esb_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
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
