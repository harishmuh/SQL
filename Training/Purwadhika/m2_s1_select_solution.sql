USE world;

# 1. Ada berapa negara di database world?
SELECT COUNT(Name) AS Jumlah_Negara
FROM country;

# 2. Tampilkan rata-rata harapan hidup di benua Asia!
 SELECT ROUND(AVG(LifeExpectancy), 2) AS Rata_Rata_Harapan_Hidup_di_Asia
 FROM country
 WHERE continent='Asia';

# 3. Tampilkan total populasi di Asia Tenggara!
 SELECT SUM(Population) AS Total_Populasi_di_Asia_Tenggara
 FROM country
 WHERE region='Southeast Asia';

# 4. Tampilkan rata-rata GNP di benua Afrika region Eastern Africa. Gunakan alias 'Average_GNP' untuk rata-rata GNP!
 SELECT AVG(GNP) AS Average_GNP
 FROM country
 WHERE region='Eastern Africa';

# 5. Tampilkan rata-rata Populasi pada negara yang luas areanya lebih dari 5 juta km2!
 SELECT AVG(Population) AS Average_Population
 FROM country
 WHERE SurfaceArea > 5000000;

# 6. Tampilkan nama provinsi di Indonesia beserta populasinya yang memiliki populasi di atas 5 juta!
SELECT Name, Population
FROM city
WHERE CountryCode = 'IDN' AND Population > 5000000;

# 7. Ada berapa bahasa (unique) di dunia?
SELECT COUNT(DISTINCT Language) AS Jumlah_Bahasa_di_Dunia
FROM countrylanguage;
 
# 8. Tampilkan bahasa-bahasa apa saja yang dipergunakan di Indonesia!
SELECT DISTINCT Language AS Bahasa_di_Indonesia
FROM countrylanguage
WHERE CountryCode='IDN';

# 9. Tampilkan GNP dari 5 negara di Asia yang populasinya di atas 100 juta penduduk!
SELECT Name, GNP FROM country
WHERE continent='Asia' AND population > 1e8
LIMIT 5;

# 10. Tampilkan negara di Afrika yang memiliki SurfaceArea di atas 1.200.000!
SELECT Name   
FROM country
WHERE continent='Africa' AND SurfaceArea > 1200000;

# 11. Tampilkan negara di Afrika yang memiliki huruf akhir 'i'!
SELECT Name   
FROM country
WHERE continent='Africa' AND Name LIKE '%i';

# 12. Tampilkan jumlah negara di Asia yang sistem pemerintahannya adalah republik. 
SELECT COUNT(Name) AS Banyaknya_Negara_Republik
FROM country
WHERE GovernmentForm='Republic' AND Continent='Asia';

# 13. Tampilkan jumlah negara di Eropa yang merdeka sebelum 1940!
SELECT COUNT(Name) AS Banyaknya_Negara
FROM country
WHERE IndepYear < 1940 AND Continent='Europe';

# 14. Tampilkan 5 nama kota yang berada di provinsi Jawa Barat!
SELECT Name FROM city
WHERE District='West Java'
LIMIT 5;

# 15. Tampilkan 3 nama kota yang memiliki id genap di negara Jepang!
SELECT *
FROM city
WHERE CountryCode='JPN' AND ID%2=0
LIMIT 3;
 

USE purwadhika;

# 16. Buat tabel bernama tabel_mahasiswa dengan isian berikut!
DROP TABLE IF EXISTS tabel_mahasiswa;
CREATE TABLE tabel_mahasiswa (
  nim INT NOT NULL AUTO_INCREMENT,
  nama VARCHAR(50) NOT NULL DEFAULT '',
  jenis_kelamin ENUM('L', 'P') NOT NULL DEFAULT 'L',
  angkatan INT UNSIGNED NOT NULL ,
  kota_asal VARCHAR(30) NOT NULL DEFAULT '',
  PRIMARY KEY (nim)
);

INSERT INTO tabel_mahasiswa (
  nim, nama, jenis_kelamin, angkatan, kota_asal)
VALUES
(0101, 'Andrea', 'L', 2001, 'Jakarta'),
(0102, 'Cartwright', 'P', 2001, 'Yogyakarta'),
(0103, 'Leonard', 'L', 2001, 'Yogyakarta'),
(0204, 'Jhonny', 'L', 2002, 'Jakarta'),
(0205, 'Riyanti', 'P', 2002, 'Semarang'),
(0306, 'Albert', 'L', 2003, 'Jakarta'),
(0307, 'Shanti', 'P', 2003, 'Jakarta'),
(0308, 'Kenward', 'L', 2003, 'Surabaya'),
(0309, 'Robert', 'L', 2003, 'Yogyakarta');

SELECT * FROM tabel_mahasiswa;

# 17. Ubah kota_asal mahasiswa dengan nim 102 menjadi Bandung!
UPDATE tabel_mahasiswa
SET kota_asal = 'Bandung'
WHERE nim = 102;	

