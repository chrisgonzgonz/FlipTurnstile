#FlipTurnstile

###Schema

- Roster
  - end date
  - has many swimmers

- Swimmer
  - firstName
  - lastName
  - email
  - paymentOption
  - Has many Attendances
  - Has one Roster

- Attendance
  - practiceDate
  - belongs to Swimmer

----------

## Proposed New Schema: 

- Roster
  - endDate
  - has many Swimmers
  - has many Races

- Swimmer
  - firstName
  - lastName
  - email
  - paymentOption
  - has many Attendances
  - has one Roster
  - has many RaceTimes
  - had many Races

- Attendance
  - practiceDate
  - belongs to Swimmer
  - belongs to Roster -> delete rule cascade

- Race
  - date
  - has many Swimmers
  - has many RaceTimes

- RaceTime
  - date
  - lapTimes -> transient property
  - finishTime
  - belongs to Swimmer 
  - belongs to Race
