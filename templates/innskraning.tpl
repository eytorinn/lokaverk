{% extends "base.html" %}
{% block title %} Innskráning {% endblock %}

{% block content %}
{% with messages = get_flashed_messages() %}
  {% if messages %}
    <h4 class="ok">
    {% for message in messages %}
      {{ message }}
    {% endfor %}
     {{ name }}
     </h4>
  {% endif %}
{% endwith %}
{% if error %}
    <p class=error>Villa:<strong> {{ error }} </strong>
  {% endif %}

<h3>{{ self.title() }}</h3>

    <form method="POST" action="{{ url_for('login') }}">
        <p>Notandanafn <input type="text" name="userID" required /></p>
        <p>Lykilorð <input type="password" name="user_password" required /></p>
        </p><input type="submit" value="senda"></p>
    </form>
<p><a href="{{ url_for('nyr') }}" class="button">register</a></p>

{% endblock %}