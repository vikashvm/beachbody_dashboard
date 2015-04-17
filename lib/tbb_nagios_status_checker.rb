require 'open-uri'
require 'nokogiri'


module TBBNagiosStatusChecker
  URL = 'http://172.28.5.43/nagiosxi/backend/?cmd=getservicestatus&username=ayadav&ticket=piffeg4hvgefhr4impgr8sc6vjkd3iop476fma0jne3894pss7o23462kndk95ca'
  Machines = 5
  def self.get_services
    url = URL + '&host_name=www.teambeachbody.com'
    content = Nokogiri::XML(open(url, :read_timeout => 20))
    services = content.xpath("servicestatuslist/servicestatus")
    services
  end

  def self.check_status(input_services, required_services)
    input_services.each do |serv|
      if required_services.include? serv
        return "red" unless serv.at_xpath("current_state").try(:text) and serv.at_xpath("current_state").text.zero?
      end
    end
    return "green"
  end

  def self.get_memory_services(num)
    url = URL + '&host_name=tbbpapp' + j.to_s + '.productpartners.com'
    content = Nokogiri::XML(open(url, :read_timeout => 20))
    services = content.xpath("servicestatuslist/servicestatus")
    services
  end

  def self.get_memory_status
    tbbClusterCPU, tbbClusterMemory, tbbClusterSWAP, tbbClusterDisk = 0, 0, 0, 0
    Machines.times do |num|
      memory_services = get_memory_services(num+1)
      memory_services.each do |mem_serv|
        service_mame = mem_serv.at_xpath("name").text
        current_state = mem_serv.at_xpath("current_state").text
        unless current_state.zero?
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
    [tbbClusterCPU, tbbClusterMemory, tbbClusterSWAP, tbbClusterDisk].map {|x| x*100/Machines}

    if cpuPercentage >= 70 or memoryPercentage >= 70 or swapPercentage >= 80 or diskPercentage >= 90
      return "red"
    elsif cpuPercentage >= 60 or memoryPercentage >= 60 or swapPercentage >= 70 or diskPercentage >= 80
      return "yellow"
    else
      return "green"
    end
        
  end
end