import pandas as pd
from datetime import datetime
import pyodbc

# Connection details
server = 'Wa\MSSQLSERVER011'  # Your server name
database = 'dbt_project'  # Database name
username = 'dbt'  # SQL Server username
password = 'admin'  # SQL Server password

# Parquet file path
parquet_file_path = 'C:\Users\wamun\Downloads\FHVH\FHVH\dbt_Project\fhvhv_tripdata_2024-01 (1).parquet'

# Read the Parquet file into a DataFrame
df = pd.read_parquet(parquet_file_path, engine='fastparquet')

# Filter out rows with invalid datetime values
valid_date_range = pd.Timestamp.min.replace(year=1753), pd.Timestamp.max
datetime_columns = ['request_datetime', 'on_scene_datetime', 'pickup_datetime', 'dropoff_datetime']

for col in datetime_columns:
    df = df[(df[col] >= valid_date_range[0]) & (df[col] <= valid_date_range[1])]

# Connect to SQL Server
conn = pyodbc.connect(
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={server};DATABASE={database};"
    f"UID={username};PWD={password}"
)
cursor = conn.cursor()

# Define batch size
batch_size = 1000

# rows = df.to_numpy()  # Convert DataFrame to NumPy array for batch processing
columns = df.columns.tolist()  # Get all column names

# SQL Insert Query
sql_insert = f"""
INSERT INTO dbt_project.[dbo].[FHV_Trip_Records] (
    hvfhs_license_num
,dispatching_base_num
,originating_base_num
,request_datetime
,on_scene_datetime
,pickup_datetime
,dropoff_datetime
,PULocationID
,DOLocationID
,trip_miles
,trip_time
,base_passenger_fare
,tolls
,bcf
,sales_tax
,congestion_surcharge
,airport_fee
,tips
,driver_pay
,shared_request_flag
,shared_match_flag
,access_a_ride_flag
,wav_request_flag
,wav_match_flag
)
VALUES ({','.join(['?' for _ in columns])})
"""
print(len(['?' for _ in columns]))

df["request_datetime"] = df['request_datetime'].apply(lambda x : str(x))
df["on_scene_datetime"] = df['on_scene_datetime'].apply(lambda x : str(x))
df["pickup_datetime"] = df['pickup_datetime'].apply(lambda x : str(x))
df["dropoff_datetime"] = df['dropoff_datetime'].apply(lambda x : str(x))

# Insert data in batches
for i in range(0, len(df), batch_size):
    rows = df[i*batch_size:(i+1)*batch_size].to_records(index=False)
    if rows.shape[0] > 0:
        # batch = rows[i:i + batch_size]  # Slice the current batch
        cursor.executemany(sql_insert, [tuple(row) for row in rows])  # Insert batch into SQL Server
    print(i)
# Commit transaction and close connection
conn.commit()
cursor.close()
conn.close()

print("Data successfully loaded into SQL Server.")