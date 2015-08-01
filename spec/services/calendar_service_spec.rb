require 'spec_helper'

describe CalendarService do

  screen_scrapper_service = CalendarService.new

  it 'Get investing weekly calendar' do

    data = screen_scrapper_service.get_weekly_calendar_data
    data.should_not be_nil
    data.should_not be_nil
    data.length.should eq 6
    data[:US].length.should eq 6
  end
end
