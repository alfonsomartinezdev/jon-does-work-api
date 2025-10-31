class Activity < ApplicationRecord
  belongs_to :task

  validates :text, presence: true
  validates :timestamp, presence: true
end
