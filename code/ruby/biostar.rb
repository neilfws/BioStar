#!/usr/bin/ruby -w

require "rubygems"
require "geoip"

ip  = "../../data/ip.txt"
db  = GeoIP::City.new("/opt/GeoIP/share/GeoIP/GeoLiteCity.dat")

File.read(ip).each do |line|
  line.chomp
  if line =~/from\s+(\d+\.\d+\.\d+\.\d+)/
    locn = []
    lookup = db.look_up($1)
    locn.push(lookup[:country_name], lookup[:country_code], lookup[:city], lookup[:latitude], lookup[:longitude])
    puts locn.join("\t")
  end
end

