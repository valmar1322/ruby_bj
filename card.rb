class Card
  attr_reader :suit, :value

  VALUES = [(2..10).to_a, 'J', 'Q', 'K', 'A'].flatten
  SUITS = ['+', '<3', '^', '<>']
  SCORES = {
    2 => 2, 3 => 3, 4 => 4, 5 => 5,
    6 => 6, 7 => 7, 8 => 8, 9 => 9,
    10 => 10, 'J' => 10, 'Q' => 10,
    'K' => 10
  }

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

  def score
    @score ||= SCORES[@value]
  end

  def picture?
    @value == 'J' || @value == 'Q' || @value == 'K'
  end

  def ace?
    @value == 'A'
  end
end
