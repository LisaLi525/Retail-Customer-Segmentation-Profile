# Load and rename tables from the database
load_and_rename_tables <- function(db_connection) {
  account_details <- tbl(db_connection, "account_details")
  items_master <- tbl(db_connection, "items_master")
  transaction_summary <- tbl(db_connection, "transaction_summary")
  fiscal_calendar <- tbl(db_connection, "fiscal_calendar")
  merch_hierarchy <- tbl(db_connection, "merch_hierarchy")
  daily_performance <- tbl(db_connection, "daily_performance")
  store_comp <- tbl(db_connection, "store_comp")
  cust_profile_data <- tbl(db_connection, "cust_profile_data")
  store_master <- tbl(db_connection, "store_master")
  
  return(list(account_details, items_master, transaction_summary, fiscal_calendar, merch_hierarchy, daily_performance, store_comp, cust_profile_data, store_master))
}
