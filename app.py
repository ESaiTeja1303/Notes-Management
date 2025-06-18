from flask import Flask,render_template,request,redirect,session,url_for,flash
import random,emaillo
from itsdangerous import URLSafeTimedSerializer,SignatureExpired
import bcrypt
from database import db
from flask_sqlalchemy import SQLAlchemy
app=Flask(__name__)


app.secret_key="teja123" 
s=URLSafeTimedSerializer(app.secret_key)  


def generateotp():
    otp = random.randint(1000, 9999)
    return str(otp)

@app.route('/')
def home():
    return render_template("home.html")


@app.route('/login',methods=['GET','POST'])
def login():
    if request.method=="POST":
        email=request.form.get("email")
        password=request.form.get("password")
        cursor=db.cursor()
        cursor.execute("SELECT id,username,password FROM users WHERE email=%s",(email,))
        user=cursor.fetchone()
        if user and bcrypt.checkpw(password.encode('utf-8'),user[2].encode('utf-8')):
            session['u_id']=user[0]
            session['username']=user[1]
            session['otp']=generateotp()
            subject="OTP for verification"
            body= f"otp for verification {session['otp']}"
            if emaillo.send_email(email,subject,body):
                return redirect("verify")
            else:
                return render_template("login.html",info='unable to send otp')


        else:
            return render_template("login.html",info="Invalid userdetails,try again!!")
    return render_template("login.html")
    

@app.route('/register',methods=["GET","POST"])
def register():
    if request.method=="POST":
        username=request.form.get("username")
        email=request.form.get("email")
        password=request.form.get("password")
        hashed_password=bcrypt.hashpw(password.encode('utf-8'),bcrypt.gensalt()).decode('utf-8')
        cursor=db.cursor()
        cursor.execute("SELECT username FROM users WHERE email=%s",(email,))
        user=cursor.fetchone()
        if user:
            return render_template("register.html",info="This email id is already registered!!")
        cursor.execute("INSERT INTO users (username,email,password) VALUES (%s,%s,%s)",(username,email,hashed_password))
        db.commit()
        return redirect("login")
    return render_template("register.html")

@app.route('/contact')
def contact():
    return render_template("contact.html")


@app.route('/dashboard')
def dashboard():
    if 'verified login' in session and 'u_id' in session:
        u_id=session["u_id"]
        cursor=db.cursor(dictionary=True)
        query="SELECT * FROM notes WHERE user_id=%s ORDER BY created_at DESC"
        cursor.execute(query,(u_id,))
        notes=cursor.fetchall()
        cursor.close()
        return render_template("dashboard.html",notes=notes,usname=session.get('username'))
    return redirect('login')


@app.route('/forgotpassword',methods=['GET','POST'])
def forgotpassword():
    if request.method=='POST':
        email=request.form.get('email')
        cursor=db.cursor()
        cursor.execute("SELECT username FROM users WHERE email=%s",(email,))
        user=cursor.fetchone()
        if user:
            session['email']=email
            token=s.dumps(email,salt='password-reset-salt')
            reset_url=url_for('resetpassword',token=token,_external=True)
            subject='Password Reset Request'
            body=f"Click the link to reset your password:{reset_url}\n\nThis link will expire in 1 hour."
            if emaillo.send_email(email,subject,body):
                return render_template("forgotpassword.html",info='reset link send to email')
            else:
                return render_template("forgotpassword.html",info='unable to send link')
        return render_template('forgotpassword.html',info="Email is not registered!!")
    return render_template('forgotpassword.html')

@app.route('/resetpassword/<token>',methods=['GET','POST'])
def resetpassword(token):
    try:
        email=s.loads(token,salt='password-reset-salt',max_age=3600)
    except SignatureExpired:
        return render_template('forgotpassword.html',info='Token Expired.Request a new link.')
    if request.method=='POST':
        newpassword=request.form.get('newpassword')
        confirmpassword=request.form.get('confirmpassword')
        if newpassword==confirmpassword:
            email=session.get('email')
            hashed_password=bcrypt.hashpw(newpassword.encode('utf-8'),bcrypt.gensalt()).decode('utf-8')
            if email:
                cursor=db.cursor()
                cursor.execute("UPDATE users SET password=%s WHERE email=%s",(hashed_password,email))
                db.commit()
                session.pop('email',None)
            return redirect(url_for('login'))
        else:
            return render_template('resetpassword',info="Newpassword and confirm password didn't match")
    return render_template('resetpassword.html')

@app.route('/verify',methods=['GET','POST'])
def verify():
    if request.method=='POST':
        enteredotp=request.form.get('otp')
        if enteredotp==session['otp']:
            session.pop('otp',None)
            session['verified login']=True
            return redirect('dashboard')

        else:
            return render_template('verify.html',info='Enter the correct otp')
    return render_template('verify.html')


@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login')) 


@app.route('/create_note',methods=['POST'])
def create_note():
    if "u_id" in session:
        content=request.form.get('content')
        u_id=session['u_id']
        cursor=db.cursor()
        cursor.execute("INSERT INTO notes (user_id,content) VALUES (%s,%s)",(u_id,content))
        db.commit()
        return redirect(url_for('dashboard'))
    return redirect(url_for('login'))

@app.route('/delete_note/<int:note_id>')
def delete_note(note_id):
    if "u_id" in session:
        u_id = session['u_id']

        cursor = db.cursor()

        cursor.execute("DELETE FROM notes WHERE id = %s AND user_id = %s", (note_id, u_id))
        db.commit()
        return redirect(url_for('dashboard'))
    
    return redirect(url_for('login'))

@app.route('/edit_note/<int:note_id>',methods=['GET','POST'])
def edit_note(note_id):
    if 'u_id' not in session:
        return redirect(url_for('login'))
    cursor=db.cursor(dictionary=True)
    if request.method=="POST":
        u_id=session['u_id']
        new_content=request.form.get('content')
        cursor.execute("UPDATE notes SET content=%s WHERE id=%s AND user_id=%s",(new_content,note_id,u_id))
        db.commit()
        return redirect(url_for('dashboard'))
    

    cursor.execute("SELECT * FROM notes WHERE id=%s AND user_id=%s",(note_id,session['u_id']))
    note=cursor.fetchone()
    cursor.close()
    if note:
        return render_template('editnote.html',note=note)
    return redirect(url_for('dashboard'))



if __name__=='__main__':
    app.run(debug=True)