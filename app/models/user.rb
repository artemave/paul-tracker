class User < ActiveRecord::Base
  has_many :trackers
end
