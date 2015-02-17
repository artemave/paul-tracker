Given(/^Sheldon has a tracker$/) do
  @sheldon = FactoryGirl.create :user
  @sheldon.trackers.create!(phone_number: 88888888, password: 'password')
end

When(/^he turns on tracker's "track movement"$/) do
  login_as @sheldon, scope: :user
  pending
end

When(/^he sends the tracker via post to his office$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^Sheldon can see how the parcel traveled from his home to his office$/) do
  pending # express the regexp above with the code you wish you had
end
