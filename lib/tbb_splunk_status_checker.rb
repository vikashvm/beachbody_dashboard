require 'faraday'
require 'json'
require 'time'
require_relative 'constants'

module ParseResponse
  def self.parse(response, interval = CONFIG['interval'])
    #interval is in format of '60s' or '10m' or '2d'
    unit = interval[-1]
    time = interval[0...-1].to_i
    time *= 60 if unit == 'm'
    time *= 3600 if unit == 'h'
    time *= 86400 if unit == 'd'
    res_body = JSON.parse(response.body)
    return "green" unless result = res_body["result"]
    date_checker(result, time)
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

  def self.request(search)
    url = SETTINGS['splunk_api_url']
    connnection.post url, {search: search, output_mode: 'json'}
  end
end
