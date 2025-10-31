class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :status
      t.date :assigned_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
