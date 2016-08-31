Given(/^(?:t|T)he user is on the index page$/) do
  visit root_path
end

When(/^he clicks on the new player button$/) do
  click_link 'New Player'
end

Then(/^he is on the new player page$/) do
  expect(current_path).to eq new_player_path
end

Given(/^The user is on the new player page$/) do
  visit new_player_path
end

When(/^he fills up the player's name with (\w+)$/) do |name|
  fill_in 'Name', with: name
end

When(/^he fills up the player's color with (\#\h{6})$/) do |color|
  fill_in 'Color', with: color
end

When(/^he clicks on the create new player button$/) do
  click_button 'Create Player'
end

Then(/^he is on the index page$/) do
  expect(current_path).to eq root_path
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

Then(/^an error about player already existing is shown$/) do
  expect(page.text).to have_content("has already been taken")
end

Then(/^an error about player not having a name is shown$/) do
  expect(page).to have_content("can't be blank")
end

When(/^he clicks on the new game button$/) do
  click_link 'New Game'
end

Then(/^he is on the new game page$/) do
  expect(current_path).to eq game_path(Game.last)
end

Given(/^A player (\d+) exists$/) do |id|
  Player.new(id: id, name: "Chiche", color: "#fabecc").save!
end

When(/^he clicks on the edit player button$/) do
  click_link 'Edit'
end

Given(/^the user is on the edit player (\d+) page$/) do |id|
  visit edit_player_path(Player.find(id))
end

Then(/^he is on the edit player (\d+) page$/) do |id|
  expect(current_path).to eq edit_player_path(Player.find(id))
end

Given(/^(?:a|A) player (\d+) exists whose name is (\w+)$/) do |id, name|
  Player.new(id: id, name: name, color: "#fabecc").save!
end

When(/^he changes the player's name to (\w+)$/) do |new_name|
  fill_in 'Name', with: new_name
end

When(/^he clicks on the update player button$/) do
  click_button 'Update Player'
end

Given(/^A player exists and his name is (\w+)$/) do |name|
  Player.new(name: name).save!
end

When(/^he clicks on the delete player button$/) do
  click_link 'Delete'
end

Then(/^the player (\d+) doesn't exist anymore$/) do |id|
  expect(Player.find_by(id: id)).to be nil
end

When(/^he clicks on the quit button$/) do
  click_link 'Quit'
end

Given(/^A game (\d+) exists$/) do |id|
  Game.new(id: id).save!
end

Given(/^(?:t|T)he user is on the game (\d+) page$/) do |id|
  visit game_path(Game.find(id))
end
