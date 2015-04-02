require 'spec_helper'

describe ScreenScrapperService do

  it 'Read walmart title after a search' do

    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'

    url = 'http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=Batman&Find.x=0&Find.y=0&Find=Find'
    doc = Nokogiri::HTML(open(url))

    puts "Title: #{doc.at_css('title').text}"

    doc.at_css('title').text.should eq 'Batman - Walmart.com'
  end
end
