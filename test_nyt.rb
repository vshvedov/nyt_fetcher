require 'rubygems'
require 'nokogiri'
require 'open-uri'

url_path  = "http://realestate.nytimes.com/rentals/10036-NEW-YORK-NY-USA/0-99000000-price/0-p"
doc = Nokogiri::HTML(open(url_path))

puts ">>>>>>>"
puts doc.at_css("title").text
total_pages =  doc.css(".input").text[/[0-9\.]+/].to_i
puts "Total pages: #{total_pages}"
puts ">>>>>>>"

for i in (0..total_pages)
  nyt_page = i*10
  url_for_page = "http://realestate.nytimes.com/rentals/10036-NEW-YORK-NY-USA/0-99000000-price/#{nyt_page.to_s}-p"
  puts "Page ---> #{url_for_page}"
  page_doc = Nokogiri::HTML(open(url_for_page))
  page_doc.css(".property-info.clearfix").each do |p|
    title = p.at_css("h3 a").text
    price = p.at_css("h4").text
    psumm = p.css(".property-summary").text

    if match = psumm.match(/(\d) BD/)
      bd = match.captures[0]
    else
      bd = "n/a"
    end

    if match = psumm.match(/(\S+) BA/)
      ba = match.captures[0]
    else
      ba = "n/a"
    end

    if match = psumm.match(/(\S+) Sq. Ft./)
      sqft = match.captures[0]
    else
      sqft = nil
    end
    
    posted_at = p.css(".property-title.box.blue.clearfix span").last.text[/[0-9\.]+/]

    puts title
    puts price
    puts bd
    puts ba
    puts sqft
    puts posted_at
    puts "------------- Page: #{i}"
  end
end
