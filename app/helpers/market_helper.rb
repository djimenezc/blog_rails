module MarketHelper

  def get_action_color(action)

    action = action.upcase

    if action == 'BUY' then
      'dark-green'
    elsif action == 'STRONG BUY' then
      'green'
    elsif action == 'SELL' then
      'dark-red'
    elsif action == 'STRONG SELL' then
      'red'
    elsif action == 'NEUTRAL' then
      'neutral'
    end
  end
end
