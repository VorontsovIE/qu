class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.references :question, index: true
      t.references :user, index: true
      t.decimal :mark, precision: 7, scale: 2

      t.timestamps
    end
  end
end
