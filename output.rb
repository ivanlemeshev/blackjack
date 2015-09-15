module Output
  def show_message(message)
    print_new_line
    print_message(message)
    print_new_line
  end

  protected

  ADDITIONAL_CHAR_COUNT = 4

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
