import pandas as pd

# Path to your Parquet file
parquet_file_path = 'C:/Users/mhamza/Documents/FHVH/dbt_Project/fhvhv_tripdata_2024-01 (1).parquet'

# Read the Parquet file
df = pd.read_parquet(parquet_file_path, engine='fastparquet')

# Display column names and data types
print("Columns and Data Types:")
print(df.dtypes)

# Display the first few rows
print("\nSample Data:")
print(df.head())
