class BlackJack
  def initialize
    @deck = Deck.new
  end

  def greetings
    puts 'Игра BlackJack.'

    begin
      puts 'Введите размер банка[50-200]$:'
      bank = gets.to_i
    end while bank < 50 || bank > 200

    create_player(bank)

    @dealer = Dealer.new(bank, [])
  end

  def create_player(bank)
    puts "Введите своё имя латинскими буквами:"
    player_name = gets.chomp
    @player = Player.new(player_name, bank, [])
  rescue RuntimeError => e
    puts 'Имя должно быть длиной от 3 до 20 символов'
    retry
  end

  def run
    greetings
  end
end
