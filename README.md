# Customer Profile & Shopping Behavior Analysis

## Overview
This project is an in-depth analysis of customer profiles and shopping behaviors for Gabes stores. It uses data from a Redshift database to perform various analyses including department analysis, customer segmentation, seasonality analysis, and market basket analysis.

## Structure
The project is structured into several modular R scripts, each serving a distinct purpose:
1. **Setup and Database Connection**: Script for initializing the environment and establishing database connections.
2. **Data Loading**: Script to load and rename tables from the database.
3. **Analysis Functions**: Separate scripts for different analyses such as open store analysis, customer segments analysis, seasonality analysis, department analysis, and market basket analysis.
4. **Main Execution**: The main script that ties together all other scripts and executes the analysis pipeline.

## Prerequisites
- R environment (Preferably RStudio)
- Access to a Redshift database with the necessary data tables
- R libraries: `RPostgreSQL`, `dplyr`, `dbplyr`, `data.table`, `lubridate`, `reshape2`, `arules`

## Usage
1. **Setup Database Connection**: Configure the database connection parameters in the `connect_to_database` function.
2. **Run Main Script**: Execute the `main` function to run the entire analysis pipeline.
3. **Individual Analysis**: Optionally, you can run individual analysis functions for specific insights.

## Customization
Replace database connection details and analysis parameters in the script with your actual values. Modify the analysis functions according to your specific requirements or data structures.

## Contributing
Contributions to enhance the project's functionality or performance are welcome. Please adhere to the project's structure and coding standards for new features or improvements.

## License
Specify the license under which this project is available, such as MIT, if applicable.
