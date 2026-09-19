-- A look at the table
SELECT *
FROM used_cars
ORDER BY id ASC
LIMIT 100;

--Potential Sales and Potential Revenue
SELECT
    COUNT(id) as potential_sales,
    SUM(price) as potential_revenue
FROM used_cars;

--TOP 10 most sold models with price and brand names
--Ford model F-150 XLT cars followed by BMW M3 Base got sold most 
WITH model_info AS(
    SELECT DISTINCT
        model,
        count(*) as models_sold,
        AVG(price) as avg_price,
        brand
    FROM used_cars
    GROUP BY model, brand)

SELECT model, models_sold AS ms, ROUND(avg_price,2), brand
FROM model_info
ORDER BY ms DESC
LIMIT 10;

--Which brand sold most
--Ford sold most cars 23088, followed by Mercedes-Benz 15500, and Toyota 15000 

SELECT DISTINCT brand,
    COUNT(*) as brand_count
FROM used_cars
GROUP BY brand
ORDER BY brand_count DESC
LIMIT 10;

--Which brand generated the most revenue
--Mercedes-Benz generated most revenue followed by ford and porche
SELECT DISTINCT brand,
    SUM(price) as total_price
FROM used_cars
GROUP BY brand
ORDER BY total_price DESC;

--To find out which Brand has most accident or damaged cars
-- first see how many accidental categories are in the dataset
SELECT DISTINCT accident
FROM used_cars;

-- Then to find out which Brand suffered most accidents
-- Ford cars suffered most accidents followed by mercedes-benz
SELECT DISTINCT brand,
    accident,
    COUNT(*) as accident_count
FROM used_cars
WHERE accident != 'None reported'
GROUP BY brand, accident
ORDER BY accident_count DESC;

-- Number of years the dataset covers
-- 34 years
SELECT DISTINCT model_year, 
    count(DISTINCT model_year) as year_count,
    RANK() OVER (ORDER BY model_year DESC) as year_rank
FROM used_cars
GROUP BY model_year
ORDER BY model_year DESC;

-- Which model_year sold most cars
-- cars of model 2021 were sold most
-- note it does not indicates that 2021 sold most cars since its model year not sell year
SELECT DISTINCT model_year,
    COUNT(*) as model_year_count
FROM used_cars
GROUP BY model_year
ORDER BY model_year_count DESC;

-- which Brand/Model has costliest car
-- which Brand/Model has cheapest car
-- Too many cars same Min and Max price of 2000 and 2954083 respectively
SELECT
    MIN(price) as cheapest_price,
    STRING_AGG(model|| ','|| brand, '|') FILTER (WHERE price = (SELECT MIN(price)
    FROM used_cars)) as cheapest_cars,
    MAX(price) as costliest_price,
    STRING_AGG(model || ',' || brand, '|') FILTER (WHERE price = (SELECT
    MAX(price) FROM used_cars)) as costliest_car
FROM used_cars;

--calculating avg price for cars with accidents vs clean cars
--avg price of cars with accident/damages is 25334.07
--avg price of cars without accident/damages is 49024.80
--median price
SELECT accident,
    ROUND(avg(price),2) avg_price,
    COUNT(*) as car_count,
    round(percentile_cont(0.5)
    WITHIN GROUP (ORDER BY price)::numeric,2) as median_price
FROM used_cars
WHERE accident IS NOT NULL
GROUP BY accident;

--there lies a diff of 23690.73 in cars with acc vs clean cars
SELECT 
    AVG(price) filter(
            WHERE accident = 'None reported'
        )
    -
    AVG(price) filter(
            WHERE accident = 'At least 1 accident or damage reported'
        ) as difff
FROM used_cars;

-- avg of price and mileage
-- hybrid cars have more demand and thus cost more, opposite to flex fuel relient vehicles
select *
FROM used_cars
LIMIT 200;

SELECT DISTINCT fuel_type, 
    round(avg(mileage) ,3) as mi,
    round(avg(price) ,3) as pi_
FROM used_cars
GROUP BY fuel_type
order BY mi DESC, pi_ DESC;

--Relation btw model year and avg price
--Early models have an edge
SELECT
    model_year,
    ROUND(AVG(price),2) avg_prc_modyear
FROM used_cars
GROUP BY model_year
ORDER BY avg_prc_modyear DESC;

--There seem to be some outliers such as avg price of
--vehicle from 1974 is higher than that of 2022 model
SELECT 
    MAX(price) as ma,
    model,
    brand
FROM used_cars
WHERE model_year = 1974
GROUP BY model, brand
ORDER BY ma DESC ;

-----------------------
-- Concluding Insights

SELECT brand,
    count(*) as brand_count
FROM used_cars
GROUP BY brand
ORDER BY brand_count DESC;


SELECT brand,
    model,
    count(*) as model_count
FROM used_cars
GROUP BY model, brand
ORDER BY model_count DESC;

SELECT model_year,
    count(*) as modyr_count
FROM used_cars
GROUP BY model_year
ORDER BY modyr_count DESC;

SELECT
    fuel_type,
    ROUND(Avg(price)) as avg_price,
    ROUND(Avg(mileage)) as avg_mileage
FROM used_cars
GROUP BY fuel_type
ORDER BY avg_price, avg_mileage DESC;

SELECT 
    brand,
    model,
    fuel_type,
    price,
    mileage
FROM used_cars
WHERE fuel_type = 'E85 Flex Fuel'
ORDER BY price DESC;

-- avg, min, max, median price of vehicles based on fuel type
SELECT
    fuel_type,
    COUNT(*) AS listings,
    ROUND(AVG(price)::numeric, 2) AS avg_price,
    --MIN(price) AS min_price,
    --MAX(price) AS max_price,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY price)::numeric,
        2
    ) AS median_price
FROM used_cars
where fuel_type is not null and fuel_type != '–' and fuel_type != 'not supported'
GROUP BY fuel_type
ORDER BY avg_price;

-- find median of price
SELECT percentile_cont(0.5) within group(order by price) as med_prc 
from used_cars
ORDER BY med_prc;

SELECT DISTINCT
    brand,
    count(*) as c
FROM used_cars
GROUP BY brand
ORDER BY c DESC;

--which brands dominates particular vehicle categories

SELECT DISTINCT ON (fuel_type)
    brand,
    fuel_type,
    count(*) as cc
FROM used_cars
where fuel_type is not null and fuel_type != '–' and fuel_type != 'not supported'
GROUP BY fuel_type, brand
ORDER BY fuel_type, cc DESC;

SELECT DISTINCT ON (fuel_type)
    brand,
    fuel_type,
    round(avg(price),2) as prc
FROM used_cars
where fuel_type is not null and fuel_type != '–' and fuel_type != 'not supported'
GROUP BY fuel_type, brand
ORDER BY fuel_type, prc DESC;

SELECT
    brand,
    count(*) as counti
FROM used_cars
where brand = 'Ford'
GROUP BY brand;