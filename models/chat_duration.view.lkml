view: chat_duration {
  sql_table_name: "CHAT"."CHAT_DURATION"
    ;;

  dimension: chat {
    type: string
    sql: ${TABLE}."CHAT" ;;
  }

  dimension: chat_duration_tier {
    type: tier
    tiers: [0,10,20,50,100,200,300,400,500,600,700,800,900,1000,2000]
    sql: ${TABLE}."CLOSED_END_DURATION_DATEDIFF_MIN" ;;
  }

  dimension: chat_duration_datediff_min {
    type: number
    sql: ${TABLE}."CHAT_DURATION_DATEDIFF_MIN" ;;
  }

  dimension: chat_duration_datediff_sec {
    type: number
    sql: ${TABLE}."CHAT_DURATION_DATEDIFF_SEC" ;;
  }

  dimension: chat_session_id {
    type: number
    sql: ${TABLE}."CHAT_SESSION_ID" ;;
  }

  dimension: closed_end_duration_datediff_min {
    type: number
    sql: ${TABLE}."CLOSED_END_DURATION_DATEDIFF_MIN" ;;
  }

  dimension: closed_end_duration_datediff_sec {
    type: number
    sql: ${TABLE}."CLOSED_END_DURATION_DATEDIFF_SEC" ;;
  }

  dimension_group: closed_time_utc {
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
    sql: CAST(${TABLE}."CLOSED_TIME_UTC" AS TIMESTAMP_NTZ) ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}."COMPANY_NAME" ;;
  }

  dimension: employee_email {
    type: string
    sql: ${TABLE}."EMPLOYEE_EMAIL" ;;
  }

  dimension_group: start_time_utc {
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
    sql: CAST(${TABLE}."START_TIME_UTC" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: stop_time_utc {
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
    sql: CAST(${TABLE}."STOP_TIME_UTC" AS TIMESTAMP_NTZ) ;;
  }

  measure: count {
    type: count
    drill_fields: [company_name]
  }
}
