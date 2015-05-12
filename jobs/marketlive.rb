SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	marketliveFlag = "green"
	threads = []
	flags = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_1"])
		req_services = CONFIG["marketlive_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_2"])
		req_services = CONFIG["marketlive_services_2"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_3"])
		req_services = CONFIG["marketlive_services_3"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads.map(&:join)

	marketliveFlag = RuleBinding.set_flag(*flags)

	p "marketliveFlag----------: #{marketliveFlag}"

   send_event('marketliveFlag_status' , { flag: marketliveFlag } )

end
