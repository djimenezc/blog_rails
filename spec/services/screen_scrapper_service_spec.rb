require 'spec_helper'

describe ScreenScrapperService do

  screenScrapperService = ScreenScrapperService.new

  it 'Get marketwatch Us market image' do

    data = screenScrapperService.get_marketwatch_data
    data.should_not be_nil
    data.name.should eq 'marketwatch'
    data.data.should_not be_nil
    data.data.length.should eq 6
    data.data[:US].length.should eq 6
  end
end