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

    time_frame = 'week'
    cal_type = 'week'

    unless params[:timeFrame].nil? then
      time_frame = params[:timeFrame]
    end

    @calendar_service.get_weekly_calendar_data(time_frame, cal_type)
  end

  def marketwatch

    @time = Time.now.to_s(:datetime_military)

    @market_snapshot = MarketSnapshot.new
    @market_snapshot.name = 'marketwatch.com'
    @market_snapshot.quotes = @marketwatch_service.get_marketwatch_data
    @market_snapshot.investing = @marketwatch_service.get_investing_data
    @market_snapshot.indices = @marketwatch_service.get_indices_detail
  end
end
