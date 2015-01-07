class AddNormalizedAnswerToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :normalized_answer, :string
  end
end
