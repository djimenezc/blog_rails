require 'spec_helper'

require 'rubygems'
# require 'nokogiri'
# require 'open-uri'
# require 'mechanize'
# require 'screencap'

describe ScreenScrapperService do

  # it 'Take a page screenshot' do
  #
  #   f = Screencap::Fetcher.new('http://google.com')
  #   screenshot = f.fetch(
  #       :output => TMP_DIRECTORY + 'googleDotCom.jpg'
  #   )
  #
  #   screenshot.should_not be_nil
  # end

  # it 'Take a page screenshot of a specific element of a page' do
  #
  #   f = Screencap::Fetcher.new('http://stockcharts.com/h-sc/ui?s=$USHL5&p=D&yr=8&mn=0&dy=0&id=p27747499092')
  #   screenshot = f.fetch(
  #       :output => TMP_DIRECTORY + 'stockcharts.com-ushl.jpg', # don't forget the extension!
  #       # optional:
  #       :div => '#chartImg', # selector for a specific element to take screenshot of
  #   # :width => 1024,
  #   # :height => 768,
  #   # :top => 0, :left => 0, :width => 100, :height => 100 # dimensions for a specific area
  #   )
  #
  #   screenshot.should_not be_nil
  #
  #   screenshot = f.fetch(
  #       :output => TMP_DIRECTORY + 'googleContent2.jpg', # don't forget the extension!
  #       # optional:
  #       :div => '#section3', # selector for a specific element to take screenshot of
  #   # :width => 1024,
  #   # :height => 768,
  #   # :top => 0, :left => 0, :width => 100, :height => 100 # dimensions for a specific area
  #   )
  #
  #   screenshot.should_not be_nil
  # end

  # it 'captures a given element' do
  #   screenshot = Screencap::Fetcher.new('http://placehold.it')
  #                    .fetch(:output => TMP_DIRECTORY + 'given_element.jpg', :div => 'img.image')
  #
  #   screenshot.should_not be_nil
  #   FastImage.size(screenshot)[0].should == 140
  # end
end
