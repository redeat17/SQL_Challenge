/*# SELECT Drills
1. For your first drill, complete the following:
    * Query the `actor` table to return `first_name` and `last_name` concatenated in a field labeled `full_name` 
    * Sort the result by `last_name` and `first_name` in ascending order
2. For your second drill, complete the following:
    * Query the `staff` table to return `first_name` and `last_name` concatenated in a field labeled `full_name`
    * Include the `email` and `username` columns in your query
    * Sort the result by `last_name` and `first_name` in ascending order
3.  For your third drill, complete the following:
    * Query the `film` table to return the film `title`, `description`, and `release_year` for all films.
    * Sort your result set by `title` in ascending order.*/
select 
	first_name || ' ' ||last_name as full_name
from
	actor
order by 
	last_name,
	first_name;
-------	
select 
	first_name || ' ' ||last_name as full_name,
	email, 
	username
from
	staff
order by 
	last_name,
	first_name;
----------
select 
	title,
	description,
	release_year
from
	film
order by
	title;
------------------------------------------------------------
-- # ORDER BY and LIMIT Drills

/*
1.  For your first drill, complete the following:
    * Query the `film` table to return the film `title`, `description`, `release_year`, and `replacement_cost` for films with a `rating` of "R".
    * Sort your result set by `replacement` cost in descending order, followed by title in ascending order.
    * Return the top 20 records, which will represent the 20 most expensive films to replace.
*/

select
	title,
	description,
	release_year,
	replacement_cost
from
	film
where
	rating = 'R'
order by
	replacement_cost desc,
	title
limit 20;

/*
2. For your second drill, complete the following:
    * Query the `film` table to return `title`, `description`, `release_year`, along with the length of each film's `description`.
    * Sort the result by the length of the film `description` in descending order.
    * Return the top 10  records, which will represent the 10 films with the longest descriptions.
*/

select
	title,
	description,
	release_year,
	length(description) as description_length
from
	film
order by
	length(description) desc
limit 10;
------------------------------------------------------------------------------------------------
-- # WHERE, BETWEEN, and LIKE Drills

/*
1.  For your first drill, complete the following:
    * Query the `film` table to return distinct set of ratings from the `rating` column.
    * Sort your result set by `rating` cost in ascending order.
*/
select
	distinct rating
from
	public.film
order by
	rating;

/*
2. For your second drill, complete the following:
    * Query the `film` table to return `title`, `description`, `release_year`, and `rating` for films that are rated "R" or NC-17. Use the `IN` operator to accomplish this.
    * Sort the result by `title`.
*/
select
	title,
	description,
	release_year,
	rating
from
	public.film
where
	rating in ('R','NC-17')
order by
	title;

/*
3. For your second drill, complete the following:
    * Query the `film` table to return `title`, `description`, `release_year`, `rating`, and `replacement_cost` for films that are rated "R" and cost between 20 and 30 dollars to replace.
    * Sort the result by `replacement_cost` in descending order, followed by `title` in ascending order.
*/
select
	title,
	description,
	release_year,
	rating,
	replacement_cost
from
	film
where
	rating = 'R'
	and replacement_cost between 20 and 30
order by
	replacement_cost desc,
	title;

/*
4. For your fourth drill, complete the following:
    * Query the `film` table to return `title`, `description`, `release_year`, `rating`, and `replacement_cost` for films that contain "thrilling" in the description.
    * Your query should be case insensitive.
    * Sort the result set by `title` in ascending order.
*/
select
	title,
	description,
	release_year,
	rating,
	replacement_cost
from
	film
where
	lower(description) like '%thrilling%'
order by
	title;
------------------------------------------------------------------
-- # JOIN Drills

/*
1.  For your first drill, complete the following:
    * Write a query to return the film title along with all of the actors who played in that film.
      * You will need to join three tables to accomplish this.
      * You should figure out the order for which to join the tables, but the tables are `actor`, `film`, and `film_actor`
    * Your query should return the film title (aliased as film_title) along with the concatenated actor name in a column aliased as `actor_name`
    * Sort your result set by `film_title` and `actor_name`.
*/

select
	f.title,
	a.first_name || ' ' || a.last_name as actor_name
from
	film_actor fa
	inner join film f
	on fa.film_id = f.film_id
	inner join actor a
	on fa.actor_id = a.actor_id
order by
	f.title,
	actor_name;

/*
2.  For your second drill, complete the following:
        * Write a query to return the film category, film title, along with all of the actors who played in that film.
          * You will need to join five tables to accomplish this.
          * You should figure out the order for which to join the tables, but the tables are `actor`, `category` `film`, `film_actor`, and `film_category`
        * Your query should return the film category (aliased as film_category), film title (aliased as film_title) along with the concatenated actor name in a column aliased as `actor_name`
        * Sort your result set by `film_category`,  `film_title` and `actor_name`.
*/

select
	c.name as film_category,
	f.title as film_title,
	a.first_name || ' ' || a.last_name as actor_name
from
	film_actor fa
	inner join film f
	on fa.film_id = f.film_id
	inner join film_category fc
	on f.film_id = fc.film_id
	inner join category c
	on fc.category_id = c.category_id
	inner join actor a
	on fa.actor_id = a.actor_id
order by
	film_category,
	film_title,
	actor_name;
--------------------------------------------------------------
/*# JOIN Drills (Part 2)

1.  For your first drill, complete the following:
    * Write a query to return the film(s) that has never been rented.
      * You will need to join three tables to accomplish this.
      * You should figure out the order for which to join the tables, but the tables are `film`, `inventory`, and `rental`
    * Your query should return only the film title for the movie(s) that have never been rented.
    * HINT: There should only be one movie that was never rented.

2.  For your second drill, complete the following:
    * Write a query to return the film categories that have no files associated with them.
      * You will need to join three tables to accomplish this.
      * You should figure out the order for which to join the tables, but the tables are `category`, `film`, and `film_category`
    * HINT: There is a possibly that all categories associated with them, so your result may contain zero records.
      If this is the case, then examine whether or not your query is correct and defend the result.*/

	