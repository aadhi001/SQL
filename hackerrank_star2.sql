/*1. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
 Ans:*?
 SELECT COUNT(CITY)- COUNT(DISTINCT CITY) FROM STATION;

 /*2.
 Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths
 (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered
 alphabetically.
 Ans:*/
 SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY),CITY LIMIT 1;
 SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC,CITY LIMIT 1;

/*3.
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
Ans:*/
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP "^[aeiou].*";

/*
4.Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

Ans:
*/
SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP ".*[AEIOU]$";

/*
5.Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters.
 Your result cannot contain duplicates.
 Ans:
 */
SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP "^[AEIOU].*[AEIOU]$";

/*
6.Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
Ans:
*/

SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP "^[^AEIOU].*";

/*
7. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
Ans:
*/

SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP "[^aeiou]$";
