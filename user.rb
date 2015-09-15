class User
  INITIALIZE_BALANCE = 100

  attr_reader :name, :cards, :balance

  def initialize(name)
    @name = name
    @balance = INITIALIZE_BALANCE
    @cards = []
  end
end
