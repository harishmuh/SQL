# WORLD
USE world;

# 1. Tampilkan 10 kota dengan populasi terbanyak (dalam persentase 2 di belakang koma). (tampilkan nama kota, asal negara, dan populasinya)

SELECT * FROM city;
SELECT * FROM country;

SELECT 
	ci.name AS Nama_Kota,
    co.name AS Asal_Negara,
    ROUND(ci.population * 100 / (SELECT SUM(population) FROM city), 2) AS Persentase
FROM city ci
JOIN country co ON ci.CountryCode = co.Code
ORDER BY Persentase DESC
LIMIT 10;


# 2. Tampilkan negara - negara di asia yang angka harapan hidupnya lebih besar dari rata-rata angka harapan hidup
# negara di benua eropa. Urutkan 10 data dari angkaharapan hidup tertinggi. (tampilkan, nama negara, benua, angkaharapanhidup, dan gnp). 

SELECT AVG(LifeExpectancy) FROM country
WHERE continent = 'Europe';

SELECT Name, Continent, LifeExpectancy, GNP
FROM country
WHERE Continent='Asia' AND LifeExpectancy > 
	(SELECT AVG(LifeExpectancy) FROM country
	WHERE continent = 'Europe')
ORDER BY LifeExpectancy DESC;

# 3. Tampilkan 10 negara dengan persentase tertinggi yang menggunakan bahasa inggris sebagai bahasa resmi negaranya.
# (Tampilkan kode negara, nama negara, bahasa, Resmi(T/F), persentase).

SELECT * FROM countrylanguage;
SELECT * FROM country;

SELECT 
	co.Code AS 'Kode Negara',
    co.Name AS 'Nama Negara',
    cl.Language AS 'Bahasa',
    cl.IsOfficial AS 'Resmi(T/F)',
    cl.Percentage AS 'Persentase'
FROM country co
JOIN countrylanguage cl 
ON co.Code = cl.CountryCode
WHERE Language = 'English' AND IsOfficial = 'T'
ORDER BY cl.Percentage DESC
LIMIT 10;


# 4. Tampilkan negara, populasi negara, GNP, ibukota, dan populasi ibukota. DI ASEAN dan urutkan berdasarkan abjad nama negara. 
# SELECT 
# 	co.Name AS 'Nama Negara', 
# 	co.Population AS 'Populasi Negara', 
# 	co.GNP AS 'GNP', 
# 	ci.Name AS 'Nama Ibukota', 
# 	ci.Population AS 'Populasi Ibukota'
# FROM country co
# JOIN city ci
# ON co.Capital = ci.ID
# WHERE co.Region = 'SouthEast Asia'
# ORDER BY co.Name;

SELECT * FROM country;
SELECT * FROM city;

SELECT 
	co.Name AS 'Nama Negara', 
	co.Population AS 'Populasi Negara', 
	co.GNP AS 'GNP', 
	ci.Name AS 'Nama Ibukota', 
	ci.Population AS 'Populasi Ibukota'  
FROM country co, city ci
WHERE co.Code = ci.CountryCode AND co.Capital = ci.ID AND region = 'Southeast Asia'
ORDER BY co.Name ASC;

# 5. Sama seperti no.4 Untuk negara G-20.
# Argentina - United States

SELECT 
	co.Name AS 'Nama Negara', 
	co.Population AS 'Populasi Negara', 
	co.GNP AS 'GNP', 
	ci.Name AS 'Nama Ibukota', 
	ci.Population AS 'Populasi Ibukota'
FROM country co
JOIN city ci
ON co.Capital = ci.ID
WHERE co.Name IN ('Argentina', 'Australia', 'Brazil', 'Canada', 'China', 'France', 
'Germany', 'India', 'Indonesia', 'Italy', 'South Korea', 'Japan', 'Mexico', 'Russian Federation',  
'Saudi Arabia', 'South Africa', 'Turkey', 'United Kingdom', 'United States')
ORDER BY co.Name;

# -----------------------------------------------------------

# SAKILA
USE sakila;
# 1. Tampilkan 10 baris data customer id, rental id, amount, dan payment date pada table payment!
SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
LIMIT 10;


