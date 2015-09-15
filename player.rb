class Player < User
  def process_move(command, deck)
    if can_pass?(command)
      pass_move
    elsif can_take_card?(command)
      take_card(deck.deal_cards(TAKE_CARDS_COUNT))
    elsif can_open_cards?(command)
      open_cards
    end
  end

  protected

  def can_pass?(command)
    command == COMMAND_PASS && !@passed_the_move
  end

  def can_take_card?(command)
    command == COMMAND_TAKE_CARD && !@took_the_card
  end
end
