class Task < ApplicationRecord
  belongs_to :user
  has_many :task_transitions, dependent: :destroy
  has_many :work_sessions, dependent: :destroy
  has_many :activities, dependent: :destroy

  enum :status, { pending: "pending", in_progress: "in_progress", completed: "completed" }

  validates :name, presence: true
  validates :status, presence: true

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= "pending"
  end
end
