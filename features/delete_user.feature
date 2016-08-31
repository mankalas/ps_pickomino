Feature: Delete a user

  Scenario Outline: The user deletes an existing user
    Given A user <id> exists
    And the user is on the index page
    When he clicks on the delete user button
    Then he is on the index page
    And the user <id> doesn't exist anymore
    Examples:
    | id |
    |  1 |
