require 'spec_helper'

describe CalendarService do

  screen_scrapper_service = CalendarService.new

  it 'Get investing weekly calendar' do

    data = screen_scrapper_service.get_weekly_calendar_data
    data.should_not be_nil
    data.length.should be > 2
  end

  it 'Get investing weekly calendar this week' do

    data = screen_scrapper_service.get_weekly_calendar_data('thisWeek', 'week')
    data.should_not be_nil
    data.should_not be_nil
    data.length.should be > 2

  end

  it 'Get investing weekly calendar next week' do

    data = screen_scrapper_service.get_weekly_calendar_data('nextWeek', 'week')
    data.should_not be_nil
    data.should_not be_nil
    data.length.should be > 2

  end

  it 'Get investing weekly calendar today' do

    data = screen_scrapper_service.get_weekly_calendar_data('today', 'day')
    data.should_not be_nil
    data.should_not be_nil
    data.length.should be > 2

  end

  it 'Get investing weekly calendar tomorrow' do

    data = screen_scrapper_service.get_weekly_calendar_data('tomorrow', 'day')
    data.should_not be_nil
    data.should_not be_nil
    data.length.should be > 2

  end

  it 'Get investing weekly calendar tomorrow' do

    data = screen_scrapper_service.get_weekly_calendar_data('yesterday', 'day')
    data.should_not be_nil
    data.should_not be_nil
    data.length.should be > 2

  end
end