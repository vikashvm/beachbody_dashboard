require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'
require_relative '../lib/constants.rb'

SCHEDULER.every '600s', :first_in => '0s' do

	chasepaymentechFlag = "green"

	# Chase Paymentech splunk data
	t1 = Thread.new do
    search_param = "search index=soa as_cc*_resp.xml | head 1"
		response1 = TBBStatusChecker.request search_param
		@service_flag_1 = ParseResponse.parse(response1)
	end

	t1.join

	chasepaymentechFlag = RuleBinding.set_flag(@service_flag_1)

	p "chasepaymentechFlag----------: #{chasepaymentechFlag}"

   send_event('chasepaymentechFlag_status' , { flag: chasepaymentechFlag } )

end
