class TrackerAPI < Struct.new(:tracker)
  def track_movement
    twilio.messages.create(
      to: tracker.phone_number,
      from: Rails.application.secrets.app_phone_number,
      body: "move #{tracker.password}"
    )
  end

  def twilio
    @twilio ||= Twilio::REST::Client.new(
      Rails.application.secrets.twilio_account_sid,
      Rails.application.secrets.twilio_auth_token)
  end
end
