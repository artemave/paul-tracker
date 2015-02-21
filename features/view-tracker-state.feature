Feature: view tracker state
  In order to understand what tracker is up to
  I need to see its current state

  Scenario: view tracker state in trackers index
    Given Sarah has set a tracker to 'track movement'
    When she checks the list of her trackers
    Then she should see that the tracker is 'tracking movement'
    And when she stop 'track movement'
    Then Sarah should see that the tracker is no longer 'tracking movement'
