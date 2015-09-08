class User
  attr_reader :name, :cards

  def initialize(name)
    @name = name
    @balance = 100
    @cards = []
  end

  def add_cards(cards)
    @cards.concat(cards)
  end

  def score
    score = 0
    @cards.each do |card|
      case card.value
      when 'J' then value = 11
      when 'Q' then value = 12
      when 'K' then value = 13
      when 'A' then value = 14
      else
        value = card.value.to_i
      end
      score += value
    end
    score
  end
end
