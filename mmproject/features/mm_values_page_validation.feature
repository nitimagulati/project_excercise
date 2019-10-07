Feature: mm values page validation

  Scenario: validates right count of values appear on screen
    Given a user goes to values page
    When values page loads
    Then right count of values labels and text boxes display on screen

  Scenario: validates total balance is correct based on one values entered
    Given a user goes to values page
    When user enters values in first text field on right top
    Then Total balance should be same as of value of first text field value

  Scenario: validates total balance is correct based on three values entered
    Given a user goes to values page
    When user enters values in first, third and fifth of text fields on right top
    Then Total balance should be sum of all of first, third and fifth text boxes values

  Scenario: validates total balance is correct based on listed value
    Given a user goes to values page
    When user enters values in all of text fields on right top
    Then Total balance should be same as listed value

  Scenario: validates value on the screen are greater than 0
    Given a user goes to values page
    When user enters values in all of text fields on right top
    Then value on the screen should be greater than 0

  Scenario: validates value on the screen are formatted as currency
    Given a user goes to values page
    When user enters values in all of text fields on right top
    Then value on the screen should be formatted as currency

  Scenario: validates total balance matches sum of the values
    Given a user goes to values page
    When user enters values in all of text fields on right top
    Then Total balance should be sum of all of text boxes values

