USE karto;

-- Maintenance Type

DROP TABLE IF EXISTS karto.maintenance_type;

-- Create Table
CREATE TABLE maintenance_type
(
    maintenance_type_id     MEDIUMINT UNSIGNED  NOT NULL    AUTO_INCREMENT  COMMENT 'PK for Maintenance Type',
    name                    VARCHAR(31)         NOT NULL    UNIQUE          COMMENT 'Name',

    PRIMARY KEY(maintenance_type_id)
)
COMMENT 'Maintenance Type';