class TradingController < ApplicationController


  def initialize

    @marketwatch_service = MarketwatchService.new
    @calendar_service = CalendarService.new
    super
  end

  def index

  end

  def calendar

    # authorize User
    set_time_parameter

    time_frame = params['time-frame'].nil? ? 'thisWeek' : params['time-frame']
    cal_type = 'week'

    unless params[:timeFrame].nil? then
      time_frame = params[:timeFrame]
    end

    @calendar_snapshot = @calendar_service.get_weekly_calendar_data(time_frame, cal_type)
    @from = '22'
    @to = '233'
    @time_frame_options = build_time_frame_options time_frame

    @first_iteration = true
  end


  def weekly_calendar

    # authorize User

  end

  def marketwatch

    set_time_parameter

    @market_snapshot = MarketSnapshot.new
    @market_snapshot.name = 'marketwatch.com'
    @market_snapshot.quotes = @marketwatch_service.get_marketwatch_data
    @market_snapshot.investing = @marketwatch_service.get_investing_data
    @market_snapshot.indices = @marketwatch_service.get_indices_detail
  end

  private

  def set_time_parameter
    @time = Time.now.to_s(:datetime_military)
  end

  def build_time_frame_options(time_frame)

    [{
         :value => 'thisWeek',
         :text => 'This week',
         :selected => time_frame == 'thisWeek'
     }, {
         :value => 'nextWeek',
         :text => 'Next Week',
         :selected => time_frame == 'nextWeek'
     }, {
         :value => 'lastWeek',
         :text => 'Last Week',
         :selected => time_frame == 'lastWeek'
     }, {
         :value => 'today',
         :text => 'Today',
         :selected => time_frame == 'today'
     }, {
         :value => 'tomorrow',
         :text => 'Tomorrow',
         :selected => time_frame == 'tomorrow'
     }, {
         :value => 'yesterday',
         :text => 'Yesterday',
         :selected => time_frame == 'yesterday'
     }
    ]
  end
end
