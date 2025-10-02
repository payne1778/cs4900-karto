USE karto;

-- Car
DROP TABLE IF EXISTS karto.car;

-- Create Table
CREATE TABLE car
(
    car_vin         CHAR(17)            NOT NULL        COMMENT 'PK for Car',
    user_email      VARCHAR(255)        NOT NULL        COMMENT 'FK to User Email',
    make            VARCHAR(20)         NOT NULL        COMMENT 'Car Make',
    model           VARCHAR(40)         NOT NULL        COMMENT 'Car Model',
    year            YEAR(4)             NOT NULL        COMMENT 'Car Year',
    color           VARCHAR(15)         NOT NULL        COMMENT 'Car Color',
    initial_mileage MEDIUMINT UNSIGNED  NOT NULL        COMMENT 'Initial Mileage of the Car',
    gas_type_id     SMALLINT UNSIGNED   NOT NULL        COMMENT 'FK to Gas Type ID',

    PRIMARY KEY(car_vin)
);

-- References and Foreign Keys
ALTER TABLE car
    ADD CONSTRAINT car_user_email_fk01
    FOREIGN KEY (user_email)
    REFERENCES user (user_email);

ALTER TABLE car
    ADD CONSTRAINT car_gas_type_id_fk01
    FOREIGN KEY (gas_type_id)
    REFERENCES gas_type (gas_type_id);

