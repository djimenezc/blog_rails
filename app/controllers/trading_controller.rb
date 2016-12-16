class TradingController < ApplicationController


  def initialize

    @marketwatch_service = MarketwatchService.new
    @calendar_service = CalendarService.new
    @screen_scrapper_service = GastlyService.new
    super
  end

  def calendar

    # authorize User
    set_time_parameter

    time_frame = params['time-frame'].nil? ? 'thisWeek' : params['time-frame']
    impact = params[:impact_levels].nil? ? [InvestingImpactCodes.get_codes[:HIGH_IMPACT][:text]] : params[:impact_levels]
    cal_type = time_frame.include?('thisWeek') || time_frame.include?('nextWeek') ||time_frame.include?('lastWeek') ? 'week' : 'day'

    unless params[:timeFrame].nil?
      time_frame = params[:timeFrame]
    end

    @calendar_snapshot = @calendar_service.get_weekly_calendar_data(time_frame, cal_type, impact)
    @from = '22'
    @to = '233'
    @time_frame_options = build_time_frame_options time_frame
    @impact_options = build_impact_options impact

    @first_iteration = true
  end

  def weekly_calendar

    # authorize User

  end

  def screen_scrapper
    # authorize User
    @nh_nl_path = "/files/#{@screen_scrapper_service.get_nl_nh}"
    @vix_path = "/files/#{@screen_scrapper_service.get_vix}"
    set_time_parameter
  end

  def marketwatch

    set_time_parameter

    @market_snapshot = MarketSnapshot.new
    @market_snapshot.name = 'marketwatch.com'
    @market_snapshot.investing = @marketwatch_service.get_investing_data
    @market_snapshot.indices = @marketwatch_service.get_indices_detail
  end

  private

  def build_impact_options(impact_list)

    [{
         :value => InvestingImpactCodes.get_codes[:HIGH_IMPACT][:text],
         :text => InvestingImpactCodes.get_codes[:HIGH_IMPACT][:text],
         :name => 'HIGH_IMPACT',
         :checked => impact_list.include?(InvestingImpactCodes.get_codes[:HIGH_IMPACT][:text]) ? true : false
     }, {
         :value => InvestingImpactCodes.get_codes[:MODERATE_IMPACT][:text],
         :text => InvestingImpactCodes.get_codes[:MODERATE_IMPACT][:text],
         :name => 'MODERATE_IMPACT',
         :checked => impact_list.include?(InvestingImpactCodes.get_codes[:MODERATE_IMPACT][:text]) ? true : false
     }, {
         :value => InvestingImpactCodes.get_codes[:LOW_IMPACT][:text],
         :text => InvestingImpactCodes.get_codes[:LOW_IMPACT][:text],
         :name => 'LOW_IMPACT',
         :checked => impact_list.include?(InvestingImpactCodes.get_codes[:LOW_IMPACT][:text]) ? true : false
     }]
  end

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
