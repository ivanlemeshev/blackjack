class Dealer < User
  THINKING_TIME = 3
  PASS_SCORE = 18

  def process_move(deck)
    think
    if can_pass?
      pass_move
    elsif can_take_card?
      take_card(deck.deal_cards(TAKE_CARDS_COUNT))
    else
      open_cards
    end
  end

  protected

  def think
    Output.print_new_line
    Output.print_message("#{@name} is thinking...")
    sleep(THINKING_TIME)
  end

  def can_pass?
    score >= PASS_SCORE && !@passed_the_move
  end

  def can_take_card?
    !@took_the_card
  end
end
