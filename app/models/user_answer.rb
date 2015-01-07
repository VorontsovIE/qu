class UserAnswer < ActiveRecord::Base
  include Normalizable

  belongs_to :question
  belongs_to :user
  belongs_to :answer
  validates :question, presence: true
  validates :user, presence: true
  validates :normalized_answer, presence: true, uniqueness: {scope: [:question, :user], case_sensitive: false} # case sensitive doesn't work in sqlite

  scope :by_user, ->(user){ where(user: user) }
  scope :by_question, ->(question){ where(question: question) }

  scope :incorrect, ->{ where(answer_id: nil) }
  scope :correct, ->{ where.not(answer_id: nil) }

  def correct?
    !!answer
  end

  def best_answer_in_group?
    answer && answer.best_answer_in_group?
  end

  def answer_group
    answer && answer.answer_group
  end

  def answer_text=(value)
    write_attribute(:answer_text, value)
    write_attribute(:normalized_answer, self.class.normalize_answer(value))
  end

  before_save :associate_to_question_answers

  def associate_to_question_answers
    self.answer = question.answers.where('LOWER("answers"."normalized_answer") = LOWER(?)', normalized_answer).first
    self.mark_score = answer ? answer.mark_score : 0.0
  end
end
