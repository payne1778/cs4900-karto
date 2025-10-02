USE karto;

-- Gas Type (Lookup Table)
DROP TABLE IF EXISTS karto.gas_type;

-- Create Table
CREATE TABLE gas_type
(
    gas_id      SMALLINT UNSIGNED       NOT NULL        COMMENT 'PK (Natural) for Gas Type, Gas Ratings (e.g., 87, 89, 91, 93)',
    gas_name    VARCHAR(15)             NOT NULL        COMMENT 'Gas Type Name',

    PRIMARY KEY (gas_id)
)
COMMENT 'Gas Type (Lookup Table)';

-- Example Data
INSERT INTO gas_type (gas_id, gas_name) VALUES
    (87, 'Regular'),
    (89, 'Mid-Grade'),
    (91, 'Premium'),
    (93, 'Super Premium');