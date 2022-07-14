view: user_facts {
    derived_table: {
      sql: SELECT user_id AS user_id
          ,COUNT(distinct order_items.order_id) AS lifetime_order_count
          ,SUM(order_items.sale_price) AS total_revenue
          ,MIN(order_items.returned_at) AS first_order_returned
          ,MAX(order_items.returned_at) AS latest_order_returned
      FROM public.order_items AS order_items
      LEFT JOIN public.orders AS orders ON order_items.order_id = orders.id
      LEFT JOIN public.users AS users ON orders.user_id = users.id
      GROUP BY user_id
       ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: user_id {
      type: number
      sql: ${TABLE}.user_id ;;
    }

    dimension: lifetime_order_count {
      type: number
      sql: ${TABLE}.lifetime_order_count ;;
    }

    dimension: total_revenue {
      type: number
      sql: ${TABLE}.total_revenue ;;
    }

    dimension_group: first_order_returned {
      type: time
      sql: ${TABLE}.first_order_returned ;;
    }

    dimension_group: latest_order_returned {
      type: time
      sql: ${TABLE}.latest_order_returned ;;
    }

  measure: average_total_revenue {
    type: average
    sql: ${TABLE}.total_revenue ;;
  }
  measure: average_lifetime_order_count {
    type: average
    sql: ${TABLE}.lifetime_order_count ;;
  }

    set: detail {
      fields: [user_id,
        lifetime_order_count,
        total_revenue,
        first_order_returned_time,
        latest_order_returned_time]
    }
  }
