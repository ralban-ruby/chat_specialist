connection: "elt_connector"

include: "*.view"

explore: chat_scorecard_rollup {
  access_filter: {field:primarylink.employeeid
    user_attribute:employee_id}
  join: primarylink {
    relationship: one_to_one
    type: left_outer
    sql_on: ${chat_scorecard_rollup.chatspecialistempcode} = ${primarylink.employee_code};;
  }
}

explore: topbar {
  access_filter: {field:primarylink.employeeid
    user_attribute:employee_id}
  join: primarylink {
    relationship: one_to_one
    type: left_outer
    sql_on: ${topbar.employeeid} = ${primarylink.employeeid};;
  }
}

explore: avail {
  access_filter: {field:primarylink.employeeid
    user_attribute:employee_id}
  join: primarylink {
    relationship: one_to_one
    type: left_outer
    sql_on: ${avail.employeeid} = ${primarylink.employeeid};;
  }
}

explore: brb {
  access_filter: {field:primarylink.employeeid
    user_attribute:employee_id}
  join: primarylink {
    relationship: one_to_one
    type: left_outer
    sql_on: ${brb.employeeid} = ${primarylink.employeeid};;
  }
}

explore: wrapping_up {
  access_filter: {field:primarylink.employeeid
    user_attribute:employee_id}
  join: primarylink {
    relationship: one_to_one
    type: left_outer
    sql_on: ${wrapping_up.employeeid} = ${primarylink.employeeid};;
  }
}

explore: recognitions_given {
  access_filter: {field:primarylink.employeeid
    user_attribute:employee_id}
  join: primarylink {
    relationship: one_to_one
    type: left_outer
    sql_on: ${recognitions_given.creator_emp_id} = ${primarylink.employee_code};;
  }
}

explore: recognitions_received {
  access_filter: {field:primarylink.employeeid
    user_attribute:employee_id}
  join: primarylink {
    relationship: many_to_one
    type: left_outer
    sql_on: ${recognitions_received.recipient_emp_id} = ${primarylink.employee_code};;
  }
}

explore: status_by_day {}

explore: pc_quality_scorecard_factv2{
  label: "Chat Service Quality Scorecards"
  view_label: "Chat Scorecards"
  join: employee_lookup_all {
    view_label: "Employee Info"
    relationship: many_to_one
    type: full_outer
    sql_on:  ${pc_quality_scorecard_factv2.chatspecialistempcode} = ${employee_lookup_all.employeeid};;
  }
  join: aspect_superstatehours_fact {
    view_label: "Aspect Superstate Hours"
    relationship: many_to_many
    type: full_outer
    sql_on: TO_CHAR(${pc_quality_scorecard_factv2.chatspecialistempcode}) = TO_CHAR(${aspect_superstatehours_fact.employeecode})
      and ${pc_quality_scorecard_factv2.submittime_date} = ${aspect_superstatehours_fact.nominal_date} ;;
  }
}

datagroup: chat_specialist_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: chat_specialist_default_datagroup
