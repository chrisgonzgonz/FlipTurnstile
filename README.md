- Quarter
  - name ['e.g. Winter']
  - start date
  - end date
  - has many Attendances

- Swimmer
  - firstName
  - lastName
  - email
  - Has many Attendances
  - Has one PaymentOption

- Attendance
  - currentDate
  - belongs to Swimmer
  - belogs to Quarter

- PaymentOption
  - belongs to a swimmer
  - *types: [Unlimited, Student, 10-Swim Pack]
