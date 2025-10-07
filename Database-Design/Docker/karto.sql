CREATE DATABASE karto;

CREATE OR REPLACE ROLE karto_manager;

GRANT ALL PRIVILEGES ON karto.* TO karto_manager;

USE karto;

-- Maintenance Type -- 

DROP TABLE IF EXISTS karto.maintenance_type_description;

CREATE TABLE maintenance_type_description
(
    maintenance_type_id     MEDIUMINT UNSIGNED  NOT NULL    AUTO_INCREMENT  COMMENT 'PK for Maintenance Type',
    name                    VARCHAR(60)         NOT NULL    UNIQUE          COMMENT 'Name',

    PRIMARY KEY(maintenance_type_id)
)
COMMENT 'Maintenance Type';

-- Gas Type (Lookup Table) --

DROP TABLE IF EXISTS karto.gas_type;

CREATE TABLE gas_type
(
    gas_type_id     SMALLINT UNSIGNED   NOT NULL    AUTO_INCREMENT  COMMENT 'PK (Natural) for Gas Type, Gas Ratings (e.g., 87, 89, 91, 93)',
    name        VARCHAR(15)             NOT NULL                    COMMENT 'Gas Type Name',

    PRIMARY KEY (gas_type_id)
)
COMMENT 'Gas Type (Lookup Table)';

-- Gas Station --

DROP TABLE IF EXISTS karto.gas_station;

CREATE TABLE gas_station (
  station_id        INT UNSIGNED     NOT NULL   AUTO_INCREMENT    COMMENT 'Station Id',
  longitude         DECIMAL(9,6)     NOT NULL                     COMMENT 'Longitude',
  latitude          DECIMAL(9,6)     NOT NULL                     COMMENT 'Latitude',
  name              VARCHAR(25)      NOT NULL                     COMMENT 'Name of Gas Station',
  address_line      VARCHAR(63)      NOT NULL                     COMMENT 'Address of Gas Station',
  city              VARCHAR(63)      NOT NULL                     COMMENT 'City',
  state             VARCHAR(31)      NOT NULL                     COMMENT 'State',
  zip_code          VARCHAR(10)      NOT NULL                     COMMENT 'Zip Code',

  PRIMARY KEY (station_id)
)
COMMENT 'Gas Station';

-- User --

DROP TABLE IF EXISTS karto.user;

CREATE TABLE user (
  user_email        VARCHAR(255)    NOT NULL                                COMMENT 'User Email',
  username          VARCHAR(31)     NOT NULL                                COMMENT 'Username',
  hashed_password   VARCHAR(127)    NOT NULL                                COMMENT 'Hashed Password',
  created_datetime  DATETIME        NOT NULL    DEFAULT CURRENT_TIMESTAMP   COMMENT 'Time of User Creation', 

  PRIMARY KEY(user_email)
);

ALTER TABLE user
  ADD CONSTRAINT user_username_uk01
  UNIQUE (username)
;

-- Car --
DROP TABLE IF EXISTS karto.car;

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

ALTER TABLE car
    ADD CONSTRAINT car_user_email_fk01
    FOREIGN KEY (user_email)
    REFERENCES user (user_email);

ALTER TABLE car
    ADD CONSTRAINT car_gas_type_id_fk01
    FOREIGN KEY (gas_type_id)
    REFERENCES gas_type (gas_type_id);

-- Maintenance --

DROP TABLE IF EXISTS karto.maintenance;

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

ALTER TABLE maintenance
    ADD CONSTRAINT maintenance_car_vin_fk
    FOREIGN KEY (car_vin)
    REFERENCES karto.car(car_vin);

ALTER TABLE maintenance
    ADD CONSTRAINT maintenance_car_vin_maintenance_datetime_unique
    UNIQUE (car_vin, maintenance_datetime);

-- Gas Price --

DROP TABLE IF EXISTS karto.gas_price;

CREATE TABLE gas_price 
(
  station_id       INT UNSIGNED             NOT NULL    COMMENT 'Station Unique ID',
  gas_type_id      SMALLINT UNSIGNED        NOT NULL    COMMENT 'Gas Type',
  price_per_gallon DECIMAL(7, 4) UNSIGNED   NOT NULL    COMMENT 'Price per gallon of GAS',
  last_updated     DATETIME                 NOT NULL DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Updated Time',

  PRIMARY KEY (station_id, gas_type_id)
)
COMMENT 'Gas Price';

