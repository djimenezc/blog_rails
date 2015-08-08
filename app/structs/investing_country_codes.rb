class InvestingCountryCodes

  USD = {:code => 5, :name => 'US'}
  AUD = {:code => 25, name => 'Australia'}
  BRL = {:code => 32, name => 'Brazil'}
  CAD = {:code => 6, name => 'Canada'}
  CNY = {:code => 37, name => 'China'}
  EUR = {:code => 72, name => 'Euro'}
  FRA = {:code => 22, name => 'France'}
  GER = {:code => 17, name => 'Germany'}
  HKD = {:code => 39, name => 'Hong Kong'}
  INR = {:code => 14, name => 'India'}
  ITL = {:code => 10, name => 'Italy'}
  JPY = {:code => 35, name => 'Japan'}
  NZD = {:code => 43, name => 'New Zealand'}
  RUB = {:code => 56, name => 'Russia'}
  SGD = {:code => 36, name => 'Singapore'}
  ZAR = {:code => 110, name => 'South Africa'}
  KRW = {:code => 11, name => 'South Korea'}
  SPN = {:code => 26, name => 'Spain'}
  CHF = {:code => 12, name => 'Switzerland'}
  GBP = {:code => 4, name => 'UK'}

  def self.get_short_list_countries
    [USD, EUR, FRA, GER, ITL, JPY, SPN, CHF, GBP]
  end

  def self.get_short_list_countries_codes(separator=nil)

    result = get_short_list_countries.map do |country|
      country[:code]
    end

    if separator.nil? then
      result
    else
      result.join separator
    end
  end
end