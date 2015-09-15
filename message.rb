class Message
  ADDITIONAL_CHAR_COUNT = 4

  def self.show(message)
    puts
    print_message(message)
    puts
  end

  def self.new_line
    puts
  end

  def self.double_new_line
    new_line
    new_line
  end

  def self.print_message(message)
    length = message.length
    line = '=' * (length + ADDITIONAL_CHAR_COUNT)
    puts line
    puts "| #{message} |"
    puts line
  end
end
