from flask import Flask, render_template, jsonify, url_for, request, redirect, session, flash
from werkzeug.security import generate_password_hash, check_password_hash
import mariadb
import mysql.connector

connection = mysql.connector.connect(
    passwd="", # password for the database
    user="root", # username
    database="gaming-site", # database name     
    port=3306, # port on which the mysql server is running 
    auth_plugin='mysql_native_password' # if you are using mysql 8.x  
)
cursor = connection.cursor(dictionary=True) # cursor = variable that allows us to connect to the database, we use it to execute queries
                                           # (connection between app and the database)

app = Flask(__name__)
app.secret_key = 'acaPukiAleksa'

#logic of the application

@app.route('/cart', methods=['GET','POST'])
def render_cart():
    if request.method =='GET':
        return render_template('cart.html')
    
@app.route('/productpage/<id>', methods=['GET','POST'])
def render_productpage(id = 1):
    query = "SELECT * FROM produkti WHERE id=%s"
    value = (id,)
    cursor.execute(query,value)
    products = cursor.fetchall()
    return render_template('productpage.html',products = products)

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'GET':
        return render_template('signup.html')
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        vrednost = (email,)
        query = "SELECT password_hash FROM korisnik WHERE email= %s"
        cursor.execute(query, vrednost)
        user = cursor.fetchone() #zapamtio ga je kao recnik?
        if user != None:
            if check_password_hash(user["password_hash"], password):
                flash('You were logged in')
                return redirect(url_for('render_navigation'))
            else:
                flash('Wrong password')
                return redirect(url_for('render_primer'))
        else:
            flash('User not found')
            return redirect(url_for('signup'))

@app.route('/new_user', methods=['GET', 'POST'])
def new_user():
     if request.method == 'GET':
        return render_template('signup.html')
     elif request.method == 'POST':
        forma = request.form
        hash_password = generate_password_hash(forma["password"])
        vrednosti = (
            forma["name"],
            forma["last name"],
            forma["email"],
            hash_password,
            "user"
        )
        query = "insert INTO korisnik (ime,prezime,email,password_hash,rola) values (%s,%s,%s,%s,%s)"
        cursor.execute(query,vrednosti)
        connection.commit()
        return(redirect(url_for('signup')))
        #return render_template('navigation.html') test za shvatanje app route
@app.route('/', methods=['GET','POST']) 
def render_navigation():
    query = "SELECT * FROM produkti" #ako hocu da ga sortira kazem mu: query = "SELECT * FROM produkti where order by popularnost asc/desc"
    cursor.execute(query) # ako imam vise query-a onda bi izgledalo ovako: query, multi = True
    rows = cursor.fetchall() #fetchuj mi sve redove iz tabele
    return render_template('navigation.html', rows = rows)


@app.route('/primer', methods=['GET','POST'])
def render_primer():
    cursor.execute("SELECT image_url FROM produkti")
    slika = cursor.fetchall() #fetchuj mi sve slike
    return render_template('primer.html', slika = slika)

@app.route('/terms', methods=['GET','POST'])
def render_terms():
    return render_template('terms.html')

@app.route('/private', methods=['GET','POST'])
def render_private():
    return render_template('private.html')

@app.route('/faq', methods=['GET', 'POST'])
def render_faq():
    return render_template('faq.html')

@app.route('/allgames', methods=['GET', 'POST'])
def render_allgames():
    query = "SELECT * FROM produkti" #ako hocu da ga sortira kazem mu: query = "SELECT * FROM produkti where order by popularnost asc/desc"
    cursor.execute(query) # ako imam vise query-a onda bi izgledalo ovako: query, multi = True
    rows = cursor.fetchall() #fetchuj mi sve redove iz tabele
    return render_template('.html', rows = rows)

@app.route('/payment', methods=['GET', 'POST'])
def render_payment():
    return render_template('payment.html')

# to keep the application running
app.run(debug = True)
connection.close()


