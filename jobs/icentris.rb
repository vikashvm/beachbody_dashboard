require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	icentrisFlag = "green"

	t1 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["icentric_host_1"])
		req_services = CONFIG["icentric_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	t1.join

	icentrisFlag = RuleBinding.set_flag(@service_flag_1)

	p "icentrisFlag----------: #{icentrisFlag}"

   send_event('icentrisFlag_status' , { flag: icentrisFlag } )

end
