Feature: Delete a user

  Scenario: The user deletes an existing user
    Given A user named "Vincent" exists
    And I am on the index page
    When I click on the "Delete" link
    Then I don't see "Vincent"
