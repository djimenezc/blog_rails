class MarketSnapshot
  include Mongoid::Document
  field :name, type: String
  field :date, type: Date
  field :market_quotes, type: Array
end