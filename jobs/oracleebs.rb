require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every '600s', :first_in => '0s' do

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

  # OracleEBS splunk data
	t5 = Thread.new do
    search_param = "search index=dba (host=ebsapp01* OR host=ebsapp02* OR  host=ebsapp03*)  source='/appsw/EBSPRD/*/FMW_Home/user_projects/domains/EBS_domain_EBSPRD/servers/oacore_*/logs/*.log' 'OutOfMemoryError' | head 1"
		response1 = TBBStatusChecker.request search_param
		@service_flag_5 = ParseResponse.parse(response1)
	end

	[t1, t2, t3, t4, t5].map(&:join)

	oracleebsFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2, @service_flag_3, @service_flag_4, @service_flag_4)

	p "oracleebsFlag----------: #{oracleebsFlag}"

   send_event('oracleebsFlag_status' , { flag: oracleebsFlag } )

end
