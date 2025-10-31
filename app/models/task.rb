class Task < ApplicationRecord
  belongs_to :user
  has_many :task_transitions, dependent: :destroy
  has_many :work_sessions, dependent: :destroy
  has_many :activities, dependent: :destroy

  enum :status, { pending: "pending", in_progress: "in_progress", completed: "completed" }

  validates :name, presence: true
  validates :status, presence: true

  after_initialize :set_default_status, if: :new_record?
  after_update :log_status_transition, if: :saved_change_to_status? # ruby magic

  private

  def set_default_status
    self.status ||= "pending"
  end

  def log_status_transition
    task_transitions.create(
      from_status: status_before_last_save,
      to_status: status,
      transitioned_at: Time.current
    )
  end
end
