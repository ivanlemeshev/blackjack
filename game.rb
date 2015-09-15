class Game
  WIN_SCORE = 21
  START_DEAL_CARDS_COUNT = 2
  GAME_DEAL_CARDS_COUNT = 1

  attr_accessor :bank, :game_over
  attr_reader :player, :dealer, :deck

  def initialize(deck, dealer, player)
    @deck = deck
    @dealer = dealer
    @player = player
    @bank = 0
    @game_over = false
    run
  end

  private

  def run
    deal_cards
    make_bets

    until @game_over
      player_move

      break if @game_over

      dealer_move

      if @player.cards.size == 3 && @dealer.cards.size == 3
        show_info
        Output.print_message('Open cards.')
        self.game_over = true
      end
    end

    open_cards

    if (self.player.balance > 0 && self.dealer.balance > 0)
      Output.print_message('Press any key to continue...')
      gets
    end
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
    ask_player_command
    command = gets.chomp
    process_player_command(command)
  end

  def ask_player_command
    puts 'What do you want to do?'
    puts 'Enter "pass" to pass the move.' unless @player.passed_the_move
    puts 'Enter "card" to get one card.' unless @player.took_the_card
    puts 'Enter "open" to open cards.'
  end

  def process_player_command(command)
    if player_can_pass?(command)
      @player.pass_move
    elsif player_can_take_card?(command)
      @player.take_card(@deck.deal_cards(GAME_DEAL_CARDS_COUNT))
    else
      @player.open_cards
      self.game_over = true
    end
  end

  def player_can_pass?(command)
    command == 'pass' && !@player.passed_the_move
  end

  def player_can_take_card?(command)
    command == 'card' && !@player.took_the_card
  end

  def dealer_move
    show_info

    if dealer_can_pass?
      @dealer.pass_move
    elsif dealer_can_take_card?
      @dealer.take_card(@deck.deal_cards(GAME_DEAL_CARDS_COUNT))
    else
      @dealer.open_cards
      self.game_over = true
    end
  end

  def dealer_can_pass?
    @dealer.score >= 18 && !@dealer.passed_the_move
  end

  def dealer_can_take_card?
    !@dealer.took_the_card
  end

  def open_cards
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
      Output.print_message('Drawn game.')
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
    @player.score == WIN_SCORE || (WIN_SCORE - @player.score).abs < (WIN_SCORE - @dealer.score).abs
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
