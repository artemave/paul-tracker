class TrackerAPI < Struct.new(:tracker)
  def track_movement on
    command = on ? "move" : "nomove"

    self.class.twilio.messages.create(
      to: tracker.phone_number,
      from: Rails.application.secrets.app_phone_number,
      body: "%s%s" % [command, tracker.password]
    )
  end

  def self.twilio
    @twilio ||= Twilio::REST::Client.new(
      Rails.application.secrets.twilio_account_sid,
      Rails.application.secrets.twilio_auth_token)
  end
end
