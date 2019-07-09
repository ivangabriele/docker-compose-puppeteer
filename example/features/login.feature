Feature: Homepage
  As an anonymous user
  I want to see the homepage content

  Scenario: Successfully login as an administrator
    When I open the homepage
    Then I should see the title "Hello Docker!"
