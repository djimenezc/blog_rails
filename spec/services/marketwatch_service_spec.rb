require 'spec_helper'

describe MarketwatchService do

  screen_scrapper_service = MarketwatchService.new

  it 'Get marketwatch Us market image' do

    data = screen_scrapper_service.get_marketwatch_data
    data.should_not be_nil
    data.should_not be_nil
    data.length.should eq 6
    data[:US].length.should eq 6
  end
end
