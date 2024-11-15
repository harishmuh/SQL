# SAKILA
USE sakila;

# 1. Tampilkan lima total rental_duration di tiap kategori film.
# Hitung jumlah kumulatif atau cumulative sum dan rata-rata bergerak atau moving average dari total rental_duration.
# Untuk membatasi data, pilih hanya film yang rental_duration-nya ≤ rata-rata keseluruhan rental_duration.

SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;

# WITH cte AS
# 	(SELECT c.name, SUM(rental_duration) AS total_rental_duration FROM film f
# 	JOIN film_category fc ON f.film_id = fc.film_id
# 	JOIN category c ON c.category_id = fc.category_id
# 	WHERE rental_duration <= (SELECT AVG(rental_duration) FROM film)
# 	GROUP BY c.name
# 	ORDER BY total_rental_duration DESC
# 	LIMIT 5)
# SELECT 
# 	name, 
#     total_rental_duration,
#     SUM(total_rental_duration) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum,
# 	AVG(total_rental_duration) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS moving_avg
# FROM cte;
USE sakila;

WITH cte AS
	(SELECT 
		c.name AS genre, 
		SUM(rental_duration) AS total_rental_duration
	FROM film f, film_category fc, category c
	WHERE f.film_id = fc.film_id AND c.category_id = fc.category_id 
	AND rental_duration <= (SELECT AVG(rental_duration) FROM film)
	GROUP BY c.name
	ORDER BY total_rental_duration DESC
	LIMIT 5)
SELECT 
	genre, 
    total_rental_duration,
    SUM(total_rental_duration) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sum,
	AVG(total_rental_duration) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS moving_avg 
FROM cte;


# 2. Tampilkan rating film beserta rata-rata durasi rentalnya.
# Gunakan data durasi rental film yang berasal dari 3 kategori dengan jumlah film terbanyak

WITH joined_table AS
	(SELECT c.name AS category, rating, rental_duration FROM film f
	JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category c ON c.category_id = fc.category_id),

top3_category AS 
	(SELECT category FROM joined_table
	GROUP BY category
	ORDER BY COUNT(*) DESC
	LIMIT 3)
    
SELECT 
	rating, 
	AVG(rental_duration) AS avg_rental_duration
FROM joined_table
WHERE category IN (SELECT * FROM top3_category)
GROUP BY rating
ORDER BY 2 DESC;


WITH joined_table AS
	(SELECT 
		c.name AS genre, rental_duration, rating
	FROM film f, film_category fc, category c
	WHERE f.film_id = fc.film_id AND c.category_id = fc.category_id),

list_top3 AS
	(SELECT genre FROM joined_table
	GROUP BY genre
	ORDER BY COUNT(*) DESC
	LIMIT 3)
    
SELECT rating, AVG(rental_duration) AS avg_rental_duration FROM joined_table
WHERE genre IN (SELECT * FROM list_top3)
GROUP BY rating
ORDER BY 2 DESC;




# 3. Tampilkan judul film dan total konsumen yang menyewa di tiap judul film tersebut.
# Saat menampilkan data tersebut, penuhi beberapa syarat berikut ini.
# Pertama, huruf pertama judul film adalah huruf ‘C’ atau ‘G’.
# Kedua, total konsumen yang menyewa di tiap judul film harus lebih tinggi dari rata-rata keseluruhan.
# Ketiga, total konsumen yang menyewa di tiap judul film harus ≥ 15 dan ≤ 25

SHOW TABLES;

WITH joined_table AS
	(SELECT title, COUNT(customer_id) AS total_customer FROM rental r
	JOIN inventory i ON r.inventory_id = i.inventory_id
	JOIN film f ON f.film_id = i.film_id
    GROUP BY title)
SELECT * FROM joined_table
WHERE (title LIKE 'C%' OR title LIKE 'G%')
AND total_customer > (SELECT AVG(total_customer) FROM joined_table)
AND total_customer BETWEEN 15 AND 25;