ALTER TABLE gas_price 
  ADD FOREIGN KEY (station_id) 
  REFERENCES gas_station (station_id)
;

ALTER TABLE gas_price 
  ADD FOREIGN KEY (gas_type_id) 
  REFERENCES gas_type (gas_type_id)
;

-- Maintenance Item Detail --

DROP TABLE IF EXISTS karto.maintenance_item_detail;

CREATE TABLE maintenance_item_detail
(
    maintenance_type_id     MEDIUMINT UNSIGNED  NOT NULL                COMMENT 'Maintenance Type',
    maintenance_id          INT UNSIGNED        NOT NULL                COMMENT 'Maintenance Log',
    quantity                TINYINT UNSIGNED    NOT NULL    DEFAULT 1   COMMENT 'Quantity',
    comments                VARCHAR(255)                                COMMENT 'Comments',

    PRIMARY KEY(maintenance_type_id, maintenance_id)
)
COMMENT 'Maintenance Item Detail';

ALTER TABLE maintenance_item_detail
    ADD CONSTRAINT maintenance_item_detail_maintenance_type_id_fk
    FOREIGN KEY (maintenance_type_id)
    REFERENCES karto.maintenance_type_description(maintenance_type_id);

ALTER TABLE maintenance_item_detail
    ADD CONSTRAINT maintenance_item_detail_maintenance_id_fk
    FOREIGN KEY (maintenance_id)
    REFERENCES karto.maintenance(maintenance_id);

-- Maintenance Receipt --

DROP TABLE IF EXISTS karto.maintenance_receipt;

CREATE TABLE maintenance_receipt (
    maintenance_id  INT UNSIGNED    NOT NULL    COMMENT 'Maintenance Receipt PK',
    receipt_image   MEDIUMBLOB      NOT NULL    COMMENT 'Image of the Receipt',
    PRIMARY KEY (maintenance_id)
)
COMMENT "Receipt for Maintenance";

ALTER TABLE maintenance_receipt
    ADD CONSTRAINT maintenance_receipt_maintenance_id_fk
    FOREIGN KEY (maintenance_id)
    REFERENCES karto.maintenance(maintenance_id);

-- Car Image --

DROP TABLE IF EXISTS karto.car_image;

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

-- Trusted Gas Station -- 
DROP TABLE IF EXISTS karto.trusted_gas_station;

CREATE TABLE trusted_gas_station (
  user_email   VARCHAR(255)  NOT NULL  COMMENT 'User Email',
  station_id   INT UNSIGNED  NOT NULL  COMMENT 'Gas Station',
  
  PRIMARY KEY (user_email, station_id)
);

ALTER TABLE trusted_gas_station 
    ADD FOREIGN KEY (user_email) 
    REFERENCES user (user_email)
;

ALTER TABLE trusted_gas_station 
    ADD FOREIGN KEY (station_id) 
    REFERENCES gas_station (station_id)
;

-- Insert Data --

INSERT INTO maintenance_type_description(name) VALUES
('Oil Change'),
('Brake Pad & Rotor Replacement'),
('Battery Replacement'),
('Tire Rotation & Balancing'),
('Wheel Alignment'),
('Air Filter Replacement'),
('Spark Plug Replacement'),
('Coolant Flush & Radiator Service'),
('Transmission Fluid Change'),
('Timing Belt or Chain Replacement');

INSERT INTO gas_type(name) VALUES
('Regular'),
('Mid-Grade'),
('Premium'),
('Diesel'),
('Biodiesel'),
('E85'),
('Natural'),
('Petroleum'),
('Hydrogen'),
('Electric');

