class Deck
  def initialize()
    @cards = generate_cards
  end

  def shuffle
    @cards.shuffle!
  end

  def deal_cards(count)
    @cards.sample(count).each { |value| @cards.delete(value) }
  end

  private

  def generate_cards
    cards = []
    suits = ['♥', '♣', '♦', '♠']
    values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    suits.each do |suit|
      values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle
  end
end
