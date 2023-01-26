from flask import Flask, render_template, jsonify, url_for, request, redirect, session
from werkzeug.security import generate_password_hash, check_password_hash 
import mariadb
import mysql.connector

konekcija = mysql.connector.connect(
    passwd="", # password for the database
    user="root", # username
    database="gaming-site", # database name     
    port=3306, # port on which the mysql server is running 
    auth_plugin='mysql_native_password' # if you are using mysql 8.x  
)
kursor = konekcija.cursor(dictionary=True) # cursor = variable that allows us to connect to the database, we use it to execute queries
                                           # (connection between app and the database)
app = Flask(__name__)

#logic of the application

@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        hashed_password = generate_password_hash(password)
        # Insert the user's email and hashed password into the database
        kursor.execute(f"INSERT INTO korisnik (email, password_hash) VALUES ('{email}', '{hashed_password}')")
        konekcija.commit()
        return redirect(url_for("render_navigation"))



@app.route('/', methods=['GET','POST']) 
def render_navigation(): 
    search_term = request.args.get('q') 
    search_results = []
    produkti =[]
    if search_term:
        search_results = search_games_in_database(search_term)
    kursor.execute("SELECT * FROM produkti ORDER BY popularnost DESC")
    produkti = kursor.fetchall()
    return render_template('navigation.html', search_results=search_results, produkti=produkti)

@app.route('/primer', methods = ['GET'])

def render_primer() -> 'html':
    return render_template('primer.html')

def search_games_in_database(search_term):
    kursor.execute(f"SELECT * FROM produkti WHERE ime LIKE '%{search_term}%'")
    search_results = kursor.fetchall()
    return search_results

@app.route('/cart', methods=['GET','POST'])

def render_cart():
    

# to keep the application running
app.run(debug = True)
konekcija.close()

