SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	shakeologyFlag = "green"
	threads = []
	flags = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["shakelogy_host_1"])
		req_services = CONFIG["shakelogy_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["shakelogy_host_2"])
		req_services = CONFIG["shakelogy_services_1"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

  # shakeology splunk data
	threads << Thread.new do
		response1 = TBBStatusChecker.request "search index=tbb sourcetype=tbb_server 'TBBRestResourceException' | head 1"
		flags << ParseResponse.parse(response1)
	end

	threads.map(&:join)

	shakeologyFlag = RuleBinding.set_flag(*flags)

	p "Shakeology----------: #{shakeologyFlag}"

   send_event('shakeology_status' , { flag: shakeologyFlag } )

end
