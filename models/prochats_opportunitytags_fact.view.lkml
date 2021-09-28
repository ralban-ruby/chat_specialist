view: prochats_opportunitytags_fact {
  sql_table_name: "FIVETRAN_DB"."PEARL_EDW_PC"."PROCHATS_OPPORTUNITYTAGS_FACT"
    ;;

  dimension: _fivetran_deleted {
    type: yesno
    hidden: yes
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  dimension_group: _fivetran_synced {
    type: time
    hidden: yes
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

  dimension_group: createdate {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATEDATE" ;;
  }

  dimension: opportunityid {
    type: number
    value_format_name: id
    sql: ${TABLE}."OPPORTUNITYID" ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}."VALUE" ;;
  }

  measure: count {
    type: count_distinct
    sql: ${TABLE}."OPPORTUNITYID" ;;
  }

  measure: count_conversion {
    hidden: yes
    type: count_distinct
    sql: CASE WHEN  ${TABLE}."VALUE"ILIKE 'lead' THEN ${TABLE}."OPPORTUNITYID" ELSE NULL END;;
  }

  measure: conversion {
    type: number
    value_format_name: percent_0
    sql: ${count_conversion} / ${count};;
  }

  drill_fields: [prochats_chat_agent_stats.chat_id,
    opportunityid,
    createdate_time,
    prochats_chat_agent_stats.agent_id,
    pc_email_lookup.name,
    prochats_chat_agent_stats.avg_queue_time,
    prochats_chat_agent_stats.avg_rate,
    prochats_chat_agent_stats.sum_duration,
    prochats_chat_agent_stats.avg_first_response,
    prochats_chat_agent_stats.avg_response,
    prochats_chat_agent_stats.agent_id,value]
}