SELECT * FROM tabel_mahasiswa;

# 18. Hapus data mahasiswa yang angkatannya 2003 dan berasal dari kota selain Jakarta!
DELETE FROM tabel_mahasiswa
WHERE angkatan = 2003 AND kota_asal NOT LIKE 'J%';

SELECT * FROM tabel_mahasiswa;

# 19. Buat tabel bernama tabel_mahasiswa dengan isian berikut!
DROP TABLE IF EXISTS tabel_nilai;
CREATE TABLE tabel_nilai (
  nim INT NOT NULL,
  kode_matakuliah VARCHAR(3),
  nilai_tugas DECIMAL(5,2),
  nilai_mid DECIMAL(5,2),
  nilai_uas DECIMAL(5,2)
);

INSERT INTO tabel_nilai (
  nim, kode_matakuliah, nilai_tugas, nilai_mid, nilai_uas)
VALUES
(0101, 'PBD',80, 75, 85 ),
(0102, 'PBD', 80, 80, 80 ),
(0103, 'PBD', 90, 60, 50 ),
(0204, 'PBD', 50, 100, 90 ),
(0205, 'PBD', 30, 75, 50 ),
(0306, 'PBD', 90, 40, 80 ),
(0307, 'PBD', 45, 55, 70 ),
(0308, 'PBD', 80, 75, 85 ),
(0309, 'PBD', 70, 80, 80 ),
(0101, 'AI', 70, 80, 75 ),
(0102, 'AI', 35, 50, 65 ),
(0204, 'AI', 80, 55, 45),
(0205, 'AI', 90, 95, 85),
(0306, 'AI', 70, 30, 35),
(0308, 'AI', 50, 10, 15 );

SELECT * FROM tabel_nilai;

# 20. Tambahkan kolom nilai akhir pada tabel_nilai dimana nilai akhir adalah 
# hasil perhitungan dari 40% nilai tugas, 30% nilai mid dan 30% nilai uas.

ALTER TABLE tabel_nilai
ADD nilai_akhir DECIMAL(5,2) NOT NULL;

UPDATE tabel_nilai
SET nilai_akhir = 0.4*nilai_tugas + 0.3*nilai_mid + 0.3*nilai_uas;

SELECT * FROM tabel_nilai;

# 21. Buat tabel bernama viewership dengan isian berikut!

# NEW YORK TIMES - LAPTOP VS MOBILE VIEWERSHIP
-- viewership table
DROP TABLE IF EXISTS viewership;
CREATE TABLE IF NOT EXISTS viewership (
  user_id INT NOT NULL,
  device_type VARCHAR(200) NOT NULL
);

-- viewership data
INSERT INTO viewership VALUES
(123, 'tablet'),
(125, 'laptop'),
(128, 'laptop'),
(129, 'phone'),
(145, 'tablet');

SELECT * FROM viewership;

# 22. Buat tabel bernama employee_expertise dengan isian berikut!

# ACCENTURE - SUBJECT MATTER EXPERTS
--  employee_expertise table
DROP TABLE IF EXISTS employee_expertise;
CREATE TABLE IF NOT EXISTS employee_expertise (
  employee_id INT NOT NULL,
  domain VARCHAR(200) NOT NULL,
  years_of_experience INT NOT NULL
);

--  employee_expertise data
INSERT INTO employee_expertise VALUES
	(101, 'Digital Transformation', 9),
	(102, 'Supply Chain', 6),
	(102, 'IoT', 7),
	(103, 'Change Management', 4),
	(104, 'DevOps', 5),
	(104, 'Cloud Migration', 5),
	(104, 'Agile Transformation', 5),
	(105, 'Change Management', 3),
	(106, 'DevOps', 15);

SELECT * FROM employee_expertise;


# 23. Buat tabel bernama applepay_transactions dengan isian berikut!
# VISA - APPLEPAY VOLUME
--  applepay_transactions table
DROP TABLE IF EXISTS applepay_transactions;
CREATE TABLE IF NOT EXISTS applepay_transactions (
  merchant_id INT NOT NULL,
  transaction_amount INT NOT NULL,
  payment_method VARCHAR(200) NOT NULL
);

--  applepay_transactions data
INSERT INTO applepay_transactions VALUES
	(1, 600, 'Contactless Chip'),
	(2, 560, 'Magstripe'),
	(1, 500, 'Apple Pay'),
	(2, 400, 'Samsung Pay'),
	(3, 1600, 'Apple Pay'),
	(3, 2050, 'Apple Pay'),
	(5, 500, 'Google Pay'),
	(5, 2500, 'Apple pay'),
	(3, 100, 'Contactless chip'),
	(4, 1180, 'apple pay'),
	(4, 1200, 'apple pay'),
	(1, 850, 'apple pay'),
	(3, 1000, 'Google pay'),
	(5, 770, 'apple Pay');
    
SELECT * FROM applepay_transactions;

