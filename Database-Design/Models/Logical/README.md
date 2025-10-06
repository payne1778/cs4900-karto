# Logical Model

### User

User has,
- user_email (as a primary key)
- username
- hashed_password
- created_datetime

The user_email is used as a primary key to have a relation between car(s) and trusted gas stations.

### Car

Car has,
- car_vin (as a primary key)
- user_email
- make
- model
- year
- color
- initial mileage
- gas_type_id

car_vin is linked to a relation of one car to a maintenance history log.

gas_type_id is linked to gas_type which relates to gas_price to grab the correct type of gas for the car that is looking for gas to get correct prices.

### Gas Station

Gas station has,
- station_id
- longitude
- latitude
- name
- address_line
- city
- state
- zip

station_id is linked to gas_id to get correct gas prices then it is also linked to trusted_gas_station for sorting later to get preferred gas stations.

### Maintenance

Maintenance has,
- maintenance_id
- car_vin
- maintenance_date
- mileage
- cost

maintaince_id is linked to a recipt blob and item detail which has the quantity and comments tag with a sub description attached to it.
