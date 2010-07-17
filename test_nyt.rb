require 'rubygems'
require 'nokogiri'
require 'open-uri'

url_path  = "http://realestate.nytimes.com/rentals/10036-NEW-YORK-NY-USA/0-99000000-price/0-p"
doc = Nokogiri::HTML(open(url_path))

puts ">>>>>>>"
puts doc.at_css("title").text
puts ">>>>>>>"


doc.css(".property-info.clearfix").each do |p|
  title = p.at_css("h3 a").text
  price = p.at_css("h4").text
  #bd = p.at_css(".property-summary")
  #ba
  posted_at = p.at_css(".clearfix span").content

  puts "-------------"
  puts title
  puts price
  #puts "BD:#{bd}"
  puts posted_at
  puts "-------------"
  puts "      |      "
end
