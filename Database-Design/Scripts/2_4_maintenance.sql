USE karto;

-- Maintenance
DROP TABLE IF EXISTS karto.maintenance;

-- Create Table
CREATE TABLE maintenance
(
    maintenance_id          INT UNSIGNED            NOT NULL    AUTO_INCREMENT              COMMENT 'PK for Maintenance',
    car_vin                 CHAR(17)                NOT NULL                                COMMENT 'Car Vehicle Identification Number',
    maintenance_datetime    DATETIME                NOT NULL                                COMMENT 'DateTime of the Maintenance',
    mileage                 MEDIUMINT UNSIGNED                                              COMMENT 'Mileage during the Maintenance',
    cost                    DECIMAL(7, 4) UNSIGNED                                          COMMENT 'Cost of the Maintenance',

    PRIMARY KEY(maintenance_id)
)
COMMENT 'Maintenance';

-- Car Vin Foreign Key
ALTER TABLE maintenance
    ADD CONSTRAINT maintenance_car_vin_fk
    FOREIGN KEY (car_vin)
    REFERENCES karto.car(car_vin);
-- Uniqueness
ALTER TABLE maintenance
    ADD CONSTRAINT maintenance_car_vin_maintenance_datetime_unique
    UNIQUE (car_vin, maintenance_datetime);