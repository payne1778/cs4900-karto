USE karto;

-- Maintenance Item Detail
DROP TABLE IF EXISTS karto.maintenance_item_detail;
-- Create Table
CREATE TABLE maintenance_item_detail
(
    maintenance_type_id     MEDIUMINT UNSIGNED  NOT NULL    REFERENCES karto.maintenance_type(maintenance_type_id)  COMMENT 'Maintenance Type',
    maintenance_id          INT UNSIGNED        NOT NULL    REFERENCES karto.maintenance(maintenance_id)            COMMENT 'Maintenance Log',
    quantity                TINYINT UNSIGNED    NOT NULL    DEFAULT 1                                               COMMENT 'Quantity',
    comments                VARCHAR(255)                                                                            COMMENT 'Comments',

    PRIMARY KEY(maintenance_type_id, maintenance_id)
);
COMMENT 'Maintenance Item Detail';