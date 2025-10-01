USE karto;

-- Maintenance Receipt
DROP TABLE IF EXISTS karto.maintenance_receipt;

-- Create Table
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
