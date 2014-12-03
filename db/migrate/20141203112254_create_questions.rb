class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :game, index: true
      t.text :question_text

      t.timestamps
    end
  end
end
