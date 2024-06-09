import logging
from datetime import datetime
from sqlalchemy import or_, select, text
from flask import Flask, render_template, request, redirect, url_for, session
from flask_sqlalchemy import SQLAlchemy
from config import Config
import re

app = Flask(__name__)
app.config.from_object(Config)
app.secret_key = 'admin' 
app.debug = True  

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
    prisprmaaned = db.Column(db.Integer, nullable=False)
    maxkm = db.Column(db.Integer)

def __repr__(self):
        return f'<Abonnementer KundeID: {self.kundeid}, BilID: {self.bilid}, PrisPrMåned: {self.prisprmaaned}>'

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

@app.route('/search_customers', methods=['GET'])
def search_customers():
    if 'username' not in session:
        return redirect(url_for('home'))

    query = request.args.get('query', '').strip()
    customers = []
    if query:
        email_pattern = r'^.*@.*\.[a-zA-Z]+$'
        if re.match(email_pattern, query):
            customers = Kunder.query.filter(Kunder.email.ilike(f'%{query}%')).all()
    return render_template('user.html', customers=customers)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/search', methods=['GET', 'POST'])
def search():
    if request.method == 'POST':
        location = request.form.get('location')
        start_date = request.form.get('start_date')
        end_date = request.form.get('end_date')

        if not start_date or not end_date:
            flash('Start date and end date are required.')
            return redirect(url_for('home'))

        try:
            start_date = datetime.strptime(start_date, '%Y-%m-%d').date()
            end_date = datetime.strptime(end_date, '%Y-%m-%d').date()

            results = Biler.query.outerjoin(Abonnementer, Biler.bilid == Abonnementer.bilid).filter(
                Biler.lokation.ilike(f'%{location}%'),
                or_(Abonnementer.startdato == None, Abonnementer.startdato > end_date, Abonnementer.slutdato < start_date)
            ).all()

            available_cars = [{'bilid': car.bilid, 'maerke': car.maerke, 'model': car.model, 'braendstoftype': car.braendstoftype,
                               'hestekraefter': car.hestekraefter, 'stelnummer': car.stelnummer, 'vognnummer': car.vognnummer,
                               'odometer': car.odometer, 'produktionsaar': car.produktionsaar, 'lokation': car.lokation,
                               'billede': car.billede} for car in results]

            return render_template('search.html', cars=available_cars, location=location, start_date=start_date, end_date=end_date)
        except ValueError as e:
            flash(f'Invalid date format: {e}')
            return redirect(url_for('home'))

    # If GET request or no cars found for the criteria, show all cars not currently on a subscription
    results = Biler.query.outerjoin(Abonnementer, Biler.bilid == Abonnementer.bilid).filter(
        Abonnementer.bilid == None
    ).all()

    all_cars = [{'bilid': car.bilid, 'maerke': car.maerke, 'model': car.model, 'braendstoftype': car.braendstoftype,
                 'hestekraefter': car.hestekraefter, 'stelnummer': car.stelnummer, 'vognnummer': car.vognnummer,
                 'odometer': car.odometer, 'produktionsaar': car.produktionsaar, 'lokation': car.lokation,
                 'billede': car.billede} for car in results]

    return render_template('search.html', cars=all_cars)

@app.route('/car_details/<int:bilid>', methods=['GET', 'POST'])
def car_details(bilid):
    car = Biler.query.get_or_404(bilid)
    start_date = request.args.get('start_date')
    end_date = request.args.get('end_date')

    if request.method == 'POST':
        fornavn = request.form.get('fornavn')
        efternavn = request.form.get('efternavn')
        adresse = request.form.get('adresse')
        email = request.form.get('email')
        telefon = request.form.get('telefon')

        new_user = Kunder(fornavn=fornavn, efternavn=efternavn, adresse=adresse, email=email, telefon=telefon)
        db.session.add(new_user)
        db.session.commit()

        start_date = request.form.get('start_date')
        end_date = request.form.get('end_date')
        prisprmåned = request.form.get('PrisPrMåned')

        new_abonnement = Abonnementer(
            kundeid=new_user.kundeid,
            bilid=bilid,
            startdato=datetime.strptime(start_date, '%Y-%m-%d').date(),
            slutdato=datetime.strptime(end_date, '%Y-%m-%d').date(),
            prispermåned=float(prisprmåned)
        )
        db.session.add(new_abonnement)
        db.session.commit()

        return redirect(url_for('search'))

    return render_template('car_details.html', car=car, start_date=start_date, end_date=end_date)

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']
    if username == 'admin' and password == 'admin':
        session['username'] = username
        return redirect(url_for('user_page'))
    else:
        return redirect(url_for('home'))

