class AddNormalizedAnswerToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :normalized_answer, :string
  end
end
