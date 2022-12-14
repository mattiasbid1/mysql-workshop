# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * FROM city WHERE name LIKE "ping%" ORDER BY population ASC;
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT * FROM city WHERE name LIKE "ran%" ORDER BY population DESC;
#
# 3: Count all cities
SELECT COUNT(Name) FROM city;
#
# 4: Get the average population of all cities
SELECT AVG(population) FROM city;
#
# 5: Get the biggest population found in any of the cities
SELECT MAX(population) FROM city;
#
# 6: Get the smallest population found in any of the cities
SELECT MIN(population) FROM city;
#
# 7: Sum the population of all cities with a population below 10000
SELECT SUM(population) FROM city;
#
# 8: Count the cities with the countrycodes MOZ and VNM
SELECT COUNT(name) FROM city WHERE CountryCode = "MOZ" || CountryCode = "VNM";
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
SELECT SUM(CASE WHEN CountryCode = "MOZ" THEN 1 ELSE 0 END) AS MOZ_COUNT,
SUM(CASE WHEN CountryCode = "VNM" THEN 1 ELSE 0 END) AS VNM_COUNT FROM city;
#
# 10: Get average population of cities in MOZ and VNM
SELECT AVG(population) FROM city WHERE CountryCode = "MOZ" || CountryCode = "VNM";
#
# 11: Get the countrycodes with more than 200 cities
SELECT CountryCode,
COUNT(CountryCode) AS Cities
FROM city
GROUP BY CountryCode
HAVING COUNT(CountryCode) > 200;
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
SELECT CountryCode,
COUNT(CountryCode) AS Cities
FROM city
GROUP BY CountryCode
HAVING COUNT(CountryCode) > 200
ORDER BY Cities DESC;
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
SELECT countrylanguage.Language
FROM city JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE city.Population > 400 && city.population < 500;
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT city.name, countrylanguage.language
FROM city JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE city.Population > 500 && city.population < 600;
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
SELECT name
FROM city
WHERE Countrycode = ( SELECT CountryCode
FROM city
WHERE population = 122199);
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
SELECT name
FROM city
WHERE Countrycode = ( SELECT CountryCode
FROM city
WHERE population = 122199) && Population <> 122199;
#
# 17: What are the city names in the country where Luanda is capital?

SELECT name
FROM city
WHERE CountryCode = ( SELECT CountryCode
FROM city
WHERE name = "Luanda");

#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren

SELECT city.Name AS CapitalCities
FROM city
INNER JOIN country ON country.capital = city.id
WHERE country.region = ( SELECT region
FROM country
WHERE capital = (SELECT ID
FROM city
WHERE Name = "Yaren"));

#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga

SELECT DISTINCT Language
FROM countryLanguage
INNER JOIN country ON country.Code = countrylanguage.CountryCode
WHERE region = ( SELECT region
FROM country
WHERE capital = ( SELECT ID
FROM city
WHERE name = "Riga"));

#
# 20: Get the name of the most populous city

SELECT name FROM city WHERE population = (SELECT MAX(Population) FROM city);
