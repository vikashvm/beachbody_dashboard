require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'
 
SCHEDULER.every '600s', :first_in => '1d' do	
	
	oracleebsFlag = "green"

	t1 = Thread.new do 
		services = NagiosStatusChecker.get_services(CONFIG["oracle_esb_host_1"])
		req_services = CONFIG["oracle_esb_services_1"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	t2 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["oracle_esb_host_2"])
		req_services = CONFIG["oracle_esb_services_1"]
		@service_flag_2 = NagiosStatusChecker.check_status(services, req_services)
	end

	t3 = Thread.new do 
		services = NagiosStatusChecker.get_services(CONFIG["oracle_esb_host_3"])
		req_services = CONFIG["oracle_esb_services_1"]
		@service_flag_3 = NagiosStatusChecker.check_status(services, req_services)
	end

	t4 = Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["oracle_esb_host_4"])
		req_services = CONFIG["oracle_esb_services_1"]
		@service_flag_4 = NagiosStatusChecker.check_status(services, req_services)
	end

	[t1, t2, t3, t4].map(&:join)
	
	oracleebsFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2, @service_flag_3, @service_flag_4)

	p "oracleebsFlag----------: #{oracleebsFlag}"

   send_event('oracleebsFlag_status' , { flag: oracleebsFlag } )
        
end
