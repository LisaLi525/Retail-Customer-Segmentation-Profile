analyze_customer_segments <- function(transaction_summary, gabe_list, start_date, end_date) {
  # Filtering transactions in the provided date range and specific stores
  active_customers_query <- transaction_summary %>%
    filter(trandate >= start_date, trandate < end_date, storeid %in% gabe_list) %>%
    select(tranid, gtin, trandate, storeid, customerid, totdiscountamount, totitemsaleprice) %>%
    distinct() %>%
    group_by(customerid) %>%
    summarise(ntran = n_distinct(tranid), 
              nunit = n_distinct(gtin), 
              nstore = n_distinct(storeid),
              spend = sum(totitemsaleprice), 
              discount = sum(totdiscountamount)) %>%
    filter(customerid != "" & spend > 0) %>%
    mutate(sp_tran_avg = spend / ntran,
           sp_unit_avg = spend / nunit,
           unit_avg = nunit / ntran) %>%
    ungroup()

  # Collecting the results
  active_customers <- active_customers_query %>%
    collect()

  # Filtering invalid customer IDs (e.g., less than 8 characters)
  active_customers_f17 <- active_customers %>%
    mutate(str_count = nchar(trimws(customerid))) %>%
    filter(str_count >= 8)

  # Classifying customers into segments
  active_customers_f17 <- active_customers_f17 %>%
    mutate(buckets = ifelse(ntran == 1, "one_and_done", 
                            ifelse(ntran > 1 & ntran < 4 & sp_tran_avg < 44, "repeat_customers", 
                                   ifelse(ntran > 1 & ntran < 4 & sp_tran_avg > 44, "repeat_highvalue_customers",
                                          ifelse(ntran >= 4 & sp_tran_avg < 44, "loyal_customers", "loyal_highvalue_customers")))))

  return(active_customers_f17)
}
