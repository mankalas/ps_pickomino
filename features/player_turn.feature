Feature: A player's turn

  A turn starts with the player rolling 8 6-sided dices.

  On the dice, the '6' value is replaced by a worm (symbol 'W').

  Once a roll is done, the player choose a value and *must* pick all
  the dice of this value. He can't choose a value he had already chosen
  before. The dice picked up add up to the player's dice score.

  The dice score is simply the sum of the dice set aside ('W's count
  as 5).

  Once the dice are set aside, the player can choose to pick a domino
  or roll again to obtain a better dice score.

  If the dice score is large enough, the player can decide to pick a
  domino whose value is less or equal to the dice score. The chosen
  domino must be either on the table AND available, or the last domino
  another player picked up.

  The turn ends when the player has chosen a domino or when he can't
  pick up dice anymore, ie. all the values of the roll have already
  been taken.

  Scenario: I begin a fresh new turn
    Given I am in a game
    Then I see a "Roll" button
    And I don't see "Roll outcome:"

  Scenario: I roll the dice for the first time
    Given I am in a game
    When I click on the "Roll" button
    Then I see "Roll outcome:"

  Scenario Outline: I choose a value to pick some dice
    Given I am in a game
    And I have made a roll whose outcome is <outcome>
    When I select <value>
    And I click on the "Pick & Roll" button
    Then I see "You've already picked"
    And I see <nb> '<value>'s
    Examples:
    | outcome  | value | nb | score |
    | 12345W12 |     1 |  2 |     2 |
    | WWWWWWWW |     W |  8 |    40 |
    | 12345123 |     4 |  1 |     4 |