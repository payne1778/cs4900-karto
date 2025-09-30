USE karto;

-- Maintenance Item Detail
DROP TABLE IF EXISTS karto.maintenance_item_detail;
-- Create Table
CREATE TABLE maintenance_item_detail
(
    maintenance_type_id     MEDIUMINT UNSIGNED  NOT NULL                COMMENT 'Maintenance Type',
    maintenance_id          INT UNSIGNED        NOT NULL                COMMENT 'Maintenance Log',
    quantity                TINYINT UNSIGNED    NOT NULL    DEFAULT 1   COMMENT 'Quantity',
    comments                VARCHAR(255)                                COMMENT 'Comments',

    PRIMARY KEY(maintenance_type_id, maintenance_id)
)
COMMENT 'Maintenance Item Detail';

-- Maintenance Type ID Foreign Key
ALTER TABLE maintenance_item_detail
    ADD CONSTRAINT maintenance_item_detail_maintenance_type_id_fk
    FOREIGN KEY (maintenance_type_id)
    REFERENCES karto.maintenance_type(maintenance_type_id);
-- Maintenance ID Foreign Key
ALTER TABLE maintenance_item_detail
    ADD CONSTRAINT maintenance_item_detail_maintenance_id_fk
    FOREIGN KEY (maintenance_id)
    REFERENCES karto.maintenance(maintenance_id);