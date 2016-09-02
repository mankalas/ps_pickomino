Feature: Create a new Game

  Scenario: I create a brand new game
    Given I am on the index page
    And a user named "Vincent" exists
    When I click on the "New Game" link
    Then I see "Vincent"
    And I see the dominos
    And I see "Turn #1"
