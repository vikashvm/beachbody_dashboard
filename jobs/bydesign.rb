require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	bydesignFlag = "green"
	threads = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["by_design_host_1"])
		req_services = CONFIG["by_design_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["by_design_host_2"])
		req_services = CONFIG["by_design_services_2"]
		@service_flag_2 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads.map(&:join)

	bydesignFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2)

	p "bydesignFlag----------: #{bydesignFlag}"

   send_event('bydesignFlag_status' , { flag: bydesignFlag } )

end
