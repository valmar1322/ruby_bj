class Participant
  include Validator

  DEFAULT_BET = 10
  EMPTY_BANK = 'Не хватает денег не ставку'

  attr_accessor :name
  attr_reader :cards, :bank

  def initialize(name, bank)
    @name = name
    @bank = bank
    @cards = []
  end

  def pick_up_card(card)
    @cards << card
  end

  def self.default_bet
    DEFAULT_BET
  end

  def bet
    raise "У #{@name} " + EMPTY_BANK if @bank - self.class.default_bet < 0
    
    @bank -= self.class.default_bet
  end

  def total_points
    points = 0
    @cards.each do |card|
      points += 
        if card.dignity.is_a? Integer
          card.dignity
        elsif card.picture?
          10
        end 
    end
    points
  end

  def hand
    @cards.join(' ')
  end
end
