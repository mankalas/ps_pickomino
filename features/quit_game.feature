Feature: Quit a new Game

  Scenario: I quit the current page
    Given A game "1" exists
    And I am on the game "1" page
    When I click on the "Quit" link
    Then I am on the index page
