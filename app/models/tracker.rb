class Tracker < ActiveRecord::Base
  bitmask :modes, as: %i{track_movement}, null: false
end
