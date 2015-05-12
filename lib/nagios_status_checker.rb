require 'open-uri'
require 'nokogiri'
require_relative './constants.rb'

module NagiosStatusChecker
  
  def self.get_services(host_name)
    base_url = "http://" + SETTINGS["nagios_host"] + "/nagiosxi/backend/?cmd=getservicestatus&username=" + SETTINGS["nagios_username"] + "&ticket=" + SETTINGS["nagios_password"]
    url = base_url + '&host_name=' + host_name    
    content = Nokogiri::XML(open(url, :read_timeout => 20))
    services = content.xpath("servicestatuslist/servicestatus")
    services
  end

  def self.check_status(input_services, required_services)
    input_services.each do |serv|
      service_name =  serv.at_xpath("name").text
      if required_services.include? service_name

        performance_data = serv.at_xpath("performance_data").text
        usage_status = ""

        if (service_name  == '/mysql Disk Usage')
          usage_status =  get_usage_status(service_name, performance_data, 90, 80)          
        end 

        if (service_name  == '/ Disk Usage')
          usage_status =  get_usage_status(service_name, performance_data, 95, 90)          
        end 

        if (service_name  == 'Memory Usage')
          usage_status =  get_usage_status(service_name, performance_data, 95, 90)   
        end 

        if (service_name  == 'Swap Usage')
          usage_status =  get_usage_status(service_name, performance_data, 80, 90)          
        end 

        if (service_name  == 'CPU Usage')
          usage_status =  get_usage_status(service_name, performance_data, 95, 90)          
        end 

        if (usage_status == "red" || usage_status == "yellow")
          return usage_status
        end

        return "red" unless serv.at_xpath("current_state").try(:text) and serv.at_xpath("current_state").text.to_i.zero?

      end
    end
    return "green"
  end


  def self.get_usage_status(service_name, performance_data, critical_limit, warning_limit)

    percent_used = 0

    if (service_name  == 'CPU Usage')
      percent_used = performance_data.split("=")[1].split(';')[0][0...-1].to_i
    else
      consumed_memory = performance_data.split("=")[1].split(';')[0][0...-2].to_f
      total_memory = performance_data.split("=")[1].split(';')[-1].to_f
      percent_used = ((consumed_memory/total_memory)*100).to_i             
    end

      if (percent_used >= critical_limit)
        return "red"
      elsif (percent_used >= warning_limit)
        return "yellow"
      else
        return "green"
      end

  end  


  def self.get_memory_status(host_list)
   tbbClusterCPU, tbbClusterMemory, tbbClusterSWAP, tbbClusterDisk = 0, 0, 0, 0
   host_list.each do |server|
      memory_services = get_services(server)
      memory_services.each do |mem_serv|
        service_mame = mem_serv.at_xpath("name").text
        current_state = mem_serv.at_xpath("current_state").text
        unless current_state.to_i.zero?
          case service_mame
            when "CPU Stats" then tbbClusterCPU += 1 
            when "Memory Usage" then tbbClusterMemory += 1 
            when "Swap Usage" then tbbClusterSWAP += 1 
            when "/ Disk Usage" then tbbClusterDisk += 1
          end
        end
      end
    end
    cpuPercentage, memoryPercentage, swapPercentage, diskPercentage = 
    [tbbClusterCPU, tbbClusterMemory, tbbClusterSWAP, tbbClusterDisk].map {|x| x*100/host_list.length}

    if cpuPercentage >= 70 or memoryPercentage >= 70 or swapPercentage >= 80 or diskPercentage >= 90
      return "red"
    elsif cpuPercentage >= 60 or memoryPercentage >= 60 or swapPercentage >= 70 or diskPercentage >= 80
      return "yellow"
    else
      return "green"
    end        
  end
  
end