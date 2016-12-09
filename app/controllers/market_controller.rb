class MarketController < ApplicationController

  def initialize

    @marketwatch_service = MarketwatchService.new
    @calendar_service = CalendarService.new
    super
  end

  def create

    @market_snapshot = MarketSnapshot.new

    @market_snapshot.name = 'marketwatch.com'
    @market_snapshot.quotes = @marketwatch_service.get_investing_data

    @market_snapshot.save!

    render status: :ok, json: @market_snapshot.to_json
  end
end
