class AddAnswerToUserAnswers < ActiveRecord::Migration
  def change
    change_table :user_answers do |t|
      t.string :answer_text, null: false, default: ''
      t.references :answer, index: true
      t.remove :mark
      t.decimal :mark_score, precision: 7, scale: 2,  default: 0
    end
  end
end
