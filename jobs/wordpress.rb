SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	wordPressFlag = "green"
	threads = []
	flags = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["wordpress_host_1"])
		req_services = CONFIG["wordpress_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["wordpress_host_2"])
		req_services = CONFIG["wordpress_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["wordpress_host_3"])
		req_services = CONFIG["wordpress_services_2"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["wordpress_host_4"])
		req_services = CONFIG["wordpress_services_2"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads.map(&:join)

	wordPressFlag = RuleBinding.set_flag(*flags)

	p "WordPress----------: #{wordPressFlag}"

   send_event('wordpress_status' , { flag: wordPressFlag } )

end
