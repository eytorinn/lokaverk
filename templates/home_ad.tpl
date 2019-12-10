{% extends "base.html" %}
{% block title %} Admin Home {% endblock %}
{% block content %}
	<h1>Admin Home Page </h1>
<table id="tafla">
    <th>userID</th>
    <th>user_name</th>
    <th>user_email</th>
    <th>user_password</th>

  </tr>
{% for row in users %}
  <tr>
    <td>{{row[0]}}</td>
    <td>{{row[1]}}</td>
    <td>{{row[2]}}</td>
    <td>{{row[3]}}</td>
  </tr>
{% endfor %}

</table>
<p>innskráður: {{ ui }} </p>

<p><a href="{{ url_for('blog') }}" class="butt">blog</a></p>
<p><a href="/homePage" class="butt">heimasíða</a></p>
<p><a href="/logout" class="butt">Útskráning</a></p>
{% endblock %}
