view: prochats_chat_agent_stats {
  sql_table_name: "FIVETRAN_DB"."PEARL_EDW_PC"."PROCHATS_CHAT_AGENT_STATS"
    ;;
 dimension: id {
  primary_key: yes
  type: number
  sql: ${TABLE}."ID" ;;
}

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

dimension: agent_id {
  type: string
  sql: ${TABLE}."AGENT_ID" ;;
}

dimension: chat_id {
  type: string
  sql: ${TABLE}."CHAT_ID" ;;
}

dimension: chat_source {
  type: string
  sql: ${TABLE}."CHAT_SOURCE" ;;
}

measure: count_chats {
  type: count_distinct
  sql: ${prochats_opportunity_fact.chat_id} ;;
  drill_fields: [id]
}

measure: count_xfrs {
  type: count_distinct
  sql: CASE WHEN ${TABLE}."TRANSFERRED" > 1 THEN ${prochats_opportunity_fact.chat_id} END;;
}

measure: xfr_rate{
  type: number
  value_format_name: percent_2
  sql: ${count_xfrs} / NULLIF(${count_chats},0);;
}

measure: avg_queue_time {
  type: average
  value_format_name: decimal_2
  sql: ${TABLE}."QUEUE_TIME";;
}

measure: count_rated {
  type: sum
  sql: CASE WHEN ${TABLE}."RATE" IS NOT NULL THEN 1 ELSE 0 END;;
}

measure: percent_rated {
  type: number
  value_format_name: percent_0
  sql: ${count_rated}/NULLIF(${count_chats},0) ;;
}

measure: avg_rate {
  label: "Average Rating"
  type: average
  sql: ${TABLE}."RATE";;
  value_format_name: percent_0
  ## here we use || to concatenate the values
}

measure: sum_chat_time {
  type: sum
  sql: ${TABLE}."DURATION";;
}

measure: avg_first_response {
  type: average
  value_format_name: decimal_0
  sql: ${TABLE}."FIRST_RESPONSE_TIME";;
}

measure: count_responses {
  type: sum
  sql: ${TABLE}."COUNT_RESPONSES";;
}
measure: sum_response_time {
  type: sum
  sql: ${TABLE}."SUM_RESPONSE_TIME" ;;
}


measure: avg_response {
  type: number
  value_format_name: decimal_0
  sql: ${sum_response_time} / NULLIF(${count_responses},0);;
  drill_fields: [
    agent_id,
    chat_source,
    chat_id,
    prochats_opportunity_fact.created,
    avg_response,
    avg_first_response,
    avg_rate,
    avg_queue_time,
    count_responses,
    sum_response_time
  ]
}

measure: count_abandoned {
  type: count_distinct
  sql: CASE WHEN ${prochats_opportunity_fact.chat_id} IS NOT NULL AND ${TABLE}."AGENT_ID" IS NULL THEN ${prochats_opportunity_fact.chat_id} ELSE NULL END;;
  drill_fields: [prochats_chat_agent_stats.chat_id,prochats_opportunity_fact.createdate_time]
}

measure: count_answered {
  type: count_distinct
  sql: CASE WHEN ${prochats_opportunity_fact.chat_id} IS NOT NULL AND ${TABLE}."AGENT_ID" IS NULL THEN NULL ELSE ${prochats_opportunity_fact.chat_id} END;;
}

measure: abandon_rate {
  type: number
  value_format_name: percent_2
  sql: ${count_abandoned}/NULLIF(${count_chats},0) ;;
}


drill_fields: [prochats_chat_agent_stats.chat_id,
  prochats_opportunity_fact.id,
  prochats_opportunity_fact.created_time,
  prochats_chat_agent_stats.agent_id,
  pc_email_lookup.name,
  prochats_chat_agent_stats.avg_queue_time,
  prochats_chat_agent_stats.avg_rate,
  prochats_chat_agent_stats.sum_chat_time,
  prochats_chat_agent_stats.avg_first_response,
  prochats_chat_agent_stats.avg_response,
  prochats_chat_agent_stats.agent_id,
  prochats_opportunitytags_fact.value]

}