INSERT INTO gas_station(longitude, latitude, name, address_line, city, state, zip_code) VALUES
(RAND(), RAND(), 'Spec Marathon', '1', "Inglewood", "Ohio", "1234567"),
(RAND(), RAND(), 'Speedway Broadway', '2', "El Paso", "Ohio", "1234567"),
(RAND(), RAND(), 'Main Clark', '3', "Escondido", "Ohio", "1234567"),
(RAND(), RAND(), 'Oakland Station', '4', "Oakland", "Ohio", "1234567"),
(RAND(), RAND(), 'Pompano Marathon', '5', "Pompano Beach", "Ohio", "1234567"),
(RAND(), RAND(), 'Johnson BP', '6', "Johnson City", "Ohio", "1234567"),
(RAND(), RAND(), 'Buccees', '7', "North Port", "Ohio", "1234567"),
(RAND(), RAND(), 'Oaks Speedway', '8', "Thousand Oaks", "Ohio", "1234567"),
(RAND(), RAND(), 'Downtown Marathon', '9', "Indianapolis", "Ohio", "1234567"),
(RAND(), RAND(), 'QuickTrip', '10', "Grayslake", "Ohio", "1234567");

INSERT INTO user(user_email, username, hashed_password) VALUES
('alice.smith@example.test', 'alice_smith', '$2b$12$KbQ1a1fPzYq3x7D8mN0P6u1ZxYv8E4rTq9JfH2kLw3mN6oPqR7s1'),
('bob.jones@example.test', 'bobbyj', '$2b$12$7nV3pQe9ZcR4sF2mHk8Lt0uJwXy1A5bCq6Zr8Tj9LmP0oQwE2y3'),
('carla89@example.test', 'carla89', '$2b$12$eT5wH8kLmP2qR9vZc3X1bF7sG6yN0uJd4Kp8Qm2LcV5t9WzA1o3'),
('daniel.k@example.test', 'daniel_k', '$2b$12$yH3mP9rQe7Zt5vLk1Xc2N8uF4sB0wJ6gR8Tn3Lp5Qv1sH2mC4a7'),
('emma.w@example.test', 'emma_w', '$2b$12$M8pQ2vR5tL1sX9yC3nF4uH7kE6zJ0wGq2B5rT8mP1vN3sL6o9a4'),
('frank_the_dev@example.test', 'frankdev', '$2b$12$zR9vL3pQe5mT2sH1nC6yF8uK4wJ0gB7qR5tN1pL3sV8mY2c6o4a9'),
('grace_lee@example.test', 'gracelee', '$2b$12$P3qR7vL1sT9mH4cX2nF6uE8wJ5yG0bK2rT9pL4sV1mN3o8a6z5'),
('hector9@example.test', 'hector9', '$2b$12$L4sP1qR8vT3mN6yC2fH9uE5wJ0bG7kR2tP5lS1vM3nQ8o4a6z9'),
('irene.z@example.test', 'irenez', '$2b$12$Q2rT8vL5pS1mN3yC6fH9uE4wJ0bG7kP5qR1tL3sV8mN2o6a9z4'),
('jack.black@example.test', 'jack_black', '$2b$12$N1pL7qR3vT5mS2yC8fH4uE9wJ0bG6kP2rT8lS5vM1nQ3o9a6z4'),
('kate.o@example.test', 'kate_o', '$2b$12$V5mN2pL8qR1tS3yC6fH9uE4wJ0bG7kP3rT9lS5vM1nQ4o8a6z2'),
('leo1990@example.test', 'leo1990', '$2b$12$S3vL1pQ7rT5mN2yC8fH4uE9wJ0bG6kP2qR8tL5sV1mN3o9a6z4');

