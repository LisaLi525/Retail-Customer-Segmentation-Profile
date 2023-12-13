analyze_seasonality <- function(total_transaction_data, active_customers_data, special_dates) {
  # Extracting week numbers from special dates for comparison
  special_weeks <- lapply(special_dates, function(date) {
    lubridate::week(as.Date(date))
  })
  
  # Analyzing transactions during special weeks
  seasonality_analysis <- total_transaction_data %>%
    mutate(tran_week = lubridate::week(trandate)) %>%
    filter(tran_week %in% unlist(special_weeks)) %>%
    inner_join(active_customers_data, by = "customerid") %>%
    group_by(buckets, tran_week) %>%
    summarise(total_spend = sum(totitemsaleprice),
              total_transactions = n_distinct(tranid),
              total_customers = n_distinct(customerid))

  # Optionally, you can extend this function to perform more detailed analysis,
  # such as comparing spend across different seasonal events, customer segments, etc.
  
  return(seasonality_analysis)
}
