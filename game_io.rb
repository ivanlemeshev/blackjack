module GameIO
  protected

  def prompt
    STDOUT.write '>> '
    gets.strip
  end

  def player_name
    puts 'Please enter your name.'
    name = prompt
    fail unless name != ''
    name
  rescue
    puts 'Name cannot be blank. Please try again.'
    retry
  end

  def command(user)
    ask_user_move(user)
    code = prompt
    exit_game if code == 'q'
    fail unless %w(p t o).include? code
    code
  rescue
    puts 'Command is invalid. Please try again.'
    retry
  end

  def ask_user_move(user)
    puts "\nWhat do you want to do?"
    puts "Enter 'p' to pass the move." unless user.passed_the_move
    puts "Enter 't' to get one card." unless user.took_the_card
    puts "Enter 'o' to open cards."
    puts "Enter 'q' to quit."
  end

  def confirm_open_cards
    Message.show('Press any key to open cards...')
    gets
  end

  def confirm_start_new_game
    Message.show('Press any key to continue...')
    gets
  end

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