INSERT INTO car(car_vin, user_email, make, model, year, color, initial_mileage, gas_type_id) VALUES
('1HGCM82633A004352', 'alice.smith@example.test', 'Toyota', 'Corolla', 2015, 'White', 62300, 1),
('2FTRX18L1XCA01234', 'bob.jones@example.test', 'Honda', 'Civic', 2018, 'Blue', 41200, 3),
('1FTFW1EF1EKD56789', 'carla89@example.test', 'Ford', 'F-150', 2012, 'Red', 95800, 7),
('1G1ZT52845F678910', 'daniel.k@example.test', 'Chevrolet', 'Malibu', 2010, 'Gray', 120400, 7),
('5YJ3E1EA7KF123456', 'emma.w@example.test', 'Tesla', 'Model 3', 2021, 'Pearl White', 15200, 3),
('WBA3A5C54FF789012', 'frank_the_dev@example.test', 'BMW', '3 Series', 2016, 'Black', 48200, 1),
('WAUEFAFL7GN901234', 'grace_lee@example.test', 'Audi', 'A4', 2019, 'Silver', 30100, 1),
('4S4BP61C576345678', 'hector9@example.test', 'Subaru', 'Outback', 2014, 'Green', 87400, 7),
('1N4AL11D75C987654', 'irene.z@example.test', 'Nissan', 'Altima', 2009, 'Maroon', 134500, 7),
('3VW217AU8HM456789', 'jack.black@example.test', 'Volkswagen', 'Golf', 2017, 'Yellow', 55900, 4),
('WDDGF8AB4LF234567', 'kate.o@example.test', 'Mercedes-Benz', 'C300', 2020, 'Black', 26200, 6),
('KNDJT2A29D7890123', 'leo1990@example.test', 'Kia', 'Soul', 2013, 'Orange', 98000, 5),
('KMHDH4AE1BU345678', 'irene.z@example.test', 'Hyundai', 'Elantra', 2011, 'Blue', 111300, 9);

INSERT INTO maintenance(car_vin, maintenance_datetime, mileage, cost) VALUES
('1HGCM82633A004352', '2023-06-15', 63500, 89.99),
('2FTRX18L1XCA01234', '2021-11-02', 43800, 129.50),
('1FTFW1EF1EKD56789', '2022-08-20', 97230, 349.75),
('1G1ZT52845F678910', '2020-03-10', 121150, 59.99),
('5YJ3E1EA7KF123456', '2024-05-22', 19800, 19.99),
('WBA3A5C54FF789012', '2022-12-05', 49920, 219.00),
('WAUEFAFL7GN901234', '2023-09-14', 31250, 149.25),
('4S4BP61C576345678', '2019-07-30', 88050, 429.00),
('1N4AL11D75C987654', '2021-01-18', 136000, 74.40),
('3VW217AU8HM456789', '2022-04-07', 57320, 95.00),
('WDDGF8AB4LF234567', '2024-10-03', 27980, 189.99),
('KNDJT2A29D7890123', '2020-09-29', 100450, 64.25),
('KMHDH4AE1BU345678', '2021-06-11', 113900, 89.00),
('1HGCM82633A004352', '2024-02-20', 64820, 249.99),
('2FTRX18L1XCA01234', '2023-05-30', 45210, 349.00),
('1FTFW1EF1EKD56789', '2024-11-11', 98510, 79.95),
('5YJ3E1EA7KF123456', '2025-03-05', 21430, 0.00),
('WBA3A5C54FF789012', '2025-08-12', 51010, 129.50);

INSERT INTO gas_price(station_id, gas_type_id, price_per_gallon) VALUES
(8, 5, 0.3300),
(10, 4, 2.0914),
(7, 8, 2.3598),
(7, 4, 3.1124),
(8, 7, 1.7171),
(8, 1, 2.9065),
(2, 5, 1.7180),
(9, 9, 0.3951),
(2, 8, 2.5333),
(2, 9, 1.5855),
(4, 7, 3.6413),
(4, 9, 3.4343),
(10, 5, 1.5562),
(3, 6, 0.9124),
(3, 1, 0.7220),
(9, 7, 1.8795),
(8, 2, 3.6847),
(6, 3, 1.5938),
(7, 6, 3.2086),
(6, 6, 0.9294),
(4, 4, 3.1498),
(4, 8, 3.9861),
(7, 10, 3.1312),
(5, 10, 2.1832),
(8, 9, 3.9797),
(1, 8, 2.1171),
(9, 6, 2.1625),
(10, 7, 2.6405),
(5, 5, 0.3033),
(7, 9, 2.9248),
(1, 3, 1.6670),
(4, 5, 2.5814),
(7, 5, 3.2545),
(6, 5, 1.2103),
(10, 8, 3.6346),
(1, 2, 1.0875),
(3, 5, 3.5017),
(10, 9, 3.4042),
(1, 10, 0.1185),
(6, 10, 0.0907),
(8, 6, 0.1629),
(10, 6, 2.7888),
(2, 2, 2.8692),
(7, 7, 0.7201),
(8, 4, 1.3392),
(9, 5, 2.0374),
(8, 8, 1.7505),
(10, 1, 3.6752),
(4, 2, 3.3185),
(2, 10, 2.1276),
(1, 5, 0.7343),
(6, 9, 1.1720),
(6, 4, 1.7702),
(3, 7, 1.3823),
(5, 9, 3.7274);

