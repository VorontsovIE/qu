class UserAnswer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :answer
  validates :question, presence: true
  validates :user, presence: true

  def correct?
    !!answer
  end

  before_save :find_associated_answer

private
  def find_associated_answer
    self.answer = question.answers.where('LOWER("answers"."answer_text") = LOWER(?)', answer_text).first
    self.mark_score = answer ? answer.mark_score : 0.0
  end
end
