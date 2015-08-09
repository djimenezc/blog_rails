require 'spec_helper'

describe CalendarService do

  screen_scrapper_service = CalendarService.new
  default_impact_level = [InvestingImpactCodes.get_codes[:HIGH_IMPACT][:text]]

  it 'Get investing weekly calendar' do

    data = screen_scrapper_service.get_weekly_calendar_data
    data.should_not be_nil
    data.length.should be > 2
  end

  it 'Get investing weekly calendar this week' do

    data = screen_scrapper_service.get_weekly_calendar_data('thisWeek', 'week', default_impact_level)
    data.should_not be_nil
    data.should_not be_nil
    data.length.should be > 2
  end

  it 'Get investing weekly calendar next week' do

    data = screen_scrapper_service.get_weekly_calendar_data('nextWeek', 'week', default_impact_level)
    data.should_not be_nil
    data.should_not be_nil
    data.length.should be > 2
  end

  it 'Get investing weekly calendar last week' do

    data = screen_scrapper_service.get_weekly_calendar_data('last', 'week', default_impact_level)
    data.should_not be_nil
    data.should_not be_nil
    data.length.should be > 2
  end

  it 'Get investing weekly calendar today' do

    data = screen_scrapper_service.get_weekly_calendar_data('today', 'day', default_impact_level)
    data.should_not be_nil
    data.should_not be_nil

  end

  it 'Get investing weekly calendar tomorrow' do

    data = screen_scrapper_service.get_weekly_calendar_data('tomorrow', 'day', default_impact_level)
    data.should_not be_nil
    data.should_not be_nil
  end

  it 'Get investing weekly calendar yesterday' do

    data = screen_scrapper_service.get_weekly_calendar_data('yesterday', 'day', default_impact_level)
    data.should_not be_nil
    data.should_not be_nil
  end
end