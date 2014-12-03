class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
