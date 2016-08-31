Feature: Edit a user

  Scenario Outline: The user edits an existing user
    Given A user <id> exists
    And the user is on the index page
    When he clicks on the edit user button
    Then he is on the edit user <id> page
    Examples:
    | id |
    |  1 |

  Scenario Outline: The user change the user's name
    Given A user <id> exists whose name is <name>
    And the user is on the edit user <id> page
    When he changes the user's name to <new_name>
    And he clicks on the update user button
    Then he is on the index page
    And he sees the user's name is <new_name>
    Examples:
    | id | name    | new_name  |
    |  1 | John    | Jean      |

  Scenario Outline: The user change the user's name to an already existing one
    Given A user exists and his name is <other_name>
    And a user <id> exists whose name is <name>
    And the user is on the edit user <id> page
    When he changes the user's name to <other_name>
    And he clicks on the update user button
    Then he is on the edit user <id> page
    And an error about user already existing is shown
    Examples:
    | id | name    | other_name |
    | 42 | Vincent | Olivier    |
