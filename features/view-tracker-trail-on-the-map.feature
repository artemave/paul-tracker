Feature: view tracker trail on the map
  In order to draw funny pictures on the map
  I need to see gps trail of the tracker on the map

  @javascript
  Scenario: view map on the site
    Given Sheldon has a tracker
    When he turns on tracker's "track movement"
    And he sends the tracker via post to his office
    Then Sheldon can see how the parcel traveled from his home to his office