@app.route('/user')
def user_page():
    if 'username' not in session:
        flash('You need to log in first.')
        return redirect(url_for('home'))

    search_term = request.args.get('search_term', '')

    # Regex search in PostgreSQL
    pattern = f"%{search_term}%"
    customers = Kunder.query.filter(
        Kunder.fornavn.ilike(pattern) |
        Kunder.efternavn.ilike(pattern) |
        Kunder.email.ilike(pattern)
    ).all()

    return render_template('user.html', customers=customers)

@app.route('/book_car/<int:bilid>', methods=['POST'])
def book_car(bilid):
    try:
        fornavn = request.form.get('fornavn')
        efternavn = request.form.get('efternavn')
        adresse = request.form.get('adresse')
        email = request.form.get('email')
        telefon = request.form.get('telefon')
        start_date = request.form.get('start_date')
        end_date = request.form.get('end_date')
        prisprmaaned = request.form.get('PrisPerMaaned')

        logging.debug(f'fornavn: {fornavn}')
        logging.debug(f'efternavn: {efternavn}')
        logging.debug(f'adresse: {adresse}')
        logging.debug(f'email: {email}')
        logging.debug(f'telefon: {telefon}')
        logging.debug(f'start_date: {start_date}')
        logging.debug(f'end_date: {end_date}')
        logging.debug(f'prisprmaaned: {prisprmaaned}')

        if not all([fornavn, efternavn, adresse, email, telefon, start_date, end_date, prisprmaaned]):
            raise ValueError("All fields are required")

        new_user = Kunder(fornavn=fornavn, efternavn=efternavn, adresse=adresse, email=email, telefon=telefon)
        db.session.add(new_user)
        db.session.commit()

        new_abonnement = Abonnementer(
            kundeid=new_user.kundeid,
            bilid=bilid,
            startdato=datetime.strptime(start_date, '%Y-%m-%d').date(),
            slutdato=datetime.strptime(end_date, '%Y-%m-%d').date(),
            prisprmaaned=int(prisprmaaned)  # Ensure this matches the model definition
        )
        db.session.add(new_abonnement)
        db.session.commit()

        return redirect(url_for('home'))
    except Exception as e:
        logging.exception("An error occurred while booking the car.")
        return redirect(url_for('home'))
    
@app.route('/user_details/<int:kundeid>', methods=['GET'])
def user_details(kundeid):
    customer = Kunder.query.get_or_404(kundeid)
    subscriptions = Abonnementer.query.filter_by(kundeid=kundeid).all()
    return render_template('user_details.html', customer=customer, subscriptions=subscriptions)

@app.route('/delete_customer/<int:kundeid>', methods=['POST'])
def delete_customer(kundeid):
    customer = Kunder.query.get_or_404(kundeid)
    subscriptions = Abonnementer.query.filter_by(kundeid=kundeid).all()
    for subscription in subscriptions:
        db.session.delete(subscription)
    db.session.delete(customer)
    db.session.commit()
    return redirect(url_for('user_page'))

@app.route('/delete_subscription/<int:abonnementid>', methods=['POST'])
def delete_subscription(abonnementid):
    subscription = Abonnementer.query.get_or_404(abonnementid)
    kundeid = subscription.kundeid
    db.session.delete(subscription)
    db.session.commit()
    return redirect(url_for('user_details', kundeid=kundeid))
    
if __name__ == '__main__':
    app.run(debug=True)