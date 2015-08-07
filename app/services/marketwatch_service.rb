class MarketwatchService

  MARKETWATCH_URL= 'http://www.marketwatch.com'

  def get_marketwatch_data

    html = Nokogiri.HTML(open(MARKETWATCH_URL))
    data = Hash.new

    data[:US]= get_marketwatch_quotes(html, '#overviewuspage .tickerrow')
    data[:EU]= get_marketwatch_quotes(html, '#overvieweuropepage .tickerrow')
    data[:asia]= get_marketwatch_quotes(html, '#overviewasiapage .tickerrow')
    data[:FX]= get_marketwatch_quotes(html, '#overviewfxpage .tickerrow')
    data[:rates]= get_marketwatch_quotes(html, '#overviewratespage .tickerrow')
    data[:futures]= get_marketwatch_quotes(html, '#overviewfuturespage .tickerrow')

    data
  end

  def get_investing_data
  end

  def get_yahoo_data

  end

  private

  def get_marketwatch_quotes(html, selector)

    result = Hash.new

    html.css(selector).each do |item|

      market_name = item.at_css('a').text
      pips_change = item.at_css('.change').text.to_s.gsub(',', '.').to_f
      price_semaphore = if pips_change > 0 then
                          'green'
                        else
                          (pips_change == 0 ? 'transparent' : 'red')
                        end

      result[market_name] = {
          :price => item.at_css('.price.bgLast').text.to_s.gsub(',', '.').to_f,
          :pips_change => pips_change,
          :percentage_chg => item.at_css('.changepercent').text,
          :price_semaphore => price_semaphore
      }
    end

    result
  end
end
