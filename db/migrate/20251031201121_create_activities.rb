class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.references :task, null: false, foreign_key: true
      t.text :text
      t.datetime :timestamp

      t.timestamps
    end
  end
end
