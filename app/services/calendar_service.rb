class CalendarService

  CALENDAR_URL= 'http://ec.forexprostools.com?columns=exc_flags,exc_currency,exc_importance,exc_actual,exc_forecast,exc_previous&features=datepicker,timezone&timeZone=58&lang=1'

  def get_weekly_calendar_data(time_frame = 'thisWeek', calType='week', impact)

    html = Nokogiri.HTML(open(get_calendar_url_relevant_countries(time_frame, calType)))

    get_calendar_quotes(html, impact)
  end

  private

  def get_calendar_quotes(html, impact)

    result = Hash.new

    selector = "#ecEventsTable > tbody > tr > #{build_impact_event_selector(impact)}"

    # selector = '#ecEventsTable > tbody > tr > td.sentiment[title="High Volatility Expected"]'

    html.css(selector).each do |item|

      market_name = item.parent.at_css('.flagCur').text
      # Remove whitespaces and special symbols
      market_name = market_name.gsub(/\s+/m, ' ').strip.split(' ')[1]
      time = item.parent.at_css('.time').text
      sentiment = item.attr('title')
      event = item.parent.at_css('.event').text
      actual = item.parent.at_css('.act').text
      forecast = item.parent.at_css('.fore').text
      previous = item.parent.at_css('.prev').text
      date = DateTime.parse(item.parent.attr('event_timestamp')).to_date

      if result[date].nil? then
        result[date] = []
      end

      result[date].push({
                            :country => market_name,
                            # :date => date,
                            :time => time,
                            :sentiment_level => sentiment,
                            :event => event,
                            :actual => actual,
                            :forecast => forecast,
                            :previous => previous
                        })
    end

    result
  end

  def build_impact_event_selector(impact)

    first_iteration1 = true
    result = ''

    impact.each do |element|

      if first_iteration1
        first_iteration1 = false
      else
        result = result + ','
      end

      result = result + 'td.sentiment[title="' + element+ '"]'
    end

    result
  end

  private

  def get_calendar_time_frame_params(time_frame, calType)

    result = ''

    unless time_frame.nil?
      result.concat "&calType=#{calType}"
    end

    unless time_frame.nil?

      result.concat "&timeFrame=#{time_frame}"
    end

    result
  end

  def get_from_to_range
    # dateFrom:2015-08-10
    # dateTo:2015-08-11
  end

  def get_calendar_url_relevant_countries(time_frame, calType)

    CALENDAR_URL + '&countries='+ InvestingCountryCodes.get_short_list_countries_codes(',') + get_calendar_time_frame_params(time_frame, calType)

  end

end
