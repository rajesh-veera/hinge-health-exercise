import pandas as pd
import psycopg2
from psycopg2 import sql
from psycopg2.extras import execute_values
from sqlalchemy import create_engine
from psycopg2 import Error, OperationalError

import os

# Database connection
DB_HOST = "localhost"
DB_NAME = "postgres"
DB_USER = "postgres"
DB_PASSWORD = "postgres"
DB_PORT = 5432  



# File paths
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
US_SOFTBALL_LEAGUE_FILE =  os.path.join(SCRIPT_DIR, "us_softball_league.txt")
UNITY_GOLF_CLUB_FILE = os.path.join(SCRIPT_DIR, "unity_golf_club.txt")
COMPANIES_FILE = os.path.join(SCRIPT_DIR, "company.csv")

# Create Postgres engine
engine = create_engine(f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}")

# create database connection
def create_connection():
    conn = None
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            port=DB_PORT
        )
        print("Connected to PostgreSQL database!")
    except OperationalError as e:
        print(f"Error connecting to database: {e}")
    return conn

# create tables
def create_tables(conn):
    try:
        cursor = conn.cursor()

        # Create companies table

        cursor.execute("""
            DROP TABLE IF EXISTS companies
        """)

        cursor.execute("""
            CREATE TABLE IF NOT EXISTS companies (
                company_id SERIAL PRIMARY KEY,
                company_name TEXT NOT NULL
            )
        """)

        # Create us_softball_league table

        cursor.execute("""
            DROP TABLE IF EXISTS us_softball_league CASCADE
        """)

        cursor.execute("""
            CREATE TABLE IF NOT EXISTS us_softball_league (
                id SERIAL PRIMARY KEY,
                name TEXT NOT NULL,
                date_of_birth DATE,
                company_id INTEGER,
                last_active DATE,
                score INTEGER,
                joined_league INTEGER,
                us_state TEXT
            )
        """)

        # Create unity_golf_club table

        cursor.execute("""
            DROP TABLE IF EXISTS unity_golf_club CASCADE
        """)

        cursor.execute("""
            CREATE TABLE IF NOT EXISTS unity_golf_club (
                id SERIAL PRIMARY KEY,
                first_name TEXT NOT NULL,
                last_name TEXT NOT NULL,
                dob DATE,
                company_id INTEGER,
                last_active DATE,
                score INTEGER,
                member_since INTEGER,
                state TEXT
            )
        """)

        conn.commit()
        print("Tables created successfully!")
    except Error as e:
        print(f"Error creating tables: {e}")

# Load data
def load_data(conn, file_path, table_name, chunk_size=1000):
    try:
        cursor = conn.cursor()

        # Read file in chunks
        for chunk in pd.read_csv(file_path, sep="\t" if table_name == "us_softball_league" else ",", chunksize=chunk_size):
            # Clean column names
            chunk.columns = [col.strip() for col in chunk.columns]

            # Convert DataFrame to list of tuples
            data_tuples = [tuple(row) for row in chunk.to_numpy()]

            # Insert data into the table
            insert_query = sql.SQL("INSERT INTO {} ({}) VALUES %s").format(
                sql.Identifier(table_name),
                sql.SQL(", ").join(map(sql.Identifier, chunk.columns))
            )
            execute_values(cursor, insert_query, data_tuples)

        conn.commit()
        print(f"Data loaded into {table_name} successfully!")
    except Error as e:
        print(f"Error loading data into {table_name}: {e}")

# Main function
def main():
    # Create database connection
    conn = create_connection()
    if conn is None:
        return

    # Create tables
    create_tables(conn)

    # Load companies.csv
    load_data(conn, COMPANIES_FILE, "companies")

    # Load us_softball_league.tsv
    load_data(conn, US_SOFTBALL_LEAGUE_FILE, "us_softball_league")

    # Load unity_golf_club.csv
    load_data(conn, UNITY_GOLF_CLUB_FILE, "unity_golf_club")

    # Close the connection
    conn.close()

# Run the script
if __name__ == "__main__":
    main()