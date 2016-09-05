Feature: Make a roll

  Scenario: Once in a game, I make a roll and I can see the dice
    Given A game "1" exists
    And I am on the game "1" page
    When I click on the "Roll" link
    Then I see "Roll outcome:"
