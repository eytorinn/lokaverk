{% extends "base.html" %}
{% block title %}Forsíða{% endblock %}

{% block content %}
<h3>{{ self.title() }}</h3>
{% with messages = get_flashed_messages() %}
  {% if messages %}
    <h4 class="ok">
    {% for message in messages %}
      {{ message }}
    {% endfor %}
  </h4>
  {% endif %}
{% endwith %}
</h4>
    {% if session['logged_in'] %}

    {% endif %}

<table id="tafla">
	<tr>
		<td>Höfundur</td><th colspan=2>Póstar</th><td>Nr.</td>
	</tr>
  {% for postur in userDetails %}
  <tr>
    <td>{{postur[2]}}</td><td colspan=2>{{postur[1]}}</td><td>{{postur[0]}}</td>
  </tr>
  {% endfor %}
</table>

<p><a href="{{ url_for('blog') }}" class="butt">blog</a></p>
<p><a href="/logout" class="butt">Útskráning</a></p>


{% endblock %}