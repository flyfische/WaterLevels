#!/usr/bin/ruby
require 'net/http'
require 'json'
def print_data(sitenum)
	uri = URI.parse("http://waterservices.usgs.gov/nwis/iv/?format=json&sites=" + sitenum)
	http = Net::HTTP.new(uri.host,uri.port)
	request = Net::HTTP::Get.new(uri.request_uri)
	response = http.request(request)
	waterdata = JSON.parse(response.body)
	printf("Data for %s\n",waterdata['value']['timeSeries'][0]['sourceInfo']['siteName'])
	waterdata['value']['timeSeries'].each do |data|
		value = data['values'][0]['value'][0]['value']
		label = data['variable']['variableDescription']
		printf "%-40s %s\n", label, value
	end
	puts "\n"
end


begin
	sites = ["01449000","01447800"]
	sites.each do |site|
		print_data(site)
	end
end