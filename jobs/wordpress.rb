require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	wordPressFlag = "green"
	threads = []

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["wordpress_host_1"])
		req_services = CONFIG["wordpress_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["wordpress_host_2"])
		req_services = CONFIG["wordpress_services_1"]
		@service_flag_2 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["wordpress_host_3"])
		req_services = CONFIG["wordpress_services_2"]
		@service_flag_3 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["wordpress_host_4"])
		req_services = CONFIG["wordpress_services_2"]
		@service_flag_4 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads.map(&:join)

	wordPressFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2, @service_flag_3, @service_flag_4)

	p "WordPress----------: #{wordPressFlag}"

   send_event('wordpress_status' , { flag: wordPressFlag } )

end
