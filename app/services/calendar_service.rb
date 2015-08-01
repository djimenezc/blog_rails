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

      market_name = item.at_css('a').text
      price = item.at_css('.price.bgLast').text
      pips_change = item.at_css('.change').text
      percentage_chg = item.at_css('.changepercent').text

      puts "#{market_name} - #{price} #{pips_change} #{percentage_chg}"

      result[market_name] = {
          :price => price.to_f,
          :pips_change => pips_change.to_f,
          :percentage_chg => percentage_chg
      }
    end

    result
  end

end
