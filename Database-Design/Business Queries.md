# Business Queries

## Total Maintenance Costs

```sql
SELECT
	SUM(m.cost)
FROM
	user u
JOIN car c ON
	c.user_email = u.user_email
JOIN maintenance m ON
	m.car_vin = c.car_vin
WHERE
	u.user_email = "email"
```

## Maintenance Costs on a Car

```sql
SELECT
	SUM(m.cost)
FROM
	car c
JOIN maintenance m ON
	m.car_vin = c.car_vin
WHERE
	c.car_vin = "vin"
```

## Fetch All User's Cars

```sql
SELECT
  car_vin,
  make,
  model,
  year,
  color
FROM
  car
WHERE
  user_email = "example@example.com"
```

## Fetch All Trusted Gas Stations

```sql
SELECT
	gs.station_id,
	gs.longitude,
	gs.latitude,
	gs.address_line,
	gs.city,
	gs.state,
	gs.zip_code
FROM
	trusted_gas_station tgs
JOIN user u ON
	u.user_email = tgs.user_email
JOIN gas_station gs ON
	gs.station_id = tgs.station_id
WHERE
	u.user_email = "carla89@example.test"
```

## Cheapest Trusted Gas Stations

```sql
SELECT
	gs.station_id,
	gs.longitude,
	gs.latitude,
	gs.address_line,
	gs.city,
	gs.state,
	gs.zip_code,
	gp.price_per_gallon,
	gp.gas_type_id
FROM
	trusted_gas_station tgs
JOIN gas_station gs ON
	gs.station_id = tgs.station_id
JOIN gas_price gp ON
	gp.station_id = gs.station_id
WHERE
	tgs.user_email = "carla89@example.test"
	AND gp.gas_type_id = 2
ORDER BY
	gp.price_per_gallon ASC
```

## Get Basic User Info & Password

```sql
SELECT
    usr.user_email,
    usr.username,
    usr.hashed_password
FROM
    user usr
WHERE
    usr.user_email = "carla89@example.test"
```

## Get Details on Specific Maintenance

```sql
SELECT
	mid.comments,
	mtd.name,
	mr.receipt_image,
	m.car_vin,
	m.maintenance_date,
	m.mileage,
	m.cost
FROM
    maintenance m
JOIN maintenance_item_detail mid
	ON m.maintenance_id = mid.maintenance_id
JOIN maintenance_type_description mtd
	ON mid.maintenance_type_id = mtd.maintenance_type_id
LEFT JOIN maintenance_receipt mr
	ON m.maintenance_id = mr.maintenance_id
WHERE
    m.maintenance_id = 2
ORDER BY m.maintenance_date DESC, mtd.name;

```
