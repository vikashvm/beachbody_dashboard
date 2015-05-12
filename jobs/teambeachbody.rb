SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	teamBeachBodyURLFlag = "green"
	threads = []
	flags = []

	# Get http, ping, DNS status and URL content for www.teambeachbody.com

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["tbb_host_1"])
		req_services = CONFIG["tbb_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["tbb_host_2"])
		req_services = CONFIG["tbb_services_2"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		flags << NagiosStatusChecker.get_memory_status(CONFIG["tbb_host_list"])
	end

	# teambeachbody splunk data
	threads << Thread.new do
		response1 = TBBStatusChecker.request "search 'unknownhostedexception' index=tbb 			sourcetype=tbb_http | head 1"
		flags << ParseResponse.parse(response1)
	end
	threads << Thread.new do
		response2 = TBBStatusChecker.request "search 'Connection could not be acquired' 			index=tbb sourcetype=tbb_server | head 1"
		flags << ParseResponse.parse(response2)
	end


	threads.map(&:join)

	teamBeachBodyURLFlag = RuleBinding.set_flag(*flags)

	p "teamBeachBodyURLFlag----------: #{teamBeachBodyURLFlag}"

  send_event('teambeachbody_status' , { flag: teamBeachBodyURLFlag } )

end
