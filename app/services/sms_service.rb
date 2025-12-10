class SmsService
  class DeliveryError < StandardError; end

  def initialize
    @client = Twilio::REST::Client.new(
      ENV.fetch("TWILIO_ACCOUNT_SID"),
      ENV.fetch("TWILIO_AUTH_TOKEN")
    )
    @from_number = ENV.fetch("TWILIO_PHONE_NUMBER")
  end

  def send_message(to:, body:)
    return mock_send(to, body) if Rails.env.development? && ENV["TWILIO_ACCOUNT_SID"].blank?

    @client.messages.create(
      from: @from_number,
      to: to,
      body: body
    )
  rescue Twilio::REST::RestError => e
    raise DeliveryError, "Twilio error: #{e.message}"
  end

  private

  def mock_send(to, body)
    Rails.logger.info "[SMS Mock] To: #{to}, Body: #{body}"
    OpenStruct.new(sid: "mock_#{SecureRandom.hex(8)}", status: "sent")
  end
end

