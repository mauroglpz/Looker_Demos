view: users {
  sql_table_name: public.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [18, 25, 35, 45, 55, 65, 75, 90]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: city_link {
    type: string
    sql: ${TABLE}.city ;;
    link: {
      label: "Search the web"
      url: "http://www.google.com/search?q={{ value | url_encode }}"
      icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | url_encode }}.com"
    }
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: state_link {
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: us_states
    html: {% if _explore._name == "order_items" %}
          <a href="/explore/mauromtr/order_items?fields=order_items.detail*&f[users.state]= {{ value }}">{{ value }}</a>
        {% else %}
          <a href="/explore/mauromtr/users?fields=users.detail*&f[users.state]={{ value }}">{{ value }}</a>
        {% endif %} ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: order_history_button {
    type: string
    sql: ${TABLE}.id ;;
    html: <a href="/explore/mauromtr/order_items?fields=order_items.order_id, users.first_name, users.last_name, users.id, order_items.count, order_items.total_revenue&f[users.id]={{ value }}"><button>Order History</button></a> ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count]
  }

  measure: average_age {
    type: average
    sql: ${TABLE}.age;;
  }

# ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }

}
