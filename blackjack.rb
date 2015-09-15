require_relative 'output'
require_relative 'deck'
require_relative 'card'
require_relative 'card_score'
require_relative 'user'
require_relative 'dealer'
require_relative 'player'
require_relative 'game'

Output.print_message('Welcode to the Blackjack game!')
Output.print_new_line

puts 'Please enter your name.'
player_name = gets.chomp

player = Player.new(player_name)

Output.print_new_line
Output.print_message("Hi, #{player.name}!")

dealer = Dealer.new('Dealer')

until dealer.balance == 0 || player.balance == 0
  Game.new(Deck.new, dealer, player)
end

Output.print_message('GAME OVER!')
