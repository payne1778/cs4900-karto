USE karto;

DROP TABLE IF EXISTS karto.gas_station;

CREATE TABLE gas_station (
  station_id        INT UNSIGNED     NOT NULL   AUTO_INCREMENT    COMMENT 'Station Id',
  longitude         DECIMAL(9,6)     NOT NULL                     COMMENT 'Longitude',
  latitude          DECIMAL(9,6)     NOT NULL                     COMMENT 'Latitude',
  name              VARCHAR(25)      NOT NULL                     COMMENT 'Name of Gas Station',
  address_line      VARCHAR(63)      NOT NULL                     COMMENT 'Address of Gas Station',
  city              VARCHAR(63)                                   COMMENT 'City',
  state             VARCHAR(31)                                   COMMENT 'State',
  zip_code          VARCHAR(10)                                   COMMENT 'Zip Code',

  PRIMARY KEY (station_id)
)
COMMENT 'Gas Station';