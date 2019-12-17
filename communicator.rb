class Communicator
  def greetings
    puts 'Игра BlackJack.'    
  end

  def turn_info
    puts
    puts "Ваш ход, можете: "
    puts "1 - Добавить карту"
    puts "2 - Открыть карты"
    puts "3 - Пропустить"
  end

  def input_player_name
    puts "Введите своё имя латинскими буквами:"
    player_name = gets.chomp
  end

  def show_game_message(msg)
    puts msg
  end

  def about_bets(bet)
    puts "Вы с дилером сделали ставки по #{bet}$"
  end

  def participants_bank(player_bank, dealer_bank)
    puts "Ваш банк: #{player_bank}"
    puts "Банк дилера: #{dealer_bank}"
  end

  def player_points(player_points)
    puts "У вас #{player_points} очков"
  end

  def dealer_points(dealer_points)
    puts "У дилера #{dealer_points} очков"
  end

  def participants_hands(player_hand, dealer_hand)
    puts "Ваша рука: #{player_hand}"
    puts "Рука дилера: #{dealer_hand}"
  end

  def show_result(winner)
    msg =
      case winner.class.to_s
      when 'Player' then "Вы выиграли!"
      when 'Dealer' then "Дилер выиграл!"
      when 'NilClass' then "Ничья"
      end
    puts msg
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
