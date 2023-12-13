perform_market_basket_analysis <- function(transaction_data) {
  # Preparing the data for market basket analysis
  transaction_items <- transaction_data %>%
    filter(totitemsaleprice > 0) %>%
    left_join(items_master, by = c("gtin" = "ugtin")) %>%
    group_by(trandate, tranno) %>%
    summarise(item_list = paste(ides, collapse = ",")) %>%
    ungroup() %>%
    collect()

  # Writing item list to a CSV file
  write.csv(transaction_items, "itemList.csv", quote = FALSE, row.names = TRUE)

  # Loading the arules package and preparing transactions
  library(arules)
  txn <- read.transactions(file = "itemList.csv", rm.duplicates = FALSE, format = "basket", sep = ",", cols = 1)
  txn@itemInfo$labels <- gsub("\"", "", txn@itemInfo$labels)

  # Running the Apriori algorithm
  basket_rules <- apriori(txn, parameter = list(minlen = 2, sup = 0.001, conf = 0.01, target = "rules"))
  df_basket <- as(basket_rules, "data.frame")
  df_basket$confidence <- df_basket$confidence * 100

  return(df_basket)
}
