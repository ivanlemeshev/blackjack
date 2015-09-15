module CardScore
  WIN_SCORE = 21
  DEFAULT_VALUE = 10
  ACE_MIN_VALUE = 1
  ACE_MAX_VALUE = 11

  def score
    total_score = 0
    ace_count = 0
    @cards.each do |card|
      ace_count += 1 if card.value == 'A'
      total_score += get_card_score(card)
    end
    add_additional_ace_score(total_score, ace_count)
  end

  def win_score?
    score == WIN_SCORE
  end

  def score_difference
    (WIN_SCORE - score).abs
  end

  protected

  def get_card_score(card)
    if %w(J Q K).include? card.value
      DEFAULT_VALUE
    elsif card.value == 'A'
      ACE_MIN_VALUE
    else
      card.value.to_i
    end
  end

  def add_additional_ace_score(total_score, ace_count)
    ace_count.times do
      ace_score = ACE_MAX_VALUE - ACE_MIN_VALUE
      total_score += ace_score if total_score + ace_score <= WIN_SCORE + 5
    end
    total_score
  end
end
