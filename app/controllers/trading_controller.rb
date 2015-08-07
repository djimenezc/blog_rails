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

    @time = Time.now.to_s(:datetime_military)


    @market_snapshot = MarketSnapshot.new
    @market_snapshot.name = 'marketwatch.com'
    @market_snapshot.quotes = @marketwatch_service.get_marketwatch_data
  end
end
