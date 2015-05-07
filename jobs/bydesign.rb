require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'
require_relative '../lib/constants.rb'

SCHEDULER.every '600s', :first_in => 0 do

	bydesignFlag = "green"

	t1 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["by_design_host_1"])
		req_services = CONFIG["by_design_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	t2 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["by_design_host_2"])
		req_services = CONFIG["by_design_services_2"]
		@service_flag_2 = NagiosStatusChecker.check_status(services, req_services)
	end

	[t1, t2].map(&:join)

	bydesignFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2)

	p "bydesignFlag----------: #{bydesignFlag}"

   send_event('bydesignFlag_status' , { flag: bydesignFlag } )

end
