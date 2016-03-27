require 'spec_helper'

describe MarketwatchService do

  screen_scrapper_service = MarketwatchService.new

  # it 'Get marketwatch quotes' do
  #
  #   data = screen_scrapper_service.get_marketwatch_data
  #   data.should_not be_nil
  #   data.should_not be_nil
  #   data.length.should eq 4
  #   data[:us].length.should eq 6
  # end

  it 'Get investing quotes' do

    data = screen_scrapper_service.get_investing_data
    data.should_not be_nil
    data.should_not be_nil
    data.length.should eq 4
    data[:indices].length.should eq 8
  end

  it 'Get indices detail' do

    data = screen_scrapper_service.get_indices_detail
    data.should_not be_nil
    data.should_not be_nil
    data.length.should eq 8
    data[:sp500].length.should eq 12
    data[:dow].length.should eq 12
  end
end
