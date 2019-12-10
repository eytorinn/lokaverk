
{% extends "base.html" %}
{% block title %} Skrifaðu innlegg {% endblock %}
{% block content %}
		<form action="{{ url_for('blog') }}" method="post" autocomplete="off">
			<h3> Write your blog </h3>
			<label>
                <textarea name='postur' cols ="100" rows="5"></textarea>
			</label>
			<label>
				<input type="hidden" name='userID' value="{{ ui }}">
			</label>
			<h5>{{ msg }}</h5>
			<input type='submit' class="button" value="Submit">
		</form>

    <hr>

    {% if session['logged_in'] %}
      <h3>Breyta eigin póstum</h3>
      <form method='post' action='/change'>
        <input input type="hidden" name="userID" value="{{ ui }}">
        <input type='submit' value='Breyta'>
      </form>
    {% endif %}

<p><a href="/homePage" class="butt">heimasíða</a></p>
<p><a href="/logout" class="butt">Útskráning</a></p>


{% endblock %}
