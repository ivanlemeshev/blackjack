class Game
  def self.init
    puts 'Welcode to the Blackjack game!'
    print 'Please enter your name: '
    player_name = gets.chomp
    dealer = Dealer.new('Dealer')
    player = Player.new(player_name)
    puts "Hi, #{player.name}!"
  end
end
