USE karto;

-- Maintenance
DROP TABLE IF EXISTS karto.maintenance;

-- Create Table
CREATE TABLE maintenance
(
    maintenance_id  INT UNSIGNED            NOT NULL    AUTO_INCREMENT              COMMENT 'PK for Maintenance',
    car_vin         CHAR(17)                NOT NULL                                COMMENT 'Car Vehicle Identification Number',
    date            DATE                    NOT NULL                                COMMENT 'Date of the Maintenance',
    mileage         MEDIUMINT UNSIGNED                                              COMMENT 'Mileage during the Maintenance',
    cost            DECIMAL(7, 4) UNSIGNED                                          COMMENT 'Cost of the Maintenance',

    PRIMARY KEY(maintenance_id)
)
COMMENT 'Maintenance';

-- Car Vin Foreign Key
ALTER TABLE maintenance
    ADD CONSTRAINT maintenance_car_vin_fk
    FOREIGN KEY (car_vin)
    REFERENCES karto.car(vin);