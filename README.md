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
