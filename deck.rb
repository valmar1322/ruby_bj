class Deck
  attr_reader :deck

  def initialize
    seed!
  end

  def seed!
    @deck = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        @deck << Card.new(suit, value)
      end
    end

    @deck.shuffle!
  end

  def pull_card
    @deck.delete(@deck[rand(@deck.length)])
  end
end
