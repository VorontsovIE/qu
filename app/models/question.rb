class Question < ActiveRecord::Base
  belongs_to :game
  acts_as_list scope: :game
  has_many :answers, inverse_of: :question, dependent: :destroy

  def new_answer_group_index
    (answers.map(&:answer_group).max || 0) + 1
  end

  def num_answers
    answers.map(&:answer_group).uniq.count
  end
end
