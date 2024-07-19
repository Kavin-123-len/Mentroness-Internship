Create database Corona_virus;
select * from corona_virus;
use Corona_virus;
-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
alter table corona_virus
Change `Country/Region` Region varchar(50);

select * from corona_virus
where Province is null 
or region is null
or Latitude is null
or Longitude is null
or date is null
or Confirmed is null
or deaths is null 
or Recovered is null;

-- Q2. If NULL values are present, update them with zeros for all columns. 
-- No Null Values in the dataset

-- Q3. check total number of rows
select count(*)  as Total_rows
from corona_virus;

-- Q4. Check what is start_date and end_date
-- step 1: Add a new date colum
alter table corona_virus add column date_ date;
Set sql_safe_updates = 0;

-- step 2: update the new colum with converted date values
SET sql_safe_updates = 0;
UPDATE corona_virus SET Date_ = STR_TO_DATE(date,'%d-%m-%Y');

 -- step 3: Drop the old text column
 alter table corona_virus drop column date;
 
 
 -- step 4: Rename the new column to the orginal column name
 alter table corona_virus change column date_ date date;

-- step 5: check for the start and end date
 select min(date) as start_date
       ,max(date) as end_date
       from corona_virus;

-- Q5. Number of month present in dataset
select timestampdiff(month, '2020-01-22' , '2021-06-13') as total_months;

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT year(date) AS YEAR, monthname(date) AS MONTH, 
avg(confirmed) AS AVG_CONFIMED_CASES, 
avg(deaths) AS AVG_DEATHS, avg(recovered) AS AVG_RECOVERED
FROM corona_virus
group by monthname(date), year(date);

-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT 
   MONTH(Date) AS Month,
   YEAR(Date) AS Year,
   MAX(Confirmed) AS Most_frequent_Confirmed,
   MAX(Deaths) AS Most_frequent_Deaths,
   MAX(Recovered) AS Most_frequent_Recovered
FROM corona_virus
GROUP BY MONTH(Date), YEAR(Date);

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT YEAR(DATE) AS YEAR, 
MIN(CONFIRMED) AS MIN_cases, 
MIN(DEATHS) AS MIN_deaths, 
MIN(RECOVERED) AS MIN_recovered 
FROM corona_virus 
GROUP BY YEAR;

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT YEAR(DATE) AS YEAR, 
MAX(CONFIRMED) AS MAX_cases, 
MAX(DEATHS) AS MAX_deaths, 
MAX(RECOVERED) AS MAX_recovered 
FROM corona_virus 
GROUP BY YEAR;

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT YEAR(DATE) AS YEAR, 
MONTH(DATE) AS MONTH, 
SUM(CONFIRMED) AS Total_cases, 
SUM(DEATHS) AS Total_deaths, 
SUM(RECOVERED) AS Total_recovered 
FROM corona_virus 
GROUP BY YEAR, MONTH;
-- Q11. Check how corona virus spread out with respect to confirmed case
-- (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM(CONFIRMED) AS Total_confirmed_cases, 
CAST(avg(CONFIRMED) AS DECIMAL (10, 2)) AS Avg_cases, 
CAST(variance(CONFIRMED) AS DECIMAL(10, 2)) AS Variance,
CAST(stddev(CONFIRMED) AS DECIMAL(10, 2)) AS standard_deviation 
FROM corona_virus; 

-- Q12. Check how corona virus spread out with respect to death case per month
-- (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT YEAR(DATE) AS YEAR, MONTH(DATE) AS MONTH,
SUM(DEATHS) AS Total_cases,
CAST(avg(DEATHS) AS DECIMAL (10, 2)) AS Avg_cases,
CAST(variance(DEATHS) AS DECIMAL (10, 2)) AS Variance, 
CAST(stddev(DEATHS) AS DECIMAL(10, 2)) AS standard_deviation
FROM corona_virus
GROUP BY YEAR, MONTH;

-- Q13. Check how corona virus spread out with respect to recovered case
-- (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM(RECOVERED) AS Recovered_cases,
 CAST(avg(RECOVERED) AS DECIMAL (10, 2)) AS Avg_cases, 
 CAST(variance(RECOVERED) AS DECIMAL(10, 2)) AS Variance, 
 CAST(stddev(RECOVERED) AS DECIMAL (10, 2)) AS standard_deviation 
 FROM corona_virus;

-- Q14. Find Country having highest number of the Confirmed case
SELECT
 region,
 SUM(CONFIRMED) AS Total_cases 
 FROM corona_virus 
 GROUP BY Region
 order by Total_cases desc 
 LIMIT 1;

-- Q15. Find Country having lowest number of the death case
SELECT
region,
SUM(CONFIRMED) AS Total_cases 
FROM corona_virus
GROUP BY region 
order by Total_cases
LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT
region,
SUM(RECOVERED) AS Recovered_cases
FROM corona_virus
GROUP BY region
order by Recovered_cases desc
LIMIT 53;


