class Game
  WIN_SCORE_COUNT = 21
  START_DEAL_CARDS_COUNT = 2
  GAME_DEAL_CARDS_COUNT = 1

  attr_accessor :bank, :game_over
  attr_accessor :player_passed_the_move, :dealer_passed_the_move
  attr_accessor :player_took_the_card, :dealer_took_the_card
  attr_reader :player, :dealer, :deck

  def initialize(deck, dealer, player)
    @deck = deck
    @dealer = dealer
    @player = player
    @bank = 0
    @game_over = false
    @player_passed_the_move = false
    @dealer_passed_the_move = false
    @player_took_the_card = false
    @dealer_took_the_card = false
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

  def player_move
    show_info

    puts 'What do you want to do?'
    puts 'Enter "pass" to pass the move.' unless self.player_passed_the_move
    puts 'Enter "card" to get one card.' unless self.player_took_the_card
    puts 'Enter "open" to open cards.'

    command = gets.chomp

    Output.print_new_line

    if command == 'pass' && !@player_passed_the_move
      Output.print_message('You pass the move.')
      self.player_passed_the_move = true
    elsif command == 'card' && !@player_took_the_card
      Output.print_message('You get one card.')
      @player.add_cards(@deck.deal_cards(GAME_DEAL_CARDS_COUNT))
      self.player_took_the_card = true
    else
      Output.print_message('Open cards.')
      self.game_over = true
    end
  end

  def dealer_move
    show_info

    if dealer.score >= 18 && !@dealer_passed_the_move
      Output.print_message('Dealer pass the move.')
      self.dealer_passed_the_move = true
    elsif !@dealer_took_the_card
      Output.print_message('Dealer get one card.')
      @dealer.add_cards(@deck.deal_cards(GAME_DEAL_CARDS_COUNT))
      self.dealer_took_the_card = true
    else
      Output.print_message('Open cards.')
      self.game_over = true
    end
  end

  def open_cards
    show_info

    if @dealer.score == @player.score
      Output.print_message('Drawn game.')
      amount = @bank / 2.0
      @dealer.take_money(amount)
      @player.take_money(amount)
    elsif @dealer.score == WIN_SCORE_COUNT
      Output.print_message("#{@dealer.name} win!")
      @dealer.take_money(@bank)
    elsif @player.score == WIN_SCORE_COUNT
      Output.print_message("#{@player.name} win!")
      @player.take_money(@bank)
    elsif (WIN_SCORE_COUNT - @player.score).abs < (21 - @dealer.score).abs
      Output.print_message("#{@player.name} win!")
      @player.take_money(@bank)
    else
      Output.print_message("#{@dealer.name} win!")
      @dealer.take_money(@bank)
    end

    self.bank = 0
    @player.clear_cards
    @dealer.clear_cards

    puts "Your balance: #{@player.balance}"
    puts "Dealer balance: #{@dealer.balance}"
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

  def show_info
    @dealer.show_closed_cards unless @game_over
    @dealer.show_opened_cards if @game_over
    @player.show_opened_cards
    @dealer.show_score if @game_over
    @player.show_score
    show_bank
  end

  def show_bank
    puts "Bank: #{@bank}"
  end
end
