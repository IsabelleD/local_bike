{% macro calculate_revenue(list_price, quantity, discount) %}
    round({{ list_price }} * {{ quantity }} * (1 - {{ discount }}), 2)
{% endmacro %}
