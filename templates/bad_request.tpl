{% extends "base.html" %}
{% block title %}Villa - 400{% endblock %}

{% block content %}
    <div class="errormsg">
        <h1>400</h1>
        <h3> Miðlarinn skilur ekki fyrirspurnina :( </h3>
        <p>This response means that server could not understand the request due to invalid syntax</p>
        <a href="/logout">Aftur á skráningarsíðu</a>
    </div>
{% endblock %}