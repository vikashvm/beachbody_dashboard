require 'faraday'
require 'json'
require 'time'

module ParseResponse
  def self.parse(response, interval = 60)
    res_body = JSON.parse(response.body)
    return "green" unless result = res_body["result"]
    date_checker(result, interval)
  end

  def self.date_checker(result, interval)
    target_time = Time.now.utc - interval
    datetime = result["_time"]
    date, time, zone = datetime.split(" ")
    year, month, day = date.split("-").map(&:to_i)
    hour, min, sec = time.split(":").map(&:to_i)
    time =  Time.new(year, month, day, hour, min, sec, Time.zone_offset(zone)).utc
    time < target_time ? "green" : "red"
  end
end

module TBBStatusChecker
  URL = SETTINGS['url']

  def self.connnection
    conn = Faraday.new url: URL, ssl: {verify: false}
    conn.basic_auth SETTINGS['username'], SETTINGS['password']
    conn
  end

  def self.request(url, search)
    connnection.post url, {search: search, output_mode: 'json'}
  end
end
