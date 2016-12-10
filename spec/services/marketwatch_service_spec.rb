require 'spec_helper'

describe MarketwatchService do

  screen_scrapper_service = MarketwatchService.new

  it 'Get investing quotes' do

    data = screen_scrapper_service.get_investing_data
    expect(data).not_to eq(nil)
    expect(data.length).to eq 4
    expect(data[:indices].length).to eq 8
    expect(data[:forex].length).to eq 8
    expect(data[:commodities].length).to eq 8
    expect(data[:bonds].length).to eq 8
  end

  it 'Get indices detail' do

    data = screen_scrapper_service.get_indices_detail
    expect(data).not_to eq(nil)
    expect(data.length).to eq 8
    expect(data[:sp500].length).to eq 12
    expect(data[:dow].length).to eq 12
  end
end
