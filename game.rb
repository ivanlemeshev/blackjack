class Game
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

    until self.game_over
      print_closed_cards
      print_player_score
      print_bank
      print_new_line

      puts "What do you want to do?"
      puts 'Enter "pass" to pass the move.'
      puts 'Enter "card" to get one card.'
      puts 'Enter "open" to open cards.'

      command = gets.chomp

      print_new_line

      if command == 'pass'
        puts 'You pass the move.'
      elsif command == 'card'
        puts 'You get one card.'
        self.player.add_cards(self.deck.deal_cards(1))
      elsif command == 'open'
        puts 'You want to open cards.'
        self.game_over = true
        break
      end

      print_closed_cards
      print_player_score
      print_bank
      print_new_line

      if dealer.score >= 18
        puts 'Dealer pass the move.'
      else
        puts 'Dealer get one card.'
        self.dealer.add_cards(self.deck.deal_cards(1))
      end
    end

    print_opened_cards
    print_dealer_score
    print_player_score
    print_bank
    print_new_line

    if self.dealer.score == self.player.score
      puts "Drawn game."
      amount = self.bank / 2.0
      self.dealer.take_money(amount)
      self.player.take_money(amount)
    elsif self.dealer.score == 21
      puts "Dealer win!"
      self.dealer.take_money(self.bank)
    elsif self.player.scode == 21
      puts "You win!"
      self.player.take_money(self.bank)
    else
    end

    self.bank = 0
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

  def print_closed_cards
    print_new_line
    self.dealer.cards.each { |card| printf('%4s', '*') }
    print_double_new_line
    self.player.cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
    print_double_new_line
  end

  def print_opened_cards
    print_new_line
    self.dealer.cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
    print_double_new_line
    self.player.cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
    print_double_new_line
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

  def print_new_line
    print "\n"
  end

  def print_double_new_line
    print "\n"
    print "\n"
  end
end
