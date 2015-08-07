class MarketwatchService

  DEFAULT_PERIOD = '?period=900'
  MARKETWATCH_URL= 'http://www.marketwatch.com'
  INVESTING_URL= 'http://www.investing.com'
  SP500_URL = 'http://www.investing.com/indices/us-spx-500-futures-technical' + DEFAULT_PERIOD
  DOW_URL = 'http://www.investing.com/indices/us-30-futures-technical' + DEFAULT_PERIOD

  def get_marketwatch_data

    html = Nokogiri.HTML(open(MARKETWATCH_URL))
    data = Hash.new

    data[:us]= get_marketwatch_quotes(html, '#overviewuspage .tickerrow')
    data[:eu]= get_marketwatch_quotes(html, '#overvieweuropepage .tickerrow')
    data[:asia]= get_marketwatch_quotes(html, '#overviewasiapage .tickerrow')
    data[:fx]= get_marketwatch_quotes(html, '#overviewfxpage .tickerrow')
    data[:rates]= get_marketwatch_quotes(html, '#overviewratespage .tickerrow')
    data[:futures]= get_marketwatch_quotes(html, '#overviewfuturespage .tickerrow')

    data
  end

  def get_investing_data

    html = Nokogiri.HTML(open(INVESTING_URL))
    data = Hash.new
    row_selector = '.genTbl.openTbl.quotesSideBlockTbl.collapsedTbl tr'

    data[:indices]= get_investing_quotes(html, '#QBS_2_inner ' + row_selector)
    data[:commodities]= get_investing_quotes(html, '#QBS_1_inner '+ row_selector)
    data[:forex]= get_investing_quotes(html, '#QBS_3_inner '+ row_selector)
    data[:bonds]= get_investing_quotes(html, '#QBS_4_inner '+ row_selector)

    data
  end

  def get_yahoo_data

  end

  def get_indices_detail

    data = Hash.new

    data[:sp500] = get_index_quote Nokogiri.HTML(open(SP500_URL))
    data[:dow] = get_index_quote Nokogiri.HTML(open(DOW_URL))
    # data[:nq] = get_index_quote Nokogiri.HTML(open(DOW_URL))
    # data[:dax] = get_index_quote Nokogiri.HTML(open(DOW_URL))
    # data[:ibex] = get_index_quote Nokogiri.HTML(open(DOW_URL))

    data
  end

  private

  def get_investing_quotes(html, selector)

    result = Hash.new

    html.css(selector).each do |item|

      market_name = item.at_css('.left.bold.first.noWrap').at_css('a').text

      pips_change = item.at_css('.chg').text.to_s.gsub(',', '.').to_f
      price_semaphore = if pips_change > 0 then
                          'green'
                        else
                          (pips_change == 0 ? 'transparent' : 'red')
                        end

      result[market_name] = {
          :price => item.at_css('.lastNum').text.to_s.gsub(',', '.').to_f,
          :pips_change => pips_change,
          :percentage_chg => item.at_css('.chgPer').text,
          :price_semaphore => price_semaphore
      }
    end

    result

  end

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

  def get_index_quote(html)

    result = Hash.new

    market_name = html.at_css('.headerWithInfoBox').text
    market_snapshot = html.css('#quotes_summary_current_data .inlineblock > span')

    pips_change = market_snapshot[1].text.to_s.gsub(',', '.').to_f
    price_semaphore = if pips_change > 0 then
                        'green'
                      else
                        (pips_change == 0 ? 'transparent' : 'red')
                      end

    analysis_table = html.at_css('#techStudiesInnerBoxRightBottom')
    quotes_summary_secondary = html.at_css('#quotes_summary_secondary_data')

    result[market_name] = {
        :price => html.at_css('#last_last').text.to_s.gsub(',', '.').to_f,
        :pips_change => pips_change,
        :percentage_chg => market_snapshot[3].text,
        :price_semaphore => price_semaphore,
        :prev_close => quotes_summary_secondary.at_css('ul > li > span:nth-child(2)').text,
        :open => quotes_summary_secondary.at_css('ul > li:nth-child(2) > span:nth-child(2)').text,
        :day_range => quotes_summary_secondary.at_css('ul > li:nth-child(3) > span:nth-child(2)').text,
        :summary => analysis_table.at_css('.studySummaryOval').text,
        :moving_average => analysis_table.at_css('.studySummaryTable').at_css('.studySummaryTableCol2 > span > span').text,
        :technical_indicator => analysis_table.at_css('.studySummaryTable.bottom').at_css('.studySummaryTableCol2 > span > span').text,
        :rsi => {
            :value => html.at_css('.technicalIndicatorsTbl #pair_0 > td:nth-child(2)').text,
            :action => html.at_css('.technicalIndicatorsTbl #pair_0 > td:nth-child(3)').text
        },
    }

    result
  end
end
