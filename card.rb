class Card
  attr_reader :suit, :card

  def initialize(suit, card)
    @suit = suit
    @card = card
  end

  def to_s
    "#{@card} #{@suit}"
  end
end
