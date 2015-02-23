module Helpers
  def capybara_host_and_port
    "%s:%s" % [Capybara.current_session.server.host, Capybara.current_session.server.port]
  end

  def assert_tracker_is_sent text
    soon do
      m = twilio.messages.list.find {|mm| mm.from == Rails.application.secrets.app_phone_number }
      expect(m.body).to eq text
    end
  end

  def receive_sms_from_tracker(tracker, text)
    if Capybara.current_driver == :selenium
      RestClient.post (capybara_host_and_port + sms_callback_path),
        {'From' => tracker.phone_number, 'Body' => text}
    else
      post sms_callback_path,
        {'From' => tracker.phone_number, 'Body' => text}
    end
  end

  def twilio
    TrackerAPI.twilio
  end
end

World Helpers
