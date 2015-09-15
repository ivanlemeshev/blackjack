class Game
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

    until self.game_over
      player_move

      break if self.game_over

      dealer_move

      if self.player.cards.size == 3 && self.dealer.cards.size == 3
        @dealer.show_closed_cards
        @player.show_opened_cards
        print_player_score
        print_bank
        Output::print_new_line
        Output::print_message('Open cards.')
        self.game_over = true
      end
    end

    open_cards

    if (self.player.balance > 0 && self.dealer.balance > 0)
      Output::print_message('Press any key to continue...')
      gets
    end
  end

  def player_move
    @dealer.show_closed_cards
    @player.show_opened_cards
    print_player_score
    print_bank
    Output::print_new_line

    puts "What do you want to do?"
    puts 'Enter "pass" to pass the move.' unless self.player_passed_the_move
    puts 'Enter "card" to get one card.' unless self.player_took_the_card
    puts 'Enter "open" to open cards.'

    command = gets.chomp

    Output::print_new_line

    if command == 'pass' && !self.player_passed_the_move
      Output::print_message('You pass the move.')
      self.player_passed_the_move = true
    elsif command == 'card' && !self.player_took_the_card
      Output::print_message('You get one card.')
      self.player.add_cards(self.deck.deal_cards(1))
      self.player_took_the_card = true
    else
      Output::print_message('Open cards.')
      self.game_over = true
    end
  end

  def dealer_move
    @dealer.show_closed_cards
    @player.show_opened_cards
    print_player_score
    print_bank
    Output::print_new_line

    if dealer.score >= 18 && !self.dealer_passed_the_move
      Output::print_message('Dealer pass the move.')
      self.dealer_passed_the_move = true
    elsif !self.dealer_took_the_card
      Output::print_message('Dealer get one card.')
      self.dealer.add_cards(self.deck.deal_cards(1))
      self.dealer_took_the_card = true
    else
      Output::print_message('Open cards.')
      self.game_over = true
    end
  end

  def open_cards
    @dealer.show_opened_cards
    @player.show_opened_cards
    print_dealer_score
    print_player_score
    print_bank
    Output::print_new_line

    if self.dealer.score == self.player.score
      Output::print_message('Drawn game.')
      amount = self.bank / 2.0
      self.dealer.take_money(amount)
      self.player.take_money(amount)
    elsif self.dealer.score == 21
      Output::print_message('Dealer win!')
      self.dealer.take_money(self.bank)
    elsif self.player.score == 21
      Output::print_message('You win!')
      self.player.take_money(self.bank)
    elsif (21 - self.player.score).abs < (21 - self.dealer.score).abs
      Output::print_message('You win!')
      self.player.take_money(self.bank)
    else
      Output::print_message('Dealer win!')
      self.dealer.take_money(self.bank)
    end

    self.bank = 0
    self.player.clear_cards
    self.dealer.clear_cards

    Output::print_new_line
    puts "Your balance: #{self.player.balance}"
    puts "Dealer balance: #{self.dealer.balance}"
    Output::print_new_line
  end

  def deal_cards
    self.player.add_cards(self.deck.deal_cards(2))
    self.dealer.add_cards(self.deck.deal_cards(2))
  end

  def make_bets
    self.dealer.make_bet
    self.bank += Dealer::BET_AMOUNT
    self.player.make_bet
    self.bank += Player::BET_AMOUNT
  end

  def print_player_score
    puts "Your score: #{self.player.score}"
  end

  def print_dealer_score
    puts "Dealer score: #{self.dealer.score}"
  end

  def print_bank
    puts "Bank: #{self.bank}"
  end
end
