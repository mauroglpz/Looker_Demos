connection: "thelook"

# include all the views
include: "/views/**/*.view"

datagroup: mauromtr_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: mauromtr_default_datagroup

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  fields: [ALL_FIELDS*]
  from: order_items
  view_name: order_items
  extends: [base_orders]

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    type: left_outer
    sql_on: ${order_items.user_id} = ${user_facts.user_id};;
    relationship: many_to_one
  }

  join: brand_order_facts {
    type: left_outer
    sql_on: ${products.brand} = ${brand_order_facts.brand} ;;
    relationship: many_to_one
  }
}

explore: base_orders {
  extension: required
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  fields: [ALL_FIELDS*]
  from: orders
  view_name: orders
  extends: [base_orders]
}

explore: product_facts {
  join: products {
    type: left_outer
    sql_on: ${product_facts.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: users {}
