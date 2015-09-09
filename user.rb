class User
  WIN_SCORE = 21
  BET_AMOUNT = 10
  DEFAULT_VALUE = 10
  ACE_MIN_VALUE = 1
  ACR_MAX_VALUE = 11
  INITIALIZE_BALANCE = 100

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

  def score
    score = 0

    self.cards.each do |card|
      if ['J', 'Q', 'K'].include? card.value
        value = DEFAULT_VALUE
      else
        value = card.value.to_i
      end
      score += value
    end

    self.cards.each do |card|
      if card.value == 'A' && score + ACE_MIN_VALUE > WIN_SCORE
        score += ACE_MIN_VALUE
      elsif card.value == 'A' && score + ACE_MIN_VALUE < WIN_SCORE
        score += ACR_MAX_VALUE
      end
    end

    score
  end

  def make_bet
    @balance -= BET_AMOUNT if @balance > 0
  end

  def take_money(amount)
    @balance += amount
  end
end
