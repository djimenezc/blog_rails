require 'spec_helper'

describe MarketController do

  it 'create a market snapshot' do
    get :create
    expect(response.status).to eq(200)
  end

end
