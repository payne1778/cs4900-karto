CREATE DATABASE karto;

CREATE OR REPLACE ROLE karto_manager;

GRANT ALL PRIVILEGES ON karto.* TO karto_manager;