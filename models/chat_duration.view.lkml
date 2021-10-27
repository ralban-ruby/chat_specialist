view: chat_duration {
  sql_table_name: "RUBY"."CHAT"."CHAT_DURATION"
    ;;

  dimension: active_chat_duration_datediff_min {
    type: number
    sql: ${TABLE}."ACTIVE_CHAT_DURATION_DATEDIFF_MIN" ;;
  }

  dimension: active_chat_duration_datediff_sec {
    type: number
    sql: ${TABLE}."ACTIVE_CHAT_DURATION_DATEDIFF_SEC" ;;
  }

  dimension: chat {
    type: string
    sql: ${TABLE}."CHAT" ;;
  }

  dimension: chat_completion_time_datediff_min {
    type: number
    sql: ${TABLE}."CHAT_COMPLETION_TIME_DATEDIFF_MIN" ;;
  }

  dimension: chat_completion_time_datediff_sec {
    type: number
    sql: ${TABLE}."CHAT_COMPLETION_TIME_DATEDIFF_SEC" ;;
  }

  dimension: chat_event_log {
    type: string
    sql: ${TABLE}."CHAT_EVENT_LOG" ;;
  }

  dimension: chat_handle_time_datediff_min {
    type: number
    sql: ${TABLE}."CHAT_HANDLE_TIME_DATEDIFF_MIN" ;;
  }

  dimension: chat_handle_time_datediff_sec {
    type: number
    sql: ${TABLE}."CHAT_HANDLE_TIME_DATEDIFF_SEC" ;;
  }

  dimension: chat_session_id {
    type: number
    sql: ${TABLE}."CHAT_SESSION_ID" ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: employee_code {
    type: number
    sql: ${TABLE}."EMPLOYEE_CODE" ;;
  }

  dimension: employee_email {
    type: string
    sql: ${TABLE}."EMPLOYEE_EMAIL" ;;
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
    drill_fields: [name, company_name]
  }
}
