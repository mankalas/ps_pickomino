Feature: Delete a player

  Scenario Outline: The user deletes an existing player
    Given A player <id> exists
    And the user is on the index page
    When he clicks on the delete player button
    Then he is on the index page
    And the player <id> doesn't exist anymore
    Examples:
    | id |
    |  1 |
