class CreateTaskTransitions < ActiveRecord::Migration[8.0]
  def change
    create_table :task_transitions do |t|
      t.references :task, null: false, foreign_key: true
      t.string :from_status
      t.string :to_status
      t.datetime :transitioned_at

      t.timestamps
    end
  end
end
