class TaskTransition < ApplicationRecord
  belongs_to :task
  validates :from_status, presence: true
  validates :to_status, presence: true
  validates :transitioned_at, presence: true
end
