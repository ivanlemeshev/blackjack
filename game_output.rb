module GameOutput
  protected

  ADDITIONAL_CHAR_COUNT = 4

  def show_message(message)
    print_new_line
    print_message(message)
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

  def print_message(message)
    length = message.length
    line = '=' * (length + ADDITIONAL_CHAR_COUNT)
    puts line
    puts "| #{message} |"
    puts line
  end

  def print_new_line
    print "\n"
  end
end
