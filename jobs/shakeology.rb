require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every '600s', :first_in => "0s" do

	shakeologyFlag = "green"

	t1 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["shakelogy_host_1"])
		req_services = CONFIG["shakelogy_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	t2 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["shakelogy_host_2"])
		req_services = CONFIG["shakelogy_services_1"]
		@service_flag_2 = NagiosStatusChecker.check_status(services, req_services)
	end

  # shakeology splunk data
	t3 = Thread.new do
		response1 = TBBStatusChecker.request "search index=tbb sourcetype=tbb_server 'TBBRestResourceException' | head 1"
		@service_flag_3 = ParseResponse.parse(response1)
	end

	[t1, t2, t3].map(&:join)

	shakeologyFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2, @service_flag_3)

	p "Shakeology----------: #{shakeologyFlag}"

   send_event('shakeology_status' , { flag: shakeologyFlag } )

end
