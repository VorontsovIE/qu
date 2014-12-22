class UserAnswer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :answer
  validates :question, presence: true
  validates :user, presence: true
  validates :answer_text, presence: true, uniqueness: {scope: [:question, :user], case_sensitive: false} # case sensitive doesn't work in sqlite

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

  before_save :associate_to_question_answers

  def associate_to_question_answers
    self.answer = question.answers.where('LOWER("answers"."answer_text") = LOWER(?)', answer_text).first
    self.mark_score = answer ? answer.mark_score : 0.0
  end
end
