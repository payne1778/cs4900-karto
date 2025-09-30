USE karto;

-- Car
DROP TABLE IF EXISTS karto.car;

-- Create Table
CREATE TABLE car
(
    vin             CHAR(17)            NOT NULL        COMMENT 'PK for Car',
    user_email      VARCHAR(255)        NOT NULL        COMMENT 'FK to User Email',
    make            VARCHAR(31)         NOT NULL        COMMENT 'Car Make',
    model           VARCHAR(31)         NOT NULL        COMMENT 'Car Model',
    year            YEAR(4)             NOT NULL        COMMENT 'Car Year',
    color           VARCHAR(31)         NOT NULL        COMMENT 'Car Color',
    initial_mileage MEDIUMINT UNSIGNED  NOT NULL        COMMENT 'Initial Mileage of the Car',
    gas_type_id     SMALLINT UNSIGNED   NOT NULL        COMMENT 'FK to Gas Type ID',

    PRIMARY KEY(vin)
);

-- References and Foreign Keys
ALTER TABLE car
    ADD CONSTRAINT car_user_email_fk01
    FOREIGN KEY (user_email)
    REFERENCES user (email);

ALTER TABLE car
    ADD CONSTRAINT car_gas_type_id_fk01
    FOREIGN KEY (gas_type_id)
    REFERENCES gas_type (gas_id);

-- Unique VIN number
ALTER TABLE car
    ADD CONSTRAINT car_vin_uk01
    UNIQUE (vin);
