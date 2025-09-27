# Database Initialization Scripts

This directory contains scripts used to initialize a database. The scripts are designed to be executed in lexicographical order, ensuring that all necessary tables and data.

## Name Formatting

- **Script Names**: `<prefix>_<numbering>_<database table or name>.sql`
- The prefix specifies what type of table is being created.
  - `0` specifies stuff before any tables are added.
  - `1` specifies look up tables (i.e. gas_type).
  - `2` specifies the core tables (i.e. user, car).
  - `3` specifies details about the core table (i.e. gas_price).
  - `4` specifies any many-to-many relationship tables between core tables (i.e. trusted_gas_station).
- The numbering specifies the execution order of the script within the same prefix (i.e. car should be executed after user).
  - This is in lexicographical order, so ADD LEADING ZEROS if needed.
- The database table or name should be in snake case (snake_case).

## Table and Column Naming

- Use snake case (snake_case)
