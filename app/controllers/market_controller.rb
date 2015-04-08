class MarketController < ApplicationController

  def initialize

    @screen_scrapper_service = ScreenScrapperService.new
    super
  end

  def create

    @market_snapshot = MarketSnapshot.new

    @market_snapshot.name = 'marketwatch'
    @market_snapshot.quotes = @screen_scrapper_service.get_marketwatch_data

    @market_snapshot.save!

    render status: :ok, json: @market_snapshot.to_json
  end
end
