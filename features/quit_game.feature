Feature: Quit a new Game

  Scenario Outline: User quit the current page
    Given A game <id> exists
    And the user is on the game <id> page
    When he clicks on the quit button
    Then he is on the index page
    Examples:
    | id |
    |  1 |
