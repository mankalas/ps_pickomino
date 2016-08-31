Feature: Create a new User

  Scenario: User goes to the new user page
    Given The user is on the index page
    When he clicks on the new user button
    Then he is on the new user page

  Scenario Outline: User fills up the user info correctly
    Given The user is on the new user page
    When he fills up the user's name with <name>
    And he fills up the user's color with <color>
    And he clicks on the create new user button
    Then he is on the index page
    And he sees the user's name is <name>
    And he sees the user's color is <color>
    Examples:
    | name    | color   |
    | Vincent | #34b3eb |
    | Marc    | #fabecc |
    | Michael | #33b17c |
    | Seth    | #3f3f3f |
    | Neil    | #fae889 |

  Scenario Outline: User tries to create a user that already exists
    Given The user is on the new user page
    And A user named <name> already exists
    When he fills up the user's name with <name>
    And he fills up the user's color with <color>
    And he clicks on the create new user button
    Then he is on the new user page
    And an error about user already existing is shown
    Examples:
    | name   | color   |
    | Chiche | #123456 |
    | CaMeL  | #123456 |

  Scenario Outline: User tries to create a user with no name
    Given The user is on the new user page
    And he fills up the user's color with <color>
    And he clicks on the create new user button
    Then he is on the new user page
    And an error about user not having a name is shown
    Examples:
    | color   |
    | #fabecc |
