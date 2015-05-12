require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	marketliveFlag = "green"
	threads = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_1"])
		req_services = CONFIG["marketlive_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_2"])
		req_services = CONFIG["marketlive_services_2"]
		@service_flag_2 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_3"])
		req_services = CONFIG["marketlive_services_3"]
		@service_flag_3 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads.map(&:join)

	marketliveFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2, @service_flag_3)

	p "marketliveFlag----------: #{marketliveFlag}"

   send_event('marketliveFlag_status' , { flag: marketliveFlag } )

end
