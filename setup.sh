#!/bin/bash

# Install required Python packages
pip install -r requirements.txt

# Run the create_db.py script to create the database
python create_db.py

# Run the init_db.py script to create tables
python init_db.py

# Open psql with your user credentials remove postgres and put in your username
psql -U your_username -h 127.0.0.1 -p 5000