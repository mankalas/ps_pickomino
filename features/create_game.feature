Feature: Create a new Game

  Scenario: I create a brand new game
    Given I am on the index page
    And a user "Vincent" exists
    When I click on the new game link
    Then I am on the new game page
    And I see "Vincent"
    And I see the dominos
