require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	chasepaymentechFlag = "green"
	threads = []

	# Chase Paymentech splunk data
	threads << Thread.new do
    search_param = "search index=soa as_cc*_resp.xml | head 1"
		response1 = TBBStatusChecker.request search_param
		@service_flag_1 = ParseResponse.parse(response1)
	end

	threads.map(&:join)

	chasepaymentechFlag = RuleBinding.set_flag(@service_flag_1)

	p "chasepaymentechFlag----------: #{chasepaymentechFlag}"

   send_event('chasepaymentechFlag_status' , { flag: chasepaymentechFlag } )

end
