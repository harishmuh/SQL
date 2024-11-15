USE world;

# 1. Ada berapa jenis region di data world?
SELECT COUNT(DISTINCT(Region)) AS Jumlah_Region
FROM country;

# 2. Ada berapa negara di Africa? Ubah headernya menjadi 'Jumlah_Negara_di_Afrika'! 
SELECT COUNT(Name) AS Jumlah_Negara_di_Afrika
FROM country
WHERE continent='Africa';

# 3. Tampilkan 5 negara dengan populasi terbesar! Ubah headernya menjadi 'Nama_Negara' dan 'Populasi'!
SELECT 
	Name AS Nama_Negara,
    Population AS Populasi
FROM country
ORDER BY Populasi DESC
LIMIT 5;

# 4. Tampilkan rata-rata harapan hidup tiap benua dan urutkan dari yang terendah! Ubah headernya menjadi 'Nama_Benua' dan 'Rata_Rata_Harapan_Hidup'!
SELECT 
	Continent AS Nama_Benua,
    AVG(LifeExpectancy) AS Rata_Rata_Harapan_Hidup
FROM country
GROUP BY Nama_Benua
ORDER BY Rata_Rata_Harapan_Hidup;

# 5. Tampilkan Jumlah region tiap benua dengan jumlah region lebih dari 3! Ubah headernya menjadi 'Nama_Benua' dan 'Jumlah_Region'!
SELECT 
	Continent AS Nama_Benua,
	COUNT(DISTINCT Region) AS Jumlah_Region
FROM country
GROUP BY Continent
HAVING Jumlah_Region > 3;

# 6. Tampilkan rata-rata GNP di Afrika berdasarkan regionnya dan urutkan dari GNP terbesar! Ubah headernya menjadi 'Nama_Region' dan 'Rata_Rata_GNP'!
SELECT 
	Region AS Nama_Region,
	AVG(GNP) AS Rata_Rata_GNP
FROM country
WHERE Continent='Africa'
GROUP BY Region
ORDER BY Rata_Rata_GNP DESC;

# 7. Tampilkan negara di Eropa yang memiliki nama dimulai dari huruf I!
SELECT Name, Continent
FROM country
WHERE Continent='Europe' AND Name LIKE 'I%';

# 8. Tampilkan Jumlah bahasa di tiap negara! Urutkan dari yg paling banyak! Ubah headernya menjadi 'Jumlah_Bahasa'
SELECT 
	CountryCode, 
	COUNT(Language) AS Jumlah_Bahasa
FROM countrylanguage
GROUP BY CountryCode
ORDER BY Jumlah_Bahasa DESC;

# 9. Tampilkan nama negara yang panjang hurufnya 6 huruf dan berakhiran 'O'
SELECT Name FROM country
WHERE Name LIKE '_____o';

# 10. Tampilkan 7 bahasa terbesar di Indonesia (secara persentase, dengan persentase yg dibulatkan)! Ubah headernya menjadi 'Bahasa' dan 'Persentase'!
SELECT 
	Language AS Bahasa,
    ROUND(Percentage,0) AS Persentase
FROM countrylanguage
WHERE CountryCode='IDN'
ORDER BY Percentage DESC
LIMIT 7;

# 11. Tampilkan 10 negara yang merdeka paling awal, yang tidak memiliki nilai kosong(NULL).
SELECT Name, IndepYear
FROM country
WHERE IndepYear IS NOT NULL
ORDER BY IndepYear
LIMIT 10;

# 12. Tampilkan Continent yang memiliki GovernmentForm kurang dari 10
SELECT 
	Continent AS Benua, 
    COUNT(DISTINCT GovernmentForm) AS Banyaknya_Bentuk_Pemerintahan
FROM country
GROUP BY Continent
HAVING Banyaknya_Bentuk_Pemerintahan < 10;

# 13.	Region mana saja yg Total GNP-nya mengalami kenaikan dari Total GNP sebelumnya (GNPOld)? Urutkan dari yang selisih kenaikannya tertinggi!
SELECT 
	Region,
    SUM(GNP) - SUM(GNPOld) AS Selisih
FROM country
GROUP BY Region
HAVING Selisih > 0
ORDER BY Selisih DESC;

USE sakila;

# 14. Tampilkan aktor yang memiliki nama depan ‘Scarlett’! 
SELECT *
FROM actor
WHERE first_name='SCARLETT';

# 15. Berapa banyak nama belakang aktor (tanpa ada pengulangan/distinct)?
SELECT COUNT(DISTINCT last_name) AS Nama_Belakang_Yang_Unik
FROM actor;

# 16. Tampilkan 5 nama belakang aktor yang keluar hanya satu kali di database Sakila!
SELECT 
	last_name AS Nama_Belakang, 
	COUNT(last_name) AS Jumlah_Kemunculan
FROM actor
GROUP BY last_name
HAVING Jumlah_Kemunculan = 1
LIMIT 5;


# 17. Tampilkan 5 nama belakang aktor yang keluar lebih dari satu kali di database Sakila!
SELECT 
	last_name AS Nama_Belakang, 
	COUNT(last_name) AS Jumlah_Kemunculan
FROM actor
GROUP BY last_name
HAVING Jumlah_Kemunculan != 1
LIMIT 5;

# 18. Tampilkan nama depan dan nama belakang dari setiap aktor dalam satu kolom dengan huruf besar semua. Ubah header-nya menjadi 'Nama_Aktor'!
SELECT CONCAT(first_name,' ',last_name) AS Nama_Aktor
FROM actor;

