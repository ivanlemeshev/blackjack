class User
  attr_reader :name

  def initialize(name)
    @name = name
    @balance = 100
  end
end
