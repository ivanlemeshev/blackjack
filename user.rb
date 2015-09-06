class User
  attr_reader :name

  def initialize(name)
    @name = name
    @balance = 100
    @cards = []
  end

  def add_cards(cards)
    @cards.concat(cards)
  end
end
