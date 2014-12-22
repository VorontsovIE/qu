class Game < ActiveRecord::Base
  has_many :questions, -> { order("position ASC") }, inverse_of: :game

  def started?
    Time.now >= start
  end

  def finished?
    Time.now > finish
  end

  def in_play?
    started? && ! finished?
  end

  def max_score
    questions.map{|question| question.max_score }.inject(0, &:+)
  end

  def total_score(user)
    questions.map{|question| question.total_score(user) }.inject(0, &:+)
  end
end
