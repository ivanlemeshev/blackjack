module GameOutput
  protected

  ADDITIONAL_CHAR_COUNT = 4

  def show_message(message)
    puts
    print_message(message)
    puts
  end

  def print_message(message)
    length = message.length
    line = '=' * (length + ADDITIONAL_CHAR_COUNT)
    puts line
    puts "| #{message} |"
    puts line
  end

  def print_new_line
    puts
  end

  def print_double_new_line
    print_new_line
    print_new_line
  end

  def greeting
    show_message('WELCOME TO BLACKJACK GAME!')
  end

  def game_over
    show_message('GAME OVER!')
    exit
  end

  def show_commands
    puts "Enter 'n' to start a new game."
    puts "Enter 'q' to quit."
  end

  def show_cards_back(cards)
    cards.each { printf('%4s', '*') }
    print_double_new_line
  end

  def show_cards_face(cards)
    cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
    print_double_new_line
  end

  def show_score(name, score)
    puts "#{name}'s scores: #{score}"
  end

  def show_balance(name, balance)
    puts "#{name}'s balance: #{balance}"
  end

  def show_bank(bank)
    puts "Bank: #{bank}"
  end
end
