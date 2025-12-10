class ScheduledTask < ApplicationRecord
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :due_at, presence: true
  validates :notify_minutes_before, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  RECURRENCE_OPTIONS = %w[none daily weekly monthly].freeze

  validates :recurrence, inclusion: { in: RECURRENCE_OPTIONS }, allow_nil: true

  scope :pending, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :upcoming, -> { pending.where("due_at > ?", Time.current).order(:due_at) }
  scope :overdue, -> { pending.where("due_at < ?", Time.current).order(:due_at) }

  def notification_time
    due_at - notify_minutes_before.minutes
  end

  def completed?
    completed_at.present?
  end

  def mark_complete!
    update!(completed_at: Time.current)
  end

  def overdue?
    !completed? && due_at < Time.current
  end
end
