class User
  attr_reader :name, :cards, :balance
  attr_reader :passed_the_move, :took_the_card, :opened_cards

  def initialize(name)
    @name = name
    @balance = START_BALANCE
    @cards = []
    @passed_the_move = false
    @took_the_card = false
    @opened_cards = false
  end

  def make_bet
    @balance -= BET_AMOUNT
    BET_AMOUNT
  end

  def take_money(amount)
    @balance += amount
  end

  def take_cards(cards)
    @cards.concat(cards) if can_take_cards?
  end

  def show_cards_back
    @cards.each { printf('%4s', '*') }
    Message.double_new_line
  end

  def show_cards_face
    @cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
    Message.double_new_line
  end

  def show_balance
    puts "#{@name}'s balance: #{@balance}"
  end

  def cards_limit_reached?
    @cards.size == MAX_CARDS_COUNT
  end

  def win(bank)
    Message.show("#{@name} win!")
    take_money(bank)
  end

  def clear_cards
    @cards = []
    @passed_the_move = false
    @took_the_card = false
    @opened_cards = false
  end

  protected

  BET_AMOUNT = 10
  START_BALANCE = 100
  MAX_CARDS_COUNT = 3

  attr_writer :passed_the_move, :took_the_card, :opened_cards

  def pass_move
    Message.show("#{name} pass the move.")
    self.passed_the_move = true
  end

  def take_card(card)
    Message.show("#{name} take a card.")
    take_cards(card)
    self.took_the_card = true
  end

  def open_cards
    Message.show("#{name} want to open cards.")
    self.opened_cards = true
  end

  def can_take_cards?
    @cards.size < 3
  end

  def can_open_cards?(command)
    command == 'o'
  end
end
