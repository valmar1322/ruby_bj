require_relative 'card'
require_relative 'deck'
require_relative 'validator'
require_relative 'participant'
require_relative 'player'
require_relative 'dealer'
require_relative 'black_jack'
require_relative 'communicator'

communicator = Communicator.new
BlackJack.new(communicator).run
