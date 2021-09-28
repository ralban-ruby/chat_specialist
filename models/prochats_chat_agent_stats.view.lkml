view: prochats_chat_agent_stats {
  sql_table_name: "FIVETRAN_DB"."PEARL_EDW_PC"."PROCHATS_CHAT_AGENT_STATS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
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

  dimension: agent_id {
    type: string
    sql: ${TABLE}."AGENT_ID" ;;
  }

  dimension: avg_response_time {
    type: number
    sql: ${TABLE}."AVG_RESPONSE_TIME" ;;
  }

  dimension: chat_id {
    type: string
    sql: ${TABLE}."CHAT_ID" ;;
  }

  dimension: chat_source {
    type: string
    sql: ${TABLE}."CHAT_SOURCE" ;;
  }

  dimension: count_responses {
    type: number
    sql: ${TABLE}."COUNT_RESPONSES" ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}."DURATION" ;;
  }

  dimension: first_response_time {
    type: number
    sql: ${TABLE}."FIRST_RESPONSE_TIME" ;;
  }

  dimension: queue_time {
    type: number
    sql: ${TABLE}."QUEUE_TIME" ;;
  }

  dimension: rate {
    type: number
    sql: ${TABLE}."RATE" ;;
  }

  dimension: sum_response_time {
    type: number
    sql: ${TABLE}."SUM_RESPONSE_TIME" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
