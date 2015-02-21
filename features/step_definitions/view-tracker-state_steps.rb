Given(/^Sarah has set a tracker to 'track movement'$/) do
  @tracker_number = ENV.fetch('TEST_TRACKER_PHONE_NUMBER')
  @sarah = FactoryGirl.create :user
  @tracker = @sarah.trackers.create!(phone_number: @tracker_number, password: 'password')
  @tracker.modes << :track_movement
  @tracker.save!
end

When(/^she checks the list of her trackers$/) do
  login_as @sarah, scope: :user
  visit trackers_path
end

Then(/^she should see that the tracker is 'tracking movement'$/) do
  expect(page).to have_css ".icon-globe-alt.state-on"
end

Then(/^when she stop 'track movement'$/) do
  @tracker.modes -= [:track_movement]
  @tracker.save!
end

Then(/^Sarah should see that the tracker is no longer 'tracking movement'$/) do
  visit current_path
  expect(page).to have_css ".icon-globe-alt.state-off"
end
