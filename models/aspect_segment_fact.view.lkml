view: aspect_segment_fact {
  sql_table_name: "PEARL_EDW_WFM"."ASPECT_SEGMENT_FACT"
    ;;
  drill_fields: [aspect_segment_fact_id]

  dimension: aspect_segment_fact_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}."ASPECT_SEGMENT_FACT_ID" ;;
  }

  dimension: _fivetran_deleted {
    hidden: yes
    type: yesno
    sql: ${TABLE}."_FIVETRAN_DELETED" ;;
  }

  dimension_group: _fivetran_synced {
    hidden: yes
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

  dimension_group: day_of_shift {
    type: time
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      month,
      quarter,
      year
    ]
    datatype: date
    convert_tz: no
    sql: ${TABLE}."DATE" ;;
  }


  dimension: employeecode {
    hidden: yes
    type: string
    sql: ${TABLE}."EMPLOYEECODE" ;;
  }

  dimension: employeeid {
    hidden: yes
    type: string
    sql: ${TABLE}."EMPLOYEEID" ;;
  }

  dimension: memo {
    type: string
    sql: ${TABLE}."MEMO" ;;
  }

  dimension: segmentdescription {
    label: "Description"
    type: string
    sql: ${TABLE}."SEGMENTDESCRIPTION" ;;
  }

  dimension: segmentid {
    hidden: yes
    type: string
    sql: ${TABLE}."SEGMENTID" ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}."STARTTIME" ;;
  }

  dimension_group: stop {
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
    sql: ${TABLE}."STOPTIME" ;;
  }

  dimension: minutes {
    hidden: yes
    type: number
    sql: DATEDIFF(minute,${TABLE}."STARTTIME",${TABLE}."STOPTIME") ;;
  }

  # dimension: Tech_Issue {
  #   type: yesno
  #   sql: ${segmentdescription} = 'Tech Issue' ;;
  # }


  measure: count {
    type: count
    drill_fields: [aspect_segment_fact_id]
  }

  measure: count_people {
    type: count_distinct
    sql: ${TABLE}."EMPLOYEECODE" ;;
  }


  measure: sum_minutes {
    type: sum
    sql: DateDiff(minute,${TABLE}."STARTTIME",${TABLE}."STOPTIME") ;;
  }

  measure: sum_hours {
    type: sum
    sql: DateDiff(minute,${TABLE}."STARTTIME",${TABLE}."STOPTIME")/60.0 ;;
  }

  measure: count_dates {
    type:  count_distinct
    sql: ${day_of_shift_date} ;;
  }



  measure: count_outage_dates {
    type:  count_distinct
    filters: [segmentdescription: "Internet/Power Outage - Swell,Internet/Power Outage - Unpaid",_fivetran_deleted: "false"]
    sql: ${day_of_shift_date} ;;
  }

  measure: count_outage_instances {
    type:  count
    filters: [segmentdescription: "Internet/Power Outage - Swell,Internet/Power Outage - Unpaid",_fivetran_deleted: "false"]
  }

  measure: sum_outage_hours {
    type: sum
    filters: [segmentdescription: "Internet/Power Outage - Swell,Internet/Power Outage - Unpaid",_fivetran_deleted: "false"]
    sql: ${minutes}/60.0 ;;
  }


  measure: count_outage_dates_per_100 {
    type: number
    sql: 100.00*${count_outage_dates} / ${aspect_superstatehours_fact.count} ;;
  }


}
