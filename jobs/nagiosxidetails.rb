require_relative '../lib/tbb_splunk_status_checker'
require_relative '../lib/tbb_nagios_status_checker'
require_relative '../lib/rule_binding'
 
SCHEDULER.every '60s', :first_in => 0 do	
	
	teamBeachBodyURLFlag = "green"

	# Get http, ping, DNS status and URL content for www.teambeachbody.com

	t1 = Thread.new do 
		services = TBBNagiosStatusChecker.get_services
		req_services = ["HTTP", "Ping", "DNS Resolution", "_coach URL Content",
										"_workout-routines_p90x-workout-iphone-app-faq URL Content",
										"DNS IP Match", "Web Page Content"]
		@service_flag = TBBNagiosStatusChecker.check_status(services, req_services)

		p "teambeachbody.com===#{@service_flag}"
	end

	t2 = Thread.new do
		@mem_serv_flag = TBBNagiosStatusChecker.get_memory_status
	 
		p "teambeachbody cluster====#{@mem_serv_flag}"
	end

	# teambeachbody splunk data
	t3 = Thread.new do
		response1 = TBBStatusChecker.request "/servicesNS/admin/search/search/jobs/export", "search 'unknownhostedexception' index=tbb 			sourcetype=tbb_http | head 1"
		@host_flag = ParseResponse.parse(response1)
	end
	t4 = Thread.new do
		response2 = TBBStatusChecker.request "/servicesNS/admin/search/search/jobs/export", "search 'Connection could not be acquired' 			index=tbb sourcetype=tbb_server | head 1"
		@conn_flag = ParseResponse.parse(response2)
	end


	[t1, t2, t3, t4].map(&:join)
	p "teambeachbody splunk====#{@host_flag}====#{@conn_flag}" 

	teamBeachBodyURLFlag = RuleBinding.set_flag(@host_flag, @conn_flag, @service_flag, @mem_serv_flag)

	p "teamBeachBodyURLFlag : #{teamBeachBodyURLFlag}"

  send_event('teambeachbody_status' , { flag: teamBeachBodyURLFlag } )
        
end
