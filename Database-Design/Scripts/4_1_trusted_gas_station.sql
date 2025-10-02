USE karto;

-- User
DROP TABLE IF EXISTS karto.trusted_gas_station;

-- Create Table
CREATE TABLE trusted_gas_station (
  user_email    VARCHAR(255)  NOT NULL  COMMENT 'User Email',
  station_id   INT UNSIGNED  NOT NULL  COMMENT 'Gas Station',
  
  PRIMARY KEY (user_email, station_id)
);

-- References and Foreign Keys
ALTER TABLE trusted_gas_station 
    ADD FOREIGN KEY (user_email) 
    REFERENCES user (user_email)
;

ALTER TABLE trusted_gas_station 
    ADD FOREIGN KEY (station_id) 
    REFERENCES gas_station (station_id)
;
