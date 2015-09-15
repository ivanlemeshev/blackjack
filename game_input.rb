module GameInput
  protected

  def prompt
    STDOUT.write '>> '
    gets
  end
end
