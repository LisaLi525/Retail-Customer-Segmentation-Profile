# Analyze open stores
analyze_open_stores <- function(transaction_summary, fiscal_calendar, start_date, end_date) {
  open_store_query <- transaction_summary %>%
    filter(trandate >= start_date, trandate < end_date) %>%
    select(trandate, storeid) %>%
    left_join(fiscal_calendar, by = c("trandate" = "fiscalday")) %>%
    select(weekstart, storeid) %>%
    distinct() %>%
    group_by(storeid) %>%
    summarise(nb_weeks = n()) %>%
    ungroup() %>%
    filter(nb_weeks == 105) %>%
    select(storeid)
    
  open_store <- open_store_query %>%
    collect()
    
  return(open_store)
}
