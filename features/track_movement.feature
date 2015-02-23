@vcr
Feature: track movement
  In order to draw funny pictures on the map
  I need to see gps trail of the tracker on the map

  @javascript
  Scenario: turn on 'track movement'
    Given Sheldon has a tracker
    When he turns on tracker's "track movement"
    And he sends the tracker via post to his office
    Then Sheldon can see how the parcel traveled from his home to his office

  Scenario: turn off 'track movement'
    Given Sarah has set a tracker to 'track movement'
    When she turns off 'track movement'
    Then the tracker stops tracking movement
    And she is able to turn it back on
