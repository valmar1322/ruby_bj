class BlackJack
  def initialize
    @deck = Deck.new
    @player_score = 0
    @dealer_score = 0
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
    # loop do
      first_deal

      restart
    # end
  end

  def first_deal
    @player.pick_up_card(@deck.pull_card)
    @player.pick_up_card(@deck.pull_card)
    @dealer.pick_up_card(@deck.pull_card)
    @dealer.pick_up_card(@deck.pull_card)
    @dealer.bet
    @player.bet
    puts "Вы с дилером сделали ставки по #{Participant.default_bet}$"
    puts
    participants_bank
    show_cards
  end

  def restart
    @deck.seed!
  end

  def show_cards
    puts "Ваша рука: #{@player.hand}"
    puts "Рука Дилера: #{@dealer.masked_cards}"
  end

  def participants_bank
    puts "Ваш Банк: #{@player.bank}$"
    puts "Банк Дилера: #{@dealer.bank}$"
    puts
  end
end
