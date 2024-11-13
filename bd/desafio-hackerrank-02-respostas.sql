/*
https://www.hackerrank.com/challenges/african-cities/problem?isFullScreen=true
Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

SELECT CT.NAME FROM CITY AS CT 
    INNER JOIN COUNTRY CNT ON CT.COUNTRYCODE = CNT.CODE
WHERE CONTINENT = 'Africa';

/*
https://www.hackerrank.com/challenges/asian-population/problem?isFullScreen=true
Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

SELECT SUM(CT.POPULATION) FROM CITY AS CT 
    INNER JOIN COUNTRY CNT ON CT.COUNTRYCODE = CNT.CODE
WHERE CONTINENT = 'Asia';

/*
https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
*/

SELECT CONTINENT, TRUNCATE(AVG(CT.POPULATION),0) FROM CITY AS CT 
    INNER JOIN COUNTRY CNT ON CT.COUNTRYCODE = CNT.CODE
GROUP BY 
    CONTINENT;
	
