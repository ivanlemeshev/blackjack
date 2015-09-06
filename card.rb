class Card
  SUIT_HEARTS   = '<3'
  SUIT_CLUBS    = '+'
  SUIT_DIAMONDS = '<>'
  SUIT_SPADES   = '^'

  VALUE_TWO   = '2'
  VALUE_THREE = '3'
  VALUE_FOUR  = '4'
  VALUE_FIVE  = '5'
  VALUE_SIX   = '6'
  VALUE_SEVEN = '7'
  VALUE_EIGHT = '8'
  VALUE_NINE  = '9'
  VALUE_TEN   = '10'
  VALEU_JACK  = 'J'
  VALUE_QUEEN = 'Q'
  VALUE_KING  = 'K'
  VALUE_ACE   = 'A'

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end
