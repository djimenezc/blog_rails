class MarketwatchService

  DEFAULT_PERIOD = '?period=900'
  MARKETWATCH_URL= 'http://www.marketwatch.com'
  INVESTING_URL= 'http://www.investing.com'
  SP500_URL = 'http://www.investing.com/indices/us-spx-500-futures-technical' + DEFAULT_PERIOD
  DOW_URL = 'http://www.investing.com/indices/us-30-futures-technical' + DEFAULT_PERIOD
  NQ_URL = 'http://www.investing.com/indices/nq-100-futures-technical' + DEFAULT_PERIOD
  DAX_URL = 'http://www.investing.com/indices/germany-30-technical' + DEFAULT_PERIOD
  IBEX_URL = 'http://www.investing.com/indices/spain-35-technical' + DEFAULT_PERIOD
  CAC40_URL = 'http://www.investing.com/indices/france-40-technical' + DEFAULT_PERIOD
  FTSE_URL = 'http://www.investing.com/indices/uk-100-technical' + DEFAULT_PERIOD
  EURO_URL = 'http://www.investing.com/indices/eu-stocks-50-futures-technical' + DEFAULT_PERIOD

  def get_investing_data

    html = Nokogiri.HTML(open(INVESTING_URL))
    data = Hash.new
    row_selector = '.genTbl.openTbl.quotesSideBlockTbl.collapsedTbl tr'

    data[:indices]= get_investing_quotes(html, '#QBS_2_inner' + row_selector)
    data[:forex]= get_investing_quotes(html, '#QBS_1_inner'+ row_selector)
    data[:commodities]= get_investing_quotes(html, '#QBS_3_inner'+ row_selector)
    data[:bonds]= get_investing_quotes(html, '#QBS_5_inner'+ row_selector)

    data
  end

  def get_yahoo_data

  end

  def get_indices_detail

    data = Hash.new

    data[:sp500] = get_index_quote Nokogiri.HTML(open(SP500_URL))
    data[:dow] = get_index_quote Nokogiri.HTML(open(DOW_URL))
    data[:nq] = get_index_quote Nokogiri.HTML(open(NQ_URL))
    data[:dax] = get_index_quote Nokogiri.HTML(open(DAX_URL))
    data[:ibex] = get_index_quote Nokogiri.HTML(open(IBEX_URL))
    data[:cac40] = get_index_quote Nokogiri.HTML(open(CAC40_URL))
    data[:ftse] = get_index_quote Nokogiri.HTML(open(FTSE_URL))
    data[:euro] = get_index_quote Nokogiri.HTML(open(EURO_URL))

    data
  end

  private

  def get_investing_quotes(html, selector)

    result = Hash.new


    html.css(selector).each do |item|

      item_title_node = item.at_css('.left.bold.first.noWrap')

      if item_title_node != nil
        market_name = item_title_node.at_css('a').text

        pips_change = item.at_css('.chg').text.to_s.gsub(',', '.').to_f
        price_semaphore = if pips_change > 0
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
    end

    result

  end

  def get_index_quote(html)

    market_name = html.at_css('.instrumentHead > h1').text
    market_snapshot = html.css('#quotes_summary_current_data .inlineblock > span')

    pips_change = market_snapshot[1].text.to_s.gsub(',', '.').to_f
    price_semaphore = if pips_change > 0
                        'green'
                      else
                        (pips_change == 0 ? 'transparent' : 'red')
                      end

    analysis_table = html.at_css('#techStudiesInnerWrap')
    quotes_summary_secondary = html.at_css('#quotes_summary_secondary_data')
    moving_avg_span = analysis_table.at_css('.summaryTableLine:nth-child(2)').at_css('span:nth-child(2)')
    technical_indicator_span = analysis_table.at_css('.summaryTableLine:nth-child(3)').at_css('span:nth-child(2)')
    rsi_value = html.at_css('.technicalIndicatorsTbl tbody tr:nth-child(1) > td:nth-child(2)')
    rsi_action = html.at_css('.technicalIndicatorsTbl tbody tr:nth-child(1) > td:nth-child(3)')

    {
        :market_name => market_name,
        :price => html.at_css('#last_last').text.to_s.gsub(',', '.').to_f,
        :pips_change => pips_change,
        :percentage_chg => market_snapshot[3].text,
        :price_semaphore => price_semaphore,
        :prev_close => quotes_summary_secondary.at_css('ul > li > span:nth-child(2)').text,
        :open => quotes_summary_secondary.at_css('ul > li:nth-child(2) > span:nth-child(2)').text,
        :day_range => quotes_summary_secondary.at_css('ul > li:nth-child(3) > span:nth-child(2)').text,
        :summary => analysis_table.at_css('.summary > span').text,
        :moving_average => moving_avg_span.text,
        :technical_indicator => technical_indicator_span.text,
        :rsi => {
            :value => rsi_value.text,
            :action => rsi_action.text
        },
    }

  end
end
