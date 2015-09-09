require_relative 'deck'
require_relative 'card'
require_relative 'user'
require_relative 'dealer'
require_relative 'player'
require_relative 'game'

Game.print_message('Welcode to the Blackjack game!')
Game.print_new_line

player = Player.new(Game.get_player_name)

Game.print_new_line
Game.print_message("Hi, #{player.name}!")

dealer = Dealer.new('Dealer')

until dealer.balance == 0 || player.balance == 0
  Game.new(Deck.new, dealer, player)
end

Game.print_message('GAME OVER!')
