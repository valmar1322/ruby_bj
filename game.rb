class Game
	def initialize(blackjack)
		@blackjack = black_jack
	end

	def run()
		greetings
		regame = false
    loop do
      @blackjack.first_deal
      puts "Вы с дилером сделали ставки по #{Participant.default_bet}$"
      participants_bank

      player_points
      turn_info
      choice = player_choice

      if choice == 1
        @blackjack.player_add_card
        player_points
        dealer_turn
      elsif choice == 2 || choice == 3
        dealer_turn
      end

      open_cards
      
      if restart?
        restart
      else
        break
      end
    end
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

  def turn_info
    puts
    puts "Ваш ход, можете: "
    puts "1 - Добавить карту"
    puts "2 - Открыть карты"
    puts "3 - Пропустить"
  end

  def create_player(bank)
    puts "Введите своё имя латинскими буквами:"
    player_name = gets.chomp
    @blackjack.create_player(player_name, bank)
  rescue RuntimeError => e
    puts 'Имя должно быть длиной от 3 до 20 символов'
    retry
  end

  def participants_bank
  	puts "Ваш банк: #{@blackjack.player_bank}"
  	puts "Банк дилера: #{@blackjack.dealer_bank}"
  end

  def player_points
  	puts "У вас #{@blackjack.player_points} очков"
  end

  def dealer_points
		puts "У дилера #{@blackjack.dealer_points} очков"
  end

  def player_choice
    choice = false
    until choice
      choice = gets.to_i

      choice = 
        case choice
        when 1..3
          choice
        else
          puts "Неверный ввод."
          false
        end
    end
    choice
  end
  
end
