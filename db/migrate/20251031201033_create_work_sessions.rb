class CreateWorkSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :work_sessions do |t|
      t.references :task, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :duration

      t.timestamps
    end
  end
end
