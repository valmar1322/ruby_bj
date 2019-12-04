class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{@value}#{@suit}"
  end

  def picture?
  	@value == 'J' || @value == 'Q' || @value == 'K'
  end
end
