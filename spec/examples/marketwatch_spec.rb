require 'spec_helper'

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'screencap'

describe MarketwatchService do

  it 'Read walmart title after a search' do

    url = 'http://www.walmart.com/search/search-ng.do?search_constraint=0&ic=48_0&search_query=Batman&Find.x=0&Find.y=0&Find=Find'
    doc = Nokogiri::HTML(open(url))

    puts "Title: #{doc.at_css('title').text}"

    doc.at_css('title').text.should eq 'Batman - Walmart.com'
  end

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

    expect {
      src = html.at('#logo')['background-image']['url']

      File.open('foo.png', 'wb') do |f|
        f.write(open(src).read)
      end
    }.to raise_error

  end

  it 'Following links' do
    mechanize = Mechanize.new

    page = mechanize.get('http://en.wikipedia.org/wiki/Main_Page')

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

  it 'Take a page screenshot' do

    f = Screencap::Fetcher.new('http://google.com')
    screenshot = f.fetch(
        :output => TMP_DIRECTORY + 'googleDotCom.jpg'
    )

    screenshot.should_not be_nil
  end

  it 'Take a page screenshot of a specific element of a page' do

    f = Screencap::Fetcher.new('http://stockcharts.com/h-sc/ui?s=$USHL5&p=D&yr=8&mn=0&dy=0&id=p27747499092')
    screenshot = f.fetch(
        :output => TMP_DIRECTORY + 'googleContent.jpg', # don't forget the extension!
        # optional:
        :div => '#chartImg', # selector for a specific element to take screenshot of
        # :width => 1024,
        # :height => 768,
        # :top => 0, :left => 0, :width => 100, :height => 100 # dimensions for a specific area
    )

    screenshot.should_not be_nil

    screenshot = f.fetch(
        :output => TMP_DIRECTORY + 'googleContent2.jpg', # don't forget the extension!
        # optional:
        :div => '#section3', # selector for a specific element to take screenshot of
        # :width => 1024,
        # :height => 768,
        # :top => 0, :left => 0, :width => 100, :height => 100 # dimensions for a specific area
    )

    screenshot.should_not be_nil
  end

  it 'captures a given element' do
    screenshot = Screencap::Fetcher.new('http://placehold.it')
                     .fetch(:output => TMP_DIRECTORY + 'given_element.jpg', :div => 'img.image')

    screenshot.should_not be_nil
    FastImage.size(screenshot)[0].should == 140
  end
end
