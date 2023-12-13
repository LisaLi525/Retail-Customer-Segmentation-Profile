# Clear all variables and set chunk options
setup_environment <- function() {
  rm(list = ls())
  knitr::opts_chunk$set(echo = TRUE)
}

# Create a connection to the database
connect_to_database <- function(host, port, user, password, dbname) {
  library(RPostgreSQL)
  library(dplyr)
  library(dbplyr)
  
  db_connection <- src_postgres(dbname, host = host, port = port, user = user, password = password)
  return(db_connection)
}
