USE karto;

-- Maintenance Receipt
DROP TABLE IF EXISTS karto.car_image;

-- Create Table
CREATE TABLE car_image (
    car_vin     CHAR(17)        NOT NULL    COMMENT 'Car Image PK',
    car_image   MEDIUMBLOB      NOT NULL    COMMENT 'Image of the Car',
    PRIMARY KEY (car_vin)
)
COMMENT "Image of the Car";

ALTER TABLE car_image
    ADD CONSTRAINT car_image_car_vin_fk
    FOREIGN KEY (car_vin)
    REFERENCES karto.car(car_vin);