# 19. Berapa rata-rata durasi film di database Sakila?
SELECT ROUND(AVG(length), 2) AS Rerata_durasi
FROM film;

# 20. Tampilkan semua kolom pada customer_list yang tinggal di Indonesia dan memiliki no hp ganjil urutkan berdasarkan kode pos, dan ID!
SELECT * FROM customer_list
WHERE country='Indonesia' AND phone%2 != 0
ORDER BY 4, ID;

# 21. Tampilkan rata-rata pembayaran tiap bulannya dan urutkan berdasarkan penjualan tertinggi!
SELECT 
	MONTHNAME(payment_date) AS bulan, 
    ROUND(AVG(amount),3) AS rerata_pembayaran
FROM payment
GROUP BY MONTHNAME(payment_date)
ORDER BY 2 DESC;

# 22. Tampilkan 5 film dengan durasi terpendek!
SELECT title, length
FROM film
ORDER BY length
LIMIT 5;

# 23. Tampilkan banyaknya film untuk tiap rating diurutkan berdasarkan jumlah film dari terbanyak hingga tersedikit!
SELECT 
	rating, 
    COUNT(title) AS Jumlah_Film
FROM film
GROUP BY rating
ORDER BY 2 DESC;

# 24. Tampilkan rata rata replacement_cost berdasarkan rental rate untuk film-film yang di awali huruf Z!
SELECT 
	rental_rate,
    avg(replacement_cost)
FROM film
WHERE title LIKE 'Z%'
GROUP BY rental_rate;

# 25. Tampilkan rating-rating film yang memiliki rata-rata durasi diatas 115 menit!
SELECT 
	rating, 
	AVG(length) AS rerata_durasi 
FROM film
GROUP BY rating
HAVING rerata_durasi > 115;

USE purwadhika;

# 26. Gunakan tabel viewership. 
# Tulis query untuk menghitung jumlah penayangan untuk laptop dan mobile device dimana mobile didefiniskan 
# sebagai jumlah penayangan tablet dan phone. Outputnya ditampilkan dengan header 'laptop_reviews' dan 'mobile_views'.
SELECT 
	SUM(CASE WHEN device_type='laptop' THEN 1 ELSE 0 END) AS laptop_views,
    SUM(CASE WHEN device_type='phone' or device_type='tablet' THEN 1 ELSE 0 END) AS mobile_views
FROM viewership;

SELECT * FROM viewership;

# 27. Gunakan tabel employee_expertise.
# Anda ditugaskan untuk mengidentifikasi Subject Matter Expert (SME) di Accenture berdasarkan pengalaman kerja mereka di domain tertentu. 
# Seorang karyawan memenuhi syarat sebagai SME jika memenuhi salah satu kriteria berikut:

# Mereka memiliki pengalaman kerja 8 tahun atau lebih dalam satu domain.
# Mereka memiliki pengalaman kerja 12 tahun atau lebih di dua domain berbeda.

# Tulis query untuk menampilkan ID karyawan dari semua SME di Accenture.

# Asumsi:
# Seorang karyawan hanya dapat dianggap sebagai SME jika mereka memenuhi persyaratan pengalaman di satu atau dua domain. 
# Kasus dimana seorang karyawan mempunyai pengalaman di lebih dari dua domain dapat diabaikan.

# Cara Mba Maya
select 
	employee_id,
    (case when sum(years_of_experience) >= 8 and count(distinct domain) = 1 then True else False end) as req_1,
	(case when sum(years_of_experience) >= 12 and count(distinct domain) = 2 then True else False end) as req_2
from employee_expertise
group by employee_id
having req_1 = 1 or req_2 = 1;

# Cara Mas Iki
select employee_id from employee_expertise
group by employee_id
having count(employee_id) < 3 and sum(years_of_experience) > 8;

# Cara
SELECT employee_id FROM employee_expertise
GROUP BY employee_id
HAVING (SUM(years_of_experience)>=8 AND COUNT(DISTINCT domain)=1)
	OR (SUM(years_of_experience)>=12 AND COUNT(DISTINCT domain)=2);


# 28. Gunakan tabel applepay_transactions.
# Visa sedang menganalisis kemitraannya dengan ApplePay. 
# Hitung total volume transaksi untuk setiap merchant yang transaksinya dilakukan melalui ApplePay.
# Tampilkan merchant_ID dan total_transaction. Untuk pedagang yang tidak memiliki transaksi ApplePay, 
# tampilkan total volume transaksi mereka sebagai 0.
# Tampilkan hasilnya dari transaksi terbesar ke terendah.

SELECT merchant_id,
SUM(CASE WHEN payment_method='Apple Pay' THEN transaction_amount ELSE 0 END) AS total_transaction
FROM applepay_transactions
GROUP BY merchant_id
ORDER BY total_transaction DESC;


# 29. Gunakan tabel tabel_nilai.
# Tulis query untuk menampilkan tabel dengan tambahan kolom bernama indeks_nilai. Dimana terdapat ketentuan sebagai berikut:
# nilai akhir >80 maka “A”
# nilai akhir >60 maka “B”
# nilai akhir >40 maka “C”
# nilai akhir >20 maka “D”
# nilai akhir <=20 maka “E”

SELECT *,
CASE 
	WHEN nilai_akhir >= 80 THEN 'A'
	WHEN nilai_akhir >= 60 THEN 'B'
	WHEN nilai_akhir >= 40 THEN 'C'
	WHEN nilai_akhir >= 20 THEN 'D'
	ELSE 'E'
END AS indeks_nilai
FROM tabel_nilai;


