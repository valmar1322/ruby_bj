class BlackJack

  attr_reader :player_score, :dealer_score, :draw_score, :dealer, :player

  def initialize
    @deck = Deck.new
    @player_score = 0
    @dealer_score = 0
    @draw_score = 0
  end

  def create_player(player_name, bank)
    @player = Player.new(player_name, bank)
  end

  def create_dealer(bank)
    @dealer = Dealer.new()
  end

  def first_deal
    @player.pick_up_card(@deck.pull_card)
    @player.pick_up_card(@deck.pull_card)
    @dealer.pick_up_card(@deck.pull_card)
    @dealer.pick_up_card(@deck.pull_card)
    @dealer.bet
    @player.bet
    
    participants_bank
    show_cards(true)
  end

  def restart
    @player.discard_cards
    @dealer.discard_cards
    @deck.seed!
  end

  def show_cards(dealer_masked)
    puts "Ваша рука: #{}"
    puts "Рука Дилера: #{}"
  end

  def player_hand
    @player.hand
  end

  def dealer_hand
    @dealer.hand(true)
  end

  def dealer_open_hand
    @dealer.hand(false)
  end 

  def player_bank
    @player.bank
  end

  def dealer_bank
    @dealer.bank
  end

  def player_points
    @player.total_points
  end

  def dealer_points
    @dealer.total_points
  end

  def player_add_card
    @player.pick_up_card(@deck.pull_card)
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
