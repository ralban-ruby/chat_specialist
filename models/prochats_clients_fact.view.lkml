view: prochats_clients_fact {
  sql_table_name: "FIVETRAN_DB"."PEARL_EDW_PC"."PROCHATS_CLIENTS_FACT"
    ;;
  drill_fields: [client_id,name,chat_provider_name,created_date,new_prl_id,pro_chats_id]

  dimension: client_id {
    label: "PCO Client ID"
    primary_key: yes
    type: string
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

  dimension: accepts_medicaid {
    type: yesno
    sql: ${TABLE}."ACCEPTS_MEDICAID" ;;
  }

  dimension: bold_folder_ids {
    type: string
    hidden: yes
    sql: ${TABLE}."BOLD_FOLDER_IDS" ;;
  }

  dimension: bold_website_ids {
    type: string
    hidden: yes
    sql: ${TABLE}."BOLD_WEBSITE_IDS" ;;
  }

  dimension: boutique_scripting {
    type: string
    sql: ${TABLE}."BOUTIQUE_SCRIPTING" ;;
  }

  dimension: can_view_transcripts {
    type: yesno
    sql: ${TABLE}."CAN_VIEW_TRANSCRIPTS" ;;
  }

  dimension: chat_provider_id {
    type: number
    sql: ${TABLE}."CHAT_PROVIDER_ID";;
  }

  dimension: chat_provider_name {
    type: string
    sql: CASE WHEN ${TABLE}."CHAT_PROVIDER_ID" = 1 THEN 'LiveChat'
              WHEN ${TABLE}."CHAT_PROVIDER_ID" = 2 THEN 'Bold360'
              WHEN ${TABLE}."CHAT_PROVIDER_ID" = 3 THEN 'PureChat'
              WHEN ${TABLE}."CHAT_PROVIDER_ID" = 4 THEN 'ArtiBot'
          END;;
  }

  dimension: complimentary_consultation {
    type: yesno
    hidden: yes
    sql: ${TABLE}."COMPLIMENTARY_CONSULTATION" ;;
  }

  dimension: consultation_includes {
    type: string
    sql: ${TABLE}."CONSULTATION_INCLUDES" ;;
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

  dimension_group: createdate {
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
    sql: ${TABLE}."CREATEDATE" ;;
  }

  dimension: developer_email {
    type: string
    sql: ${TABLE}."DEVELOPER_EMAIL" ;;
  }

  dimension: developer_name {
    type: string
    sql: ${TABLE}."DEVELOPER_NAME" ;;
  }

  dimension: developer_phone {
    type: string
    sql: ${TABLE}."DEVELOPER_PHONE" ;;
  }

  dimension: differentiators {
    type: string
    sql: ${TABLE}."DIFFERENTIATORS" ;;
  }

  dimension: dont_send_email_transcripts {
    type: yesno
    sql: ${TABLE}."DONT_SEND_EMAIL_TRANSCRIPTS" ;;
  }

  dimension: emergency_instructions {
    type: string
    sql: ${TABLE}."EMERGENCY_INSTRUCTIONS" ;;
  }

  dimension: emergency_phone {
    type: string
    sql: ${TABLE}."EMERGENCY_PHONE" ;;
  }

  dimension: insurance {
    type: string
    sql: ${TABLE}."INSURANCE" ;;
  }

  dimension: medicaid_alternatives {
    type: string
    sql: ${TABLE}."MEDICAID_ALTERNATIVES" ;;
  }

  dimension_group: modifydate {
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
    sql: ${TABLE}."MODIFYDATE" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: new_prl_id {
    type: string
    sql: ${TABLE}."NEW_PRL_ID" ;;
  }

  dimension: payment_options {
    type: string
    sql: ${TABLE}."PAYMENT_OPTIONS" ;;
  }

  dimension: pro_chats_id {
    type: string
    sql: ${TABLE}."PRO_CHATS_ID" ;;
  }

  dimension: service_titan_api_key {
    type: string
    sql: ${TABLE}."SERVICE_TITAN_API_KEY" ;;
  }

  dimension: show_phi_warning_in_email {
    type: yesno
    sql: ${TABLE}."SHOW_PHI_WARNING_IN_EMAIL" ;;
  }

  dimension: sms_enabled {
    type: yesno
    sql: ${TABLE}."SMS_ENABLED" ;;
  }

  dimension: sms_notification_number {
    type: string
    sql: ${TABLE}."SMS_NOTIFICATION_NUMBER" ;;
  }

  dimension: special_instructions {
    type: string
    sql: ${TABLE}."SPECIAL_INSTRUCTIONS" ;;
  }

  dimension: state_medicaid_name {
    type: string
    sql: ${TABLE}."STATE_MEDICAID_NAME" ;;
  }

  dimension: treatments {
    type: string
    sql: ${TABLE}."TREATMENTS" ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}."UPDATED_AT" ;;
  }

  dimension: vertical {
    type: string
    sql: ${TABLE}."VERTICAL" ;;
  }

  dimension: website {
    type: string
    sql: ${TABLE}."WEBSITE" ;;
  }

  measure: count {
    type: count
  }
}
