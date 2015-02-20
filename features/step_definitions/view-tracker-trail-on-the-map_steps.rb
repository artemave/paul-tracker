Given(/^Sheldon has a tracker$/) do
  @tracker_number = ENV.fetch('TEST_TRACKER_PHONE_NUMBER')
  @sheldon = FactoryGirl.create :user
  @sheldon.trackers.create!(phone_number: @tracker_number, password: 'password')
end

When(/^he turns on tracker's "track movement"$/) do
  login_as @sheldon, scope: :user
  visit root_path
  click_link_or_button @tracker_number
  click_link_or_button 'Track Movement'

  RestClient.post (capybara_host_and_port + sms_callback_path),
    {'From' => @tracker_number, 'Body' => 'move ok!'}

end

When(/^he sends the tracker via post to his office$/) do
  RestClient.post (capybara_host_and_port + sms_callback_path),
    {'From' => @tracker_number, 'Body' => "move! \nlat:51.36162 long:-0.18200 speed:003.0 \r\nT:02/19/15 20:38 \r\n"}

  RestClient.post (capybara_host_and_port + sms_callback_path),
    {'From' => @tracker_number, 'Body' => "move! \nlat:51.36174 long:-0.18069 speed:000.8 \r\nT:02/19/15 20:43 \r\n"}
end

Then(/^Sheldon can see how the parcel traveled from his home to his office$/) do
  visit tracker_path @sheldon.trackers.first
  coordinates = page.evaluate_script %{ window.testCoordinates }
  expected_coordinates = @sheldon.trackers.first.movements.map do |m|
    [m.lat, m.lng]
  end

  expect(coordinates).to eq(expected_coordinates)
end
