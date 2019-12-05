class Game
	def initialize(blackjack)
		@blackjack = black_jack
	end

	def run()

	end

  def greetings
    puts 'Игра BlackJack.'

    bank = 100
    # begin
    #   puts 'Введите размер банка[50-200]$:'
    #   bank = gets.to_i
    # end while bank < 50 || bank > 200
    
    create_player(bank)
    @blackjack.create_dealer(bank)
  end

  def create_player(bank)
    puts "Введите своё имя латинскими буквами:"
    player_name = gets.chomp
    @blackjack.create_player(player_name, bank)
  rescue RuntimeError => e
    puts 'Имя должно быть длиной от 3 до 20 символов'
    retry
  end

  
end
