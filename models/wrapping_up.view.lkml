view: wrapping_up {
  sql_table_name: "CHAT"."WRAPPING_UP"
    ;;

  dimension: avail {
    type: number
    sql: ${TABLE}."AVAIL" ;;
  }

  dimension: availability_ratio {
    type: number
    sql: ${TABLE}."AVAILABILITY_RATIO" ;;
  }

  dimension: employeeid {
    type: number
    value_format_name: id
    sql: ${TABLE}."EMPLOYEEID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension_group: nominaldate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."NOMINALDATE" ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}."TOTAL" ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
