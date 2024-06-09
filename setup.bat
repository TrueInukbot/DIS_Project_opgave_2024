@echo off

REM Install required Python packages
python pip install -r requirements.txt

REM Run the create_db.py script to create the database
python create_db.py

REM Run the init_db.py script to create tables
python init_db.py

REM Open psql with your user credentials remove postgres and put in your username
psql -U postgres -h localhost -p 5432
pause
