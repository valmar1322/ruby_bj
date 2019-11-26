class Player < Participant

  validate :name, :format, /^[a-zA-Z]{3,20}$/

	def initialize(name, bank, cards)
    super(name, bank, cards)
    validate!
  end
end
