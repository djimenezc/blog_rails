class CalendarService

  CALENDAR_URL= 'http://ec.forexprostools.com?columns=exc_flags,exc_currency,exc_importance,exc_actual,exc_forecast,exc_previous&features=datepicker,timezone&countries=25,32,6,37,72,22,17,39,14,10,35,43,56,36,110,11,26,12,4,5&calType=week&timeZone=58&lang=1'


  def get_weekly_calendar_data

    html = Nokogiri.HTML(open(CALENDAR_URL))
    data = Hash.new

    data['us'] = get_calendar_quotes(html, '#overviewuspage .tickerrow')

  end

  private

  def get_calendar_quotes(html, country)

    result = Hash.new

    selector = '#ecEventsTable > tbody > tr > td.sentiment[title="High Volatility Expected"]'

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


      result[market_name] = {
          :country => market_name,
          :time => time,
          :sentiment_level => sentiment,
          :event => event,
          actual => actual,
          forecast => forecast,
          previous => previous
      }
    end

    result
  end

end
