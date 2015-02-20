# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create!(email: 'test@test.com', password: 'password')
t = u.trackers.create!(phone_number: ENV.fetch("TEST_TRACKER_PHONE_NUMBER"), password: ENV.fetch("TEST_TRACKER_PASSWORD"))

[
  {lat: 51.36251, lng: -0.18429, speed: 5.4, reported_at: Time.strptime("02/19/15 20:33", "%D %H:%M")},
  {lat: 51.36162, lng: -0.18200, speed: 3.0, reported_at: Time.strptime("02/19/15 20:38", "%D %H:%M")},
  {lat: 51.36174, lng: -0.18069, speed: 0.8, reported_at: Time.strptime("02/19/15 20:43", "%D %H:%M")},
].each do |opts|
  t.movements.create!(opts)
end
