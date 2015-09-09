require_relative 'deck'
require_relative 'card'
require_relative 'user'
require_relative 'dealer'
require_relative 'player'
require_relative 'game'

puts "Welcode to the Blackjack game!"
print 'Please enter your name: '
player_name = gets.chomp

player = Player.new(player_name)
puts "\nHi, #{player.name}!"

dealer = Dealer.new('Dealer')

deck = Deck.new

game = Game.new(deck, dealer, player)
