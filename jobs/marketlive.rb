require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'
 
SCHEDULER.every '600s', :first_in => '1d' do	
	
	marketliveFlag = "green"

	t1 = Thread.new do 
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_1"])
		req_services = CONFIG["marketlive_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	t2 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_2"])
		req_services = CONFIG["marketlive_services_2"]
		@service_flag_2 = NagiosStatusChecker.check_status(services, req_services)
	end

	t3 = Thread.new do 
		services = NagiosStatusChecker.get_services(CONFIG["marketlive_host_3"])
		req_services = CONFIG["marketlive_services_3"]
		@service_flag_3 = NagiosStatusChecker.check_status(services, req_services)
	end

	[t1, t2, t3].map(&:join)
	
	marketliveFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2, @service_flag_3)

	p "marketliveFlag----------: #{marketliveFlag}"

   send_event('marketliveFlag_status' , { flag: marketliveFlag } )
        
end
