# Physical Model

### User

User has,
- user_email (used as primary key)
- username
- hashed_password
- created_datetime

User_email is a not null variable string of 256 characters used as a primary key to trusted gas stations and car.

username is a not null variable string of 31 characters used to destignguish a user.

hashed_password is a not null variable string of 127 characters used to login to the account.

Create_datetime is a datetime stamp that is not null used to organize users in a database.

### Gas Station

Gas Station has,
- station_id (used a primary key)
- longitude
- latitude
- name
- address_line
- city
- state
- zip

Station id is used as a primary key to be used as a relation to trusted gas stations and gas price. As one user can have many trusted gas stations. This also allows specific gas types to be fetched depending on the car that is being looked for.

Gas Price is a smaller table related to gas type which is signified by gas type id which to know what type of gas to look up for specific cars.

Gas Type is used as an identifier to be able to look up specific gas types per car as if one car takes 88 or another takes 93.

city is a variable string that is not null of 63

state is a variable string that is not null of 13

zip is a variable string that is not null of 18

### Car

Car has,
- car_vin (used as a primary key for maintenance)
- user_email (used to see if the car is owned by the user)
- make
- model
- year
- color
- initial mileage
- gas_type_id (used to distingiuish the type of gas)

Car vin is used to track maintenance logs per unique car as each car has a specific vin number. is a string character of 17 length and cannot be null.

gas type id is the various list of gas types that can be put in a car

### Maintenance

Maintenance has,
- maintanance_id
- car_vin
- maintenance_date
- mileage
- cost

maintenance date is a date from the calendar and cannot be null

mileage is a medium int that cannot be negative

cost is a decimal that cannot be negative and ranges of 7, 4

Maintenance Recipt holds maintenance id and is attached to maintenance by maintenance_id

 maintenance_item_detail has
 - quantity
 - comments

 quantity is of the amount done such as tires and is a tiny int that cannot be null or negative.

 comments is a variable string length of 255 that holds details of the repair.

 maintenance_type_description is attached to item detail that is of some medium int that cannot be negative or null that depecits what type of maintenance is done with a variable string length of 30 that also cannot be null.
