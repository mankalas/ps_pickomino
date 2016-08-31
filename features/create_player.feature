Feature: Create a new Player

  Scenario: User goes to the new player page
    Given The user is on the index page
    When he clicks on the new player button
    Then he is on the new player page

  Scenario Outline: User fills up the player info correctly
    Given The user is on the new player page
    When he fills up the player's name with <name>
    And he fills up the player's color with <color>
    And he clicks on the create new player button
    Then he is on the index page
    And he sees the player's name is <name>
    And he sees the player's color is <color>
    Examples:
    | name    | color   |
    | Vincent | #34b3eb |
    | Marc    | #fabecc |
    | Michael | #33b17c |
    | Seth    | #3f3f3f |
    | Neil    | #fae889 |

  Scenario Outline: User tries to create a player that already exists
    Given The user is on the new player page
    And A player named <name> already exists
    When he fills up the player's name with <name>
    And he fills up the player's color with <color>
    And he clicks on the create new player button
    Then he is on the new player page
    And an error about player already existing is shown
    Examples:
    | name   | color   |
    | Chiche | #123456 |
    | CaMeL  | #123456 |

  Scenario Outline: User tries to create a player with no name
    Given The user is on the new player page
    And he fills up the player's color with <color>
    And he clicks on the create new player button
    Then he is on the new player page
    And an error about player not having a name is shown
    Examples:
    | color   |
    | #fabecc |
