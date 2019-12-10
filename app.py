
import os
from flask import Flask, flash, redirect, render_template, request, url_for, make_response, escape, session, abort
import pymysql

app = Flask(__name__)
app.secret_key = os.urandom(12)
print(os.urandom(12))


conn = pymysql.connect(host='localhost', port=3306, user='root', password='root', database='lokaverkefni')

@app.route('/', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        ui = request.form.get('userID')
        psw = request.form.get('user_password')

        conn = pymysql.connect(host='localhost', port=3306, user='root', password='root', database='lokaverkefni')
        cur = conn.cursor()
        cur.execute("SELECT * FROM lokaverkefni.users where userID=%s AND user_password=%s",(ui,psw))
        result = cur.fetchone() #fáum tuple -fetchone
        session['user'] = ui
        # er user og psw til í db?
        if ui == 'admin' and result[3] == psw:
            cur.close()
            conn.close()
            flash('Innskráning tókst ')
            session['logged_in'] = True
            return redirect(url_for('homeAD',ui=ui))
        elif result:
            cur.close()
            conn.close()
            flash('Innskráning tókst ')
            session['logged_in'] = True
            return redirect(url_for('home',ui=ui))
        else:
            error = 'Innskráning mistókst - reyndu aftur'

    return render_template('innskraning.tpl', error=error)

@app.route("/logout")
def logout():
    session['logged_in'] = False
    return render_template('logout.tpl')




@app.route('/nyskra', methods=['GET', 'POST'])
def nyr():
    error = None
    if  request.method == 'POST':
        userDetails = request.form
        user = userDetails['userID']
        name = userDetails['user_name']
        email = userDetails['user_email']
        password = userDetails['user_password']

        try:
            cur = conn.cursor()
            cur.execute("INSERT INTO lokaverkefni.users(userID, user_name, user_email, user_password) VALUES(%s, %s, %s, %s)",(user, name, email, password))
            conn.commit()
            print(cur)
            cur.close()
            flash('Nýskráning tókst! Skráðu þig inn ')
            return render_template('innskraning.tpl',name=name)
        except pymysql.IntegrityError:
            error = 'Notandi er þegar skráður með þessu nafni og/eða lykilorði'
    return render_template('nyskraning.tpl', error=error)

@app.route('/homePage')
def home():
    if 'logged_in' in session:
        conn = pymysql.connect(host='localhost', port=3306, user='root', password='root', database='lokaverkefni')
        cur = conn.cursor()
        resultValue = cur.execute("SELECT * FROM lokaverkefni.posts;")
        if  resultValue > 0:
            userDetails = cur.fetchall()
            flash('Velkomin')
            return render_template('homePage.tpl',userDetails=userDetails)

@app.route('/home_ad')
def homeAD():
    if 'logged_in' in session:
        conn = pymysql.connect(host='localhost', port=3306, user='root', password='root', database='lokaverkefni')
        cur = conn.cursor()
        users = cur.execute("SELECT * FROM lokaverkefni.users;")
        if users:
            users = cur.fetchall()
            flash('Velkomin')
            return render_template('home_ad.tpl',users=users,ui=session['user'])


@app.route('/new_post', methods=['GET', 'POST'])
def blog():
    if 'logged_in' in session:
        msg = ''
        if request.method == 'POST' and 'postur' in request.form and 'userID' in request.form:
            postID = request.form.get('postID')
            postur = request.form.get('postur')
            userID = request.form.get('userID')
            cur = conn.cursor()
            cur.execute("SELECT * FROM lokaverkefni.posts where userID = %s", (userID))
            blogs = cur.fetchone()
            if blogs:
                cur.execute("INSERT INTO lokaverkefni.posts VALUES(%s,%s,%s)", (postID, postur, userID))
                conn.commit()
                cur.close()
                msg = 'You wrote the blog!'
            else:
                msg = 'The blog already exist'
        cur = conn.cursor()
        cur.execute("SELECT * FROM lokaverkefni.posts")
        blogs = cur.fetchall()
        return render_template('blog.tpl', msg=msg, ui=session['user'])
    return redirect(url_for('home'))



@app.route('/change', methods=['GET', 'POST'])
def edit():
    if not session.get('logged_in'):
        return render_template('innskraning.tpl')
    else:
        session['logged_in'] = True

    error = None
    if request.method == 'POST':
        ui = request.form.get('userID')
        try:
            cur = conn.cursor()
            userPosts = cur.execute("SELECT * FROM lokaverkefni.posts WHERE userID=%s", (ui))
            if userPosts > 0:
                userPosts = cur.fetchall()
                flash('Veldu póstnúmer ')
                print(ui)
                return render_template('change.tpl', userPosts=userPosts, ui=ui)
        except pymysql.IntegrityError:
            error = 'Þú hefur ekki aðgang að þessari síðu'
        #return render_template('logout.tpl')


@app.route('/changePost/<int:id>', methods=['GET', 'POST'])
def editpost(id):
    if not session.get('logged_in'):
        return render_template('innskraning.tpl')
    else:
        session['logged_in'] = True

    try:
        conn = pymysql.connect(host='localhost', port=3306, user='root', password='root', database='lokaverkefni')
        cur = conn.cursor()
        cur.execute("SELECT * FROM lokaverkefni.posts WHERE postID=%s", id)
        conn.commit()

        postur = cur.fetchall()  # fáum gögnin í "tuple"
        print(id)
        if postur:
            return render_template('changePost.tpl', postur=postur)
        else:
            return 'Villa! Póstur #{id} er ekki til'
    finally:
        cur.close()
        conn.close()



@app.route('/update/', methods=['GET', 'POST'])
def post():
    if not session.get('logged_in'):
        return render_template('index.tpl')
    else:
        session['logged_in'] = True

    pi = request.form.get('postID')
    po = request.form.get('postur')
    ui = request.form.get('userID')

    button = request.form.get('breyta')
    # input VALUE = Breyta  else Eyða
    if button == 'Breyta':
        conn = pymysql.connect(host='localhost', port=3306, user='root', passwd='root', db='lokaverkefni')
        cur = conn.cursor()
        cur.execute("UPDATE lokaverkefni.posts SET postur=%s WHERE postID=%s AND userID=%s", (po, pi, ui))
        conn.commit()
        print(cur)
        cur.close()
        conn.close()
        flash('Póstinum hefur< verið breytt ')
        session['logged_in'] = True
        return render_template('blog.tpl', ui=ui)
        # return redirect(url_for('user',ui=ui))
    else:
        conn = pymysql.connect(host='localhost', port=3306, user='root', passwd='root', db='lokaverkefni')
        cur = conn.cursor()
        cur.execute("Delete FROM lokaverkefni.posts WHERE postID=%s", (pi))
        conn.commit()
        cur.close()
        conn.close()
        flash('Póstinum hefur verið eytt úr gagnagrunninum ')
        # return redirect(url_for('user',ui=ui))
        return render_template('blog.tpl', ui=ui)

if __name__ == '__main__':
    app.run(debug=True)
#    app.run(host='0.0.0.0')
