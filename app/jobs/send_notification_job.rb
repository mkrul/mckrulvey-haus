class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(notification_id)
    notification = Notification.find_by(id: notification_id)
    return unless notification
    return if notification.sent_at.present?

    phone_number = notification.phone_number
    return unless phone_number.active?

    task = notification.scheduled_task

    sms = SmsService.new
    sms.send_message(
      to: phone_number.number,
      body: build_message(task)
    )

    notification.mark_sent!
  rescue SmsService::DeliveryError => e
    Rails.logger.error "Failed to send notification #{notification_id}: #{e.message}"
    notification.mark_failed!
  end

  private

  def build_message(task)
    message = "🏡 Reminder: #{task.title}"
    message += "\n\n#{task.description}" if task.description.present?
    message += "\n\nDue: #{task.due_at.strftime('%b %d at %l:%M %p')}"
    message
  end
end

