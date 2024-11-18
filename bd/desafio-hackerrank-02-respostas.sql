/*
https://www.hackerrank.com/challenges/african-cities/problem?isFullScreen=true
Dadas as tabelas CITY e COUNTRY, consulte os nomes de todas as cidades onde o CONTINENT é 'África'.
Nota: CITY.CountryCode e COUNTRY.Code são colunas-chave correspondentes.
*/

SELECT CITY.NAME FROM CITY INNER JOIN COUNTRY 
ON COUNTRYCODE = CODE
WHERE CONTINENT = 'AFRICA';

/*
https://www.hackerrank.com/challenges/asian-population/problem?isFullScreen=true
Dadas as tabelas CITY e COUNTRY, consulte a soma das populações de todas as cidades onde o CONTINENTE é 'Ásia'.
Nota: CITY.CountryCode e COUNTRY.Code são colunas-chave correspondentes.
*/

SELECT SUM(CITY.POPULATION) FROM CITY
INNER JOIN COUNTRY ON COUNTRYCODE = CODE
WHERE CONTINENT = 'Asia';

/*
https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true
Dadas as tabelas CITY e COUNTRY, consulte os nomes de todos os continentes (COUNTRY.Continent) e suas
respectivas populações médias de cidades (CITY.Population) arredondados para o número inteiro mais próximo.
Nota: Utilize a função TRUNCATE para o arredondamento.
*/

SELECT CONTINENT, TRUNCATE(AVG(CITY.POPULATION),0) 
FROM CITY INNER JOIN
COUNTRY ON COUNTRYCODE = CODE
GROUP BY CONTINENT;