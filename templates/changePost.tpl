{% extends "base.html" %}
{% block title %}Eigin póstar{% endblock %}

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

<h4> 
  {% if session['logged_in'] %}
    <p>innskráður: {{ ui }} </p>
  {% endif %}
</h4>
<form method='post' action='/update/' accept-charset="UTF-8">
    <table>  
        <tr>
        {% for item in postur %}
            <td><p>Póstnúmer:{{item[0]}} <input type="hidden" name="postID" value="{{item[0]}}"></p>
            <br><textarea rows="6" name="postur">{{item[1]}}</textarea>
            <input type="hidden" name="userID" value="{{item[2]}}"></td>
        {% endfor %}
        </tr>
        <tr> <!-- ath id sem notað er til að velja á milli eyða og bæta við -->
            <td><input type='submit' name='breyta' value='Breyta'> | 
            <input type='submit' name='eyda' value='Eyða' class="error"></td>
        </tr>
    </table>
</form>
<p><a href="/logout" class="butt">Útskráning</a></p>
{% endblock %}