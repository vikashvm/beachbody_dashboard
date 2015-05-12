SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	digitalFlag = "green"
	threads = []
	flags = []

  #Digital Nagios Api
	CONFIG['digital_hosts'].each do |host|
		threads << Thread.new do
			services = NagiosStatusChecker.get_services(host)
			req_services = CONFIG["digital_services"]
			flags << NagiosStatusChecker.check_status(services, req_services)
		end
	end


	#Splunk Apis
	CONFIG['digital_splunk'].each do |query|
		threads << Thread.new do
			response1 = TBBStatusChecker.request query
			flags << ParseResponse.parse(response1)
		end
	end


	threads.map(&:join)

	digitalFlag = RuleBinding.set_flag(*flags)

	p "Digital----------: #{digitalFlag}"

   send_event('digital_status' , { flag: digitalFlag } )

end
