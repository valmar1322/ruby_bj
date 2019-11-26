class Participant
  include Validator

  DEFAULT_BET = 10
  EMPTY_BANK = 'Not enough money to bet'

  attr_accessor :name
  attr_reader :cards, :bank

  def initialize(name, bank = 100, *cards)
    @name = name
    @bank = bank
    @cards = @cards
  end

  def pick_up_card(card)
    cards << card
  end

  def default_bet
    DEFAULT_BET
  end

  def bet(bet = DEFAULT_BET)
    raise EMPTY_BANK if bank - bet < 0
    
    bank -= bet
  end

  def total_points
    points = 0
    @cards.each do |card|
      points += 
        if card.dignity.is_a? Integer
          card.dignity
        elsif card.dignity == 'A'
          11
        else
          10
        end 
    end
    points
  end
end
