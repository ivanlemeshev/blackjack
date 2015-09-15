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

begin
  puts 'Please enter your name.'
  player_name = gets.chomp
  fail if player_name.empty?
rescue
  puts 'Player name cannot be blank.'
  retry
end

player = Player.new(player_name)

Output.print_new_line
Output.print_message("Hi, #{player.name}!")

dealer = Dealer.new('Dealer')

until dealer.balance == 0 || player.balance == 0
  Output.print_new_line
  Output.print_message('Press any key to play a new game...')
  gets
  Game.new(Deck.new, dealer, player)
end

Output.print_message('GAME OVER!')
