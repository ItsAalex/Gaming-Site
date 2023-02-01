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

# Create a cart list in the session to store selected game IDs
@app.before_request
def create_cart():
    if 'cart' not in session:
        session['cart'] = []

# Add a game to the cart
@app.route('/add_to_cart/<int:game_id>')
def render_add_to_cart(game_id):
    session['cart'].append(game_id)
    return redirect(url_for("render_navigation"))

# Remove a game from the cart
@app.route('/remove_from_cart/<int:game_id>')
def remove_from_cart(game_id):
    session['cart'].remove(game_id)
    return redirect(url_for("render_navigation"))

# Display the cart
@app.route('/cart')
def render_cart():
    cart = []
    total_price = 0
    for game_id in session['cart']:
        cursor.execute(f"SELECT * FROM produkti WHERE id = {game_id}")
        game = cursor.fetchone()
        cart.append(game)
        total_price += game['cena']
    return render_template('cart.html', cart=cart, total_price=total_price)

# Clear the cart
@app.route('/clear_cart')
def clear_cart():
    session['cart'] = []
    return redirect(url_for("render_navigation"))

#logic of the application

@app.route('/login', methods=['GET', 'POST'])
def render_login():
    if request.method == 'GET':
        return render_template('login.html')
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        vrednost = (email,)
        cursor.execute("SELECT password_hash FROM korisnik WHERE email= %s", vrednost)
        user = cursor.fetchone()
        if user:
            if (user["password_hash"] == password):
                flash('You were logged in')
                return redirect(url_for('render_navigation'))
            else:
                flash('Wrong password')
                return redirect(url_for('render_primer'))
        else:
            flash('User not found')
            return redirect(url_for('render_login'))


@app.route('/signup', methods=['GET', 'POST'])
def render_signup():
    return render_template('signup.html')

@app.route('/new_user',methods=['GET','POST'])
def new_user():
    if request.method=='GET':
        render_template('navigation.html')
    elif request.method == 'POST':
        forma = request.form
        hash_password = generate_password_hash(forma["lozinka"])
        vrednosti = (
            forma["ime"],
            forma["prezime"],
            forma["email"],
            hash_password,
            "user"
        )
        upit = "insert INTO korisnik (ime,prezime,email,password_hash,rola) values (%s,%s,%s,%s,%s)"
        cursor.execute(upit,vrednosti)
        connection.commit()
        return(redirect(url_for('render_login')))

@app.route('/', methods=['GET','POST']) 
def render_navigation(): 
    products =[]
    cursor.execute("SELECT * FROM produkti ORDER BY popularnost DESC")
    products = cursor.fetchall()
    return render_template('navigation.html', products = products)


@app.route('/primer', methods=['GET','POST'])
def render_primer():
    return render_template('primer.html')

# to keep the application running
app.run(debug = True)
connection.close()

