  view: order_details_summary {
      derived_table: {
        explore_source: order_items {
          column: order_id {}
          column: count {}
          column: id { field: users.id }
        }
      }
      dimension: order_id {
        type: number
      }
      dimension: count {
        type: number
      }
      dimension: id {
        type: number
      }
    }
