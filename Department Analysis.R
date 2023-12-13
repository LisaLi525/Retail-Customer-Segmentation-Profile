analyze_departments <- function(transaction_summary, items_master, merch_hierarchy) {
  # Collecting necessary data
  item_summary <- items_master %>% collect()
  merch_hierarchy_summary <- merch_hierarchy %>% collect()
  
  # Merging item details with merchandise hierarchy
  department_data <- item_summary %>%
    left_join(merch_hierarchy_summary, by = c("icls" = "ccls"))

  # Analysis based on department
  department_analysis <- transaction_summary %>%
    inner_join(department_data, by = c("gtin" = "ugtin")) %>%
    group_by(divnam, dptnam) %>%
    summarise(total_sales = sum(totitemsaleprice),
              total_transactions = n_distinct(tranid),
              total_units_sold = n(),
              total_discount = sum(totdiscountamount)) %>%
    ungroup() %>%
    collect()

  return(department_analysis)
}
