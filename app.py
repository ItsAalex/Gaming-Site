from flask import Flask, render_template, jsonify, url_for, request, redirect, session, flash
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
        kursor.execute(f"SELECT * FROM produkti WHERE id = {game_id}")
        game = kursor.fetchone()
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
        connection = mysql.connector.connect(
            host="127.0.0.1",
            user="root",
            password="",
            database="gaming-site"
        )
        cursor = connection.cursor()
        cursor.execute(f"SELECT password_hash FROM korisnik WHERE email='{email}'")
        user = cursor.fetchone()
        connection.close()
        if user:
            if check_password_hash(user[0], password):
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
    if request.method == 'GET':
        return render_template('signup.html')
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        password_confirm = request.form['password_confirm']
        if password != password_confirm:
            flash('Passwords do not match')
            return redirect(url_for('signup'))
        password_hash = generate_password_hash(password)
        connection = mysql.connector.connect(
            host="127.0.0.1",
            user="root",
            password="",
            database="gaming-site"
        )
        cursor = connection.cursor()
        cursor.execute(f"INSERT INTO korisnik (email, password_hash) VALUES ('{email}', '{password_hash}')")
        connection.commit()
        connection.close()
        flash('You were signed up')
        return redirect(url_for('login'))


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


@app.route('/primer', methods=['GET','POST'])
def render_primer():
    return render_template('primer.html')

# to keep the application running
app.run(debug = True)
konekcija.close()

