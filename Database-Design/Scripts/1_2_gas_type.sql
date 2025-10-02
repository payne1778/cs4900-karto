USE karto;

-- Gas Type (Lookup Table)
DROP TABLE IF EXISTS karto.gas_type;

-- Create Table
CREATE TABLE gas_type
(
    gas_type_id     SMALLINT UNSIGNED       NOT NULL        COMMENT 'PK (Natural) for Gas Type, Gas Ratings (e.g., 87, 89, 91, 93)',
    gas_name        VARCHAR(15)             NOT NULL        COMMENT 'Gas Type Name',

    PRIMARY KEY (gas_type_id)
)
COMMENT 'Gas Type (Lookup Table)';

-- Example Data
INSERT INTO gas_type (gas_type_id, gas_name) VALUES
    (1, 'Regular'),
    (2, 'Mid-Grade'),
    (3, 'Premium'),
    (4, 'Super Premium');