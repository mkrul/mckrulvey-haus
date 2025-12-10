class Notification < ApplicationRecord
  belongs_to :scheduled_task
  belongs_to :phone_number

  STATUSES = %w[pending sent failed].freeze

  validates :status, inclusion: { in: STATUSES }

  scope :pending, -> { where(status: "pending") }
  scope :sent, -> { where(status: "sent") }
  scope :failed, -> { where(status: "failed") }

  def mark_sent!
    update!(status: "sent", sent_at: Time.current)
  end

  def mark_failed!
    update!(status: "failed")
  end
end
