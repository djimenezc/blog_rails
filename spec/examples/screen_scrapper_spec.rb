require 'spec_helper'

require 'rubygems'
require 'nokogiri'
require 'open-uri'

describe ScreenScrapperService do

  # it 'Read walmart title after a search' do
  #
  #   url = 'http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=Batman&Find.x=0&Find.y=0&Find=Find'
  #   doc = Nokogiri::HTML(open(url))
  #
  #   puts "Title: #{doc.at_css('title').text}"
  #
  #   doc.at_css('title').text.should eq 'Batman - Walmart.com'
  # end

  it 'Get walmart item for batman search' do

    url = 'http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=Batman&Find.x=0&Find.y=0&Find=Find'

    doc = Nokogiri::HTML(open(url))
    doc.css('.item').each do |item|
      text = item.at_css('.prodLink').text
      price = item.at_css('.PriceXLBold, .PriceCompare .BodyS').text[/\$[0-9\.]+/]
      puts "#{text} - #{price}"
    end
  end

  it 'Get an marketwatch image' do

    PAGE = 'http://www.marketwatch.com'

    html = Nokogiri.HTML(open(PAGE))

    src  = html.at('#logo')['background-image']['url']

    File.open('foo.png', 'wb') do |f|
      f.write(open(src).read)
    end
  end
end
