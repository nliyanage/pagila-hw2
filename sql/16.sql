/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */
select RANK() OVER (order by COALESCE(sum(payment.amount), 0.00) desc) as rank, title, COALESCE(sum(payment.amount), 0.00) as revenue from film
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN payment USING (rental_id)
GROUP BY title
ORDER BY rank, revenue DESC;
