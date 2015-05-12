SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	digitalFlag = "green"
	threads = []
	flags = []

	# Digital OHS (Digital OHS)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_ohs_host_1"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_ohs_host_2"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_ohs_host_3"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_ohs_host_4"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end





 	# Digital App (Digital App)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_1"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_2"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_3"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_4"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_5"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_6"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end





	# Digital WordPress (Digital WordPress)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_1"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_2"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_3"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_4"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_5"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_6"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_7"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_8"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end




	#Digital MySQL (Digital MySQL)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_1"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_2"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_3"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_4"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_5"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_6"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end






	# Digital Content (Digital Content)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_1"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_2"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_3"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_4"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_5"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end




	# Digital MongoDB (Digital MongoDB)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mongodb_host_1"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mongodb_host_2"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mongodb_host_3"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mongodb_host_4"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end


	# Digital Admin (Digital Admin)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_admin_host_1"])
		req_services = CONFIG["digital_services"]
		flags << NagiosStatusChecker.check_status(services, req_services)
	end

	#Splunk Apis
	threads << Thread.new do
    search_param = "search index=tbb sourcetype=tbb_server does not match any name from EnrollmentUtil.ClubTrialTypeEnum | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search index=tbb sourcetype=tbb_server Could not get the productSkuPriceMetaSignupTypeList with id | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end

	threads << Thread.new do
    search_param = "search index=tbb sourcetype=tbb_server Could not get the skuMeta with id | head 1"
		response1 = TBBStatusChecker.request search_param
		flags << ParseResponse.parse(response1)
	end


	threads.map(&:join)

	digitalFlag = RuleBinding.set_flag(*flags)

	p "Digital----------: #{digitalFlag}"

   send_event('digital_status' , { flag: digitalFlag } )

end
