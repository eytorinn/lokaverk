{% extends "base.html" %}
{% block title %}Breyta pósti{% endblock %}
{% block content %}

{% with messages = get_flashed_messages() %}
  {% if messages %}
    <h4 class="ok">
    {% for message in messages %}
      {{ message }}
    {% endfor %}
    {{ ui }} 
     </h4>
  {% endif %}
{% endwith %}
<h3>{{ self.title() }}</h3>
<h4> 
  {% if session['logged_in'] %}

  {% endif %}
</h4>

<table>
    <th>Númer</th>
    <th>Póstur</th>
    <th>Notandi</th>
  </tr>
{% for row in userPosts %}
  <tr>
    <td><a href='/changePost/{{row[0]}}'>{{row[0]}}</a></td>
    <td>{{row[1]}}</td>
    <td>{{row[2]}}</td>
  </tr>
{% endfor %}

</table>
<p>innskráður: {{ ui }} </p>
<p><a href="/logout">Útskráning</a></p>

{% endblock %}