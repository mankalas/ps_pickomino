Feature: Create a new Game

  Scenario: I want to create a new game
    Given I am on the index page
    And a user named "Vincent" exists
    And a user named "Maurice" exists
    When I click on the "New Game" link
    Then I am on the new game page
    And I see "Vincent"
    And I see "Maurice"
    And I see a "Create game" button

  Scenario: I create a game with no player
    Given I am on the new game page
    When I click on the "Create game" button
    Then I see "At least one player is required"

  Scenario: I create a game with two players
    Given I am on the index page
    And a user named "Vincent" exists
    And a user named "Maurice" exists
    When I click on the "New Game" link
    And I check "Vincent"
    And I check "Maurice"
    And I click on the "Create game" button
    Then I see "Game #"
