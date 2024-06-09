import psycopg2
from psycopg2 import sql
import subprocess
import os
from app import app

def install_packages():
    """Install required packages."""
    try:
        subprocess.check_call([os.sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])
    except subprocess.CalledProcessError as e:
        raise Exception(f"An error occurred while installing packages: {e}")

def create_database():
    """Create the biludlejning database if it doesn't exist."""
    try:
        print("Creating database...")
        conn = psycopg2.connect(
            dbname="postgres",  # Connect to the default database
            user="postgres",
            password="Mamima909506",
            host="localhost",
            port="5432"  # Default port for PostgreSQL
        )
        conn.autocommit = True
        cursor = conn.cursor()

        # Check if the biludlejning database exists
        cursor.execute("SELECT 1 FROM pg_database WHERE datname='biludlejning'")
        exists = cursor.fetchone()
        if not exists:
            cursor.execute(sql.SQL("CREATE DATABASE {}").format(
                sql.Identifier('biludlejning')))
            print("Database 'biludlejning' created successfully.")
        else:
            print("Database 'biludlejning' already exists.")
        
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"An error occurred while creating the database: {e}")

def create_tables():
    """Create tables in the biludlejning database."""
    try:
        print("Creating tables...")
        conn = psycopg2.connect(
            dbname="biludlejning",
            user="postgres",
            password="Mamima909506",
            host="localhost",
            port="5432"  # Default port for PostgreSQL
        )
        cursor = conn.cursor()
        cursor.execute(open('sql/create_tables.sql', 'r').read())
        conn.commit()
        cursor.close()
        conn.close()
        print("Tables created successfully.")
    except Exception as e:
        print(f"An error occurred while creating the tables: {e}")

def open_psql():
    """Open psql for the user."""
    try:
        print("Opening psql...")
        subprocess.run(['psql', '-U', 'your_username', '-h', 'localhost', '-p', '5432', 'biludlejning'])
    except Exception as e:
        print(f"An error occurred while opening psql: {e}")

if __name__ == "__main__":
    try:
        install_packages()
        create_database()
        create_tables()
    except Exception as e:
        print(f"An error occurred: {e}")
    app.run(host='127.0.0.1', port=5000)