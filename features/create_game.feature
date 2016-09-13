Feature: Create a new Game

  Scenario: I create a game with two players
    Given I am on the index page
    And a user named "Vincent" exists
    And a user named "Maurice" exists
    When I click on the "New Game" link
    And I check "1"
    And I check "2"
    And I click on the "Create game" button
    Then I see "Game #"
    And I see "Vincent"
    And I see "Maurice"
