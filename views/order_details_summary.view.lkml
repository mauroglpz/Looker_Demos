  view: order_details_summary {
    derived_table: {
      explore_source: public.order_items {
        column: order_id {}
        column: id { field: users.id }
        column: count {}
      }
      datagroup_trigger: mauromtr_default_datagroup
    }
    dimension: order_id {
      type: number
    }
    dimension: id {
      type: number
    }
    dimension: count {
      type: number
    }
  }
