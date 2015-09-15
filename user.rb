class User
  include CardScore

  INITIALIZE_BALANCE = 100
  BET_AMOUNT         = 10

  attr_reader :name, :cards, :balance

  def initialize(name)
    @name = name
    @balance = INITIALIZE_BALANCE
    @cards = []
  end

  def add_cards(cards)
    @cards.concat(cards)
  end

  def clear_cards
    @cards = []
  end

  def make_bet
    @balance -= BET_AMOUNT if @balance > 0
  end

  def take_money(amount)
    @balance += amount
  end
end
