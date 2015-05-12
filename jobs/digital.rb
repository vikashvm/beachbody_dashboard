require_relative '../lib/nagios_status_checker'
require_relative '../lib/rule_binding'

SCHEDULER.every CONFIG['interval'], :first_in => CONFIG['start_time'] do

	digitalFlag = "green"
	threads = []

	# Digital OHS (Digital OHS)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_ohs_host_1"])
		req_services = CONFIG["digital_services"]
		@service_flag_1 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_ohs_host_2"])
		req_services = CONFIG["digital_services"]
		@service_flag_2 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_ohs_host_3"])
		req_services = CONFIG["digital_services"]
		@service_flag_3 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_ohs_host_4"])
		req_services = CONFIG["digital_services"]
		@service_flag_4 = NagiosStatusChecker.check_status(services, req_services)
	end





 	# Digital App (Digital App)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_1"])
		req_services = CONFIG["digital_services"]
		@service_flag_5 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_2"])
		req_services = CONFIG["digital_services"]
		@service_flag_6 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_3"])
		req_services = CONFIG["digital_services"]
		@service_flag_7 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_4"])
		req_services = CONFIG["digital_services"]
		@service_flag_8 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_5"])
		req_services = CONFIG["digital_services"]
		@service_flag_9 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_app_host_6"])
		req_services = CONFIG["digital_services"]
		@service_flag_10 = NagiosStatusChecker.check_status(services, req_services)
	end





	# Digital WordPress (Digital WordPress)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_1"])
		req_services = CONFIG["digital_services"]
		@service_flag_11 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_2"])
		req_services = CONFIG["digital_services"]
		@service_flag_12 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_3"])
		req_services = CONFIG["digital_services"]
		@service_flag_13 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_4"])
		req_services = CONFIG["digital_services"]
		@service_flag_14 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_5"])
		req_services = CONFIG["digital_services"]
		@service_flag_15 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_6"])
		req_services = CONFIG["digital_services"]
		@service_flag_16 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_7"])
		req_services = CONFIG["digital_services"]
		@service_flag_17 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_wp_host_8"])
		req_services = CONFIG["digital_services"]
		@service_flag_18 = NagiosStatusChecker.check_status(services, req_services)
	end




	#Digital MySQL (Digital MySQL)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_1"])
		req_services = CONFIG["digital_services"]
		@service_flag_19 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_2"])
		req_services = CONFIG["digital_services"]
		@service_flag_20 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_3"])
		req_services = CONFIG["digital_services"]
		@service_flag_21 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_4"])
		req_services = CONFIG["digital_services"]
		@service_flag_22 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_5"])
		req_services = CONFIG["digital_services"]
		@service_flag_23 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mysql_host_6"])
		req_services = CONFIG["digital_services"]
		@service_flag_24 = NagiosStatusChecker.check_status(services, req_services)
	end






	# Digital Content (Digital Content)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_1"])
		req_services = CONFIG["digital_services"]
		@service_flag_25 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_2"])
		req_services = CONFIG["digital_services"]
		@service_flag_26 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_3"])
		req_services = CONFIG["digital_services"]
		@service_flag_27 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_4"])
		req_services = CONFIG["digital_services"]
		@service_flag_28 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_content_host_5"])
		req_services = CONFIG["digital_services"]
		@service_flag_29 = NagiosStatusChecker.check_status(services, req_services)
	end




	# Digital MongoDB (Digital MongoDB)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mongodb_host_1"])
		req_services = CONFIG["digital_services"]
		@service_flag_30 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mongodb_host_2"])
		req_services = CONFIG["digital_services"]
		@service_flag_31 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mongodb_host_3"])
		req_services = CONFIG["digital_services"]
		@service_flag_32 = NagiosStatusChecker.check_status(services, req_services)
	end

	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_mongodb_host_4"])
		req_services = CONFIG["digital_services"]
		@service_flag_33 = NagiosStatusChecker.check_status(services, req_services)
	end


	# Digital Admin (Digital Admin)
	threads << Thread.new do
		services = NagiosStatusChecker.get_services(CONFIG["digital_admin_host_1"])
		req_services = CONFIG["digital_services"]
		@service_flag_34 = NagiosStatusChecker.check_status(services, req_services)
	end


	threads.map(&:join)

	digitalFlag = RuleBinding.set_flag(@service_flag_1, @service_flag_2, @service_flag_3, @service_flag_4, @service_flag_5, @service_flag_6, @service_flag_7, @service_flag_8, @service_flag_9, @service_flag_10, @service_flag_11, @service_flag_12, @service_flag_13, @service_flag_14, @service_flag_15, @service_flag_16, @service_flag_17, @service_flag_18, @service_flag_19, @service_flag_20, @service_flag_21, @service_flag_22, @service_flag_23, @service_flag_24, @service_flag_25, @service_flag_26, @service_flag_27, @service_flag_28, @service_flag_29, @service_flag_30, @service_flag_31, @service_flag_32, @service_flag_33, @service_flag_34)

	p "Digital----------: #{digitalFlag}"

   send_event('digital_status' , { flag: digitalFlag } )

end
