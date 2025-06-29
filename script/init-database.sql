/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

DO
$$
BEGIN
    IF EXISTS (SELECT FROM pg_database WHERE datname = 'datawarehouse') THEN
        -- Force disconnect all connections
        PERFORM pg_terminate_backend(pid)
        FROM pg_stat_activity
        WHERE datname = 'datawarehouse';

        -- Drop the database
        EXECUTE 'DROP DATABASE datawarehouse';
    END IF;
END
$$;

-- Create the new database
CREATE DATABASE datawarehouse;

-- NOTE: The following should be run after connecting to the newly created 'datawarehouse' database:

-- Create Schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
