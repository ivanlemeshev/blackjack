module GameOutput
  protected

  def greeting
    Message.show('WELCOME TO BLACKJACK GAME!')
  end

  def game_over
    Message.show('GAME OVER!')
    exit
  end

  def show_commands
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
