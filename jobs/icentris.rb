SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	icentrisFlag = "green"
	threads = []
	flags = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["icentric_host_1"])
		req_services = CONFIG["icentric_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	#Splunk Apis

	threads << Thread.new do
    search_param = "search File incoming/daily/stop_daily_*.dat 'has been put on remote server 172.18.17.28' | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search index=soa scqualification*.dat | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads.map(&:join)

	icentrisFlag = RuleBinding.set_flag(*flags)

	p "icentrisFlag----------: #{icentrisFlag}"

   send_event('icentrisFlag_status' , { flag: icentrisFlag } )

end
