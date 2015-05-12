SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	bydesignFlag = "green"
	threads = []
	flags = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["by_design_host_1"])
		req_services = CONFIG["by_design_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["by_design_host_2"])
		req_services = CONFIG["by_design_services_2"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	#Splunk Apis - Internal Processing
	threads << Thread.new do
    search_param = "search index=tbb sourcetype=tbb_http soap:Fault | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search index=tbb sourcetype=tbb_http 'SqlClient' | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search Error in getUserIdByEmailAddress : | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search Exception during RESTful coachLookup: | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search Exception during getting custType | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search TBB ByDesign user creation failed for user.  NetOps contact ByDesign immediately. | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search host='pinf-ftp1' Beachbody_OptinList_*.txt | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	#Splunk Apis - File Processing

	threads << Thread.new do
    search_param = "search index=soa as_cc*.asc | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search index=soa IS*.csv* | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads.map(&:join)

	bydesignFlag = RuleBinding.set_flag(*flags)

	p "bydesignFlag----------: #{bydesignFlag}"

   send_event('bydesignFlag_status' , { flag: bydesignFlag } )

end
