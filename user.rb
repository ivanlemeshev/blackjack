class User
  include CardScore

  INITIALIZE_BALANCE = 100
  BET_AMOUNT         = 10

  attr_accessor :passed_the_move, :took_the_card
  attr_reader :name, :cards, :balance

  def initialize(name)
    @name = name
    @balance = INITIALIZE_BALANCE
    @cards = []
    @passed_the_move = false
    @took_the_card = false
  end

  def add_cards(cards)
    @cards.concat(cards)
  end

  def clear_cards
    @cards = []
    @passed_the_move = false
    @took_the_card = false
  end

  def make_bet
    @balance -= BET_AMOUNT if @balance > 0
  end

  def take_money(amount)
    @balance += amount
  end

  def show_closed_cards
    @cards.each { printf('%4s', '*') }
    print "\n"
  end

  def show_opened_cards
    @cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
    print "\n"
  end

  def show_score
    puts "#{@name}'s score: #{score}"
  end

  def show_balance
    puts "#{@name}'s balance: #{@balance}"
  end

  def pass_move
    Output.print_message("#{@name} passed the move.")
    self.passed_the_move = true
  end

  def take_card(card)
    Output.print_message("#{@name} took the card.")
    add_cards(card)
    self.took_the_card = true
  end

  def open_cards
    Output.print_message('Open cards.')
  end

  def win(bank)
    Output.print_message("#{@name} win!")
    take_money(bank)
  end
end
