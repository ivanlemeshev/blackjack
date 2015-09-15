module GameInput
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
    puts "\nWhat do you want to do?"
    puts "Enter 'p' to pass the move." unless user.passed_the_move
    puts "Enter 't' to get one card." unless user.took_the_card
    puts "Enter 'o' to open cards."
    command = prompt
    fail unless %w(p t o).include? command
    command
  rescue
    puts 'You enter the ivalid commad. Please try again.'
    retry
  end

  def confirm_open_cards
    Message.show('Press any key to open cards...')
    prompt
  end

  def confirm_start_new_game
    Message.show('Press any key to continue...')
    prompt
  end
end
