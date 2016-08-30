Given(/^The user is on the index page$/) do
  visit root_path
end

When(/^he clicks on the new player button$/) do
  click_link 'New player'
end

Then(/^he is on the new player page$/) do
  expect(current_path).to eq new_players_path
end

Given(/^The user is on the new player page$/) do
  visit new_players_path
end

When(/^he fills up the player's name with (\w+)$/) do |name|
  fill_in 'Name', with: name
end

When(/^he fills up the player's color with (\#\h{6})$/) do |color|
  fill_in 'Color', with: color
end

When(/^he clicks on the create new player button$/) do
  click_button 'Create player'
end

Then(/^he is on the index page$/) do
  expect(current_path).to eq welcome_index_path
end

Then(/^he sees the player's name is (\w+)$/) do |name|
  expect(page).to have_content(name)
end

Then(/^he sees the player's color is (\#\h{6})$/) do |color|
  expect(page).to have_content(color)
end

Given(/^A player named (\w+) already exists$/) do |name|
  Player.new(name: name).save!
end

Then(/^a error about player already existing is shown$/) do
  expect(page.text).to have_content("has already been taken")
end

Then(/^a error about player not having a name is shown$/) do
  expect(page).to have_content("can't be blank")
end
