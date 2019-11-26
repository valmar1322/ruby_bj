class Dealer < Participant
  DEALER_NAME = 'Дилер'

  def initialize(bank, *cards)
    super(dealer_name, bank, cards)
  end

  def dealer_name
    DEALER_NAME
  end

  def masked_cards
    Array.new(cards.size, '*')
  end
end
