class TradingController < ApplicationController


  def initialize

    @marketwatch_service = MarketwatchService.new
    @calendar_service = CalendarService.new
    super
  end

  def index

  end

  def calendar


  end

  def weekly_calendar
    # authorize User
    @calendar_service.get_weekly_calendar_data


  end

  def marketwatch

  end
end
