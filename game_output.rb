module GameOutput
  protected

  def game_greeting
    Message.show('WELCOME TO BLACKJACK GAME!')
  end

  def player_greeting(name)
    Message.show("Hi, #{name}!")
  end

  def exit_game
    Message.show('GAME OVER! BYE!')
    exit
  end

  def start_new_game
    Message.show('Starting a new game.')
  end

  def drawn_game
    Message.show('Drawn game.')
  end

  def show_base_commands
    puts "Enter 'n' to start a new game."
    puts "Enter 'q' to quit."
  end

  def show_score(name, score)
    puts "#{name}'s scores: #{score}"
  end

  def show_bank(bank)
    puts "Bank: #{bank}"
  end
end
