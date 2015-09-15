class Player < User
  def process_move(command, hand)
    if can_pass?(command)
      pass_move
    elsif can_take_card?(command)
      take_card(hand.deal_one_card)
    elsif can_open_cards?(command)
      open_cards
    end
  end

  protected

  def can_pass?(command)
    command == 'p' && !@passed_the_move
  end

  def can_take_card?(command)
    command == 't' && !@took_the_card
  end
end
