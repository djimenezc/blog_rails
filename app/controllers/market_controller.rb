
class MarketController < ApplicationController

  def initialize

    @screen_scrapper_service = ScreenScrapperService.new

    super
  end

  def create

    data = @screen_scrapper_service.get_marketwatch_data

    @market_snapshot = MarketSnapshot.new

    @market_snapshot.name = 'marketwatch'
    @market_snapshot.date = Date.new
    # @market_snapshot.market_quotes= data

    @market_snapshot.save

    render status: 200, json: @market_snapshot.to_json
  end
end
