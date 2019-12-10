{% extends "base.html" %}
{% block title %}Logout{% endblock %}

{% block content %}
    <h3>{{ self.title() }}</h3>
    <h4>Takk fyrir komuna</h4>
        {% if session['logged_in'] == False  %}

    {% endif %}
    <p><a href="/">Aftur á skráningarsíðu</a></p>
{% endblock %}