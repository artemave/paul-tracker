Given(/^Sheldon has a tracker$/) do
  tracker_number = ENV.fetch('TEST_TRACKER_PHONE_NUMBER')
  @sheldon = FactoryGirl.create :user
  @tracker = @sheldon.trackers.create!(phone_number: tracker_number, password: 'password')
end

When(/^he turns on tracker's "track movement"$/) do
  login_as @sheldon, scope: :user
  visit root_path
  click_link_or_button @tracker.phone_number
  click_link_or_button 'Track Movement'

  assert_tracker_is_sent "movepassword"

  receive_sms_from_tracker(@tracker, 'move ok!')
end

When(/^he sends the tracker via post to his office$/) do
  receive_sms_from_tracker(@tracker,
                           "move! \nlat:51.36162 long:-0.18200 speed:003.0 \r\nT:02/19/15 20:38 \r\n")

  receive_sms_from_tracker(@tracker,
                           "move! \nlat:51.36162 long:-0.18200 speed:003.0 \r\nT:02/19/15 20:38 \r\n")

  receive_sms_from_tracker(@tracker,
                           "move! \nlat:51.36174 long:-0.18069 speed:000.8 \r\nT:02/19/15 20:43 \r\n")
end

Then(/^Sheldon can see how the parcel traveled from his home to his office$/) do
  visit tracker_path @sheldon.trackers.first
  coordinates = page.evaluate_script %{ window.testCoordinates }
  expected_coordinates = @sheldon.trackers.first.movements.map do |m|
    [m.lat, m.lng]
  end

  expect(coordinates).to eq(expected_coordinates)
end

When(/^she turns off 'track movement'$/) do
  login_as @sarah, scope: :user
  visit root_path
  click_link_or_button @tracker_number
  click_link_or_button 'Stop Track Movement'
end

Then(/^the tracker stops tracking movement$/) do
  assert_tracker_is_sent "nomovepassword"
end

Then(/^she is able to turn it back on$/) do
  receive_sms_from_tracker(@tracker, 'nomove ok!')
  visit current_path
  expect(page).to have_selector(:link_or_button, 'Track Movement')
end
