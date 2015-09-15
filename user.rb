class User
  BET = 10
  START_BALANCE = 100

  attr_reader :name, :cards, :balance

  def initialize(name)
    @name = name
    @balance = START_BALANCE
    @cards = []
  end

  def make_bet
    @balance -= BET
    BET
  end

  def take_cards(cards)
    @cards.concat(cards) if can_take_cards?
  end

  protected

  def can_take_cards?
    @cards.size < 3
  end
end
