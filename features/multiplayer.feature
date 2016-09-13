Feature: Multiplayer games

  Several users can join the game and become players.

  There is no limit on the number of players (yet), but there should
  be at least one.

  The players play in turns, and when a player has finished his turn,
  whether by picking a domino or losing the turn, the next player can
  play.

  Scenario: I go to the new user page
    Given I am on the index page
    When I click on the "New User" link
    Then I see "Here comes a new challenger!"

  Scenario: I can see an already existing user
    Given A user named "Vincent" exists
    And I am on the index page
    Then I see "Vincent"

  Scenario: I create a new user with correct info
    Given I am on the new user page
    When I fill up "Name" with "Vincent"
    And I fill up "Color" with "#fabecc"
    And I click on the "Create User" button
    Then I am on the index page
    And I see "Vincent"
    And I see "#fabecc"

  Scenario: I try to create a user that already exists
    Given A user named "Vincent" exists
    And I am on the new user page
    When I fill up "Name" with "Vincent"
    And I fill up "Color" with "#fabecc"
    And I click on the "Create User" button
    And I see "has already been taken"

  Scenario: I try to create a user with no name
    Given I am on the new user page
    And I fill up "Color" with "#fabecc"
    And I click on the "Create User" button
    Then I see "can't be blank"

  Scenario: I delete a user
    Given A user named "Vincent" exists
    And I am on the index page
    When I click on the "Delete" link
    Then I don't see "Vincent"

  Scenario: I edit an existing user
    Given A user named "Vincent" exists
    And I am on the index page
    When I click on the "Edit" link
    Then I see "Edit user Vincent"

  Scenario: I change the user's name
    Given A user named "Vincent" exists
    And I am on the user "Vincent" edit page
    When I fill up "Name" with "Maurice"
    And I click on the "Update User" button
    Then I see "Maurice"

  Scenario: I change the user's name to an already existing one
    Given A user named "Vincent" exists
    And a user named "Maurice" exists
    And I am on the user "Maurice" edit page
    When I fill up "Name" with "Vincent"
    And I click on the "Update User" button
    Then I see "has already been taken"
