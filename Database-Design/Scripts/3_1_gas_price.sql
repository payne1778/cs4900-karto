USE karto;

DROP TABLE IF EXISTS karto.gas_price;

CREATE TABLE gas_price 
(
   station_id      INT       UNSIGNED NOT NULL
  ,gas_type_id     SMALLINT  UNSIGNED NOT NULL
  ,price_usd_cents SMALLINT  UNSIGNED NOT NULL


  ,PRIMARY KEY (station_id, gas_type_id)
);

ALTER TABLE gas_price 
  ADD FOREIGN KEY (station_id) 
  REFERENCES gas_station (station_id)
;

ALTER TABLE gas_price 
  ADD FOREIGN KEY (gas_type_id) 
  REFERENCES gas_type (gas_type_id)
;
