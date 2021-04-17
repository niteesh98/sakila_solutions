USE sakila;
SHOW TABLES;
SELECT * FROM actor;

SELECT title, description, rental_duration,rental_rate,
rental_duration*rental_rate as total_rental_cost
FROM film;

select DISTINCT last_name FROM actor;

SELECT distinct postal_code FROM address;

select distinct rating from film;

select title, description, rating, length
FROM film
WHERE length>=180;

SELECT payment_id, amount, payment_date FROM payment
WHERE payment_date >= DATE('2005-05-27 00:00:00');

SELECT payment_id, amount, payment_date
FROM payment 
WHERE payment_date >= DATE('2005-05-27 00:00:00') AND
	payment_date <=DATE('2005-05-28 00:00:00');
    
--   
-- 3d. Select all columns from the customer table for rows that have a last name beginning with "S" and a first name ending with "N".
--
SELECT * FROM customer
WHERE last_name LIKE 'S%' AND first_name LIKE '%N';
--
-- 3e. Select all columns from the customer table for rows where the customer is inactive or has a last name ending with "M"..
--
SELECT * FROM customer
WHERE active=0 or last_name LIKE '%M';

--
-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either "C", "S" or "T".
--
SELECT * FROM category
WHERE category_id >4 and name like 'C%'or name like 'S%'or name like 'T%';

--
-- 3g. Select all columns minus the password column from the staff table for rows that contain a password
--
select * from staff where password IS NULL;

-- 3h. Select all columns minus the password column from the staff table for rows that do not contain a password.

SELECT *
FROM staff
WHERE password IS NOT NULL;

-- ## 4. IN operator

-- 4a. Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.

SELECT phone, district FROM address
WHERE district IN('California','England','Taipei','West Java');

-- 4b. Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005.
-- (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)

SELECT payment_id,amount,payment_date 
FROM payment 
WHERE CAST(payment_date AS DATE) IN('2005-05-25','2005-05-27','2005-05-29');

# 4c. Select all columns from the film table for films rated G, PG-13 or NC-17.

SELECT * FROM film
where rating IN ('G','PG-13','NC-17');

## 5. BETWEEN operator

# 5a. Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.

SELECT * FROM payment
where payment_date between '2005-05-25 00:00:00' AND '2005-05-25 23:59:59'
ORDER BY payment_date ASC;

# 5b. Select the following columns from the film table for films where the length of the description is between 100 and 120.
#
# COLUMN NAME           Note
# title                 Exists in film table.
# description           Exists in film table.
# release_year          Exists in film table.
# total_rental_cost     rental_duration * rental_rate

SELECT title, description, release_year,
rental_duration*rental_rate AS total_rent_cost
FROM film 
WHERE length(description) between 100 and 120;

## 6. LIKE operator

# 6a. Select the following columns from the film table for rows where the description begins with "A Thoughtful".
# Title, Description, Release Year

SELECT title, description, release_year
FROM film 
where description LIKE 'A Thoughtful%';

# 6b. Select the following columns from the film table for rows where the description ends with the word "Boat".
# Title, Description, Rental Duration
SELECT title, description, release_year
FROM film 
where description LIKE '%Boat';

# 6c. Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
# Title, Length, Description, Rental Rate

SELECT title,length, description, rental_rate
FROM film 
WHERE description LIKE '%Database%' AND length >=180;

## 7. LIMIT Operator
# 7a. Select all columns from the payment table and only include the first 20 rows.

SELECT * FROM payment
LIMIT 20;

# 7b. Select the payment id, payment date and amount columns from the payment table for rows where the payment amount is greater than 5 and only select rows whose zero-based index in the result set is between 51-100.

SELECT payment_id, payment_date, amount
FROM payment 
WHERE amount >5 
ORDER BY payment_id
LIMIT 50 OFFSET 50;

# 7c. Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.

SELECT * from customer
ORDER BY customer_id
LIMIT 100 OFFSET 100;

## 8. ORDER BY statement

# 8a. Select all columns from the film table and order rows by the length field in ascending order.

SELECT * 
FROM film
ORDER BY length;

# 8b. Select all distinct ratings from the film table ordered by rating in descending order.
SELECT DISTINCT rating
FROM film
ORDER BY rating DESC;

# 8c. Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.

SELECT payment_date, amount
FROM payment
order by amount DESC
LIMIT 20;

# 8d. Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.

SELECT title,description, special_features, length, rental_duration
FROM film
WHERE special_features LIKE '%Behind the Scenes%' AND length<='120'
AND rental_duration BETWEEN 5 AND 7
ORDER BY length DESC
limit 10;

## 9. JOINS
# (Take some time to compare results of the next three exercises)

# 9a. Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. `customer.last_name = actor.last_name`)
# Label customer first_name/last_name columns as customer_first_name/customer_last_name
# Label actor first_name/last_name columns in a similar fashion.

SELECT cust.first_name as customer_first_name,
cust.last_name as customer_last_name,
act.first_name as actor_first_name,
act.last_name as actor_last_name
from customer as cust
LEFT JOIN actor as act
ON cust.last_name= act.last_name;

# 9b. Select the customer first_name/last_name and actor first_name/last_name columns from performing a right join between the customer and actor column on the last_name column in each table. (i.e. `customer.last_name = actor.last_name`)

SELECT cust.first_name as customer_first_name,
cust.last_name as customer_last_name,
act.first_name as actor_first_name,
act.last_name as actor_last_name
from customer as cust
RIGHT JOIN actor as act
ON cust.last_name= act.last_name;

# 9c. Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. `customer.last_name = actor.last_name`)
SELECT cust.first_name as customer_first_name,
cust.last_name as customer_last_name,
act.first_name as actor_first_name,
act.last_name as actor_last_name
from customer as cust
INNER JOIN actor as act
ON cust.last_name= act.last_name;

# 9d. Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.

SELECT city, country
FROM city
LEFT JOIN country
on city.country_id= country.country_id;

# 9e. Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
# Label the language.name column as "language" (e.g. `select language.name as language`)

SELECT title, description, release_year, language.name as language
FROM film
LEFT JOIN language
ON film.language_id=language.language_id;

# 9f. Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.

select * from staff;
select * from address;
select * from city;

SELECT first_name, last_name, address.address, address.address2,city.city,address.district,address.postal_code
FROM staff
LEFT JOIN address
ON staff.address_id= address.address_id
LEFT JOIN city
ON address.city_id= city.city_id;
