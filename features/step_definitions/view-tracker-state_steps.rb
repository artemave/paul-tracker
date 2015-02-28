Given(/^Sarah has set a tracker to 'track movement'$/) do
  @tracker_number = ENV.fetch('TEST_TRACKER_PHONE_NUMBER')
  @sarah = FactoryGirl.create :user
  @tracker = @sarah.trackers.create!(phone_number: @tracker_number, password: 'password')
  receive_sms_from_tracker(@tracker, 'move ok!')
end

When(/^she checks the list of her trackers$/) do
  login_as @sarah, scope: :user
  visit trackers_path
end

Then(/^she should see that the tracker is 'tracking movement'$/) do
  expect(page).to have_css ".icon-globe-alt.state-on"
end

Then(/^when she stop 'track movement'$/) do
  receive_sms_from_tracker(@tracker, 'nomove ok!')
end

Then(/^Sarah should see that the tracker is no longer 'tracking movement'$/) do
  visit current_path
  expect(page).to have_css ".icon-globe-alt.state-off"
end
