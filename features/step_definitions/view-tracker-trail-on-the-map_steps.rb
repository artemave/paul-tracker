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
  pending # express the regexp above with the code you wish you had
end

Then(/^Sheldon can see how the parcel traveled from his home to his office$/) do
  pending # express the regexp above with the code you wish you had
end
