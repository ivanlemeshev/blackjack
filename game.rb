class Game
  def self.init
    puts 'Welcode to the Blackjack game!'

    print 'Please enter your name: '
    player_name = gets.chomp

    dealer = Dealer.new('Dealer')
    player = Player.new(player_name)

    puts "Hi, #{player.name}!"

    deck = Deck.new

    player.add_cards(deck.deal_cards(2))
    dealer.add_cards(deck.deal_cards(2))

    print "\n"
    dealer.cards.each { |card| printf("%4s", "*") }
    print "\n"
    print "\n"
    player.cards.each { |card| printf("%4s", "#{card.value}#{card.suit}") }
    puts "\tscore: #{player.score}"
    print "\n"
    print "\n"
  end
end
