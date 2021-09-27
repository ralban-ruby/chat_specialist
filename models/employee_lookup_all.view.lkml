view: employee_lookup_all {
  sql_table_name: "PEARL_EDW_OPS"."EMPLOYEE_LOOKUP_ALL"
    ;;

  dimension: _fivetran_deleted {
    type: yesno
    hidden: no
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

  dimension: conntypeid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}."CONNTYPEID" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: employee_code {
    label: "Paycom Code"
    type: string
    sql: ${TABLE}."EMPLOYEE_CODE" ;;
  }

  dimension: employeeid {
    label: "Employee ID"
    type: number
    value_format_name: id
    sql: ${TABLE}."EMPLOYEEID" ;;
  }

  dimension_group: hire {
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
    sql: ${TABLE}."HIRE_DATE" ;;
  }

  dimension_group: departure {
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
    sql: ${TABLE}."TERMINATION_DATE" ;;
  }

  dimension: icuserid {
    label: "IC Username"
    type: string
    sql: ${TABLE}."ICUSERID" ;;
  }

  dimension: legalname {
    hidden: yes
    type: string
    sql: ${TABLE}."LEGALNAME" ;;
  }

  dimension: location_desc {
    label: "Location"
    type: string
    sql: ${TABLE}."LOCATION_DESC" ;;
  }

  dimension: mailnickname {
    hidden: yes
    type: string
    sql: ${TABLE}."MAILNICKNAME" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: recordid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}."RECORDID" ;;
  }

  dimension: samaccountname {
    label: "Active Directory Username"
    type: string
    sql: ${TABLE}."SAMACCOUNTNAME" ;;
  }

  dimension: supervisor_primary {
    label: "Manager Name"
    type: string
    sql: ${TABLE}."SUPERVISOR_PRIMARY" ;;
  }

  dimension: team {
    type: string
    sql: ${TABLE}."TEAM" ;;
    #suggestions: ["The Chatting Nuggets", "The Mad Chatters", "The Ruby Rebels", "The Night Owls", "The Goal Diggers"]
  }

  dimension: title {
    type: string
    sql: ${TABLE}."TITLE" ;;
  }

  measure: count {
    type: count
    drill_fields: [samaccountname, mailnickname, legalname, name]
  }
}
