-- 1. Show total revenue from each film

select fi.title , SUM(pay.amount) as TotalRevenue from film fi
join inventory inve ON inve.film_id =  fi.film_id
join rental rent ON rent.inventory_id =  inve.inventory_id
join payment pay ON pay.rental_id = rent.rental_id
GROUP BY fi.title

-- 2. List customers who rented more than once in a single day

SELECT cu.first_name, cu.last_name, cu.email, rent.rental_date, COUNT(rent.rental_id) AS RentalCount
FROM customer cu
JOIN rental rent ON rent.customer_id = cu.customer_id
GROUP BY cu.customer_id, cu.first_name, cu.last_name, cu.email, rent.rental_date
HAVING COUNT(rent.rental_id) > 1

-- 3. Get all active customers

select * from customer where active =1

-- 4. List the top 3 languages by number of films

select top 3* from language lan
join film fil ON fil.language_id = lan.language_id 
ORDER BY fil.language_id

-- 5. Find which staff member made the highest revenue in total

select TOP 1 sta.first_name,sta.last_name,SUM(pay.amount) as TotalRevenue from staff sta
join payment pay ON pay.staff_id = sta.staff_id
GROUP BY sta.first_name,sta.last_name
ORDER BY TotalRevenue desc

-- 6. List all rentals made by customer “Mary Smith”

select custo.first_name,custo.last_name, rent.* from rental rent 
join customer custo ON rent.customer_id = custo.customer_id
WHERE custo.first_name + ' ' + custo.last_name = 'Mary Smith'

-- 7. Find customers who have never rented anything

select cust.* from customer cust
join rental rent ON rent.customer_id =  cust.customer_id
where cust.customer_id NOT IN (select ren.customer_id from rental ren)

-- 8. Find all films not in inventory

select fi.title,fi.release_year from film  fi
LEFT JOIN inventory inve ON inve.film_id = fi.film_id
WHERE inve.film_id IS NULL

-- 9. Get average film length per rating
 select fi.title,fi.rating, AVG(fi.length) as AverageFilmLength
 from film fi
 GROUP BY fi.rating,fi.title
 ORDER BY fi.rating ASC

-- 10. Show the daily revenue for a specific date (e.g., 2005-07-05)

-- 11. Get all actors with last name ‘Davis’

   select * from actor where last_name = 'Davis'

-- 12. List all categories of films
   
   select * from category

-- 13. Get a list of all overdue rentals

-- 14. List customers from ‘Canada’
   select * from customer_list where country = 'Canada'

-- 15. Calculate the average time between rentals per customer

   select AVG(rent.rental_date) AS AverageTime from rental rent
   GROUP  BY rent.rental_date
  
-- 16. Count how many films each actor has starred in
   select act.first_name,act.last_name, COUNT(fi.film_id) as NumberOfFilms from film_actor fi
   JOIN actor act ON act.actor_id = fi.actor_id
   GROUP BY act.first_name,act.last_name

-- 17. Find customers who rented a film on the same day they registered

  select * from customer cust
  join rental rent ON cust.customer_id = rent.customer_id
  WHERE CAST(rent.rental_date as DATE) =CAST(cust.create_date as DATE)

-- 18. Find the number of films in each rating category

  select fi.rating,COUNT(fi.rating) FilmRating from film fi
  GROUP BY fi.rating

-- 19. Show inventory turnover rate (rental count / stock) per film
    
-- 20. List the 3 most rented categories
  SELECT TOP 3 cat.name, COUNT(filcat.category_id) as CategoryCount from category cat
  join film_category filcat ON cat.category_id = filcat.category_id  
  join film fi  ON fi.film_id =  filcat.film_id
  GROUP BY filcat.category_id, cat.name
  ORDER BY filcat.category_id ASC
   
-- 21. Get all customers who have rented more than 10 times

   select cust.first_name,cust.last_name, COUNT(rent.rental_id) as RentalCount from customer cust 
   join rental rent ON rent.customer_id = cust.customer_id
   GROUP BY cust.customer_id,cust.first_name,cust.last_name
   HAVING COUNT(rent.rental_id) > 10

-- 22. List the most popular film per month (based on rental count)
   
   select fi.title,COUNT(*) as RentalCount from film fi
   join inventory inve ON inve.film_id = fi.film_id
   join rental re ON re.inventory_id  = inve.inventory_id 
   GROUP BY  fi.film_id,fi.title 
   ORDER BY RentalCount DESC

-- 23. Get the most rented film(s)
SELECT TOP 5 fi.title, COUNT(*) AS RentalCount
FROM film fi
JOIN inventory inve ON inve.film_id = fi.film_id
JOIN rental re ON re.inventory_id = inve.inventory_id
GROUP BY fi.film_id, fi.title
ORDER BY RentalCount DESC;

-- 24. Create a view that lists each film with total revenue and rental count
GO
CREATE VIEW FileRevenueRentals AS
SELECT 
  fi.title, 
  SUM(pay.amount) AS TotalRevenue, 
  COUNT(rent.rental_id) AS RentalCount
FROM film fi
JOIN inventory inve ON inve.film_id = fi.film_id
JOIN rental rent ON rent.inventory_id = inve.inventory_id
JOIN payment pay ON pay.rental_id = rent.rental_id
GROUP BY fi.title, fi.film_id;

-- 25. Find actors whose first name starts with ‘S’

  Select * from actor where actor.first_name like 'S%'

-- 26. Show staff names and the stores they work in
SELECT 
    s.first_name,
    s.last_name,
    st.store_id,
    a.address
FROM staff s
JOIN store st ON s.store_id = st.store_id
JOIN address a ON st.address_id = a.address_id;

-- 27. Find all films released in 2006

-- 28. Show total revenue per category
-- 29. List the first 10 films in alphabetical order
-- 30. List the most active customer (by rental count)
-- 31. Find how many customers each staff member has served
-- 32. List the 5 actors with the most film appearances
-- 33. Calculate total revenue per category
-- 34. Show the length (in minutes) of each film
-- 35. List all films and their categories (JOIN)
-- 36. List films rented more than 100 times
-- 37. Get the email of customer with ID 5
-- 38. List top 5 longest films
-- 39. List all films and their ratings
-- 40. List all customers: Show first_name, last_name, and email
-- 41. Find customers who rented from both stores
-- 42. Get all actors who have never starred in an “Action” film
-- 43. Find customers who rented the same film more than once
-- 44. Find average rental duration per category
-- 45. List all languages spoken in the films
-- 46. List actors in the film “ACADEMY DINOSAUR”
-- 47. List rentals that happened on weekends
-- 48. List film titles and their ratings
-- 49. Count total films in the inventory
-- 50. Find customers who rented a film on the same day they registered