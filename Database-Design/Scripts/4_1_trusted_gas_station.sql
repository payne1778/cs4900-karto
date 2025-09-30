USE karto;

-- User
DROP TABLE IF EXISTS karto.trusted_gas_station;

-- Create Table
CREATE TABLE trusted_gas_station (
  user          VARCHAR(255) NOT NULL,
  gas_station   INT UNSIGNED NOT NULL,
  
  PRIMARY KEY (user, gas_station)
);

ALTER TABLE trusted_gas_station 
    ADD FOREIGN KEY (user) 
    REFERENCES user (email)
;

ALTER TABLE trusted_gas_station 
    ADD FOREIGN KEY (gas_station) 
    REFERENCES gas_station (station_id)
;



