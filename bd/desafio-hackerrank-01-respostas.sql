/*
https://www.hackerrank.com/challenges/select-all-sql/problem?isFullScreen=true
Query all columns (attributes) for every row in the CITY table.
*/

SELECT * FROM CITY;

/*
https://www.hackerrank.com/challenges/select-by-id/problem?isFullScreen=true
Query all columns for a city in CITY with the ID 1661.
*/

SELECT * FROM CITY WHERE ID = 1661;

/*
https://www.hackerrank.com/challenges/weather-observation-station-1/problem?isFullScreen=true
Query a list of CITY and STATE from the STATION table.
*/

SELECT CITY, STATE FROM STATION;

/*
https://www.hackerrank.com/challenges/japanese-cities-attributes/problem?isFullScreen=true
Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
*/

SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

/*
https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true
Query all columns for all American cities in the CITY table with populations larger than 100000. 
The CountryCode for America is USA.
*/

SELECT * FROM CITY WHERE COUNTRYCODE = 'USA' AND POPULATION > 100000;

/*
https://www.hackerrank.com/challenges/revising-the-select-query-2/problem?isFullScreen=true
Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
*/

SELECT NAME FROM CITY WHERE COUNTRYCODE = 'USA' AND POPULATION > 120000;

/*
https://www.hackerrank.com/challenges/weather-observation-station-6/problem?isFullScreen=true
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY FROM STATION WHERE 
CITY LIKE 'a%' OR
CITY LIKE 'e%' OR
CITY LIKE 'i%' OR
CITY LIKE 'o%' OR
CITY LIKE 'u%';

/*
https://www.hackerrank.com/challenges/weather-observation-station-7/problem?isFullScreen=true
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY FROM STATION WHERE 
CITY LIKE '%a' OR
CITY LIKE '%e' OR
CITY LIKE '%i' OR
CITY LIKE '%o' OR
CITY LIKE '%u';

/*
https://www.hackerrank.com/challenges/weather-observation-station-8/problem?isFullScreen=true
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
*/

SELECT DISTINCT CITY FROM STATION WHERE 
(CITY LIKE 'a%' OR
CITY LIKE 'e%' OR
CITY LIKE 'i%' OR
CITY LIKE 'o%' OR
CITY LIKE 'u%') AND
(CITY LIKE '%a' OR
CITY LIKE '%e' OR
CITY LIKE '%i' OR
CITY LIKE '%o' OR
CITY LIKE '%u');

/* Resolvendo com SUBSTR e IN */

SELECT DISTINCT CITY FROM STATION 
WHERE SUBSTR(CITY,1,1) IN ('a','e','i','o','u')
AND SUBSTR(CITY,-1,1) IN ('a','e','i','o','u');

