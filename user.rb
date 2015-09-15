class User
  include CardScore

  TAKE_CARDS_COUNT   = 1
  MAX_CARDS_COUNT    = 3
  INITIALIZE_BALANCE = 100
  BET_AMOUNT         = 10

  COMMAND_PASS       = 'pass'
  COMMAND_TAKE_CARD  = 'card'
  COMMAND_OPEN_CARDS = 'open'

  attr_reader :name, :cards, :balance
  attr_reader :passed_the_move, :took_the_card, :opened_cards

  def initialize(name)
    @name = name
    @balance = INITIALIZE_BALANCE
    @cards = []
    @passed_the_move = false
    @took_the_card = false
    @opened_cards = false
  end

  def add_cards(cards)
    @cards.concat(cards) unless cards_limit_reached?
  end

  def clear_cards
    @cards = []
    @passed_the_move = false
    @took_the_card = false
    @opened_cards = false
  end

  def make_bet
    @balance -= BET_AMOUNT if @balance > 0
  end

  def take_money(amount)
    @balance += amount
  end

  def show_closed_cards
    @cards.each { printf('%4s', '*') }
    Output.print_double_new_line
  end

  def show_opened_cards
    @cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
    Output.print_double_new_line
  end

  def show_score
    puts "#{@name}'s scores: #{score}"
  end

  def show_balance
    puts "#{@name}'s balance: #{@balance}"
  end

  def pass_move
    Output.print_message_with_new_lines("#{@name} passed the move.")
    self.passed_the_move = true
  end

  def take_card(card)
    Output.print_message_with_new_lines("#{@name} took the card.")
    add_cards(card)
    self.took_the_card = true
  end

  def open_cards
    self.opened_cards = true
  end

  def win(bank)
    Output.print_message_with_new_lines("#{@name} win!")
    take_money(bank)
  end

  def cards_limit_reached?
    @cards.size == MAX_CARDS_COUNT
  end

  def ask_command
    puts "\nWhat do you want to do?"
    puts "Enter '#{COMMAND_PASS}' to pass the move." unless @passed_the_move
    puts "Enter '#{COMMAND_TAKE_CARD}' to get one card." unless @took_the_card
    puts "Enter '#{COMMAND_OPEN_CARDS}' to open cards."
  end

  def command
    command = gets.chomp
    fail unless valid_command?(command)
    command
  rescue
    puts 'You enter ivalid commad. Please try again.'
    retry
  end

  def valid_command?(command)
    [COMMAND_PASS, COMMAND_TAKE_CARD, COMMAND_OPEN_CARDS].include? command
  end

  protected

  attr_writer :passed_the_move, :took_the_card, :opened_cards

  def can_open_cards?(command)
    command == COMMAND_OPEN_CARDS
  end
end
