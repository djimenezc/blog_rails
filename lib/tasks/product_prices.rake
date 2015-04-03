desc 'Fetch product prices'

# http://asciicasts.com/episodes/190-screen-scraping-with-nokogiri

task :fetch_prices => :environment do

  require 'nokogiri'
  require 'open-uri'

  Product.find_all_by_price(nil).each do |product|
    escaped_product_name = CGI.escape(product.name)
    url = "http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=#{escaped_product_name}&Find.x=0&Find.y=0&Find=Find"
    doc = Nokogiri::HTML(open(url))
    price = doc.at_css('.PriceXLBold, .PriceCompare .BodyS').text[/[0-9\.]+/]
    product.update_attribute(:price, price)
  end
end

desc 'Get title with mechanize'

task :import_list => :environment do
  require 'mechanize'

  agent = Mechanize.new
  page = agent.get('http://stackoverflow.com/')

  puts page.title

end