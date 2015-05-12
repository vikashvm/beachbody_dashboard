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
	CONFIG['bydesign_splunk'].each do |query|
		threads << Thread.new do
			response1 = TBBStatusChecker.request query
			flags << ParseResponse.parse(response1)
		end
	end

	threads.map(&:join)

	bydesignFlag = RuleBinding.set_flag(*flags)

	p "bydesignFlag----------: #{bydesignFlag}"

   send_event('bydesignFlag_status' , { flag: bydesignFlag } )

end
