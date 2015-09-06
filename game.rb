class Game
  def self.init
    deck = self.generate_deck
    deck.shuffle
  end

  private

  def self.generate_deck
    cards = []
    Deck.new(cards)
  end
end
