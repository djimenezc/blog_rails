class MarketSnapshot
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :name, type: String
  field :quotes, type: Hash
  # embeds_many :quotes

end