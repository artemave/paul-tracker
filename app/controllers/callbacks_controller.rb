class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def sms
    from = params.fetch('From', '')
    text = params.fetch('Body', '')

    if tracker = Tracker.where(phone_number: from).first
      if text =~ /move ok!/
        tracker.modes << :track_movement
      end
    end

    head :ok
  end
end
