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

  attr_accessor :bank, :game_over

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
    Message.show("Hi, #{name}")
    @dealer = Dealer.new
    @hand = Hand.new

    until @player.balance == 0 || @dealer.balance == 0
      @bank = 0
      @game_over = false
      make_bets
      deal_cards
      until @game_over
        player_move
        break if @game_over || players_cards_limit_reached?
        dealer_move
        stop_game if players_cards_limit_reached?
      end
      open_cards
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
    @dealer.show_cards_back unless @game_over
    @dealer.show_cards_face if @game_over
    @player.show_cards_face

    show_score(@dealer.name, @hand.score(@dealer.cards)) if @game_over
    show_score(@player.name, @hand.score(@player.cards))

    show_bank(@bank)
  end

  def player_move
    show_info
    @player.process_move(command(@player), @hand)
    self.game_over = @player.opened_cards
  end

  def dealer_move
    show_info
    @dealer.process_move(@hand)
    self.game_over = @dealer.opened_cards
  end

  def players_cards_limit_reached?
    @player.cards_limit_reached? && @dealer.cards_limit_reached?
  end

  def stop_game
    show_info
    self.game_over = true
  end

  def open_cards
    self.game_over = true

    confirm_open_cards
    show_info
    determine_winner
    clear_bank

    @player.clear_cards
    @dealer.clear_cards

    @player.show_balance
    @dealer.show_balance
  end

  def determine_winner
    if drawn?
      Message.show('Drawn game.')
      amount = @bank / 2.0
      @dealer.take_money(amount)
      @player.take_money(amount)
    elsif player_win?
      @player.win(@bank)
    else
      @dealer.win(@bank)
    end
  end

  def player_win?
    @hand.win_score?(@player.cards) || player_has_less_score_difference?
  end

  def player_has_less_score_difference?
    @hand.score_difference(@dealer.cards) < @hand.score_difference(@dealer.cards)
  end

  def drawn?
    @hand.score(@dealer.cards) == @hand.score(@player.cards)
  end

  def clear_bank
    self.bank = 0
  end
end
