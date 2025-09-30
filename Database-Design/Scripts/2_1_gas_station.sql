USE karto;

DROP TABLE IF EXISTS karto.gas_station;

CREATE TABLE gas_station (
  station_id     INT UNSIGNED PRIMARY KEY NOT NULL
  ,longitude     DECIMAL(8,6)             NOT NULL
  ,latitude      DECIMAL(8,6)             NOT NULL
  ,name          VARCHAR(31)              NOT NULL
  ,address       VARCHAR(127)             NOT NULL
);
