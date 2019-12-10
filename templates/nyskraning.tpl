{% extends "base.html" %}
{% block title %} Nýskráning {% endblock %}

{% block content %}
{% if error %}
    <p class=error>Villa:<strong> {{ error }} </strong>
  {% endif %}

<h3>{{ self.title() }}</h3>
<form method="POST" action="{{ url_for('nyr') }}">
    <p>Notandanafn <input type="text" name="userID" required /></p>
    <p>Nafn <input type="text" name="user_name" required /></p>
    <p>Tölvupóstur <input type="email" name="user_email" required /></p>
    <p>Lykilorð <input type="password" name="user_password" required /></p>   <!-- notið type="password" -->
    </p><input type="submit" value="senda"></p>
</form>
<p><a href="{{ url_for('login') }}" class="butt">login</a></p>

{% endblock %}