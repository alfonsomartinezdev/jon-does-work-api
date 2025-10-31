class WorkSession < ApplicationRecord
  belongs_to :task

  validates :started_at, presence: true
  validates :ended_at, presence: true

  # Calculate and set duration before saving
  before_save :calculate_duration

  private

  def calculate_duration
    if started_at && ended_at
      self.duration = (ended_at - started_at).to_i
    end
  end
end
