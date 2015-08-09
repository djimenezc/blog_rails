class InvestingImpactCodes

  HIGH_IMPACT = {:text => 'High Volatility Expected'}
  MODERATE_IMPACT = {:text => 'Moderate Volatility Expected'}
  LOW_IMPACT = {:text => 'Low Volatility Expected'}

  def self.get_codes
    {:HIGH_IMPACT => HIGH_IMPACT, :MODERATE_IMPACT => MODERATE_IMPACT, :LOW_IMPACT => LOW_IMPACT}
  end
end