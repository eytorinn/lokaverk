{% extends "base.html" %}
{% block title %}Villa - 404{% endblock %}

{% block content %}
    <div class="errormsg">
        <h1>404</h1>
        <h3> Vefsíðan finnst ekki :( </h3>
        <P>The server can not find requested resource. In the browser, this means the URL is not recognized. In an API, this can also mean that the endpoint is valid but the resource itself does not exist. Servers may also send this response instead of 403 to hide the existence of a resource from an unauthorized client. This response code is probably the most famous one due to its frequent occurence on the web.
        </P>
        <P> Heimild: <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Status">Dev Mos</a></p>
        <a href="/">Aftur á skráningarsíðu</a>
    </div>
{% endblock %}