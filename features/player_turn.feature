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

  If the dice score is large enough AND the player has picked at least
  one dice on the worm side ('W'), the player can decide to pick a
  domino whose value is less or equal to the dice score. The chosen
  domino must be either on the table AND available, or the last domino
  another player picked up.

  If the roll results in a situation where the player can't pick any
  dice, ie. all the values of the roll have already been taken, the
  turn is lost and the domino that has the highest value on the game
  is discarded.

  The turn ends when the player has chosen a domino or when he can't
  pick up dice anymore.

  Scenario: I begin a fresh new turn
    Given I am in a game
    Then I see a "Roll" button
    And I don't see "You've already picked"
    And I don't see "Your dice score is"
    And I don't see "Roll outcome:"
    And I don't see "I'd like to pick the"
    And I don't see a "Pick Dice" button
    And I don't see "I want to pick the domino"
    And I don't see a "Pick Domino" button

  Scenario: I roll the dice
    Given I am in a game
    When I click on the "Roll" button
    Then I don't see a "Roll" button
    And I don't see "You've already picked"
    And I don't see "Your dice score is 0."
    And I see "Roll outcome:"
    And I see "I'd like to pick the"
    And I see a "Pick Dice" button
    And I don't see "I want to pick the domino"
    And I don't see a "Pick Domino" button

  Scenario: I've rolled, and I can't choose any value
    Given I am in a game
    And I already have picked 5 1s
    And I have made a roll whose outcome is 111
    Then I see "Highest domino discarded."
    And I see image "Domino35"
    And I don't see image "Domino36"
    And I don't see a "Roll" button
    And I don't see "I'd like to pick the"
    And I don't see a "Pick Dice" button
    And I don't see "I want to pick the domino"
    And I don't see a "Pick Domino" button

  Scenario: I've pick all the dice
    Given I am in a game
    And I already have picked 4 4s
    And I already have picked 4 Ws
    Then I don't see a "Roll" button
    And I see "You've already picked"
    And I see "Your dice score is"
    And I don't see "Roll outcome:"
    And I don't see "I'd like to pick the"
    And I don't see a "Pick Dice" button
    And I see "I want to pick the domino"
    And I see a "Pick Domino" button

  Scenario Outline: I've rolled, and I choose a value to pick some dice. My score is too low to pick a domino.
    Given I am in a game
    And I have made a roll whose outcome is <outcome>
    When I select the "value" <value>
    And I click on the "Pick Dice" button
    Then I see "You've already picked"
    And I see <nb> '<value>'s
    And I see "Your dice score is <score>."
    And I see a "Roll" button
    And I don't see "I'd like to pick the"
    And I don't see a "Pick Dice" button
    And I don't see "I want to pick the domino"
    And I don't see a "Pick Domino" button
    Examples:
    |  outcome | value | nb | score |
    | 12345W12 |     W |  1 |     5 |
    | 12345144 |     4 |  3 |    12 |

  Scenario Outline: I've rolled, and I choose a value to pick some dice. My score is high enough to pick a domino.
    Given I am in a game
    And I have made a roll whose outcome is WWWWW123
    When I select the "value" W
    And I click on the "Pick Dice" button
    Then I see "Your dice score is 25."
    And I see a "Roll" button
    And I don't see "I'd like to pick the"
    And I don't see a "Pick Dice" button
    And I see "I want to pick the domino"
    And I see a "Pick Domino" button
    Examples:
    | outcome  | value | nb | score |
    | WWWWW123 | W     |  5 |    25 |

  Scenario: I've rolled a high score, but I've picked no worm so I can't pick a domino
    Given I am in a game
    And I already have picked 6 5s
    Then I don't see "I want to pick the domino"
    And I don't see a "Pick Domino" button

  Scenario: I've rolled a high score and I've picked some worms so I can pick a domino
    Given I am in a game
    And I already have picked 6 Ws
    When I select the "domino" 30
    And I click on the "Pick Domino" button
    Then I see "3 worms"
