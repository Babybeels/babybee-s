copy used_cars
from 'C:\Users\Windows10\Documents\Used_car_sql_analysis_project\csv_files\used_cars.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF-8');

-- since it threw 'permission denied' error in vs code I had to load the table using psql tools in pgadmin4 the ide of postgreSQL
