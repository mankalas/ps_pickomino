Feature: Edit a player

  Scenario Outline: The user edits an existing player
    Given A player <id> exists
    And the user is on the index page
    When he clicks on the edit player button
    Then he is on the edit player <id> page
    Examples:
    | id |
    |  1 |

  Scenario Outline: The user change the player's name
    Given A player <id> exists whose name is <name>
    And the user is on the edit player <id> page
    When he changes the player's name to <new_name>
    And he clicks on the update player button
    Then he is on the index page
    And he sees the player's name is <new_name>
    Examples:
    | id | name    | new_name  |
    |  1 | John    | Jean      |

  Scenario Outline: The user change the player's name to an already existing one
    Given A player exists and his name is <other_name>
    And a player <id> exists whose name is <name>
    And the user is on the edit player <id> page
    When he changes the player's name to <other_name>
    And he clicks on the update player button
    Then he is on the edit player <id> page
    And an error about player already existing is shown
    Examples:
    | id | name    | other_name |
    | 42 | Vincent | Olivier    |
