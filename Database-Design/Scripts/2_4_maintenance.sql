USE karto;

-- Maintenance
DROP TABLE IF EXISTS karto.maintenance;

-- Create Table
CREATE TABLE maintenance
(
    maintenance_id  INT UNSIGNED        NOT NULL    AUTO_INCREMENT              COMMENT 'PK for Maintenance',
    car_vin         CHAR(17)            NOT NULL    REFERENCES karto.car(vin)   COMMENT 'Car Vehicle Identification Number',
    date            DATE                NOT NULL                                COMMENT 'Date of the Maintenance',
    receipt         MEDIUMBLOB                                                  COMMENT 'Image of the Receipt',
    mileage         MEDIUMINT UNSIGNED                                          COMMENT 'Mileage during the Maintenance',
    cost_usd_cents  INT UNSIGNED                                                COMMENT 'Cost of the Maintenance',

    PRIMARY KEY(maintenance_id)
)
COMMENT 'Maintenance';