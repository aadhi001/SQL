/*
1. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels.
Your result cannot contain duplicates.
Ans:
*/
SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP "^[^AEIOU]" OR CITY REGEXP "[^AEIOU]$";

/*
2.Query the list of CITY names from STATION that do not start with vowels and do not end with vowels.
 Your result cannot contain duplicates.
Ans:
*/

SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP "^[^AEIOU]" AND CITY REGEXP "[^AEIOIU]$";

/*
3.Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output
by the last three characters of each name. If two or more students both have 
names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
Ans:
*/
SELECT NAME 
FROM STUDENTS
WHERE MARKS>75 
ORDER BY SUBSTRING(NAME,-3), ID;

/*
4.
Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table 
in alphabetical order.
Ans:
*/

SELECT NAME
FROM EMPLOYEE
ORDER BY NAME;

/*
5.
Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having
a salary greater than 2000 per month who have been employees for less than 2 months. Sort your result by 
ascending employee_id.
Ans:
*/

SELECT NAME FROM EMPLOYEE
WHERE SALARY > 2000 AND MONTHS<10
ORDER BY EMPLOYEE_ID;

/*
*/