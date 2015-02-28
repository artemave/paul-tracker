class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sms
    from = params.fetch('From', '')
    text = params.fetch('Body', '')

    if tracker = Tracker.where(phone_number: from).first
      case text
      when /^move ok!/
        tracker.modes << :track_movement
        tracker.save!
      when /^move!/
        lat         = text[/lat:([^ ]+)/, 1]
        lng         = text[/long:([^ ]+)/, 1]
        speed       = text[/speed:([^ ]+)/, 1]
        reported_at = text[/T:([^ ]+ [^ ]+)/, 1]

        tracker.movements.create!(
          lat: lat, lng: lng, speed: speed, reported_at: Time.strptime(reported_at, "%D %H:%M")
        )
      when /^nomove ok!/
        tracker.modes.delete :track_movement
        tracker.save!
      end
    end

    head :ok
  end
end
