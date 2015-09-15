class Game
  include GameInput
  include GameOutput

  def initialize
    run
  end

  protected

  def run
    trap('INT') { game_over }
    greeting
    show_commands
    while (code = prompt)
      process_prompt(code)
    end
  end

  def process_prompt(code)
    if code == 'n'
      start_game
    elsif code == 'q'
      game_over
    else
      puts "Sorry, I don't understand."
    end
  end

  def start_game
    name = player_name
    @player = Player.new(name)
    show_message("Hi, #{name}")
    @dealer = Dealer.new
    @deck = Deck.new

    # make bets
    # deal cards
    # show_cards
    # ask player move
    # dealer move
    # open cards
    # determine winner
  end
end
