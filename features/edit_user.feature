Feature: Edit a user

  Scenario: I edit an existing user
    Given A user named "Vincent" exists
    And I am on the index page
    When I click on the "Edit" link
    Then I see "Edit user Vincent"

  Scenario: I change the user's name
    Given A user named "Vincent" exists
    And I am on the user "Vincent" edit page
    When I fill up "Name" with "Maurice"
    And I click on the "Update User" button
    Then I see "Maurice"

  Scenario: I change the user's name to an already existing one
    Given A user named "Vincent" exists
    And a user named "Maurice" exists
    And I am on the user "Maurice" edit page
    When I fill up "Name" with "Vincent"
    And I click on the "Update User" button
    Then I see "has already been taken"
