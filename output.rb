class Output
  def self.print_message(message)
    length = message.length
    line = '=' * (length + 4)
    puts line
    puts "| #{message} |"
    puts line
  end

  def self.print_message_with_new_lines(message)
    print_new_line
    print_message(message)
    print_new_line
  end

  def self.print_new_line
    print "\n"
  end

  def self.print_double_new_line
    print_new_line
    print_new_line
  end
end
