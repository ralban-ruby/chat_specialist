view: prochats_opportunity_fact {
  sql_table_name: "FIVETRAN_DB"."PEARL_EDW_PC"."PROCHATS_OPPORTUNITY_FACT"
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

  dimension_group: call_completed {
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
    sql: ${TABLE}."CALL_COMPLETED_AT" ;;
  }

  dimension: caller_id {
    type: number
    sql: ${TABLE}."CALLER_ID" ;;
  }

  dimension: chat_id {
    type: string
    sql: ${TABLE}."CHAT_ID" ;;
  }

  dimension: chat_source {
    type: string
    sql: ${TABLE}."CHAT_SOURCE" ;;
  }

  dimension: chat_type {
    type: string
    sql: ${TABLE}."CHAT_TYPE" ;;
  }

  dimension: client_call_connected {
    type: yesno
    sql: ${TABLE}."CLIENT_CALL_CONNECTED" ;;
  }

  dimension: client_id {
    type: number
    sql: ${TABLE}."CLIENT_ID" ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: createtime {
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
    sql: ${TABLE}."CREATETIME" ;;
  }

  dimension: customer_call_connected {
    type: yesno
    sql: ${TABLE}."CUSTOMER_CALL_CONNECTED" ;;
  }

  dimension_group: email_completed {
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
    sql: ${TABLE}."EMAIL_COMPLETED_AT" ;;
  }

  dimension: emailer_id {
    type: number
    sql: ${TABLE}."EMAILER_ID" ;;
  }

  dimension: needs_call_connect {
    type: yesno
    sql: ${TABLE}."NEEDS_CALL_CONNECT" ;;
  }

  dimension_group: queued {
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
    sql: ${TABLE}."QUEUED_AT" ;;
  }

  dimension_group: sent_to_service_titan {
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
    sql: ${TABLE}."SENT_TO_SERVICE_TITAN_AT" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
