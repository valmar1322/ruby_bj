class Player < Participant

  validate :name, :format, /^[a-zA-Z]{3,20}$/

  def initialize(name, bank)
    super(name, bank)
    validate!
  end
end
