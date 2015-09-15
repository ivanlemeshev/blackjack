class Game
  include GameInput
  include GameOutput

  def initialize
    trap('INT') { game_over }
    greeting
    show_commands
    while (code = prompt)
      process_prompt(code)
    end
  end

  protected

  attr_accessor :bank

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
    @bank = 0
    @game_over = false
    name = player_name
    @player = Player.new(name)
    show_message("Hi, #{name}")
    @dealer = Dealer.new
    @hand = Hand.new

    until @player.balance == 0 || @dealer.balance == 0
      make_bets
      deal_cards
      show_info
      # player_move
      # dealer move
      # open_cards
      # determine_winner
    end
  end

  def make_bets
    self.bank += @player.make_bet
    self.bank += @dealer.make_bet
  end

  def deal_cards
    @player.take_cards(@hand.deal_cards)
    @dealer.take_cards(@hand.deal_cards)
  end

  def show_info
    show_cards_back(@dealer.cards) unless @game_over
    show_cards_face(@dealer.cards) if @game_over
    show_cards_face(@player.cards)

    show_score(@dealer.name, @hand.score(@dealer.cards)) if @game_over
    show_score(@player.name, @hand.score(@player.cards))

    show_bank(@bank)
  end
end
