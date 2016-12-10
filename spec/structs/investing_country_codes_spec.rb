require 'spec_helper'

describe InvestingCountryCodes do

  it 'Get list of code of US and European relevant countries' do


    country_list = InvestingCountryCodes.get_short_list_countries_codes
    expect(country_list).not_to eq(nil)
    expect(country_list.length).to eq 10
    expect(country_list).to include(5,)
  end

  it 'Get list of code of US and European relevant countries with separator' do

    country_list = InvestingCountryCodes.get_short_list_countries_codes ','
    expect(country_list).not_to eq(nil)
    expect(country_list).to include('5,')
  end

end