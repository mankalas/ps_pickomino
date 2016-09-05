Given(/^I am on the index page$/) do
  visit root_path
end

Given(/^I am on the new user page$/) do
  visit new_user_path
end

Given(/^I am on the user "([^"]*)" edit page$/) do |name|
  visit edit_user_path(User.where(name: name).take)
end

Given(/^I am on the game "([^"]*)" page$/) do |id|
  visit game_path(Game.find(id))
end

Given(/^I have rolled the dice$/) do
  click_link 'Roll'
end

When(/^I click on the "([^"]*)" link$/) do |link|
  CreateDominosService.new.call if link == "New Game"
  click_link link
end

When(/^I click on the "([^"]*)" button$/) do |button|
  click_button button
end

When(/^I fill up "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end


Given(/^(?:A|a) user named "([^"]*)" exists$/) do |name|
  User.create!(name: name)
end

Given(/^A game "([^"]*)" exists$/) do |id|
  CreateDominosService.new.call
  game = Game.create!(id: id)
  SetupGame.new(game).call
end

Given(/^I am in a game$/) do
  step 'A game "1" exists'
  step 'I am on the game "1" page'
end


Then(/^I see "([^"]*)"$/) do |name|
  expect(page).to have_content(name)
end

Then(/^I don't see "([^"]*)"$/) do |name|
  expect(page).not_to have_content(name)
end

Then(/^I see a "([^"]*)" button$/) do |name|
  expect(find_button(name)).not_to be nil
end

Then(/^I see the dominos$/) do
  expect(page).to have_content("Dominos available: #{(21..36).to_a.join(', ')}")
end

Then(/^The "([^"]*)" dropdown has values ([^"]*)$/) do |dropdown, arg2|
  expect(page).to have_select(dropdown, :options => [arg2.split])
end

Given(/^I have made a roll whose outcome is ([^"]*)$/) do |outcome|
  game = Game.find(1)
  game.current_turn.rolls.create!(outcome: outcome)
  visit game_path(game)
end

When(/^I select (\w)$/) do |value|
  select(value, :from => "value")
end

Then(/^I see (\d+) '(\w)'s$/) do |nb, value|
  expect(page).to have_content("#{nb} '#{value}'s")
end
