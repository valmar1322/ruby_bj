class Deck
  attr_reader :deck

  def initialize
    cards = [(2..10).to_a, 'J', 'Q', 'K', 'A'].flatten    
    suits = ['+', '<3', '^', '<>']

    @deck = []

    suits.each do |suit|
      cards.each do |card|
        @deck << Card.new(suit, card)
      end
    end

    # @deck.shuffle!
  end

  def pull_card
    @deck.delete(@deck[rand(@deck.length)])
  end

  def deck
    @deck.each { |card| puts card }
  end
end