INSERT INTO maintenance_item_detail(maintenance_type_id, maintenance_id, quantity) VALUES
(1, 6, 4),
(3, 14, 2),
(7, 4, 9),
(3, 16, 6),
(10, 7, 1),
(6, 9, 8),
(3, 11, 5),
(9, 7, 4),
(3, 6, 5),
(1, 4, 5),
(2, 18, 8),
(7, 7, 9),
(5, 5, 9),
(5, 16, 9),
(6, 5, 6),
(2, 13, 3),
(8, 7, 2),
(9, 14, 6),
(2, 16, 9),
(3, 2, 1),
(6, 12, 1),
(1, 1, 7),
(3, 8, 7),
(3, 1, 9),
(4, 2, 3),
(7, 18, 9),
(10, 3, 9),
(5, 6, 7),
(2, 10, 3),
(3, 12, 6),
(10, 12, 8),
(5, 3, 1),
(6, 17, 6),
(5, 4, 5),
(5, 10, 2),
(4, 16, 5),
(6, 4, 3),
(7, 9, 9),
(8, 18, 9),
(5, 14, 5),
(10, 11, 8),
(9, 12, 2),
(4, 8, 1),
(4, 3, 10),
(2, 15, 5),
(6, 8, 1),
(9, 17, 1),
(8, 1, 9),
(6, 16, 7),
(7, 3, 7),
(10, 15, 9),
(4, 6, 6),
(3, 5, 3),
(5, 18, 8),
(1, 8, 10),
(6, 13, 4),
(2, 2, 4),
(1, 10, 4),
(7, 5, 7),
(5, 11, 5),
(7, 15, 7),
(3, 9, 3),
(9, 13, 7);

INSERT INTO maintenance_receipt(maintenance_id, receipt_image) VALUES
(10, 10),
(17, 17),
(18, 18),
(5, 5),
(1, 1),
(6, 6),
(15, 15),
(12, 12),
(7, 7),
(3, 3),
(9, 9),
(13, 13);

INSERT INTO car_image(car_vin, car_image) VALUES
("4S4BP61C576345678", 11),
("3VW217AU8HM456789", 5),
("1HGCM82633A004352", 0),
("1FTFW1EF1EKD56789", 8),
("1N4AL11D75C987654", 10),
("KNDJT2A29D7890123", 6),
("KMHDH4AE1BU345678", 12),
("WDDGF8AB4LF234567", 7);

INSERT INTO trusted_gas_station(user_email, station_id) VALUES
("kate.o@example.test", 10),
("daniel.k@example.test", 5),
("frank_the_dev@example.test", 6),
("grace_lee@example.test", 3),
("kate.o@example.test", 2),
("emma.w@example.test", 4),
("emma.w@example.test", 7),
("jack.black@example.test", 7),
("emma.w@example.test", 6),
("hector9@example.test", 6),
("bob.jones@example.test", 1),
("daniel.k@example.test", 9),
("grace_lee@example.test", 5),
("jack.black@example.test", 9),
("frank_the_dev@example.test", 2),
("irene.z@example.test", 7),
("grace_lee@example.test", 7),
("hector9@example.test", 3),
("daniel.k@example.test", 2),
("kate.o@example.test", 5),
("jack.black@example.test", 10),
("jack.black@example.test", 4),
("hector9@example.test", 10),
("irene.z@example.test", 1),
("daniel.k@example.test", 7),
("bob.jones@example.test", 6),
("grace_lee@example.test", 4),
("emma.w@example.test", 1),
("carla89@example.test", 5),
("carla89@example.test", 1),
("carla89@example.test", 7),
("kate.o@example.test", 1);
