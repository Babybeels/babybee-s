--Check Datatypes
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'used_cars';

--Check for duplicates
SELECT
    COUNT(*) FILTER (WHERE id is NULL) as null_id,
    COUNT(*) FILTER (WHERE model_year is NULL) as null_year,
    COUNT(*) FILTER (WHERE mileage is NULL) as null_mileage,
    COUNT(*) FILTER (WHERE clean_title is NULL) as null_title,
    COUNT(*) FILTER (WHERE price is NULL) as null_price,
    COUNT(*) FILTER (WHERE fuel_type is NULL) as null_fuel,
    COUNT(*) FILTER (WHERE engine is NULL) as null_engine,
    COUNT(*) FILTER (WHERE transmission is NULL) as null_transmission,
    COUNT(*) FILTER (WHERE ext_col is NULL) as null_extcol,
    COUNT(*) FILTER (WHERE int_col is NULL) as null_intcol,
    COUNT(*) FILTER (WHERE brand is NULL) as null_brand,
    COUNT(*) FILTER (WHERE model is NULL) as null_model,
    COUNT(*) FILTER (WHERE accident is NULL) as null_accident
FROM used_cars;

--Check for Duplicates
--No Duplicates Found
SELECT
    id ,
    brand ,
    model,
    model_year,
    mileage,
    fuel_type,
    engine,
    transmission,
    ext_col,
    int_col,
    accident,
    clean_title,
    price,
    COUNT(*) AS occurrences
FROM used_cars
GROUP BY id, brand, model, model_year, mileage, fuel_type, engine, transmission, ext_col, int_col, accident, clean_title, price
HAVING COUNT(*) > 1;

-- Checking for Brand names and fuel types
SELECT brand, COUNT(*)
FROM used_cars
GROUP BY brand
ORDER BY brand;

SELECT DISTINCT fuel_type
FROM used_cars
ORDER BY fuel_type;
