class Card
  attr_reader :suit, :value

  VALUES = [(2..10).to_a, 'J', 'Q', 'K', 'A'].flatten
  SUITS = ['+', '<3', '^', '<>']

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def self.values
  	VALUES
	end

	def self.suits
		SUITS
	end

  def to_s
    "#{@value}#{@suit}"
  end

  def picture?
  	@value == 'J' || @value == 'Q' || @value == 'K'
  end
end
