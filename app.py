from flask import Flask, render_template, url_for, request, redirect, session
from werkzeug.security import generate_password_hash, check_password_hash 
import mariadb
import mysql.connector

konekcija = mysql.connector.connect(
    passwd="", # lozinka za bazu
    user="root", # korisničko ime
    database="gaming-site", # ime baze     
    port=3306, # port na kojem je mysql server 
    auth_plugin='mysql_native_password' # ako se koristi mysql 8.x  
)
kursor = konekcija.cursor(dictionary=True)# kursor = promenljiva koja nam sluzi da se povezemo sa bazom, nad njom izvrsavamo upite
                                           #(veza izmedju app i baze)
#deklaracija aplikacije
app = Flask(__name__)

#logika aplikacije
@app.route('/', methods=['GET','POST']) # "/" moze da ostane za ovo, a login neka se desava po zelji

def render_navigation() -> 'html':
    return render_template('navigation.html')

@app.route('/primer', methods = ['GET'])

def render_primer() -> 'html':
    return render_template('primer.html')

#da aplikacija stalno bude upaljena
app.run(debug = True)