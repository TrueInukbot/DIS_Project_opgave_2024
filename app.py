import logging
import os
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
    if username == 'admin' and password == '12345':
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

        insert_kunde_path = os.path.join('sql', 'insert_kunde.sql')
        insert_abonnement_path = os.path.join('sql', 'insert_abonnement.sql')

        logging.debug(f'Checking if SQL files exist...')
        if not os.path.exists(insert_kunde_path):
            logging.error(f"The file {insert_kunde_path} does not exist.")
            raise FileNotFoundError(f"The file {insert_kunde_path} does not exist.")
        if not os.path.exists(insert_abonnement_path):
            logging.error(f"The file {insert_abonnement_path} does not exist.")
            raise FileNotFoundError(f"The file {insert_abonnement_path} does not exist.")

        logging.debug(f'Reading SQL files...')
        with open(insert_kunde_path, 'r') as file:
            sql_kunde_content = file.read().strip()
        with open(insert_abonnement_path, 'r') as file:
            sql_abonnement_content = file.read().strip()

        logging.debug(f'insert_kunde.sql content: {sql_kunde_content}')
        logging.debug(f'insert_abonnement.sql content: {sql_abonnement_content}')

        if not sql_kunde_content or not sql_abonnement_content:
            logging.error("One of the SQL scripts is empty.")
            raise ValueError("SQL script is empty.")

        sql_kunde = text(sql_kunde_content)
        sql_abonnement = text(sql_abonnement_content)

        result = db.session.execute(sql_kunde, {
            'fornavn': fornavn,
            'efternavn': efternavn,
            'adresse': adresse,
            'email': email,
            'telefon': telefon
        })
        new_kundeid = result.scalar()

        db.session.execute(sql_abonnement, {
            'kundeid': new_kundeid,
            'bilid': bilid,
            'startdato': datetime.strptime(start_date, '%Y-%m-%d').date(),
            'slutdato': datetime.strptime(end_date, '%Y-%m-%d').date(),
            'prisprmaaned': int(prisprmaaned)
        })
        db.session.commit()

        return redirect(url_for('home'))
    except Exception as e:
        logging.exception("An error occurred while booking the car.")
        db.session.rollback()
        return redirect(url_for('home'))


@app.route('/user_details/<int:kundeid>', methods=['GET'])
def user_details(kundeid):
    customer = Kunder.query.get_or_404(kundeid)
    subscriptions = Abonnementer.query.filter_by(kundeid=kundeid).all()
    return render_template('user_details.html', customer=customer, subscriptions=subscriptions)

@app.route('/update_customer/<int:kundeid>', methods=['GET', 'POST'])
def update_customer(kundeid):
    customer = Kunder.query.get_or_404(kundeid)
    subscriptions = Abonnementer.query.filter_by(kundeid=kundeid).all()
    if request.method == 'POST':
        fornavn = request.form['fornavn']
        efternavn = request.form['efternavn']
        adresse = request.form['adresse']
        email = request.form['email']
        telefon = request.form['telefon']

        sql = text(open('sql/update_user.sql').read())
        try:
            db.session.execute(sql, {
                'kundeid': kundeid,
                'fornavn': fornavn,
                'efternavn': efternavn,
                'adresse': adresse,
                'email': email,
                'telefon': telefon
            })
            db.session.commit()
            return redirect(url_for('user_details', kundeid=kundeid))
        except Exception as e:
            db.session.rollback()
            return f"There was an issue updating the customer: {str(e)}"
    else:
        return render_template('user_details.html', customer=customer, subscriptions=subscriptions)

@app.route('/delete_customer/<int:kundeid>', methods=['POST'])
def delete_customer(kundeid):
    sql = text(open('sql/delete_user.sql').read())
    try:
        db.session.execute(sql, {'kundeid': kundeid})
        db.session.commit()
        return redirect(url_for('user_page'))
    except Exception as e:
        db.session.rollback()
        return f"There was an issue deleting the customer: {str(e)}"

@app.route('/delete_subscription/<int:abonnementid>', methods=['POST'])
def delete_subscription(abonnementid):
    subscription = Abonnementer.query.get_or_404(abonnementid)
    kundeid = subscription.kundeid 
    sql = text(open('sql/delete_subscription.sql').read())
    try:
        db.session.execute(sql, {'abonnementid': abonnementid})
        db.session.commit()
        return redirect(url_for('user_details', kundeid=kundeid))
    except Exception as e:
        db.session.rollback()
        return f"There was an issue deleting the subscription: {str(e)}"
    
if __name__ == '__main__':
    app.run(debug=True)