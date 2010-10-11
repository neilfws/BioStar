#!/usr/bin/ruby

require "rubygems"
require "mechanize"
require "logger"

log    = Logger.new('ip.txt')
url    = "http://biostar.stackexchange.com/users"
auth   = ARGV[0] or abort("Usage = biostar.rb auth-cookie-string")
agent  = Mechanize.new
cookie = Mechanize::Cookie.new("user", auth)
cookie.domain = ".stackexchange.com"
cookie.path   = "/"

# login first
page  = agent.get(url)
agent.cookie_jar.add(page.uri, cookie)

i = 1
loop do
  page  = agent.get("#{url}?page=#{i}")
  users = []

  page.links.each do |link|
    if link.uri.to_s =~/\/users\/\d+\// && link.text != ""
      users.push(link)
    end
  end

# skip first user link after login (= you, top of page)
  users[1..users.count - 1].each do |user|
    ip = ""
    userpage = user.click
    lastip   = userpage.search(".//div[@class='summaryinfo']").inner_text
    if lastip =~/from\s+(.*?)$/
      ip = $1
    end
    log.debug "#{user.text}\t#{ip}"
  end
  break if page.link_with(:text => ' next').nil?
  i += 1
end
