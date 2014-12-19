class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question, index: true
      t.string :answer_text
      t.decimal :mark_score, precision: 7, scale: 2
      t.integer :answer_group, default: 1

      t.timestamps
    end
  end
end
