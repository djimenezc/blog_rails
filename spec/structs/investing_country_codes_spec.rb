require 'spec_helper'

describe InvestingCountryCodes do

  it 'Get list of code of US and European relevant countries' do


    country_list = InvestingCountryCodes.get_short_list_countries_codes
    country_list.should_not be_nil
    country_list.length.should eq 9
    country_list.should include 5
  end

  it 'Get list of code of US and European relevant countries with separator' do

    country_list = InvestingCountryCodes.get_short_list_countries_codes ','
    country_list.should_not be_nil
    country_list.should include '5,'
  end

end