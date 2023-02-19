from flask import Flask, render_template, jsonify, url_for, request, redirect, session
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
"""The variable __name__ is passed as first argument when creating an instance of the Flask object 
(a Python Flask application). In this case __name__ represents the name of the application package and it’s used 
by Flask to identify resources like templates, static assets and the instance folder."""

app.secret_key = 'acaPukiAleksa' 
#Each Flask web application contains a secret key which used to sign session cookies for protection against cookie data tampering

#logic of the application
def ulogovan():
    if "ulogovani_user" in session:
        return True         
    else:                 
        return False
@app.route('/cartadd<id>', methods=['GET','POST'])
def cartadd(id):
    query = "INSERT INTO cart(id_korisnik,id_produkti) values(%s,%s)"
    value = (session.get("ulogovani_user"),id)
    cursor.execute(query,value)
    connection.commit()
    return redirect(url_for("render_productpage",id = id))

@app.route('/cartdelete<id>', methods=['GET','POST'])
def cartdelete(id):
    query = "DELETE FROM cart WHERE id_korisnik = %s AND id_produkti = %s LIMIT 1"
    value = (session.get("ulogovani_user"),id)
    cursor.execute(query,value)
    connection.commit()
    return redirect(url_for("render_cart"))


@app.route('/cart', methods=['GET','POST'])
def render_cart():
    query = "SELECT p.*, c.* FROM produkti p  JOIN cart c on p.id = c.id_produkti "
    cursor.execute(query)
    product = cursor.fetchall()
    return render_template('cart.html',product = product)


  
@app.route('/productpage/<id>', methods=['GET','POST'])
def render_productpage(id = 1): # u principu ovaj id nam sluzi da racunar shvati sta i kako, nije nama vazan
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
        email = request.form['email'] # iz htmla primi mail
        password = request.form['password'] # iz htmla primi password i to obican a ne hesovan
        value = (email,)
        query = "SELECT * FROM korisnik WHERE email= %s"
        cursor.execute(query, value)
        user = cursor.fetchone() #zapamtio ga je kao dictionary.
        if user != None:
            if check_password_hash(user["password_hash"], password):
                session["ulogovani_user"] = user["id"]
                print("2222222222222222222222222222222222222222",session["ulogovani_user"])
                return redirect(url_for('render_navigation'))
            else:
                return redirect(url_for('render_primer'))
        else:
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
        print("22222222222222222222",type(vrednosti)) # do ovde sam stigo sa proverom
        query = "insert INTO korisnik (ime,prezime,email,password_hash,rola) values (%s,%s,%s,%s,%s)"
        cursor.execute(query,vrednosti)
        connection.commit()
        return(redirect(url_for('signup')))
        #return render_template('navigation.html') test za shvatanje app route

@app.route("/logout") 
def logout():
    session["ulogovani_user"] = None
    return redirect(url_for("signup"))

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
    return render_template('allgames.html')

@app.route('/payment', methods=['GET', 'POST'])
def render_payment():
    return render_template('payment.html')

# to keep the application running
app.run(debug = True)
connection.close()

