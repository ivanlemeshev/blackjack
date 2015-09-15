class Game
  GAME_DEAL_CARDS_COUNT  = 1
  START_DEAL_CARDS_COUNT = 2

  def initialize(deck, dealer, player)
    @deck = deck
    @dealer = dealer
    @player = player
    @bank = 0
    @game_over = false
    run
  end

  private

  attr_accessor :bank, :game_over
  attr_reader :player, :dealer, :deck

  def run
    deal_cards
    make_bets
    until @game_over
      player_move
      break if @game_over || players_cards_limit_reached?
      dealer_move
      stop_game if players_cards_limit_reached?
    end
    open_cards
  end

  def deal_cards
    @player.add_cards(@deck.deal_cards(START_DEAL_CARDS_COUNT))
    @dealer.add_cards(@deck.deal_cards(START_DEAL_CARDS_COUNT))
  end

  def make_bets
    @dealer.make_bet
    self.bank += Dealer::BET_AMOUNT
    @player.make_bet
    self.bank += Player::BET_AMOUNT
  end

  def player_move
    show_info
    @player.ask_command
    @player.process_move(@player.command, @deck)
    self.game_over = @player.opened_cards
  end

  def dealer_move
    show_info
    @dealer.process_move(@deck)
    self.game_over = @dealer.opened_cards
  end

  def stop_game
    show_info
    self.game_over = true
  end

  def players_cards_limit_reached?
    @player.cards_limit_reached? && @dealer.cards_limit_reached?
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

  def confirm_open_cards
    Output.print_message_with_new_lines('Press any key to open cards...')
    gets
  end

  def determine_winner
    if drawn?
      Output.print_message_with_new_lines('Drawn game.')
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
    @player.win_score? || player_has_less_score_difference?
  end

  def player_has_less_score_difference?
    @player.score_difference < @dealer.score_difference
  end

  def drawn?
    @dealer.score == @player.score
  end

  def show_info
    @dealer.show_closed_cards unless @game_over
    @dealer.show_opened_cards if @game_over
    @player.show_opened_cards
    @dealer.show_score if @game_over
    @player.show_score
    show_bank
  end

  def clear_bank
    self.bank = 0
  end

  def show_bank
    puts "Bank: #{@bank}"
  end
end
