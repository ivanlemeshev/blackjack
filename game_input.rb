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
end
