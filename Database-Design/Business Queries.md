# Business Queries

## Combined Maintenance Costs for All Cars

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
	u.user_email = "alice.smith@example.test"
```

## Maintenance Costs on Each Car

```sql
SELECT
	SUM(m.cost),
	m.car_vin
FROM
	car c
JOIN maintenance m ON
	m.car_vin = c.car_vin
GROUP BY c.car_vin
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
  user_email = "jack.black@example.test"
```

## Fetch All Trusted Gas Stations

```sql
SELECT
	gs.name,
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
	u.user_email = "carla89@example.test
```

## Cheapest Trusted Gas Stations

```sql
SELECT
	gs.name,
	gs.longitude,
	gs.latitude,
	gs.address_line,
	gs.city,
	gs.state,
	gs.zip_code,
	gp.price_per_gallon,
	gt.name
FROM
	trusted_gas_station tgs
JOIN gas_station gs ON
	gs.station_id = tgs.station_id
JOIN gas_price gp ON
	gp.station_id = gs.station_id
JOIN gas_type gt ON
	gt.gas_type_id = gp.gas_type_id
WHERE
	tgs.user_email = "emma.w@example.test"
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
    usr.user_email = "hector9@example.test"
```

## Get Details on Specific Maintenance

```sql
SELECT
	mtd.name,
	mid.comments,
	mr.receipt_image,
	c.year,
    c.make,
    c.model,
    m.car_vin,
	m.maintenance_datetime,
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
JOIN car c
	ON m.car_vin = c.car_vin
WHERE
    m.car_vin = 'WAUEFAFL7GN901234'
ORDER BY m.maintenance_datetime DESC, mtd.name
```
