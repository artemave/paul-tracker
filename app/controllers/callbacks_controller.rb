class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sms
    from = params.fetch('From', '')
    text = params.fetch('Body', '')

    if tracker = Tracker.where(phone_number: from).first
      if text =~ /move ok!/
        tracker.modes << :track_movement
      end

      if text =~ /move!/
        lat         = text[/lat:([^ ]+)/, 1]
        lng         = text[/long:([^ ]+)/, 1]
        speed       = text[/speed:([^ ]+)/, 1]
        reported_at = text[/T:([^ ]+ [^ ]+)/, 1]

        tracker.movements.create!(
          lat: lat, lng: lng, speed: speed, reported_at: Time.strptime(reported_at, "%D %H:%M")
        )
      end
    end

    head :ok
  end
end
