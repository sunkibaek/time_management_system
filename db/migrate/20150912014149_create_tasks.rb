class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.date :date
      t.integer :hour
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
