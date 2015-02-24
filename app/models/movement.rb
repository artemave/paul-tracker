class Movement < ActiveRecord::Base
  scope :within_time_window, ->(opts) {
    reported_at = Movement.arel_table[:reported_at]

    where(
      reported_at.gt(opts[:time_window_start]).and(
        reported_at.lt(opts[:time_window_end]))
      )
  }
end
