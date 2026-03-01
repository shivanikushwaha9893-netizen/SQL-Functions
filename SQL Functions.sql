/* ---------- CREATE TABLE ---------- */
CREATE TABLE IF NOT EXISTS Student_Performance (
student_id INT PRIMARY KEY,
name VARCHAR(50),
course VARCHAR(30),
score INT,
attendance INT,
mentor VARCHAR(50),
join_date DATE,
city VARCHAR(50)
);

/* ---------- (अगर data पहले से insert है तो ये skip कर देना) ---------- */
/* यहाँ तुम अपना INSERT वाला data paste कर सकती हो */

/* ---------- Q1: Ranking by score ---------- */
SELECT name, score,
RANK() OVER (ORDER BY score DESC) AS ranking
FROM Student_Performance;

/* ---------- Q2: Previous student's score ---------- */
SELECT name, score,
LAG(score) OVER (ORDER BY score DESC) AS previous_score
FROM Student_Performance;

/* ---------- Q3: Uppercase name + month ---------- */
SELECT UPPER(name) AS name_upper,
MONTHNAME(join_date) AS join_month
FROM Student_Performance;

/* ---------- Q4: Next student's attendance ---------- */
SELECT name, attendance,
LEAD(attendance) OVER (ORDER BY attendance) AS next_attendance
FROM Student_Performance;

/* ---------- Q5: NTILE performance groups ---------- */
SELECT name, score,
NTILE(4) OVER (ORDER BY score DESC) AS performance_group
FROM Student_Performance;

/* ---------- Q6: Row number per course ---------- */
SELECT name, course, attendance,
ROW_NUMBER() OVER (PARTITION BY course ORDER BY attendance DESC) AS row_num
FROM Student_Performance;

/* ---------- Q7: Days enrolled till 2025-01-01 ---------- */
SELECT name, join_date,
DATEDIFF('2025-01-01', join_date) AS days_enrolled
FROM Student_Performance;

/* ---------- Q8: Format join date ---------- */
SELECT name,
DATE_FORMAT(join_date, '%M %Y') AS formatted_date
FROM Student_Performance;

/* ---------- Q9: Replace Mumbai with MUM ---------- */
SELECT name,
REPLACE(city, 'Mumbai', 'MUM') AS city_display
FROM Student_Performance;

/* ---------- Q10: Highest score per course ---------- */
SELECT name, course, score,
FIRST_VALUE(score) OVER (PARTITION BY course ORDER BY score DESC) AS highest_in_course
FROM Student_Performance;
