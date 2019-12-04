class BlackJack
  def initialize
    @deck = Deck.new
    @player_score = 0
    @dealer_score = 0
    @draw_score = 0
  end

  def greetings
    puts 'Игра BlackJack.'

    bank = 100
    # begin
    #   puts 'Введите размер банка[50-200]$:'
    #   bank = gets.to_i
    # end while bank < 50 || bank > 200

    create_player(bank)

    @dealer = Dealer.new(bank)
  end

  def create_player(bank)
    # puts "Введите своё имя латинскими буквами:"
    # player_name = gets.chomp
    player_name = 'Vladimir'
    @player = Player.new(player_name, bank)
  rescue RuntimeError => e
    puts 'Имя должно быть длиной от 3 до 20 символов'
    retry
  end

  def run
    greetings
    regame = false
    loop do
      first_deal
      player_points
      turn_info
      choice = player_choice

      if choice == 1
        @player.pick_up_card(@deck.pull_card)
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

  def first_deal
    @player.pick_up_card(@deck.pull_card)
    @player.pick_up_card(@deck.pull_card)
    @dealer.pick_up_card(@deck.pull_card)
    @dealer.pick_up_card(@deck.pull_card)
    @dealer.bet
    @player.bet
    puts "Вы с дилером сделали ставки по #{Participant.default_bet}$"
    
    participants_bank
    show_cards(true)
  end

  def restart?
    regame = false
    puts 'Еще раз? (y/n)'
    until regame
      regame = gets.chomp
      case regame
      when 'y', 'n' then regame
      else
        puts 'Неверный ввод'
        false
      end
    end
    regame == 'y'
  end

  def restart
    @player.discard_cards
    @dealer.discard_cards
    @deck.seed!
  end

  def show_cards(dealer_masked)
    puts "Ваша рука: #{@player.hand}"
    puts "Рука Дилера: #{@dealer.hand(dealer_masked)}"
  end

  def participants_bank
    puts "Ваш Банк: #{@player.bank}$"
    puts "Банк Дилера: #{@dealer.bank}$"
    puts
  end

  def turn_info
    puts
    puts "Ваш ход, можете: "
    puts "1 - Добавить карту"
    puts "2 - Открыть карты"
    puts "3 - Пропустить"
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

  def player_points
    puts "У вас #{@player.total_points} очков"
  end

  def dealer_points
    puts "У дилера #{@dealer.total_points} очков"
  end

  def open_cards
    show_cards(false)

    player_points = @player.total_points
    dealer_points = @dealer.total_points

    if player_points > 21
      dealer_win
    elsif dealer_points > 21 
      player_win
    elsif player_points < dealer_points
      dealer_win
    elsif player_points > dealer_points
      player_win
    else 
      draw
    end
  end

  def dealer_win
    puts "Дилер победил"
    @dealer_score += 1
    @dealer.take_money(Participant.default_bet * 2)
  end

  def player_win
    puts "Вы победили!"
    player_points
    dealer_points
    @player_score += 1
    @player.take_money(Participant.default_bet * 2)
  end

  def draw
    player_points
    dealer_points
    puts "Ничья"
    @draw_score += 1
  end

  def dealer_turn
    if @dealer.total_points < 17
      @dealer.pick_up_card(@deck.pull_card)
    end
  end
end
