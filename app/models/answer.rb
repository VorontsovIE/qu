class Answer < ActiveRecord::Base
  belongs_to :question
  validates :question, presence: true
  validates :mark_score, presence: true, numericality: true
  validates :answer_text, presence: true, uniqueness: {scope: :question, case_sensitive: false} # case sensitive doesn't work in sqlite
end
