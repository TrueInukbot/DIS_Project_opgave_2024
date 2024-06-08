import logging
from datetime import datetime
from sqlalchemy import text
from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from config import Config

app = Flask(__name__)
app.config.from_object(Config)
app.debug = True  # Enable debug mode

db = SQLAlchemy(app)

# Configure logging
logging.basicConfig(level=logging.DEBUG)

class Kunder(db.Model):
    __tablename__ = 'kunder'
    kundeid = db.Column(db.Integer, primary_key=True, autoincrement=True)
    fornavn = db.Column(db.String(50), nullable=False)
    efternavn = db.Column(db.String(50), nullable=False)
    adresse = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    telefon = db.Column(db.String(20), nullable=False)

    def __repr__(self):
        return f'<Kunder {self.fornavn} {self.efternavn}>'

class Abonnementer(db.Model):
    __tablename__ = 'abonnementer'
    abonnementid = db.Column(db.Integer, primary_key=True, autoincrement=True)
    kundeid = db.Column(db.Integer, db.ForeignKey('kunder.kundeid'), nullable=False)
    bilid = db.Column(db.Integer, db.ForeignKey('biler.bilid'), nullable=False)
    startdato = db.Column(db.Date, nullable=False)
    slutdato = db.Column(db.Date, nullable=False)
    prisprmaaned = db.Column(db.Float, nullable=False)

    def __repr__(self):
        return f'<Abonnementer KundeID: {self.kundeid}, BilID: {self.bilid}>'

class Biler(db.Model):
    __tablename__ = 'biler'
    bilid = db.Column(db.Integer, primary_key=True, autoincrement=True)
    maerke = db.Column(db.String(50), nullable=False)
    model = db.Column(db.String(50), nullable=False)
    braendstoftype = db.Column(db.String(50), nullable=False)
    hestekraefter = db.Column(db.Integer, nullable=False)
    stelnummer = db.Column(db.String(50), nullable=False)
    vognnummer = db.Column(db.String(50), nullable=False)
    odometer = db.Column(db.Integer, nullable=False)
    produktionsaar = db.Column(db.Integer, nullable=False)
    lokation = db.Column(db.String(50), nullable=False)
    billede = db.Column(db.String(50), nullable=False)

    def __repr__(self):
        return f'<Bil: model: {self.model}, brændstof: {self.braendstoftype}, mærke: {self.maerke}, BilID: {self.bilid}>'

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/greet', methods=['POST'])
def greet():
    fornavn = request.form['fornavn']
    efternavn = request.form['efternavn']
    adresse = request.form['adresse']
    email = request.form['email']
    telefon = request.form['telefon']

    new_user = Kunder(fornavn=fornavn, efternavn=efternavn, adresse=adresse, email=email, telefon=telefon)
    db.session.add(new_user)
    db.session.commit()

    return render_template('greet.html', fornavn=fornavn, efternavn=efternavn, adresse=adresse, email=email, telefon=telefon)

@app.route('/search', methods=['GET', 'POST'])
def search():
    try:
        if request.method == 'POST':
            location = request.form.get('location')
            start_date = request.form.get('start_date')
            end_date = request.form.get('end_date')

            logging.debug(f"Search criteria - Location: {location}, Start Date: {start_date}, End Date: {end_date}")

            if start_date and end_date:
                start_date = datetime.strptime(start_date, '%Y-%m-%d').date()
                end_date = datetime.strptime(end_date, '%Y-%m-%d').date()

                sql = """
                SELECT bilid, maerke, model, braendstoftype, hestekraefter, stelnummer, 
                       vognnummer, odometer, produktionsaar, lokation, billede
                FROM cars_by_location_and_date
                WHERE lokation ILIKE :location
                AND (startdato IS NULL OR startdato > :end_date OR slutdato < :start_date)
                """
                results = db.session.execute(text(sql), {'location': f'%{location}%', 'end_date': end_date, 'start_date': start_date}).fetchall()

                available_cars = [dict(row) for row in results]

                logging.debug(f"Available cars: {available_cars}")

                return render_template('search.html', cars=available_cars, location=location, start_date=start_date, end_date=end_date)
    except Exception as e:
        logging.exception("An error occurred during the search.")
        return render_template('error.html', error=str(e))
    
    return render_template('search.html', cars=[])
@app.route('/test_db')
def test_db():
    try:
        # Perform a simple query to test the database connection
        result = db.session.execute(text('SELECT 1')).scalar()
        if result == 1:
            return "Database connection is working!", 200
        else:
            return "Unexpected result from the database.", 500
    except Exception as e:
        # Log the error and return a failure message
        logging.error(f"Error testing database connection: {e}")
        return f"Database connection failed: {e}", 500

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        # Run the SQL script to create views
        with open('sql/create_views.sql') as f:
            db.session.execute(text(f.read()))
            db.session.commit()
    app.run(debug=True)