USE karto;

-- User
DROP TABLE IF EXISTS karto.trusted_gas_station;

-- Create Table
CREATE TABLE trusted_gas_station (
  user_email    VARCHAR(255)  NOT NULL  COMMENT 'User Email',
  gas_station   INT UNSIGNED  NOT NULL  COMMENT 'Gas Station',
  
  PRIMARY KEY (user, gas_station)
);

-- References and Foreign Keys
ALTER TABLE trusted_gas_station 
    ADD FOREIGN KEY (user) 
    REFERENCES user (user_email)
;

ALTER TABLE trusted_gas_station 
    ADD FOREIGN KEY (gas_station) 
    REFERENCES gas_station (station_id)
;
