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
  access_filter: {field:employee_lookup_all.employeeid
    user_attribute:employee_id}
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

explore: prochats_opportunity_fact {
  access_filter: {field:employee_lookup_all.employeeid
    user_attribute:employee_id}
  label: "Chats"
  view_label: "ProChats Online Opportunity"
  sql_always_where: ${_fivetran_deleted} <> 'yes';;
  join: prochats_opportunitytags_fact {
    view_label: "ProChats Online Tags"
    relationship: one_to_many
    type: left_outer
    sql_on: ${prochats_opportunity_fact.id} = ${prochats_opportunitytags_fact.opportunityid};;
  }
  join: prochats_chat_agent_stats {
    view_label: "Chat Metrics"
    relationship: one_to_many
    type: full_outer
    sql_on: ${prochats_opportunity_fact.chat_id} = ${prochats_chat_agent_stats.chat_id}
      and ${prochats_opportunity_fact.chat_source} = ${prochats_chat_agent_stats.chat_source} ;;
  }
  join: prochats_clients_fact {
    view_label: "ProChats Online Client"
    relationship: many_to_one
    type: left_outer
    sql_on:  ${prochats_opportunity_fact.client_id} = ${prochats_clients_fact.client_id};;
  }
  join: account {
    view_label: "Salesforce Account"
    relationship: many_to_one
    type: left_outer
    sql_on:  ${prochats_clients_fact.pro_chats_id} = ${account.pco_id_c};;
  }
  join: pc_email_lookup {
    view_label: "Chat Agent Email"
    relationship: many_to_one
    type: full_outer
    sql_on:  ${prochats_chat_agent_stats.agent_id} = ${pc_email_lookup.email};;
  }
  join: employee_lookup_all {
    view_label: "Employee Info"
    relationship: many_to_one
    type: full_outer
    sql_on:  ${pc_email_lookup.employeeid} = ${employee_lookup_all.employeeid};;
  }
  join: aspect_segment_fact {
    view_label: "Schedule Segments"
    relationship: many_to_many
    type: full_outer
    sql_on: TO_CHAR(${employee_lookup_all.employee_code}) = TO_CHAR(${aspect_segment_fact.employeecode})
      and ${prochats_opportunity_fact.created_raw} between ${aspect_segment_fact.start_raw} and ${aspect_segment_fact.stop_raw};;
  }
  join: aspect_superstatehours_fact {
    relationship: many_to_many
    type: full_outer
    sql_on: TO_CHAR(${aspect_superstatehours_fact.employeecode}) = TO_CHAR(${aspect_segment_fact.employeecode})
      and ${aspect_superstatehours_fact.nominal_date} = ${aspect_segment_fact.day_of_shift_date} ;;
  }
}

datagroup: chat_specialist_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: chat_specialist_default_datagroup
