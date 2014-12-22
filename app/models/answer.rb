class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :user_answers, inverse_of: :answer
  validates :question, presence: true
  validates :mark_score, presence: true, numericality: true
  validates :answer_text, presence: true, uniqueness: {scope: :question, case_sensitive: false} # case sensitive doesn't work in sqlite

  # scope :by_question, ->(question){ where(question: question) }

  after_save :update_user_answers
  after_destroy :update_user_answers

  def update_user_answers
    question.user_answers.each do |user_answer|
      user_answer.associate_to_question_answers
      user_answer.save!
    end
  end

  def best_mark_score_in_group
    Answer.where(question: question, answer_group: answer_group).order('mark_score DESC').limit(1).pluck(:mark_score).first
  end
  def best_answer_in_group?
    mark_score == best_mark_score_in_group
  end
end
