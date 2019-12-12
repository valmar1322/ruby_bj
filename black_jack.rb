class BlackJack
  def initialize(communicator)
    @communicator = communicator
    @deck = Deck.new
    @player_score = 0
    @dealer_score = 0
    @draw_score = 0
  end

  def run
    @communicator.greetings
    create_participants

    loop do
      first_deal

      @communicator.about_bets(Participant.default_bet)
      @communicator.participants_bank(@player.bank, @dealer.bank)
      @communicator.participants_hands(@player.hand, @dealer.hand(true))
      @communicator.player_points(@player.total_points)
      @communicator.turn_info

      choice = @communicator.player_choice

      if choice == 1
        player_add_card
        dealer_turn
      elsif choice == 3
        dealer_turn
      end

      @communicator.player_points(@player.total_points)
      @communicator.dealer_points(@dealer.total_points)
      @communicator.participants_hands(@player.hand, @dealer.hand(false))
      @communicator.show_result(result)
      
      if restart?
        restart
      else
        break
      end
    end
  end

  def create_participants
    bank = 100

    begin
      player_name = @communicator.input_player_name
      create_player(player_name, bank)
    rescue RuntimeError => e
      @communicator.show_game_message(e.message)
      retry
    end

    create_dealer(bank)
  end

  def create_player(player_name, bank)
    @player = Player.new(player_name, bank)
  end

  def create_dealer(bank)
    @dealer = Dealer.new(bank)
  end

  def first_deal
    @player.pick_up_card(@deck.pull_card)
    @player.pick_up_card(@deck.pull_card)
    @dealer.pick_up_card(@deck.pull_card)
    @dealer.pick_up_card(@deck.pull_card)
    @dealer.bet
    @player.bet
  end

  def restart
    @player.discard_cards
    @dealer.discard_cards
    @deck.seed!
  end

  def player_add_card
    @player.pick_up_card(@deck.pull_card)
  end

  def result
    player_points = @player.total_points
    dealer_points = @dealer.total_points

    if player_points > 21
      dealer_win
      -1
    elsif dealer_points > 21
      player_win
      1
    elsif player_points < dealer_points
      dealer_win
      -1
    elsif player_points > dealer_points
      player_win
      1
    else
      draw
      0
    end
  end

  def dealer_win
    @dealer_score += 1
    @dealer.take_money(Participant.default_bet * 2)
  end

  def player_win
    @player_score += 1
    @player.take_money(Participant.default_bet * 2)
  end

  def draw
    @player.take_money(Participant.default_bet)
    @dealer.take_money(Participant.default_bet)
    @draw_score += 1
  end

  def dealer_turn
    if @dealer.total_points < 17
      @dealer.pick_up_card(@deck.pull_card)
    end
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
end
