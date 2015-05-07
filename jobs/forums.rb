require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every '600s', :first_in => '1d' do

	forumsFlag = "green"

	t1 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["forums_host_1"])
		req_services = CONFIG["forums_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	t1.join

	forumsFlag = RuleBinding.set_flag(@service_flag_1)

	p "Forums----------: #{forumsFlag}"

   send_event('forums_status' , { flag: forumsFlag } )

end
