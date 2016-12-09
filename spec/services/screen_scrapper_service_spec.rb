require 'spec_helper'

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'screencap'

describe ScreenScrapperService do

  it 'Read walmart title after a search' do

    url = 'https://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=Batman&Find.x=0&Find.y=0&Find=Find'
    doc = Nokogiri::HTML(open(url))

    puts "Title: #{doc.at_css('title').text}"

    doc.at_css('title').text.should eq 'Batman - Walmart.com'
  end

  it 'Get walmart item for batman search' do

    url = 'https://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=Batman&Find.x=0&Find.y=0&Find=Find'

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

    expect {
      src = html.at('#logo')['background-image']['url']

      File.open('foo.png', 'wb') do |f|
        f.write(open(src).read)
      end
    }.to raise_error

  end

  it 'Following links' do
    mechanize = Mechanize.new
    # noinspection RubyResolve
    mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    page = mechanize.get('http://en.wikipedia.org/wiki/Main_Page')

    # noinspection RubyResolve
    link = page.link_with(text: 'Random article')

    page = link.click

    puts "Link: #{page.uri.to_s}"
  end

  it 'Filling in a form' do

    mechanize = Mechanize.new

    page = mechanize.get('https://www.gov.uk/')

    form = page.forms.first

    form['q'] = 'passport'

    page = form.submit

    page.search('#top-results h3').each do |h3|
      puts "result: #{h3.text.strip}"
    end
  end

end
