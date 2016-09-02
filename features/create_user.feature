Feature: Create a new User

  Scenario: User goes to the new user page
    Given I am on the index page
    When I click on the "New User" link
    Then I see "Here comes a new challenger!"

  Scenario: User fills up the user info correctly
    Given I am on the new user page
    When I fill up "Name" with "Vincent"
    And I fill up "Color" with "#fabecc"
    And I click on the "Create User" button
    Then I am on the index page
    And I see "Vincent"
    And I see "#fabecc"

  Scenario: A user already exists
    Given A user named "Vincent" exists
    And I am on the index page
    Then I see "Vincent"

  Scenario: User tries to create a user that already exists
    Given A user named "Vincent" exists
    And I am on the new user page
    When I fill up "Name" with "Vincent"
    And I fill up "Color" with "#fabecc"
    And I click on the "Create User" button
    And I see "has already been taken"

  Scenario: User tries to create a user with no name
    Given I am on the new user page
    And I fill up "Color" with "#fabecc"
    And I click on the "Create User" button
    Then I see "can't be blank"
