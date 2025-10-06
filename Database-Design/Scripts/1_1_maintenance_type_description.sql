USE karto;

-- Maintenance Type

DROP TABLE IF EXISTS karto.maintenance_type_description;

-- Create Table
CREATE TABLE maintenance_type_description
(
    maintenance_type_id     MEDIUMINT UNSIGNED  NOT NULL    AUTO_INCREMENT  COMMENT 'PK for Maintenance Type',
    name                    VARCHAR(60)         NOT NULL    UNIQUE          COMMENT 'Name',

    PRIMARY KEY(maintenance_type_id)
)
COMMENT 'Maintenance Type';