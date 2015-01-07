class Question < ActiveRecord::Base
  belongs_to :game
  validates :position, uniqueness: {scope: :game}
  acts_as_list scope: :game
  has_many :answers, inverse_of: :question, dependent: :destroy
  has_many :user_answers, -> { order("created_at DESC") }, inverse_of: :question, dependent: :destroy

  has_many :pictures
  has_many :documents

  def new_answer_group_index
    (answers.map(&:answer_group).max || 0) + 1
  end

  def num_answers
    answers.map(&:answer_group).uniq.count
  end

  def each_answer_group(&block)
    answers.group_by(&:answer_group)
      .sort_by{|answer_group, answers| answer_group }
      .each(&block)
  end

  def each_correct_user_answer_group(&block)
    user_answers.correct.group_by(&:answer_group).sort_by{|answer_group_index, group_of_answers| group_of_answers.map(&:updated_at).max }.reverse.each(&block)
  end

  def total_score(user)
    UserAnswer.by_question(self).by_user(user).includes(:answer).correct.group_by(&:answer_group).map{|ans_gr_index, group_of_answers|
      group_of_answers.map(&:mark_score).max
    }.inject(0.0, &:+)
  end

  def max_score
    answers.group_by(&:answer_group).map{|ans_gr_index, group_of_answers|
      group_of_answers.map(&:mark_score).max
    }.inject(0.0, &:+)
  end
end
