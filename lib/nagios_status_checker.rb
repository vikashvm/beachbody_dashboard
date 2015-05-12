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
        return "red" unless serv.at_xpath("current_state").try(:text) and serv.at_xpath("current_state").text.to_i.zero?
      end
    end
    return "green"
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