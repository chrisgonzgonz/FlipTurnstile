- Quarter
  - name ['e.g. Winter']
  - start date
  - end date
  - has many swimmers

- Swimmer
  - Has many Attendances
  - Has many Quarters
  - Has a PaymentOption

- Attendance
  - belongs to Swimmer

- PaymentOption
  - belongs to a swimmer
  - belongs to a quarter
  - *[Unlimited, Student, 10-Swim Pack]
