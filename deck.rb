class Deck
  attr_reader :deck

  def initialize
    seed!
  end

  def seed!
    values = [(2..10).to_a, 'J', 'Q', 'K', 'A'].flatten    
    suits = ['+', '<3', '^', '<>']

    @deck = []

    suits.each do |suit|
      values.each do |value|
        @deck << Card.new(suit, value)
      end
    end

    @deck.shuffle!
  end

  def pull_card
    @deck.delete(@deck[rand(@deck.length)])
  end
end
