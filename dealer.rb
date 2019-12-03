class Dealer < Participant
  DEALER_NAME = 'Дилер'

  def initialize(bank)
    super(dealer_name, bank)
  end

  def dealer_name
    DEALER_NAME
  end

  def masked_cards
    Array.new(cards.size, '*').join(' ')
  end
end
