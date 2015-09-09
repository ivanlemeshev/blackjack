class Deck
  CARD_SUITS = ['♡', '♧', '♢', '♤']
  CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize()
    @cards = generate_cards
  end

  def deal_cards(count)
    @cards.sample(count).each { |value| @cards.delete(value) }
  end

  private

  def generate_cards
    cards = []
    CARD_SUITS.each do |suit|
      CARD_VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle
  end
end
