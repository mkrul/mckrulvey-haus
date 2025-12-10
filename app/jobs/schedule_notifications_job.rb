class ScheduleNotificationsJob < ApplicationJob
  queue_as :default

  def perform
    upcoming_tasks = ScheduledTask.pending.where(
      "due_at BETWEEN ? AND ?",
      Time.current,
      1.hour.from_now
    )

    active_phone_numbers = PhoneNumber.active

    upcoming_tasks.find_each do |task|
      notification_time = task.notification_time

      next if notification_time < Time.current

      active_phone_numbers.find_each do |phone|
        notification = Notification.find_or_create_by!(
          scheduled_task: task,
          phone_number: phone
        )

        next if notification.sent_at.present?

        SendNotificationJob.set(wait_until: notification_time).perform_later(notification.id)
      end
    end
  end
end