# 2. Dari table “film”, tampilkan 10 judul film, tahun release, dan durasi rental di mana judul film yang ditampilkan yang dimulai dengan huruf “S”!
SELECT 
	title,
    release_year,
    rental_duration
FROM film
WHERE title LIKE 'S%'
LIMIT 10;


# 3. Dari tabel “film”, tampilkan durasi rental, banyaknya film setiap durasi rental, dan rata-rata durasi film!
# Kelompokkan jumlah film dan rata-rata durasi film berdasarkan durasi rentalnya!
# Karena rata-rata durasi film angka desimal, bulatkan 2 angka di belakang koma!

SELECT 
	rental_duration AS durasi_rental, 
	COUNT(title) AS banyaknya_fim, 
	ROUND(AVG(length), 2) AS rata_rata_durasi_film
FROM film
GROUP BY rental_duration
ORDER BY rental_duration;


# 4. Dari tabel film, tampilkan title, durasi film, dan juga rating yang durasi filmnya lebih dari rata-rata durasi film total!
# Tampilkan 10 data yang diurutkan dari durasi terlama!
SELECT 
	title, 
    length, 
    rating
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER by length DESC
LIMIT 10;

# 5. Dari tabel “film”, tampilkan rating, Replacement Cost tertinggi, Rental Rate Terendah, dan Rata-Rata Durasi untuk tiap rating film!
SELECT 
	rating,
    MAX(replacement_cost) AS replacement_cost_tertinggi,
    MIN(rental_rate) AS rental_rate_terendah,
    AVG(length) AS rata_rata_durasi
FROM film
GROUP BY rating;


# 6. Tampilkan 15 daftar film yang memiliki huruf “K” pada akhir pada title, lalu tampilkan title, durasi, serta Bahasa pada film!
# Sebagai catatan, lakukan join terlebih dahulu dari tabel “film” dan tabel “language”!

# SELECT 
# 	f.title AS judul_film, 
# 	f.length AS durasi,  
# 	l.name AS bahasa
# FROM film f
# JOIN language l
# ON f.language_id = l.language_id
# WHERE title LIKE '%K'
# LIMIT 15;

SELECT 
	f.title AS judul_film, 
	f.length AS durasi,  
	l.name AS bahasa
FROM film f, language l
WHERE f.language_id = l.language_id
AND f.title LIKE '%K'
LIMIT 15;


# 7. Tampilkan Judul Film (dari tabel “film”), First Name (dari tabel “actor”), dan Last Name (Dari tabel “actor”) dari actor yang memiliki “actor_id” = 14!
# Sebagai catatan, lakukan join table terlebih dahulu antara tabel “film”, “film_actor”, dan “actor”! Tampilkan 10 baris pertama!
SELECT f.title, a.first_name, a.last_name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.actor_id = 14
LIMIT 10;


# 8. Dari tabel "city“, tampilkan city dan country id! 
# Tampilkan hanya city atau kota yang namanya ada huruf "d" di posisi mana pun dan diakhiri huruf “a”!
# Tampilkan 15 data yang diurutkan berdasarkan city-nya secara ascending!
SELECT city, country_id 
FROM city
WHERE city LIKE '%d%a'
ORDER BY city
LIMIT 15;


# 9. Tampilkan nama genre (name dari tabel “category”) dan jumlah banyaknya film di setiap genrenya!
# Lakukan join terlebih dahulu antara tabel “film”, “film_category”, dan “category”!
# Urutkan berdasarkan jumlah film di setiap kategorinya secara ascending!
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;

SELECT 
	c.name AS Nama_Genre,
	COUNT(f.title) AS Jumlah_Film
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY Nama_Genre
ORDER BY Jumlah_Film;

# 10. Dari tabel “film”, tampilkan title, description, length, serta rating!
# Tampilkan 10 judul film yang diakhiri huruf ‘h’ dan durasinya di atas durasi rata-rata!
# Urutkan berdasarkan judulnya secara ascending!
SELECT title, description, length, rating 
FROM film
WHERE title LIKE '%h' AND length > (SELECT AVG(length) FROM film)
LIMIT 10;

