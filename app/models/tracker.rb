class Tracker < ActiveRecord::Base
  bitmask :modes, as: %i{track_movement}, null: false

  has_many :movements

  def tracking_movement?
    modes? :track_movement
  end
end
