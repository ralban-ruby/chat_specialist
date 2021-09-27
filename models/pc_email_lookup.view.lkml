view: pc_email_lookup {
  sql_table_name: "PEARL_EDW_PC"."PC_EMAIL_LOOKUP"
    ;;

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  dimension: _fivetran_id {
    type: string
    sql: ${TABLE}."_FIVETRAN_ID" ;;
  }

  dimension_group: _fivetran_synced {
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
    sql: CAST(${TABLE}."_FIVETRAN_SYNCED" AS TIMESTAMP_NTZ) ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
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

  dimension: pcemailid {
    type: number
    value_format_name: id
    sql: ${TABLE}."PCEMAILID" ;;
  }

  dimension: supervisor_primary {
    type: string
    sql: ${TABLE}."SUPERVISOR_PRIMARY" ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
