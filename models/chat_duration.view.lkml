view: chat_duration {
  sql_table_name: "CHAT"."CHAT_DURATION"
    ;;

  dimension: chat {
    type: string
    sql: ${TABLE}."CHAT" ;;
  }

  dimension: chat_agents {
    type: string
    sql: ${TABLE}."CHAT_AGENTS" ;;
  }

  dimension: chat_duration_datediff_min {
    type: number
    sql: ${TABLE}."CHAT_DURATION_DATEDIFF_MIN" ;;
  }

  dimension: chat_duration_datediff_sec {
    type: number
    sql: ${TABLE}."CHAT_DURATION_DATEDIFF_SEC" ;;
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
    convert_tz: yes
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

  dimension: company_guid {
    type: string
    sql: ${TABLE}."COMPANY_GUID" ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}."COMPANY_ID" ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}."COMPANY_NAME" ;;
  }

  dimension_group: end_time_utc {
    convert_tz: yes
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
    sql: CAST(${TABLE}."END_TIME_UTC" AS TIMESTAMP_NTZ) ;;
  }

  dimension_group: start_time_utc {
    convert_tz: yes
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

  measure: count {
    type: count
    drill_fields: [company_name]
  }
}
