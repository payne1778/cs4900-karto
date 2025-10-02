USE karto;

DROP TABLE IF EXISTS karto.gas_price;

CREATE TABLE gas_price 
(
  station_id       INT UNSIGNED             NOT NULL    COMMENT 'Station Unique ID',
  gas_type_id      SMALLINT UNSIGNED        NOT NULL    COMMENT 'Gas Type',
  price_per_gallon DECIMAL(7, 4) UNSIGNED   NOT NULL    COMMENT 'Price per gallon of GAS',
  last_updated     DATETIME                 NOT NULL DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Updated Time',

  PRIMARY KEY (station_id, gas_type_id)
)
COMMENT 'Gas Price';

ALTER TABLE gas_price 
  ADD FOREIGN KEY (station_id) 
  REFERENCES gas_station (station_id)
;

ALTER TABLE gas_price 
  ADD FOREIGN KEY (gas_type_id) 
  REFERENCES gas_type (gas_type_id)
;
