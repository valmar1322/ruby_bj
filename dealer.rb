class Dealer < Participant
  DEALER_NAME = 'Дилер'

  def initialize(bank)
    super(dealer_name, bank)
  end

  def dealer_name
    DEALER_NAME
  end

  def hand(masked)
    if masked
      Array.new(cards.size, '*').join(' ')
    else
      super()
    end
  end
end
