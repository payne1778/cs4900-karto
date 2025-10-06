USE karto;

-- Gas Type (Lookup Table)
DROP TABLE IF EXISTS karto.gas_type;

-- Create Table
CREATE TABLE gas_type
(
    gas_type_id     SMALLINT UNSIGNED   NOT NULL    AUTO_INCREMENT  COMMENT 'PK (Natural) for Gas Type, Gas Ratings (e.g., 87, 89, 91, 93)',
    name        VARCHAR(15)             NOT NULL                    COMMENT 'Gas Type Name',

    PRIMARY KEY (gas_type_id)
)
COMMENT 'Gas Type (Lookup Table)';