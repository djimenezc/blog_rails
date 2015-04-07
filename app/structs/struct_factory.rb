class StructFactory
  include Singleton

  def get_market

    Struct.new(:name, :date, :data)
  end

  def get_price

    Struct.new(:price, :pips_change, :percentage_chg)
  end
end