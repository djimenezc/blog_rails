require 'spec_helper'

describe MarketwatchService do

  screen_scrapper_service = MarketwatchService.new

  it 'Get marketwatch quotes' do

    data = screen_scrapper_service.get_marketwatch_data
    data.should_not be_nil
    data.should_not be_nil
    data.length.should eq 6
    data[:US].length.should eq 6
  end

  it 'Get investing quotes' do

    data = screen_scrapper_service.get_investing_data
    data.should_not be_nil
    data.should_not be_nil
    data.length.should eq 4
    data[:indices].length.should eq 7
  end
end
