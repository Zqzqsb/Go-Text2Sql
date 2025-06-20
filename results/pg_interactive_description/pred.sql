SELECT e.name AS employee_name, 
       e.employee_id AS employee_identifier,
       ar.check_in AS check_in_time,
       ar.check_out AS check_out_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部' 
  AND ar.date = '2024-10-13'
  AND (ar.check_out - ar.check_in) > INTERVAL '15 hours';	3457299966
SELECT e.name AS employee_name,
       e.employee_id AS employee_unique_id,
       ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-10-11'::date
  AND ar.check_in > '09:00:00'::time;	1044893251
SELECT COUNT(*) AS late_days_count
FROM attendance_records
WHERE employee_id = 'H03961'
  AND date BETWEEN '2024-01-01' AND '2024-12-31'
  AND check_in > '09:00:00';	3626797096
SELECT e.name AS employee_name, ar.check_in AS check_in_time, pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24'::date 
  AND ar.check_in < '08:30:00'::time
  AND pe.rating = 'A+';	207527642
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    ar.date = '2024-10-05';	4093748071
SELECT 
    e.name AS employee_name, 
    d.name AS department_name, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    ar.date = '2024-09-21'
ORDER BY 
    d.name;	4123999737
SELECT 
    ROUND(COUNT(CASE WHEN pe.status = '离职' AND (pe.end_date - pe.start_date) < 90 THEN 1 END) * 100.0 / COUNT(*), 2) AS early_resignation_percentage
FROM probation_employees pe;	560968712
SELECT e.name AS employee_name, e.employee_id AS employee_identifier, a.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE d.name = '客户服务部' AND a.date = '2024-10-08' AND a.check_in > '09:00:00';	2123418406
SELECT e.name AS employee_name, e.hire_date AS employment_date
FROM employees e
JOIN probation_employees pe ON e.employee_id = pe.employee_id;	2685336973
SELECT 
    d.name AS department_name, 
    e.name AS employee_name, 
    ar.check_in AS check_in_time, 
    e.remaining_annual_leave AS remaining_leave_days
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-22'::date
    AND ar.check_in > '09:00:00'::time
    AND e.remaining_annual_leave < 5
ORDER BY 
    d.name, 
    e.name;	1786804299
SELECT 
    e.name AS employee_name,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    EXTRACT(YEAR FROM e.hire_date) = 2023
    AND ar.date = '2024-10-05'
    AND pe.evaluation_date = (
        SELECT MAX(evaluation_date) 
        FROM performance_evaluations 
        WHERE employee_id = e.employee_id
    );	187164736
SELECT e.name AS employee_name, e.hire_date, pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2023
  AND ar.date = '2024-09-26';	16656251
SELECT COUNT(*) AS early_check_out_days
FROM attendance_records
WHERE employee_id = 'H05598' 
  AND date BETWEEN '2024-01-01' AND '2024-12-31'
  AND check_out < '18:00:00';	3745687130
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-28' AND ar.check_in > '09:00:00';	2706374430
SELECT e.name AS employee_name, e.employee_id AS employee_identifier, a.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE d.name = '运营部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	1934436050
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-10-11' AND ar.check_in > '09:00:00';	3074190923
SELECT e.name AS employee_name, e.employee_id AS employee_id, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部' AND ar.date = '2024-09-21' AND ar.check_in > '09:00:00';	511554832
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-12-11' AND pe.rating = 'C';	2699770862
SELECT e.name AS employee_name, d.name AS department_name
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-22' AND ar.check_in > '09:00:00';	2054121283
SELECT e.employee_id AS employee_unique_id, 
       e.name AS employee_name, 
       a.award_name AS innovation_award_name, 
       pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2023 
  AND a.award_name LIKE '%创新%' 
  AND pe.rating = 'A+';	1458867293
SELECT e.name AS employee_name, e.employee_id AS employee_id, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部' AND ar.date = '2024-10-09' AND ar.check_in > '08:30:00';	3998131614
SELECT COUNT(DISTINCT e.employee_id) AS award_recipients_during_probation_2023
FROM employees e
JOIN probation_employees pe ON e.employee_id = pe.employee_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.year = 2023
  AND a.award_name = '优秀员工奖'
  AND pe.start_date <= '2023-12-31'
  AND pe.end_date >= '2023-01-01'
  AND (pe.status = 'active' OR pe.status = 'completed');	3232263409
SELECT e.name AS employee_name, a.award_name AS award_received
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2021
  AND a.year = 2022;	3292642794
SELECT e.employee_id AS employee_unique_id, e.name AS employee_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.check_in IS NOT NULL 
  AND ar.check_out IS NOT NULL
  AND ar.check_in < ar.check_out
GROUP BY e.employee_id, e.name, ar.date
HAVING COUNT(*) > 1;	1309577663
SELECT d.name AS department_name, e.name AS employee_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-24'::date
  AND ar.check_in > '09:30:00'::time
  AND e.remaining_annual_leave < 10;	3488243740
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部' 
  AND ar.date = '2024-09-19' 
  AND ar.check_in > '09:00:00';	651157477
SELECT d.name AS department_name, e.name AS employee_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-26'::date
  AND ar.check_in > '09:00:00'::time
  AND pe.rating = 'C';	53102733
SELECT e.name AS employee_name, 
       a.award_name AS award_received, 
       p.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2021
  AND a.year = 2021
  AND p.rating = 'B';	3108523290
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部' 
  AND ar.date = '2024-10-03' 
  AND ar.check_in > '09:00:00';	840538968
SELECT e.name AS employee_name, pe.status AS employment_status
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN probation_employees pe ON e.employee_id = pe.employee_id
WHERE a.year = 2020 AND a.award_name = '优秀员工'
AND pe.start_date <= CURRENT_DATE AND pe.end_date >= CURRENT_DATE
AND pe.status = '试用期';	3192644686
SELECT e.name AS employee_name, a.award_name AS award_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2023
  AND a.year = 2023
  AND pe.rating = 'A+';	1597119407
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    probation_employees pe ON e.employee_id = pe.employee_id
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id AND ar.date = '2024-09-19'
WHERE 
    pe.status = 'active'
    AND '2024-09-19' BETWEEN pe.start_date AND pe.end_date;	3355699316
SELECT 
    e.employee_id AS employee_unique_id, 
    e.name AS employee_name, 
    e.hire_date AS employment_date, 
    e.remaining_annual_leave AS remaining_leave_days, 
    (365 - e.remaining_annual_leave) AS used_leave_days 
FROM 
    employees e;	1396580707
SELECT e.name AS employee_name, ar.date AS attendance_date, ar.check_in, ar.check_out
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2022 AND a.award_name = '技术突破奖'
AND (ar.check_out - ar.check_in) > interval '10 hours'
ORDER BY e.name, ar.date;	2385394779
SELECT e.name AS employee_name, 
       e.employee_id AS employee_id, 
       ar.check_in AS check_in_time, 
       ar.check_out AS check_out_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '质量控制部' 
  AND ar.date = '2024-09-20'::date
  AND (ar.check_out - ar.check_in) > interval '8 hours';	3598287205
SELECT e.name AS employee_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
AND ar.date = '2024-09-25'::date
AND ar.check_in < '09:00:00'::time;	1157360763
SELECT e.name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE pe.rating = 'A+'
GROUP BY e.name
ORDER BY AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) DESC
LIMIT 1;	1456890377
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_identifier, 
    ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部' 
  AND ar.date = '2024-10-04' 
  AND ar.check_in > '09:00:00';	455172185
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-18' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'D';	4212530835
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-25' 
  AND ar.check_in > '08:30:00' 
  AND pe.rating = 'B+';	1240612673
SELECT 
    employee_id AS "员工ID",
    interview_date AS "面试日期",
    interview_count AS "面试次数"
FROM 
    interviews 
WHERE 
    interview_date >= '2024-01-01' 
    AND interview_date <= '2024-12-31'
ORDER BY 
    interview_count DESC;	2857901445
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-10' 
  AND ar.check_in > '08:30:00' 
  AND pe.rating = 'A+';	71265646
SELECT 
    d.name AS department_name, 
    e.name AS employee_name, 
    ar.check_in AS check_in_time, 
    e.remaining_annual_leave
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-27' 
    AND ar.check_in > '09:00:00' 
    AND e.remaining_annual_leave < 10;	2168264130
SELECT e.name AS employee_name, p.evaluation_date AS performance_evaluation_date
FROM employees e
JOIN performance_evaluations p ON e.employee_id = p.employee_id;	1505285087
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-07' 
    AND ar.check_in > '09:00:00' 
    AND ar.check_out < '17:00:00';	1736090929
SELECT 
    e.name AS employee_name, 
    d.name AS department_name, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-05';	816170327
SELECT d.department_id, AVG(i.interview_count) AS avg_interview_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN interviews i ON e.employee_id = i.employee_id
GROUP BY d.department_id
ORDER BY avg_interview_count DESC
LIMIT 1;	3913837113
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_unique_id,
    ar.date AS attendance_date,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-09-27' 
    AND pe.rating = 'A+';	578427607
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2024 
  AND a.award_name = '最佳团队奖'
  AND ar.date = '2024-10-09'
  AND ar.check_in > '09:00:00';	2435455132
SELECT e.name AS employee_name, e.employee_id AS employee_unique_id, ar.check_in AS attendance_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '质量控制部' AND ar.date = '2024-10-14' AND ar.check_in > '09:00:00';	801113743
SELECT e.name AS employee_name, ar.check_out AS check_out_time, pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24' 
  AND ar.check_out > '13:00:00' 
  AND pe.rating = 'B+';	879816496
SELECT e.name AS employee_name, d.name AS department_name
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-10-08' AND ar.check_in > '09:00:00';	2367322111
SELECT e.name AS employee_name, d.name AS department_name, a.award_name AS award_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE a.year = 2022;	247458622
SELECT e.name AS employee_name, ar.check_in AS check_in_time, pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-12' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'D';	570267133
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    e.university = '清华大学'
    AND ar.date = '2024-10-13'::date
    AND ar.check_in < '09:30:00'::time;	137546085
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_id, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '客户服务部' 
    AND ar.date = '2024-09-22';	4072264422
SELECT e.name AS employee_name, a.award_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND pe.rating = 'A+';	4121529769
SELECT e.name AS employee_name, e.employee_id AS employee_code, a.check_in AS check_in_time, d.name AS department_name
FROM attendance_records a
JOIN employees e ON a.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE a.date = '2024-10-05' AND a.check_in > '08:30:00' AND d.manager_id = 'H05487';	437939056
SELECT 
    e.name AS employee_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '行政部'
  AND ar.date = '2024-10-02'
  AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	2108794903
SELECT d.name AS department_name, e.name AS employee_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.rating = 'D' AND pe.evaluation_date = '2023-03-31';	2803368869
SELECT e.name AS employee_name, e.car_plate AS vehicle_plate
FROM employees e
WHERE e.employee_type = '正式员工';	408783378
SELECT e.name AS employee_name, e.employee_id AS employee_unique_id, ar.check_in AS attendance_check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '质量控制部' AND ar.date = '2024-09-19' AND ar.check_in > '09:00:00';	1719343281
SELECT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2022 
  AND a.award_name = '客户满意度奖'
  AND ar.date = '2024-10-12'
  AND ar.check_in > '09:00:00'
GROUP BY e.name;	2395193694
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time,
    d.name AS department_name
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-11'::date
    AND ar.check_in > '09:00:00'::time
    AND d.manager_id = 'H00842';	2461283805
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE a.year = 2023 AND a.award_name = '领导力奖';	1004841644
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 
  AND a.award_name = '领导力奖'
  AND ar.date = '2024-10-09'::date
  AND ar.check_in > '09:00:00'::time;	958025096
SELECT 
    e.name AS intern_name, 
    d.name AS department_name, 
    d.manager_id AS department_manager_id
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records a ON e.employee_id = a.employee_id
WHERE 
    e.employee_type = '实习生'
    AND a.date = '2024-10-02'
    AND a.check_in BETWEEN '09:00:00' AND '10:00:00';	4156394932
SELECT d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.birth_date)) DESC
LIMIT 1;	5535555
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_unique_id,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-09-16'::date
    AND pe.rating = 'C';	1584866592
SELECT e.name AS employee_name, 
       e.employee_id AS employee_id,
       ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '研发部' 
  AND ar.date = '2024-10-08'::date
  AND ar.check_in > '09:00:00'::time;	4123927043
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '财务部' 
  AND ar.date = '2024-09-20' 
  AND ar.check_in > '09:00:00';	2642437739
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    e.department_id = 'D00005'
    AND ar.date = '2024-10-05'::date
    AND (ar.check_out - ar.check_in) > INTERVAL '8 hours';	1412040002
SELECT 
    e.employee_id AS employee_unique_id, 
    e.name AS employee_name, 
    a.check_in AS check_in_time, 
    a.check_out AS check_out_time, 
    p.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records a ON e.employee_id = a.employee_id
JOIN 
    performance_evaluations p ON e.employee_id = p.employee_id
WHERE 
    a.date = '2024-10-14' 
    AND p.rating = 'A+';	467771706
SELECT e.name AS employee_name, e.employee_id AS employee_number, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00009' 
  AND ar.date = '2024-09-27'::date 
  AND ar.check_in > '09:00:00'::time;	416599650
SELECT d.name AS department_name, COUNT(e.employee_id) AS employee_count 
FROM departments d 
LEFT JOIN employees e ON d.department_id = e.department_id 
GROUP BY d.name;	2074887228
SELECT e.name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.rating = 'A+'
ORDER BY e.hire_date DESC
LIMIT 1;	4204863942
WITH department_avg AS (
    SELECT 
        e.department_id,
        AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) AS avg_attendance_hours
    FROM 
        employees e
    JOIN 
        attendance_records ar ON e.employee_id = ar.employee_id
    GROUP BY 
        e.department_id
),
employee_attendance AS (
    SELECT 
        e.employee_id,
        e.name,
        e.department_id,
        EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600 AS individual_hours
    FROM 
        employees e
    JOIN 
        attendance_records ar ON e.employee_id = ar.employee_id
)
SELECT 
    ea.employee_id AS employee_unique_id,
    ea.name AS employee_name,
    ea.department_id AS department_identifier,
    ea.individual_hours AS actual_attendance_hours,
    da.avg_attendance_hours AS department_avg_attendance_hours,
    ABS(ea.individual_hours - da.avg_attendance_hours) AS attendance_deviation
FROM 
    employee_attendance ea
JOIN 
    department_avg da ON ea.department_id = da.department_id
ORDER BY 
    attendance_deviation DESC;	603993474
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time,
    (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600)::numeric(5,2) AS working_hours
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '研发部'
    AND ar.date = '2024-10-05'
    AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10
ORDER BY 
    working_hours DESC;	4133405205
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    p.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records a ON e.employee_id = a.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    performance_evaluations p ON e.employee_id = p.employee_id
WHERE 
    a.date = '2024-10-12';	1822156377
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部' 
  AND ar.date = '2024-10-11' 
  AND ar.check_in > '09:00:00';	3941104083
SELECT e.name AS employee_name, 
       d.name AS department_name, 
       ar.check_in AS check_in_time, 
       a.award_name AS award_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE ar.date = '2024-09-26' 
  AND ar.check_in > '09:00:00' 
  AND a.year = 2024;	1448803792
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_identifier,
    ar.check_in AS check_in_time,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-10-05' 
    AND ar.check_in > '09:00:00' 
    AND pe.rating = 'A+';	2348295774
SELECT e.name AS employee_name, e.employee_id AS employee_id, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE d.name = '人力资源部' 
  AND ar.date = '2024-10-07'::date 
  AND ar.check_in > '09:00:00'::time;	1351044911
SELECT e.name AS employee_name, d.name AS department_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.employee_type = '实习生'
  AND ar.date = '2024-10-11'::date
  AND ar.check_in < '09:00:00'::time;	1269433479
SELECT e.name AS employee_name, a.award_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2023 
  AND a.award_name = '优秀员工奖'
  AND pe.rating = 'A+'
  AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023;	2181400574
SELECT d.department_id AS department_identifier, 
       COUNT(DISTINCT e.employee_id) AS core_talent_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5
  AND e.position IN ('核心骨干', '骨干', '经理', '总监', '主管')
GROUP BY d.department_id;	2992677261
SELECT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2024 AND a.award_name = '新人奖' AND ar.date = '2024-10-08';	1583766775
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-02'
AND pe.rating = 'A+'
AND ar.check_in > '09:00:00';	2928703740
SELECT e.name AS employee_name, d.name AS department_name 
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE a.year = 2024 AND a.award_name = '新人奖';	2166514841
SELECT 
    AVG(EXTRACT(DAY FROM (first_promotion.promotion_date - e.hire_date))) AS avg_days_to_first_management_position
FROM 
    employees e
JOIN (
    SELECT 
        employee_id, 
        MIN(hire_date) AS promotion_date
    FROM 
        employees
    WHERE 
        position IN ('主管', '总监', '经理')
    GROUP BY 
        employee_id
) first_promotion ON e.employee_id = first_promotion.employee_id;	2864760744
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '研发部'
    AND ar.date = '2024-10-06'
    AND (ar.check_out - ar.check_in) > INTERVAL '10 hours';	2860391364
SELECT e.name AS employee_name, 
       a.award_name AS award_received, 
       p.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '技术突破奖'
  AND p.rating = 'A+';	1852490763
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-17'::date
  AND pe.rating = 'D'
  AND ar.check_in > '09:00:00'::time;	2494653166
SELECT DISTINCT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2024 
  AND a.award_name = '项目管理奖'
  AND ar.date = '2024-10-03';	3084451002
SELECT e.name AS employee_name, e.hire_date AS hire_date, a.award_name AS award_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.year = 2023 AND a.award_name LIKE '%领导力%' AND e.hire_date > '2017-12-31';	408688532
SELECT e.name AS employee_name, 
       e.employee_id AS employee_unique_id, 
       ar.check_in AS work_start_time, 
       ar.check_out AS work_end_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学' 
  AND ar.date = '2024-09-16'
  AND (ar.check_out - ar.check_in) > INTERVAL '8 hours';	4036648411
SELECT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2023 
  AND a.award_name = '领导力奖'
  AND pe.evaluation_date = '2023-06-04' 
  AND pe.rating = 'D';	548473863
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部' 
  AND ar.date = '2024-10-12' 
  AND ar.check_in > '09:00:00';	2286968533
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-21'
AND ar.check_in > '09:00:00'
AND pe.rating = 'B'
ORDER BY e.name;	3284637113
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'C';	773404511
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_unique_id,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '行政部'
  AND ar.date = '2024-10-05'
  AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	2149393306
SELECT e.name AS employee_name, 
       e.employee_id AS employee_unique_id, 
       ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '财务部' 
  AND ar.date = '2024-10-06' 
  AND ar.check_in > '09:00:00';	2477803619
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    d.manager_id AS department_manager_id
FROM 
    employees e
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    pe.rating = 'A+' 
    AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023;	821353235
SELECT 
    e.name AS employee_name,
    ar.check_in AS check_in_time
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-09-28' 
    AND ar.check_in > '09:00:00'
    AND pe.rating = 'A+';	907163187
SELECT 
    e.employee_id AS employee_unique_id, 
    e.id AS employee_id, 
    ar.date AS attendance_date, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    a.year = 2023 
    AND a.award_name = '销售冠军' 
    AND ar.date = '2024-10-01';	811463423
WITH first_a_plus AS (
    SELECT 
        e.employee_id,
        e.department_id,
        e.name,
        MIN(pe.evaluation_date - e.hire_date) AS days_to_first_a_plus
    FROM 
        employees e
    JOIN 
        performance_evaluations pe ON e.employee_id = pe.employee_id
    WHERE 
        pe.rating = 'A+'
    GROUP BY 
        e.employee_id, e.department_id, e.name
),
ranked_employees AS (
    SELECT 
        d.department_id AS department_id,
        f.employee_id AS employee_id,
        f.name AS employee_name,
        f.days_to_first_a_plus,
        RANK() OVER (PARTITION BY d.department_id ORDER BY f.days_to_first_a_plus ASC) AS rank
    FROM 
        first_a_plus f
    JOIN 
        departments d ON f.department_id = d.department_id
)
SELECT 
    department_id,
    employee_id,
    employee_name,
    days_to_first_a_plus
FROM 
    ranked_employees
WHERE 
    rank = 1;	2913040945
SELECT e.name AS employee_name, d.name AS department_name
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-22' AND ar.check_in > '09:00:00';	1736656854
SELECT e.name AS employee_name, a.award_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2024 AND a.award_name = '优秀员工' AND pe.rating = 'A+';	2339817132
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    pe.rating AS performance_rating
FROM 
    performance_evaluations pe
JOIN 
    employees e ON pe.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    pe.evaluation_date = '2023-10-29';	2218878981
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_id, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学' 
  AND ar.date = '2024-09-17'
  AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	1785434408
SELECT e.name AS employee_name, d.name AS department_name
FROM performance_evaluations pe
JOIN employees e ON pe.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2022-06-16' AND pe.rating = 'C';	2274426817
SELECT DISTINCT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2022 
  AND a.award_name = '优秀员工'
  AND p.evaluation_date = '2022-10-30'
  AND p.rating = 'A+';	1121061015
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-15' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'B'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date) 
    FROM performance_evaluations 
    WHERE employee_id = e.employee_id
  );	1822740611
SELECT e.name AS employee_name, e.position AS job_title 
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
WHERE d.name = '销售部';	3049098373
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-23' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'D';	2137629249
SELECT e.employee_id AS employee_unique_id, e.name AS employee_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE d.name = '客户服务部' 
AND p.rating = 'D'
AND p.evaluation_date <= '2024-10-14'
AND (p.evaluation_date = (
    SELECT MAX(p2.evaluation_date) 
    FROM performance_evaluations p2 
    WHERE p2.employee_id = e.employee_id 
    AND p2.evaluation_date <= '2024-10-14'
));	2240615465
SELECT e.name AS employee_name, e.hire_date AS hire_date, a.award_name AS award_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.award_name = '领导力奖' AND a.year = 2023 AND e.hire_date >= '2019-01-01';	1309270874
SELECT d.name AS department_name, e.name AS employee_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'A+';	2420332715
SELECT DISTINCT e.employee_id AS employee_unique_id, e.name AS employee_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.rating = '一般'
AND e.employee_id IN (
    SELECT employee_id 
    FROM awards 
    WHERE award_name ILIKE '%同事评价%' OR award_name ILIKE '%团队贡献%'
);	60966118
SELECT e.name AS employee_name, ar.check_in AS check_in_time, pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20'
  AND ar.check_in BETWEEN '08:00:00' AND '09:00:00'
  AND pe.rating = 'B';	1965264110
SELECT e.employee_id AS employee_unique_id, e.name AS employee_name
FROM employees e
WHERE e.employee_id IN (
    SELECT pe.employee_id
    FROM performance_evaluations pe
    WHERE pe.rating = 'B' 
    AND pe.evaluation_date < '2024-01-01'
    AND pe.evaluation_date = (
        SELECT MAX(pe2.evaluation_date)
        FROM performance_evaluations pe2
        WHERE pe2.employee_id = pe.employee_id
    )
);	1436736406
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-19' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'B+';	2263195811
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time,
    (ar.check_out - ar.check_in) AS working_hours
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-24'
    AND (ar.check_out - ar.check_in) > INTERVAL '12 hours';	1079007714
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_unique_id,
    ar.check_in AS attendance_check_in_time
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    e.university = '清华大学' 
    AND ar.date = '2024-09-29' 
    AND ar.check_in < '09:00:00';	2835428087
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-11' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'A';	2600324766
AMBIGUOUS_QUERY	1290741288
SELECT e.employee_id AS employee_unique_id, 
       e.name AS employee_name, 
       ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '厦门大学'
  AND ar.date = '2024-09-23'
  AND ar.check_in > '09:00:00';	3714812669
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-19' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'D';	4217899403
SELECT e.name AS employee_name, e.employee_id AS employee_unique_id, ar.date AS attendance_date, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学' AND ar.date = '2024-10-11' AND ar.check_in > '08:30:00';	1946117596
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-10' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'D';	1268105110
SELECT e.name AS employee_name, a.award_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2024
  AND a.year = 2024
  AND a.award_name = '新人奖'
  AND pe.rating = 'A';	910719964
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-26'
  AND ar.check_in BETWEEN '08:00:00' AND '09:00:00'
  AND pe.rating = 'B+';	4215983699
SELECT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 
  AND a.award_name = '创新奖'
  AND ar.date = '2024-09-25'
  AND ar.check_in IS NOT NULL;	3022631781
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'D';	1326215630
SELECT d.name AS department_name, AVG(e.remaining_annual_leave) AS avg_annual_leave
FROM departments d
JOIN employees e ON d.department_id = e.department_id
WHERE d.manager_id = 'H03372'
GROUP BY d.name;	2739991096
SELECT 
    e.name AS employee_name,
    ar.date AS attendance_date,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-10-12' 
    AND pe.rating = 'A+';	3094758858
SELECT e.name AS employee_name, ar.date AS attendance_date, ar.check_in AS check_in_time
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND ar.date = '2024-10-03' AND ar.check_in > '09:00:00';	3240116959
SELECT e.name AS employee_name, 
       e.employee_id AS employee_identifier, 
       d.name AS department_name, 
       pe.rating AS performance_rating
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE d.name = '财务部'
AND pe.rating = 'A+'
AND pe.evaluation_date <= '2024-09-15'
AND (pe.evaluation_date = (
    SELECT MAX(evaluation_date) 
    FROM performance_evaluations 
    WHERE employee_id = e.employee_id 
    AND evaluation_date <= '2024-09-15'
));	3253971302
SELECT e.name AS employee_name, e.employee_id AS employee_identifier, a.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE d.name = '质量控制部' AND a.date = '2024-09-21' AND a.check_in > '09:00:00';	3037862925
SELECT 
    e.name AS employee_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '销售部'
    AND ar.date = '2024-09-25'::date
    AND (ar.check_out - ar.check_in) > INTERVAL '8 hours';	1991610345
SELECT 
    e.name AS employee_name, 
    a.award_name, 
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    a.year = 2022
    AND a.award_name = '技术突破奖'
    AND pe.evaluation_date > '2022-07-13'
    AND EXTRACT(YEAR FROM pe.evaluation_date) = 2022;	3421802959
SELECT e.name AS employee_name, e.employee_id AS employee_number, a.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE d.name = '财务部' AND a.date = '2024-10-11' AND a.check_in > '09:00:00';	3350855518
SELECT e.name AS employee_name, e.employee_id AS employee_unique_id, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '研发部' 
  AND ar.date = '2024-10-12' 
  AND ar.check_in > '09:00:00';	1481678835
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.evaluation_date = '2023-08-06' AND pe.rating = 'C';	1832961045
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-01'
    AND (ar.check_out - ar.check_in) > INTERVAL '12 hours';	3794832374
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-09' 
  AND pe.rating = 'A+'
  AND ar.check_in > '09:00:00'
ORDER BY ar.check_in DESC;	4131389571
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '人力资源部' 
  AND ar.date = '2024-09-24' 
  AND ar.check_in > '09:00:00';	2592420070
SELECT e.employee_id AS employee_number, e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00003' 
AND ar.date = '2024-10-02'
AND ar.check_in > '09:00:00';	1526114356
SELECT e.name AS employee_name, 
       ar.check_out AS check_out_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-11' 
  AND ar.check_out > '21:00:00' 
  AND pe.rating = 'B+';	906637391
SELECT 
    e.name AS employee_name, 
    d.name AS department_name, 
    e.hire_date
FROM 
    employees e
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    pe.rating = 'B' 
    AND EXTRACT(YEAR FROM pe.evaluation_date) = 2022
ORDER BY 
    e.hire_date;	3180358031
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-22'
    AND d.name = '客户服务部';	1427670664
SELECT d.name AS department_name, e.name AS employee_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'B';	2517372671
SELECT e.name AS earliest_arrival_employee_name
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
WHERE ar.date = '2024-10-02'
ORDER BY ar.check_in ASC
LIMIT 1;	2374975326
SELECT 
    e.employee_id AS employee_unique_id, 
    e.name AS employee_name,
    ar.date AS attendance_date,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    EXTRACT(YEAR FROM e.hire_date) = 2023
    AND ar.date = '2024-10-10'
    AND pe.rating = 'B+';	1399658957
SELECT e.name AS employee_name, 
       e.employee_id AS employee_id, 
       ar.date AS attendance_date, 
       ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '财务部' 
  AND ar.date = '2024-10-04' 
  AND ar.check_in > '09:00:00';	1337508734
SELECT e.name AS employee_name, ar.date AS attendance_date, pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-17' AND pe.rating = 'A+';	2509046712
SELECT d.name AS department_name
FROM probation_employees pe
JOIN employees e ON pe.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.status = 'extended'
GROUP BY e.employee_id, d.name
ORDER BY COUNT(*) DESC
LIMIT 3;	1196649212
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_unique_id, 
    ar.check_in AS check_in_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '财务部' 
    AND ar.date = '2024-10-04' 
    AND ar.check_in > '09:00:00';	3455582973
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE a.year = 2023 AND a.award_name = '优秀员工';	2169239057
SELECT COUNT(DISTINCT e.employee_id) AS employees_count
FROM employees e
JOIN probation_employees pe ON e.employee_id = pe.employee_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.award_name = '客户满意度奖'
  AND a.year = 2023
  AND pe.start_date <= '2023-12-31'
  AND pe.end_date >= '2023-01-01';	329969630
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24' 
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'C';	1957766738
SELECT e.name AS employee_name, a.award_name AS award_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id;	701997867
SELECT e.name AS employee_name, e.employee_id AS employee_unique_id, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '法务部' 
AND ar.date = '2024-10-13' 
AND ar.check_in < '08:30:00';	906781191
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '质量控制部'
    AND ar.date = '2024-09-17'
    AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	388401260
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    ar.date = '2024-09-26'::date
    AND e.remaining_annual_leave > 10;	1988310183
SELECT e.name AS employee_name, e.employee_id AS employee_id, a.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE d.name = '财务部' AND a.date = '2024-10-09' AND a.check_in > '09:00:00'
ORDER BY a.check_in;	2363197929
SELECT e.name AS employee_name, 
       e.employee_id AS employee_id, 
       ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'
  AND ar.date = '2024-10-10'
  AND ar.check_in > '09:00:00';	935583315
SELECT 
    e.employee_id AS employee_unique_identifier,
    e.name AS employee_full_name,
    COUNT(DISTINCT a.id) AS active_innovation_project_count
FROM 
    employees e
LEFT JOIN 
    awards a ON e.employee_id = a.employee_id
WHERE 
    a.award_name LIKE '%创新%' 
    OR a.award_name LIKE '%孵化%' 
    OR a.award_name LIKE '%Innovation%' 
    OR a.award_name LIKE '%Incubation%'
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    active_innovation_project_count DESC, 
    employee_full_name
LIMIT 100;	3679145520
SELECT e.name AS employee_name, d.name AS department_name
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-25' AND ar.check_in > '09:00:00';	1647521458
SELECT e.name AS employee_name, e.employee_id AS employee_identifier, pe.rating AS performance_rating
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE d.name = '客户服务部' 
  AND pe.rating = 'A+' 
  AND pe.evaluation_date <= '2024-09-28'
  AND (pe.evaluation_date = (
      SELECT MAX(pe2.evaluation_date) 
      FROM performance_evaluations pe2 
      WHERE pe2.employee_id = e.employee_id AND pe2.evaluation_date <= '2024-09-28'
  ))
ORDER BY pe.evaluation_date DESC;	2154404311
SELECT e.name AS employee_name, 
       e.employee_id AS employee_identifier, 
       ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '法务部' 
  AND ar.date = '2024-10-07' 
  AND ar.check_in > '09:00:00';	1956887122
SELECT e.name AS employee_name, 
       d.name AS department_name,
       ar.check_in AS check_in_time,
       ar.check_out AS check_out_time
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-10-14';	541499305
SELECT DISTINCT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.award_name = '优秀员工' 
  AND a.year = 2021
  AND ar.date > '2021-01-01';	607760760
SELECT AVG(e.remaining_annual_leave) AS avg_remaining_annual_leave
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.year = 2024 
  AND a.award_name = '领导力奖'
  AND e.hire_date > '2017-12-31';	3786409554
SELECT e.employee_id AS employee_unique_id, e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE e.university IS NOT NULL 
  AND e.major IS NOT NULL
  AND p.rating IN ('优秀', '卓越')
LIMIT 50;	1833538335
SELECT e.name AS employee_name, d.name AS department_name
FROM performance_evaluations pe
JOIN employees e ON pe.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-12-07' AND pe.rating = 'B';	2571560082
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    a.award_name
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    EXTRACT(YEAR FROM e.hire_date) = 2023 
    AND a.year = 2023;	3184081384
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_identifier,
    ar.check_in AS check_in_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '销售部' 
    AND ar.date = '2024-09-25' 
    AND ar.check_in > '09:00:00';	3265054996
SELECT e.name AS employee_name, 
       e.employee_id AS employee_unique_id, 
       ar.check_in AS attendance_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '质量控制部' 
  AND ar.date = '2024-09-20' 
  AND ar.check_in > '09:00:00';	1987469456
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '客户服务部'
    AND ar.date = '2024-09-29'::date
    AND (ar.check_out - ar.check_in) > INTERVAL '10 hours';	3475714298
SELECT e.name AS employee_name, ar.check_in AS check_in_time, pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-04'::date
  AND ar.check_in > '08:30:00'::time
  AND pe.rating = 'A+';	3158837504
SELECT 
    e.employee_id AS employee_identifier,
    COUNT(CASE WHEN a.check_in > '09:00:00' THEN 1 END) AS late_days_count
FROM 
    employees e
LEFT JOIN 
    attendance_records a ON e.employee_id = a.employee_id
GROUP BY 
    e.employee_id;	1341335041
SELECT e.employee_id AS employee_unique_id, e.name AS employee_name 
FROM employees e 
JOIN attendance_records ar ON e.employee_id = ar.employee_id 
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id 
WHERE ar.date = '2024-09-15' AND pe.rating = 'A+';	1248129462
SELECT DISTINCT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2021 AND a.award_name = '最佳团队奖'
  AND ar.date = '2024-09-19';	2929076718
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_identifier,
    ar.check_in AS clock_in_time,
    ar.check_out AS clock_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '客户服务部'
    AND ar.date = '2024-09-21';	860593492
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_number,
    a.check_in AS check_in_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records a ON e.employee_id = a.employee_id
WHERE 
    d.name = '财务部'
    AND a.date = '2024-09-23'::date
    AND a.check_in < '09:30:00'::time;	803138423
SELECT e.name AS employee_name, a.check_in AS check_in_time
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE a.date = '2024-10-09' 
  AND a.check_in > '09:00:00' 
  AND e.employee_type = 'intern';	1392351924
SELECT 
    e.name AS employee_name,
    a.date AS attendance_date,
    a.check_in AS check_in_time,
    a.check_out AS check_out_time
FROM 
    employees e
JOIN 
    awards aw ON e.employee_id = aw.employee_id
JOIN 
    attendance_records a ON e.employee_id = a.employee_id
WHERE 
    aw.year = 2023 
    AND aw.award_name = '项目管理奖'
    AND a.date = '2024-09-23';	2647170145
SELECT e.name AS employee_name, a.award_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2022
  AND a.year = 2023
  AND pe.rating = 'A+';	2581619009
SELECT 
    e.name AS employee_name, 
    d.name AS department_name, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '人力资源部' 
    AND ar.date = '2024-10-13';	2697889458
SELECT e.name AS employee_name, e.employee_id AS employee_id, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '行政部' AND ar.date = '2024-09-18' AND ar.check_in > '09:00:00';	3387668548
SELECT 
    e.employee_id,
    e.name,
    COUNT(DISTINCT i.id) AS mentor_program_participation_count,
    COUNT(DISTINCT a.id) AS awards_received_count,
    COUNT(DISTINCT pe.id) AS performance_evaluation_count,
    AVG(CASE WHEN pe.rating = '优秀' THEN 1 ELSE 0 END) AS high_performance_ratio,
    COUNT(DISTINCT ar.id) AS attendance_days_count,
    (SELECT COUNT(*) FROM probation_employees WHERE employee_id = e.employee_id) AS probation_experience_flag,
    (SELECT COUNT(*) FROM departments WHERE manager_id = e.employee_id) AS rotation_experience_flag,
    (SELECT COUNT(*) FROM performance_evaluations WHERE employee_id = e.employee_id AND rating = '优秀') AS high_performance_count
FROM 
    employees e
LEFT JOIN 
    interviews i ON e.employee_id = i.employee_id
LEFT JOIN 
    awards a ON e.employee_id = a.employee_id
LEFT JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    e.hire_date >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    high_performance_ratio DESC, awards_received_count DESC, high_performance_count DESC
LIMIT 100;	1417292000
SELECT e.name AS employee_name, e.employee_id AS employee_number, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部' AND ar.date = '2024-09-20' AND ar.check_in > '08:00:00';	1597423542
WITH department_oldest AS (
    SELECT 
        e.department_id,
        e.employee_id,
        e.name,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.birth_date)) AS age,
        DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.birth_date)) DESC) AS age_rank
    FROM 
        employees e
)
SELECT 
    department_id AS department_identifier,
    employee_id AS employee_identifier,
    name AS employee_name,
    age AS max_age
FROM 
    department_oldest
WHERE 
    age_rank = 1
ORDER BY 
    department_identifier;	3397723976
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '人力资源部' 
  AND ar.date = '2024-09-30' 
  AND ar.check_in > '09:00:00';	339893232
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '研发部' 
  AND ar.date = '2024-09-18' 
  AND ar.check_in > '09:00:00';	244305078
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-28' 
  AND ar.check_in > '09:30:00' 
  AND pe.rating = 'A+';	2030661443
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-17' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'B';	2290320497
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_unique_id, 
    ar.date AS attendance_date, 
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-09-22' 
    AND pe.rating = 'D';	2134005508
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_id, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time, 
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-10-03' 
    AND pe.rating = 'A+';	3179866905
SELECT e.name AS employee_name,
       e.employee_id AS employee_identifier,
       ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部'
  AND ar.date = '2024-10-07'::date
  AND ar.check_in > '09:00:00'::time;	1447725797
SELECT e.employee_id AS employee_unique_id, 
       ar.date AS attendance_date, 
       ar.check_in AS clock_in_time, 
       ar.check_out AS clock_out_time, 
       pe.rating AS performance_rating
FROM employees e
LEFT JOIN attendance_records ar ON e.employee_id = ar.employee_id
LEFT JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date IS NOT NULL OR pe.rating IS NOT NULL
ORDER BY e.employee_id, ar.date DESC;	3166523944
SELECT e.name AS employee_name, a.award_name AS award_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE ar.date = '2024-10-05' 
  AND ar.check_in > '09:00:00'
  AND a.year = 2021;	3133264714
SELECT e.name AS employee_name, e.employee_id AS employee_unique_id, ar.check_in AS attendance_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '质量控制部' AND ar.date = '2024-09-25' AND ar.check_in > '08:30:00';	2850698943
SELECT 
    EXTRACT(YEAR FROM ar.date) AS performance_year,
    EXTRACT(QUARTER FROM ar.date) AS performance_quarter,
    ar.employee_id AS top_performer_id
FROM 
    attendance_records ar
JOIN 
    (SELECT 
        EXTRACT(YEAR FROM pe.evaluation_date) AS year,
        EXTRACT(QUARTER FROM pe.evaluation_date) AS quarter,
        pe.employee_id AS top_performer_id
    FROM 
        performance_evaluations pe
    WHERE 
        pe.evaluation_date >= CURRENT_DATE - INTERVAL '3 years'
        AND pe.rating = 'A+'
    ) AS top_performers
ON 
    ar.employee_id = top_performers.top_performer_id
    AND EXTRACT(YEAR FROM ar.date) = top_performers.year
    AND EXTRACT(QUARTER FROM ar.date) = top_performers.quarter
GROUP BY 
    performance_year, performance_quarter, top_performer_id
ORDER BY 
    performance_year, performance_quarter;	2860363666
SELECT DISTINCT e.employee_id AS employee_unique_id, 
       e.name AS employee_name, 
       a.award_name AS award_received, 
       pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2023 AND pe.rating = 'A+';	3284872060
SELECT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2022 
  AND a.award_name = '质量改进奖'
  AND ar.date = '2024-10-04'::date
  AND ar.check_in > '09:00:00'::time;	1370529433
SELECT e.employee_id AS employee_unique_id, e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部' 
AND ar.date = '2024-10-03' 
AND ar.check_in > '09:00:00';	4101493476
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '人力资源部' 
  AND ar.date = '2024-10-02' 
  AND ar.check_in > '09:00:00';	1724137514
SELECT e.name AS employee_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2023 
  AND a.award_name = '优秀员工'
  AND pe.rating = 'A+';	3595600525
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.evaluation_date = '2023-05-31' AND pe.rating = 'A+';	815548435
SELECT 
    e.name AS employee_name,
    ar.check_in AS check_in_time,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-10-02' 
    AND ar.check_in > '09:00:00' 
    AND pe.rating = 'A+';	2061849622
SELECT 
    a.date,
    a.check_in AS check_in_time,
    a.check_out AS check_out_time
FROM 
    attendance_records a
JOIN 
    awards aw ON a.employee_id = aw.employee_id
WHERE 
    aw.year = 2021 
    AND aw.award_name = '销售冠军'
    AND a.date = '2024-09-18';	1250267679
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-05-27' AND pe.rating = 'A+';	1929429344
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE a.date = '2024-09-16' AND a.check_in > '09:00:00';	3689323727
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;	2977986068
SELECT 
    e.employee_id AS employee_unique_id,
    e.name AS employee_name,
    e.birth_date AS birth_date,
    e.hire_date AS hire_date,
    e.position AS current_position,
    e.university AS education_institution,
    e.major AS education_major,
    (CURRENT_DATE - e.hire_date) AS employment_duration_days
FROM employees e
ORDER BY employment_duration_days DESC, position ASC
LIMIT 1;	3402561235
SELECT e.name AS employee_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE e.department_id = 'D00007' 
  AND pe.rating = 'A' 
  AND pe.evaluation_date BETWEEN '2024-01-01' AND '2024-12-31';	3958686389
SELECT DISTINCT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2022 
  AND a.award_name = '创新奖'
  AND ar.date = '2024-10-12'::date
  AND ar.check_in > '09:00:00'::time;	3786147845
SELECT e.name AS employee_name, d.name AS department_name
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-23' AND ar.check_in > '09:00:00';	1159542995
SELECT COUNT(DISTINCT e.employee_id) AS award_and_top_performer_count
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '质量改进奖'
  AND p.rating = 'A+';	3254827737
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-09-23'::date
  AND ar.check_in > '08:00:00'::time
  AND ar.check_out < '18:00:00'::time;	3909320290
SELECT d.name AS department_name, e.name AS employee_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN awards a ON e.employee_id = a.employee_id
JOIN interviews i ON e.employee_id = i.employee_id
WHERE a.award_name = '优秀员工'
AND a.year = 2023
AND i.interview_date = '2023-10-09';	628072208
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-12'::date
  AND ar.check_in < '09:00:00'::time
  AND pe.rating = 'B+';	3286899081
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20' 
  AND pe.rating = 'A+'
  AND ar.check_in > '09:00:00'
ORDER BY ar.check_in;	2517269758
SELECT e.name AS employee_name, a.award_name AS award_received, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2021 
  AND a.award_name = '质量改进奖'
  AND pe.rating = 'B+';	3866100328
SELECT e.name AS employee_name, e.employee_id AS employee_id, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部' AND ar.date = '2024-09-29' AND ar.check_in > '08:30:00';	3469101707
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    d.manager_id AS department_manager_id
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-16' 
    AND ar.check_in > '08:30:00';	2797510377
SELECT 
    e.name AS employee_name,
    e.position AS employee_position,
    ar.check_in AS check_in_time
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    ar.date = '2024-10-01' 
    AND e.position = '顾问' 
    AND ar.check_in > '09:00:00';	2587625643
SELECT e.name AS employee_name, e.employee_id AS employee_id, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部' AND ar.date = '2024-09-23' AND ar.check_in > '09:00:00';	2556819995
SELECT 
    a.year AS award_year,
    e.name AS awardee_name,
    a.award_name AS innovation_award,
    'Impact assessment pending' AS innovation_impact_status
FROM 
    awards a
JOIN 
    employees e ON a.employee_id = e.employee_id
WHERE 
    (a.award_name LIKE '%创新%' OR a.award_name LIKE '%技术%')
    AND a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5
ORDER BY 
    a.year DESC, e.name;	2163155798
SELECT e.name AS employee_name, e.employee_id AS employee_identifier, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '财务部' 
  AND ar.date = '2024-10-06'
  AND ar.check_in > '09:00:00';	1599035554
SELECT e.name AS employee_name, d.name AS department_name
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-10-04' AND ar.check_in > '09:00:00';	3248411469
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE a.date = '2024-10-04';	2257279104
SELECT 
    e.employee_id AS employee_id, 
    a.award_name AS award_name, 
    p.rating AS performance_rating, 
    p.evaluation_date AS evaluation_date
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id
JOIN 
    performance_evaluations p ON e.employee_id = p.employee_id
WHERE 
    a.year = 2023 
    AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	2036213054
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE a.date = '2024-10-10' AND a.check_in > '09:30:00';	2231439732
SELECT 
    e.name AS employee_name, 
    d.name AS department_name, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    ar.date = '2024-09-19';	1852561007
SELECT e.name AS employee_name,
       e.employee_id AS employee_id,
       ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '行政部'
  AND ar.date = '2024-10-03'::date
  AND ar.check_in > '09:00:00'::time;	3057784484
SELECT d.department_id AS department_id, AVG(e.remaining_annual_leave) AS avg_remaining_leave
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id
ORDER BY avg_remaining_leave DESC
LIMIT 1;	604055577
SELECT 
    e.name AS employee_name,
    ar.check_in AS check_in_time,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-09-27' 
    AND ar.check_in < '10:00:00'::time 
    AND pe.rating = 'A+';	1799658813
SELECT 
    i.interview_date AS interview_date,
    i.interview_count AS interview_count
FROM 
    interviews i
WHERE 
    i.interview_date BETWEEN '2024-01-01' AND '2024-12-31';	556306212
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00:00';	3669286537
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    d.name AS department_name,
    p.rating AS performance_rating
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    performance_evaluations p ON e.employee_id = p.employee_id
WHERE 
    d.name = '研发部' 
    AND p.rating = 'B+'
    AND p.evaluation_date <= '2024-09-29'
    AND (p.evaluation_date = (
        SELECT MAX(evaluation_date) 
        FROM performance_evaluations 
        WHERE employee_id = e.employee_id AND evaluation_date <= '2024-09-29'
    ));	1975822937
SELECT 
    e.employee_id AS employee_number, 
    e.name AS employee_name, 
    ar.date AS attendance_date, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2022 
  AND a.award_name = '销售冠军' 
  AND ar.date = '2024-10-10';	1362951886
SELECT e.name AS employee_name, e.hire_date AS hire_date, a.award_name AS award_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.award_name = '客户满意度奖' AND a.year = 2023 AND e.hire_date > '2020-06-19';	2799760973
SELECT e.name AS employee_name, 
       ar.check_in AS check_in_time, 
       pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-22'::date
  AND ar.check_in > '09:00:00'::time
  AND pe.rating = 'A+';	1692765210
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.evaluation_date = '2022-06-20' AND pe.rating = 'C';	804998806
SELECT 
    e.name AS employee_name, 
    a.award_name, 
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    a.year = 2024 
    AND a.award_name = '客户满意度奖'
    AND pe.rating = 'C';	170694593
SELECT e.name AS employee_name, 
       AVG(EXTRACT(EPOCH FROM (a.check_out - a.check_in))/3600) AS avg_daily_work_hours
FROM employees e
JOIN awards aw ON e.employee_id = aw.employee_id
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE aw.year = 2023 
  AND aw.award_name = '项目管理奖'
  AND EXTRACT(YEAR FROM a.date) = 2023
  AND a.check_out IS NOT NULL
  AND a.check_in IS NOT NULL
  AND a.check_out > a.check_in
GROUP BY e.name
HAVING AVG(EXTRACT(EPOCH FROM (a.check_out - a.check_in))/3600) > 10;	2091607073
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-03-09' AND pe.rating = 'D';	2894384990
AMBIGUOUS_QUERY	1149281173
SELECT 
    e.name AS employee_name, 
    d.name AS department_name, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-08';	1884200158
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_unique_id,
    ar.check_in AS check_in_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '人力资源部'
    AND ar.date = '2024-09-26'::date
    AND ar.check_in > '09:00:00'::time;	2557740373
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-28' 
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'A+';	3799739588
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE d.name = '研发部' 
AND ar.date = '2024-09-20' 
AND ar.check_in > '09:00:00';	1074403791
SELECT d.name AS department_name, e.name AS employee_name
FROM attendance_records ar
JOIN employees e ON ar.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-13'::date
  AND ar.check_in > '09:00:00'::time
  AND pe.rating = 'A+';	1640643914
SELECT e.name AS employee_name, a.award_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2023 AND a.award_name = '销售冠军' AND (pe.rating = 'A' OR pe.rating = 'B' OR pe.rating = 'S');	3875469036
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_id, 
    ar.check_in AS check_in_time, 
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    e.department_id = 'D00004' 
    AND ar.date = '2024-09-17' 
    AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	1182082319
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time,
    d.name AS department_name,
    d.manager_id AS department_manager_id
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-18' 
    AND ar.check_in > '09:00:00';	219564979
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 
  AND a.award_name = '技术突破奖'
  AND ar.date = '2024-09-23'
  AND ar.check_in > '09:00:00';	2296352057
SELECT e.name AS employee_name, e.employee_id AS employee_number, ar.check_in AS clock_in_time, ar.check_out AS clock_out_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00007' AND ar.date = '2024-09-26';	3848854887
SELECT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.award_name = '优秀员工' 
  AND a.year = 2020
  AND EXTRACT(YEAR FROM p.evaluation_date) = 2023
  AND p.rating = 'C';	4144781586
SELECT e.name AS employee_name, ar.check_in AS check_in_time, pe.rating AS performance_rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-03' 
  AND ar.check_in > '09:00:00' 
  AND pe.rating = 'C';	543593806
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_unique_id, 
    ar.check_in AS check_in_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '法务部' 
    AND ar.date = '2024-10-12' 
    AND ar.check_in > '09:00:00';	3302179394
WITH department_hiring AS (
    SELECT 
        EXTRACT(YEAR FROM i.interview_date) AS year,
        e.department_id,
        COUNT(DISTINCT i.employee_id) AS interview_count,
        COUNT(DISTINCT e.employee_id) AS hired_count,
        ROUND(COUNT(DISTINCT e.employee_id) * 100.0 / NULLIF(COUNT(DISTINCT i.employee_id), 0), 2) AS hiring_rate
    FROM 
        interviews i
    LEFT JOIN 
        employees e ON i.employee_id = e.employee_id
    WHERE 
        i.interview_date >= CURRENT_DATE - INTERVAL '5 years'
    GROUP BY 
        EXTRACT(YEAR FROM i.interview_date), e.department_id
),
ranked_departments AS (
    SELECT 
        year,
        department_id,
        hiring_rate,
        RANK() OVER (PARTITION BY year ORDER BY hiring_rate DESC) AS rank
    FROM 
        department_hiring
)
SELECT 
    year,
    department_id,
    hiring_rate
FROM 
    ranked_departments
WHERE 
    rank = 1
ORDER BY 
    year;	1798514231
SELECT 
    e.name AS employee_name, 
    e.employee_id AS employee_unique_id, 
    ar.check_in AS attendance_check_in, 
    ar.check_out AS attendance_check_out
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    e.university = '清华大学' 
    AND ar.date = '2024-10-12';	2882208186
SELECT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.award_name = '领导力奖' 
  AND a.year = 2023
  AND ar.date = '2024-10-01'::date
  AND ar.check_in > '09:00:00'::time;	2752876678
SELECT DISTINCT e.name AS employee_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 
  AND a.award_name = '销售冠军'
  AND ar.date = '2024-09-22'::date
  AND ar.check_in > '09:00:00'::time;	2550918549
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00005' 
  AND ar.date = '2024-10-10'::date 
  AND ar.check_in > '09:00:00'::time;	2654497153
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-04-20' AND pe.rating = 'D';	776263740
SELECT 
    COUNT(DISTINCT CASE WHEN a.employee_id IS NOT NULL AND pe.employee_id IS NOT NULL THEN e.employee_id END) * 100.0 / 
    COUNT(DISTINCT e.employee_id) AS percentage_with_awards_and_performance_improvement
FROM 
    employees e
LEFT JOIN 
    (SELECT DISTINCT employee_id FROM awards WHERE year >= EXTRACT(YEAR FROM CURRENT_DATE) - 1) a 
    ON e.employee_id = a.employee_id
LEFT JOIN 
    (SELECT DISTINCT employee_id FROM performance_evaluations 
     WHERE evaluation_date >= CURRENT_DATE - INTERVAL '2 years' 
     AND rating IN ('Improved', 'Excellent', 'Outstanding')) pe 
    ON e.employee_id = pe.employee_id;	1728657056
SELECT e.employee_id AS employee_unique_id, 
       e.name AS employee_name, 
       a.award_name AS award_received, 
       p.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE e.hire_date BETWEEN '2023-01-01' AND '2023-12-31'
AND a.year = 2023
AND a.award_name = '优秀员工奖'
AND p.rating = 'A+'
AND p.evaluation_date BETWEEN '2023-01-01' AND '2023-12-31';	4069271992
SELECT e.name AS employee_name, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部' AND ar.date = '2024-09-21' AND ar.check_in > '09:00:00';	2408826226
SELECT 
    e.employee_id AS employee_id,
    SUM(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))) AS total_work_seconds
FROM 
    employees e
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
GROUP BY 
    e.employee_id;	2252548426
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_identifier,
    ar.check_in AS check_in_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '客户服务部'
    AND ar.date = '2024-09-15'::date
    AND ar.check_in > '09:00:00'::time;	141603518
SELECT e.name AS employee_name, ar.date AS attendance_date, ar.check_in AS check_in_time
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2021 
  AND a.award_name = '创新奖'
  AND ar.date = '2024-10-05'
  AND ar.check_in > '09:00:00';	3509550647
SELECT 
    e.name AS employee_name,
    a.award_name AS award_name,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    a.year = 2024 
    AND pe.rating = 'C';	102704152
SELECT e.name AS employee_name, a.award_name, pe.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2024 AND a.award_name = '领导力奖' AND pe.rating = 'C';	4066261878
SELECT e.name AS employee_name, e.employee_id AS employee_id, ar.check_in AS check_in_time
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '质量控制部' AND ar.date = '2024-09-19' AND ar.check_in > '09:00:00';	7133946
SELECT DISTINCT e.name AS award_winner_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2024 
  AND a.award_name = '项目管理奖'
  AND ar.date = '2024-09-23';	2339648
SELECT 
    e.name AS employee_name, 
    d.name AS department_name, 
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
LEFT JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-09-20';	1476916008
SELECT e.name AS employee_name, 
       d.name AS department_name,
       d.manager_id AS department_manager_id
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-26' 
  AND ar.check_in > '09:30:00';	2848971755
SELECT e.name AS employee_name, e.employee_id AS employee_unique_id, ar.check_in AS check_in_time
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学' AND ar.date = '2024-10-03' AND ar.check_in > '09:00:00';	1510555187
SELECT 
    e.name AS employee_name,
    e.employee_id AS employee_id,
    ar.check_in AS check_in_time,
    ar.check_out AS check_out_time
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    d.name = '研发部'
    AND ar.date = '2024-10-01'
    AND (ar.check_out - ar.check_in) > INTERVAL '10 hours';	1954114065
SELECT e.name AS employee_name, 
       a.award_name AS award_received, 
       p.rating AS performance_rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '优秀员工'
  AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	3968556416
SELECT 
    d.cust_no AS customer_number,
    d.acct_bal AS deposit_balance,
    SUM(l.loan_balance) AS total_loan_balance,
    STRING_AGG(DISTINCT l.loan_type, ', ') AS loan_types
FROM deposit_account_info d
JOIN loan_detail_info l ON d.cust_no = l.cust_id
WHERE d.data_dt = '2024-07-19'::timestamp 
  AND d.acct_bal > 100000
  AND l.dw_date = '2024-07-19'::timestamp
  AND l.loan_balance > 500000
GROUP BY d.cust_no, d.acct_bal;	2192717523
SELECT DISTINCT f.cust_no AS customer_id,
       f.wealth_bal AS usd_financial_balance
FROM financial_products f
JOIN currency c ON f.currency = c.curr_code
WHERE f.data_dt = '2024-07-02'::timestamp
  AND c.curr_code = 'USD'
  AND f.wealth_bal > 5000000;	747211607
SELECT rs_type_name AS classification_name, rs_type_id AS classification_code 
FROM five_level_classification 
WHERE rs_type = '不良' AND data_dt = '2024-07-22';	218132520
SELECT 
    c.customer_name AS "客户姓名",
    o.occupation_name AS "职业名称",
    lr.description AS "还款描述"
FROM 
    customer c
LEFT JOIN 
    occupation o ON c.occupation_id = o.id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
ORDER BY 
    lr.repayment_amount DESC;	175056471
SELECT 
    c.customer_name AS "客户姓名", 
    c.id_number AS "身份证号", 
    c.phone_number AS "手机号", 
    c.email AS "电子邮件", 
    c.address AS "住址"
FROM 
    customer c
JOIN 
    occupation o ON c.occupation_id = o.id
WHERE 
    o.occupation_name = '护士'
ORDER BY 
    c.customer_name;	334027216
SELECT COUNT(DISTINCT d.cust_no) AS private_customers_with_deposit_and_loan_count
FROM deposit_account_info d
JOIN loan_detail_info l ON d.cust_no = l.cust_id
WHERE d.data_dt = '2024-07-19'::timestamp 
  AND d.org_nm LIKE '%沈阳%'
  AND d.cust_type = '对私'
  AND l.dw_date = '2024-07-19'::timestamp;	3272129262
SELECT 
    c.curr_code AS currency_code,
    c.curr_full_name AS currency_full_name,
    b.bank_name AS bank_name,
    b.bank_level AS bank_level
FROM 
    currency c
LEFT JOIN 
    financial_products f ON c.curr_code = f.currency AND f.data_dt = '2023-06-30'
LEFT JOIN 
    bank_orgnization b ON f.bank_no = b.bank_id AND b.data_dt = '2023-06-30'
WHERE 
    c.data_dt = '2023-06-30'
    AND (f.currency IS NOT NULL OR b.bank_name IS NOT NULL);	2889578956
SELECT deposit_id AS "存款产品编号", deposit_name AS "存款产品名称" FROM deposit_type WHERE data_dt = '2024-07-22';	88302712
SELECT 
    d.card_no AS "银行卡号",
    d.cust_nm AS "客户姓名",
    d.residential_address AS "居住地址"
FROM 
    debit_card_information d
WHERE 
    d.open_date::date = '2024-07-15' 
    AND d.current_bal > 2000;	1348647978
SELECT customer_id AS "客户ID", credit_score AS "信用评分" 
FROM loan_credit 
WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	1016905624
SELECT 
    c.gender AS 性别,
    c.customer_name AS 客户姓名,
    SUM(lr.repayment_amount) AS 总还款金额
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
GROUP BY 
    c.gender, c.customer_name;	3611732895
SELECT 
    c.customer_name AS customer_name,
    la.loan_amount AS highest_loan_amount
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
ORDER BY 
    la.loan_amount DESC
LIMIT 1;	1319754722
SELECT COUNT(DISTINCT f.cust_no) AS qualified_customer_count
FROM financial_products f
INNER JOIN debit_card_information d ON f.cust_no = d.cust_no
WHERE f.wealth_bal > 1000000 AND d.card_state = '正常';	2123954700
SELECT cust_name, ci_ref_acct, act_mon_avg_bal 
FROM deposit_account_info 
WHERE data_dt = '2024-07-19' 
  AND org_nm = '沈阳余淮支行' 
  AND acct_type_code = '活期' 
  AND act_mon_avg_bal > 50000;	4161720938
SELECT c.customer_name AS "客户姓名", la.loan_amount AS "贷款金额"
FROM loan_application la
JOIN customer c ON la.customer_id = c.id
WHERE la.loan_amount > 30000 AND la.status = 'PENDING';	1485816909
SELECT 
    dt.deposit_type_name AS deposit_type,
    COUNT(DISTINCT c.id) AS customer_count
FROM 
    (SELECT customer_id FROM loan_application ORDER BY loan_amount DESC LIMIT 20) top_loans
JOIN 
    customer c ON top_loans.customer_id = c.id
LEFT JOIN 
    deposit_account_info dai ON c.id_number = dai.cert_code
LEFT JOIN 
    deposit_type dt ON dai.acct_type_code = dt.deposit_id
GROUP BY 
    dt.deposit_type_name;	864749016
SELECT curr_code AS currency_code, curr_full_name AS currency_full_name 
FROM currency 
WHERE curr_class = '外币' 
ORDER BY curr_code ASC;	3380354553
SELECT 
    c.id AS customer_id, 
    COALESCE(SUM(la.loan_amount), 0) AS total_loan_amount
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
GROUP BY 
    c.id
ORDER BY 
    total_loan_amount DESC;	146146439
SELECT 
    cast_type AS customer_type,
    AVG(wealth_sta_m_avg_bal_a) AS monthly_avg_balance
FROM financial_products
WHERE data_dt BETWEEN '2024-07-01' AND '2024-07-31'
GROUP BY cast_type;	2245911258
SELECT 
    reportid AS loan_record_id,
    cust_id AS customer_id,
    cust_type AS customer_type,
    iou_no AS loan_contract_number,
    loan_type AS loan_type_code,
    vouch_type AS collateral_type,
    currency_type AS currency_code,
    account_state AS account_status,
    loan_amount AS total_loan_amount,
    loan_balance AS outstanding_balance,
    blc_capital AS principal_balance,
    blc_inner AS interest_balance,
    blc_off AS other_charges_balance,
    judgelevel AS risk_classification,
    loandate_s AS loan_start_date,
    loandate_e AS loan_end_date,
    dw_date AS data_processing_date
FROM 
    loan_detail_info
WHERE 
    loandate_s >= '2024-04-01';	904046704
WITH age_groups AS (
    SELECT 
        c.id,
        c.customer_name,
        CASE 
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 0 AND 20 THEN '0-20'
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 21 AND 40 THEN '21-40'
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 41 AND 60 THEN '41-60'
            ELSE '61+'
        END AS age_group,
        la.loan_amount
    FROM 
        customer c
    JOIN 
        loan_application la ON c.id = la.customer_id
),
group_avg AS (
    SELECT 
        age_group,
        AVG(loan_amount) AS avg_loan_amount
    FROM 
        age_groups
    GROUP BY 
        age_group
)
SELECT 
    ag.customer_name AS customer_name,
    ag.age_group AS age_group,
    ag.loan_amount AS actual_loan_amount,
    ga.avg_loan_amount AS group_avg_loan_amount
FROM 
    age_groups ag
JOIN 
    group_avg ga ON ag.age_group = ga.age_group
WHERE 
    ag.loan_amount > ga.avg_loan_amount * 1.5
ORDER BY 
    ag.age_group, ag.loan_amount DESC;	2037290745
SELECT birth_date AS user_birth_date, gender AS user_gender FROM customer;	1073845704
SELECT DISTINCT l.cust_id AS customer_id, l.loan_balance AS outstanding_loan_amount
FROM loan_detail_info l
JOIN bank_orgnization b ON l.loan_orgno = b.bank_id
WHERE l.loan_balance > 500000
AND b.bank_parent IN (SELECT bank_id FROM bank_orgnization WHERE bank_name LIKE '%沈阳%')
AND l.dw_date = '2024-07-19'::timestamp;	1970903262
SELECT 
    ldi.iou_no AS loan_identifier,
    ldi.loan_balance AS outstanding_balance,
    c.curr_full_name AS currency_full_name,
    flc.rs_type_name AS risk_classification_name
FROM 
    loan_detail_info ldi
LEFT JOIN 
    currency c ON ldi.currency_type = c.curr_code
LEFT JOIN 
    five_level_classification flc ON ldi.judgelevel = flc.rs_type_id
WHERE 
    ldi.loan_balance > 1000000;	2098164166
SELECT 
    ldi.cust_id AS customer_identifier,
    c.curr_full_name AS currency_full_name,
    ldi.loan_balance AS loan_balance_amount
FROM 
    loan_detail_info ldi
JOIN 
    currency c ON ldi.currency_type = c.curr_code
WHERE 
    ldi.loan_balance > 1000000
ORDER BY 
    ldi.loan_balance DESC;	3382000879
SELECT 
    customer_id AS customer_identifier,
    COUNT(DISTINCT behavior_type) AS distinct_behavior_types_count
FROM 
    user_behavior
WHERE 
    behavior_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    customer_id
ORDER BY 
    distinct_behavior_types_count DESC
LIMIT 5;	2579167658
SELECT 
    SUM(stm_overdu) AS total_overdue_amount, 
    COUNT(DISTINCT xaccount) AS overdue_account_count 
FROM credit_card_data 
WHERE corporation = 'Corp3' AND cycle_nbr = '2024-07-03';	1454085576
SELECT 
    reportid AS 贷款标识,
    cust_type AS 客户类型,
    iou_no AS 贷款合同编号,
    loan_type AS 贷款类型,
    loan_orgno AS 发放机构,
    vouch_type AS 担保方式,
    currency_type AS 币种,
    account_state AS 账户状态,
    loan_amount AS 贷款金额,
    loan_balance AS 贷款余额,
    blc_capital AS 本金余额,
    blc_inner AS 表内余额,
    blc_off AS 表外余额,
    judgelevel AS 五级分类,
    loandate_s AS 贷款起始日期,
    loandate_e AS 贷款结束日期,
    dw_date AS 数据仓库日期
FROM loan_detail_info
WHERE cust_id = '1004';	1846154246
SELECT 
    c.customer_name AS customer_name, 
    t.transfer_amount AS transfer_amount, 
    t.transfer_date AS transfer_date
FROM customer c
LEFT JOIN transfer t ON c.id = t.source_customer_id OR c.id = t.target_customer_id;	3291969349
SELECT 
    c.id AS customer_id,
    ub.behavior_type AS customer_behavior,
    lr.repayment_amount AS loan_repayment_amount
FROM customer c
LEFT JOIN user_behavior ub ON c.id = ub.customer_id
LEFT JOIN loan_application la ON c.id = la.customer_id
LEFT JOIN loan_repayment lr ON la.id = lr.loan_application_id;	3977283654
SELECT 
    d.cust_name AS customer_name,
    d.acct_bal AS account_balance,
    dt.deposit_type_name AS deposit_type_name
FROM 
    deposit_account_info d
JOIN 
    deposit_type dt ON d.acct_type_code = dt.deposit_id
WHERE 
    d.data_dt = '2024-07-21'::timestamp 
    AND d.acct_bal > 50000;	2512363543
SELECT 
    c.customer_name AS "客户名称",
    c.province AS "所在省份",
    SUM(la.loan_amount) AS "贷款总额",
    ROUND(SUM(la.loan_amount) * 100.0 / NULLIF(province_total.total_amount, 0), 2) AS "贷款占比(%)"
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
JOIN (
    SELECT 
        province, 
        SUM(loan_amount) AS total_amount
    FROM 
        customer c
    JOIN 
        loan_application la ON c.id = la.customer_id
    GROUP BY 
        province
) province_total ON c.province = province_total.province
GROUP BY 
    c.id, 
    c.customer_name, 
    c.province, 
    province_total.total_amount
ORDER BY 
    c.province, 
    "贷款总额" DESC;	4035425926
WITH approval_rates AS (
    SELECT 
        c.province AS region_name,
        o.occupation_name AS occupation_name,
        COUNT(CASE WHEN la.status = 'APPROVED' THEN 1 END) * 100.0 / COUNT(*) AS approval_rate,
        RANK() OVER (PARTITION BY c.province ORDER BY COUNT(CASE WHEN la.status = 'APPROVED' THEN 1 END) * 100.0 / COUNT(*) DESC) AS rank
    FROM 
        loan_application la
    JOIN 
        customer c ON la.customer_id = c.id
    JOIN 
        occupation o ON c.occupation_id = o.id
    GROUP BY 
        c.province, o.occupation_name
)
SELECT 
    region_name,
    occupation_name,
    approval_rate
FROM 
    approval_rates
WHERE 
    rank = 1
ORDER BY 
    region_name;	82349614
WITH branch_total AS (
    SELECT 
        org_nm AS branch_name,
        SUM(acct_bal) AS total_balance
    FROM 
        deposit_account_info
    GROUP BY 
        org_nm
),
top_customers AS (
    SELECT 
        org_nm,
        acct_bal,
        ROW_NUMBER() OVER (PARTITION BY org_nm ORDER BY acct_bal DESC) AS rank
    FROM 
        deposit_account_info
)
SELECT 
    t.org_nm AS branch_name,
    ROUND(SUM(t.acct_bal) * 100.0 / b.total_balance, 2) AS top10_percentage
FROM 
    top_customers t
JOIN 
    branch_total b ON t.org_nm = b.branch_name
WHERE 
    t.rank <= 10
GROUP BY 
    t.org_nm, b.total_balance
ORDER BY 
    top10_percentage DESC;	3816528329
SELECT cust_nm AS customer_name, tel_no AS phone_number 
FROM debit_card_information 
WHERE cust_nm LIKE '%Lee%';	3967240206
SELECT 
    c.id AS customer_id,
    ub.behavior_type AS customer_behavior,
    lr.repayment_amount AS repayment_amount
FROM 
    customer c
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id;	2555762315
SELECT DISTINCT c.id AS customer_id, la.id AS loan_application_id
FROM loan_credit lc
JOIN customer c ON lc.customer_id = c.id
JOIN loan_application la ON c.id = la.customer_id
JOIN loan_repayment lr ON la.id = lr.loan_application_id
WHERE lc.credit_score > 0.75 
  AND DATE(lc.credit_date) = '2021-11-10'
  AND DATE(lr.repayment_date) = '2021-11-10';	1472446382
SELECT 
    id AS repayment_id, 
    loan_application_id AS loan_app_id, 
    repayment_amount AS amount, 
    repayment_date AS date, 
    description AS repayment_desc 
FROM 
    loan_repayment 
WHERE 
    repayment_amount > 900;	837468015
SELECT 
    d.cust_no AS customer_number,
    d.cust_nm AS customer_name,
    d.card_no AS debit_card_number,
    d.residential_address AS residential_address
FROM 
    debit_card_information d
WHERE 
    d.card_state = '正常' 
    AND d.residential_address = '987 Willow Street'
    AND d.data_dt = '2024-07-09';	3614707278
SELECT 
    c.id AS customer_id, 
    c.id_number AS customer_identifier, 
    COALESCE(ldi.loan_balance, 0) AS outstanding_loan_balance
FROM 
    customer c
LEFT JOIN 
    loan_detail_info ldi ON c.id_number = ldi.cust_id;	3381297740
SELECT 
    lt.loan_type_name AS loan_type,
    COUNT(DISTINCT dbi.cust_no) AS debit_card_user_count
FROM 
    loan_type lt
LEFT JOIN 
    loan_detail_info ldi ON lt.loan_type_name = ldi.loan_type
LEFT JOIN 
    debit_card_information dbi ON ldi.cust_id = dbi.cust_id AND dbi.card_state = '正常'
GROUP BY 
    lt.loan_type_name;	3209601254
SELECT 
    lt.loan_type_name AS loan_type,
    COUNT(DISTINCT la.customer_id) AS customer_count
FROM 
    loan_type lt
LEFT JOIN 
    loan_application la ON lt.id = la.loan_type_id
GROUP BY 
    lt.loan_type_name;	1181974520
SELECT 
    c.id AS customer_id,
    c.customer_name,
    lc.credit_score,
    lc.description AS credit_description
FROM 
    customer c
LEFT JOIN 
    loan_credit lc ON c.id = lc.customer_id AND lc.credit_date = '2011-04-13'
WHERE 
    lc.credit_date IS NOT NULL;	4290316983
SELECT 
    SUM(wealth_bal) AS total_financial_balance,
    SUM(wealth_bal_f) AS total_guaranteed_financial_balance
FROM 
    financial_products
WHERE 
    data_dt = '2024-07-14'::timestamp
    AND org_no IN (
        SELECT bank_id 
        FROM bank_orgnization 
        WHERE bank_name LIKE '%余淮支行%' 
        AND bank_parent LIKE '%沈阳%'
    )
    AND cust_type = '2';	4121525980
SELECT customer_id, credit_score 
FROM loan_credit 
WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	1634196262
SELECT 
    source_customer_id AS transfer_origin_customer_id,
    target_customer_id AS transfer_destination_customer_id
FROM transfer;	2019378478
SELECT loan_type_name AS mortgage_loan_name FROM loan_type WHERE loan_type_code = 'MORTGAGE';	522536270
SELECT cust_nm AS customer_name, card_no AS debit_card_number
FROM debit_card_information
WHERE card_state = '正常' AND data_dt = '2024-07-05';	126227619
SELECT 
    bank_nm AS bank_name, 
    cast_type AS customer_type, 
    COUNT(*) AS product_count 
FROM 
    financial_products 
GROUP BY 
    bank_nm, cast_type 
ORDER BY 
    bank_name, customer_type;	2456368123
SELECT deposit_name AS "存款产品名称", deposit_type_id AS "存款类型产品组号" FROM deposit_type ORDER BY deposit_name;	1564372003
SELECT 
    la.status AS loan_status,
    la.loan_amount AS loan_amount
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id;	2160477527
SELECT 
    c.id AS customer_id,
    c.customer_name,
    c.id_number,
    c.phone_number,
    c.email,
    c.address,
    c.birth_date,
    c.gender,
    c.occupation_id,
    c.province
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_score = 0.77;	1462437870
SELECT 
    lt.loan_type_name AS loan_type_description,
    lt.description AS loan_type_full_description,
    lr.repayment_amount AS repayment_record
FROM 
    loan_type lt
LEFT JOIN 
    loan_application la ON lt.id = la.loan_type_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id;	4083934626
SELECT 
    category AS category_code,
    category AS category_name
FROM 
    credit_card_data
WHERE 
    category IS NOT NULL
GROUP BY 
    category
ORDER BY 
    category;	2872120818
SELECT card_no AS "银行卡号", closing_date AS "关闭日期" 
FROM debit_card_information 
WHERE closing_date > '2024-07-05'::timestamp;	1283326851
SELECT card_type_nm AS card_type_name, card_state AS card_status 
FROM debit_card_information 
WHERE card_type_nm IS NOT NULL;	531921010
SELECT cust_id, SUM(loan_balance) AS total_loan_balance 
FROM loan_detail_info 
WHERE dw_date = '2024-07-19' AND loan_balance > 100000 
GROUP BY cust_id;	1418289021
SELECT 
    bo.bank_name AS bank_name,
    CORR(dai.acct_bal, ldi.loan_balance) AS deposit_loan_correlation
FROM 
    bank_orgnization bo
JOIN 
    deposit_account_info dai ON bo.bank_id = dai.bank_no AND bo.data_dt = dai.data_dt
JOIN 
    loan_detail_info ldi ON bo.bank_id = ldi.loan_orgno AND bo.data_dt = ldi.dw_date::date
WHERE 
    bo.data_dt = (SELECT MAX(data_dt) FROM bank_orgnization)
    AND dai.acct_bal IS NOT NULL
    AND ldi.loan_balance IS NOT NULL
GROUP BY 
    bo.bank_name
HAVING 
    COUNT(*) > 1
ORDER BY 
    deposit_loan_correlation DESC;	137242606
SELECT 
    EXTRACT(YEAR FROM t.transfer_date) AS transaction_year,
    EXTRACT(MONTH FROM t.transfer_date) AS transaction_month,
    SUM(t.transfer_amount) AS total_transfer_amount,
    COALESCE(SUM(l.loan_amount), 0) AS total_loan_amount
FROM 
    transfer t
LEFT JOIN 
    loan_application l ON EXTRACT(YEAR FROM t.transfer_date) = EXTRACT(YEAR FROM l.apply_date) 
                      AND EXTRACT(MONTH FROM t.transfer_date) = EXTRACT(MONTH FROM l.apply_date)
GROUP BY 
    transaction_year, transaction_month
ORDER BY 
    transaction_year, transaction_month;	2672242323
SELECT customer_name AS "客户姓名", phone_number AS "手机号码" FROM customer WHERE province = '上海市';	2845015839
SELECT credit_score AS "信用评分", credit_date AS "信用日期" FROM loan_credit WHERE customer_id = 533302;	1582007502
SELECT 
    id AS transfer_id,
    source_customer_id AS from_customer_id,
    target_customer_id AS to_customer_id,
    transfer_amount AS amount,
    transfer_date AS transaction_date,
    description AS transfer_description
FROM 
    transfer
ORDER BY 
    transfer_amount DESC;	283689317
SELECT 
    customer_id AS user_id, 
    COUNT(DISTINCT behavior_type) AS distinct_behavior_type_count
FROM 
    user_behavior
GROUP BY 
    customer_id;	1594346019
SELECT COUNT(DISTINCT d.cert_code) AS qualified_customer_count
FROM deposit_account_info d
JOIN credit_card_data c ON d.cert_code = c.custr_nbr
JOIN bank_orgnization b ON d.org_no = b.bank_id
WHERE d.data_dt = '2024-07-22'::timestamp
  AND b.bank_name = '沈阳分行'
  AND d.acct_bal > 100000
  AND c.stm_overdu > 5000
  AND c.cycle_nbr = (
    SELECT MAX(cycle_nbr) 
    FROM credit_card_data 
    WHERE custr_nbr = c.custr_nbr 
    AND cycle_nbr <= '2024-07-22'::timestamp
  );	3342713409
SELECT d.card_no AS debit_card_number, d.cust_nm AS customer_name
FROM debit_card_information d
JOIN bank_orgnization b ON d.bank_no = b.bank_id OR d.org_no = b.bank_id
WHERE (b.bank_id = 'BANK_002' OR b.bank_parent = 'BANK_002') AND d.card_type = '借记卡';	842726032
WITH monthly_applications AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', apply_date)::date AS month_apply
    FROM 
        loan_application
    GROUP BY 
        customer_id, DATE_TRUNC('month', apply_date)
),
grouped_months AS (
    SELECT 
        customer_id,
        month_apply,
        month_apply - (ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY month_apply) * INTERVAL '1 month') AS month_group
    FROM 
        monthly_applications
),
consecutive_groups AS (
    SELECT 
        customer_id,
        month_group,
        COUNT(*) AS consecutive_months_count
    FROM 
        grouped_months
    GROUP BY 
        customer_id, month_group
    HAVING 
        COUNT(*) >= 3
)
SELECT 
    COUNT(DISTINCT customer_id) AS customers_with_consecutive_applications
FROM 
    consecutive_groups;	236915033
SELECT cust_no AS customer_number, bank_nm AS bank_name 
FROM financial_products 
ORDER BY cust_no;	4229311898
SELECT occupation_code AS "职业代码", occupation_name AS "职业名称" FROM occupation ORDER BY occupation_name;	258690623
SELECT COUNT(DISTINCT f.cust_no) AS qualified_customers_count
FROM financial_products f
JOIN debit_card_information d ON f.cust_no = d.cust_no
WHERE f.wealth_bal > 10 * d.current_bal;	3376193292
SELECT loan_orgno AS loan_organization_number, loan_balance AS outstanding_loan_amount 
FROM loan_detail_info 
WHERE loan_amount > 70000;	116553538
SELECT DISTINCT 
    lt.loan_type_name AS "贷款类型名称", 
    ub.behavior_type AS "用户行为类型"
FROM 
    loan_type lt
LEFT JOIN 
    loan_application la ON lt.id = la.loan_type_id
LEFT JOIN 
    user_behavior ub ON la.customer_id = ub.customer_id
WHERE 
    ub.behavior_type IS NOT NULL;	646950911
SELECT bank_level, COUNT(*) AS org_count 
FROM bank_orgnization 
GROUP BY bank_level;	109259315
SELECT 
    d.current_bal AS "活期余额",
    d.fixed_bal AS "定期余额"
FROM 
    debit_card_information d
    JOIN customer c ON d.cust_no = c.id_number
WHERE 
    c.customer_name = 'Olivia Lee'
    AND d.org_nm = '北京东单支行'
    AND d.data_dt = '2024-07-15'::timestamp
LIMIT 1;	2700778328
SELECT 
    c.customer_name AS "客户姓名",
    lc.description AS "信用描述"
FROM 
    customer c
JOIN 
    loan_credit lc ON c.id = lc.customer_id
WHERE 
    lc.credit_date = '2017-10-31' 
    AND lc.credit_score > 0.85
ORDER BY 
    lc.credit_score DESC;	4212764935
SELECT 
    c.id AS customer_id,
    c.customer_name AS customer_name,
    la.loan_amount AS car_loan_amount
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
WHERE 
    lt.loan_type_name = '汽车贷款';	4269406178
SELECT 
    lt.loan_type_name AS loan_type,
    AVG(lr.repayment_amount) AS avg_repayment_amount,
    COUNT(lr.id) AS repayment_count
FROM 
    loan_repayment lr
JOIN 
    loan_application la ON lr.loan_application_id = la.id
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
GROUP BY 
    lt.loan_type_name;	1128360712
SELECT 
    acc_name1 AS account_name, 
    bank AS bank_name, 
    category AS account_category, 
    day_opened AS opening_date
FROM 
    credit_card_data 
WHERE 
    corporation = 'Corp3' 
ORDER BY 
    day_opened DESC;	2724005771
SELECT customer_name AS "客户姓名", address AS "居住地址" FROM customer;	3382134012
SELECT 
    b.bank_id AS bank_identifier,
    COALESCE(SUM(l.loan_amount), 0) AS total_loan_amount,
    COALESCE(SUM(d.current_bal), 0) AS total_debit_card_balance,
    CASE 
        WHEN COALESCE(SUM(d.current_bal), 0) = 0 THEN NULL 
        ELSE COALESCE(SUM(l.loan_amount), 0) / COALESCE(SUM(d.current_bal), 0) 
    END AS loan_to_debit_ratio
FROM 
    bank_orgnization b
LEFT JOIN 
    loan_detail_info l ON b.bank_id = l.loan_orgno AND EXTRACT(YEAR FROM l.dw_date) = 2023
LEFT JOIN 
    debit_card_information d ON b.bank_id = d.bank_no AND EXTRACT(YEAR FROM d.data_dt) = 2023
GROUP BY 
    b.bank_id;	1545912595
SELECT 
    id AS repayment_id,
    loan_application_id AS application_id,
    repayment_amount AS amount,
    repayment_date AS payment_date,
    description AS repayment_description
FROM loan_repayment
ORDER BY ABS(repayment_amount - (SELECT AVG(repayment_amount) FROM loan_repayment))
LIMIT 1;	2397640501
SELECT DISTINCT c.id AS customer_id
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
JOIN financial_products fp ON c.id::text = fp.cust_no
WHERE lc.credit_score > 0.8
  AND fp.data_dt >= '2024-07-01' 
  AND fp.data_dt < '2024-08-01';	561955406
SELECT 
    EXTRACT(YEAR FROM apply_date) AS application_year,
    EXTRACT(MONTH FROM apply_date) AS application_month,
    (SUM(CASE WHEN status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS approval_rate_percentage
FROM loan_application
GROUP BY application_year, application_month
ORDER BY application_year, application_month;	1986127383
SELECT 
    bo.bank_name AS bank_name,
    COUNT(DISTINCT c.id) AS new_customer_count,
    COALESCE(AVG(la.loan_amount), 0) AS avg_loan_amount
FROM 
    bank_orgnization bo
LEFT JOIN 
    deposit_account_info dai ON bo.bank_id = dai.bank_no
LEFT JOIN 
    customer c ON dai.cert_code = c.id_number
LEFT JOIN 
    loan_application la ON c.id = la.customer_id 
    AND la.apply_date BETWEEN '2024-01-01' AND '2024-03-31'
WHERE 
    dai.data_dt BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY 
    bo.bank_name;	1657316021
SELECT 
    bo.bank_name AS jurisdiction_bank_name,
    AVG(ld.loan_amount) AS avg_loan_amount,
    AVG(DATE_PART('day', ld.loandate_e::timestamp - ld.loandate_s::timestamp)/30) AS avg_loan_term_months
FROM 
    loan_detail_info ld
JOIN 
    bank_orgnization bo ON ld.loan_orgno = bo.bank_id
WHERE 
    bo.bank_level = '1'
GROUP BY 
    bo.bank_name;	2162181589
SELECT c.id AS customer_id, lc.credit_score, lc.credit_date
FROM customer c
LEFT JOIN loan_credit lc ON c.id = lc.customer_id;	2307971258
SELECT 
    cust_id AS customer_identifier,
    loan_balance AS outstanding_loan_amount
FROM 
    loan_detail_info
WHERE 
    loandate_e::date < '2026-01-01';	2557946358
SELECT apply_date AS "贷款申请日期", loan_amount AS "贷款金额" FROM loan_application;	3214990589
SELECT 
    la.customer_id AS customer_id,
    la.loan_amount AS approved_housing_loan_amount
FROM 
    loan_application la
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
WHERE 
    lt.loan_type_name = '住房贷款' 
    AND la.status = 'APPROVED'
ORDER BY 
    la.loan_amount DESC;	140188268
SELECT 
    org_nm AS branch_name, 
    bank_nm AS parent_bank_name, 
    SUM(acct_bal) AS total_deposit_balance
FROM 
    deposit_account_info
GROUP BY 
    org_nm, bank_nm
ORDER BY 
    total_deposit_balance DESC
LIMIT 5;	2839950527
SELECT 
    id AS repayment_id, 
    loan_application_id AS loan_app_id, 
    repayment_amount AS amount, 
    repayment_date AS payment_date, 
    description AS repayment_desc 
FROM 
    loan_repayment 
WHERE 
    description LIKE '%严琳%';	2833646672
SELECT rs_type_name AS classification_type, COUNT(*) AS count 
FROM five_level_classification 
GROUP BY rs_type_name;	508839263
SELECT rs_type_name AS classification_type, COUNT(*) AS count 
FROM five_level_classification 
GROUP BY rs_type_name;	3720034566
SELECT 
    b.bank_name AS bank_organization_name,
    f.cust_no AS customer_number,
    f.wealth_bal AS financial_product_balance
FROM 
    financial_products f
JOIN 
    bank_orgnization b ON f.org_no = b.bank_id;	1167041688
SELECT loan_type_code AS "贷款类型代码", loan_type_name AS "贷款类型名称", description AS "贷款类型描述" FROM loan_type ORDER BY loan_type_code;	1532873158
SELECT 
    b1.bank_name AS bank_name,
    b2.bank_name AS parent_bank_name
FROM 
    bank_orgnization b1
JOIN 
    bank_orgnization b2 ON b1.bank_parent = b2.bank_id
WHERE 
    b1.bank_level = '2';	2367133121
WITH ranked_customers AS (
    SELECT 
        c.province AS 地区名称,
        c.customer_name AS 客户姓名,
        SUM(la.loan_amount) AS 贷款金额,
        RANK() OVER (PARTITION BY c.province ORDER BY SUM(la.loan_amount) DESC) AS rank
    FROM 
        customer c
    JOIN 
        loan_application la ON c.id = la.customer_id
    GROUP BY 
        c.province, c.customer_name
)
SELECT 
    地区名称,
    客户姓名,
    贷款金额
FROM 
    ranked_customers
WHERE 
    rank <= 3
ORDER BY 
    地区名称, 贷款金额 DESC;	2982430979
SELECT 
    id AS transfer_id, 
    source_customer_id AS sender_id, 
    target_customer_id AS receiver_id, 
    transfer_amount AS amount, 
    transfer_date AS transaction_date, 
    description AS transfer_notes 
FROM 
    transfer 
WHERE 
    source_customer_id = 376252;	4126585093
SELECT 
    c.customer_name AS "客户姓名",
    c.gender AS "性别",
    o.occupation_name AS "职业名称"
FROM 
    customer c
LEFT JOIN 
    occupation o ON c.occupation_id = o.id;	1577554550
SELECT 
    COUNT(DISTINCT fp.cust_no) AS non_guaranteed_customer_count,
    SUM(fp.wealth_bal_f) AS total_non_guaranteed_balance
FROM 
    financial_products fp
WHERE 
    fp.org_nm LIKE '%余淮%' 
    AND fp.bank_nm LIKE '%沈阳%'
    AND fp.data_dt >= '2024-07-01' 
    AND fp.data_dt <= '2024-07-31'
    AND fp.wealth_bal_f > 0;	1654794343
SELECT DISTINCT customer_id 
FROM loan_credit 
WHERE credit_score > 0.8;	2092588313
SELECT 
    c1.customer_name AS sender_name, 
    c2.customer_name AS receiver_name, 
    t.transfer_amount
FROM 
    transfer t
JOIN 
    customer c1 ON t.source_customer_id = c1.id
JOIN 
    customer c2 ON t.target_customer_id = c2.id
WHERE 
    t.transfer_amount > 5000;	2021025668
SELECT DISTINCT c.id AS customer_id, c.customer_name AS customer_name
FROM customer c
JOIN loan_application la ON c.id = la.customer_id
WHERE EXTRACT(YEAR FROM la.apply_date) = 2019
AND la.status = 'APPROVED';	891116215
SELECT 
    d.card_type AS card_type_code,
    d.card_type_nm AS card_type_name,
    COUNT(DISTINCT d.cust_no) AS customer_count,
    AVG(f.wealth_bal) AS avg_financial_balance
FROM 
    debit_card_information d
LEFT JOIN 
    financial_products f ON d.cust_no = f.cust_no
GROUP BY 
    d.card_type, d.card_type_nm;	3533102799
SELECT 
    c.customer_name AS customer_name,
    la.loan_amount AS loan_amount
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
ORDER BY 
    la.apply_date ASC;	2160175524
SELECT 
    COALESCE(SUM(acct_bal), 0) AS total_account_balance,
    COALESCE(SUM(act_year_avg_bal), 0) AS total_annual_average_balance
FROM 
    deposit_account_info
WHERE 
    data_dt = '2024-07-19'::timestamp 
    AND cust_type = 'P';	305358980
SELECT c.customer_name AS customer_name, o.occupation_name AS occupation_name
FROM loan_repayment lr
JOIN loan_application la ON lr.loan_application_id = la.id
JOIN customer c ON la.customer_id = c.id
LEFT JOIN occupation o ON c.occupation_id = o.id
WHERE lr.repayment_amount < 500;	3219483220
SELECT 
    c.customer_name AS customer_name,
    d.acct_bal AS account_balance
FROM 
    customer c
JOIN 
    deposit_account_info d ON c.id_number = d.cert_code
WHERE 
    d.data_dt = '2023-07-19'::timestamp;	3553634354
SELECT 
    c.id AS customer_id,
    c.customer_name,
    d.acct_bal AS max_account_balance,
    la.loan_amount,
    la.apply_date AS latest_loan_application_date
FROM 
    deposit_account_info d
JOIN 
    customer c ON d.cust_no = c.id_number
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
WHERE 
    d.acct_bal = (SELECT MAX(acct_bal) FROM deposit_account_info)
ORDER BY 
    la.apply_date DESC NULLS LAST
LIMIT 1;	1610907085
SELECT o.occupation_name AS occupation, COUNT(c.id) AS customer_count 
FROM customer c 
JOIN occupation o ON c.occupation_id = o.id 
GROUP BY o.occupation_name;	1410414363
SELECT c.customer_name AS customer_name, t.transfer_amount AS transfer_amount
FROM transfer t
JOIN customer c ON t.source_customer_id = c.id
WHERE t.transfer_date = '2016-06-11' AND t.transfer_amount > 5000
ORDER BY t.transfer_amount DESC;	3954115529
SELECT 
    ld.cust_id AS customer_id,
    ld.loan_balance AS loan_balance,
    lt.loan_type_name AS loan_type,
    c.curr_full_name AS currency_name
FROM 
    loan_detail_info ld
JOIN 
    loan_type lt ON ld.loan_type = lt.loan_type_code
JOIN 
    currency c ON ld.currency_type = c.curr_code
WHERE 
    ld.loandate_s >= '2024-07-01' 
    AND ld.loan_balance > 1000000
ORDER BY 
    ld.loan_balance DESC;	1086674624
SELECT 
    id AS behavior_id, 
    customer_id AS customer_identifier, 
    behavior_type AS action_category, 
    behavior_date AS event_date, 
    description AS behavior_description 
FROM 
    user_behavior 
WHERE 
    behavior_date = '2018-06-26';	1680159550
SELECT 
    id AS repayment_id, 
    loan_application_id AS loan_application_id, 
    repayment_amount AS repayment_amount, 
    repayment_date AS repayment_date, 
    description AS repayment_description 
FROM 
    loan_repayment 
WHERE 
    EXTRACT(DOW FROM repayment_date) IN (0, 6);	2548352227
SELECT 
    dt.deposit_type_name AS deposit_product_type,
    lt.loan_type_name AS loan_product_type,
    COUNT(DISTINCT c.id) AS customer_count
FROM 
    customer c
LEFT JOIN deposit_account_info dai ON c.id_number = dai.cert_code
LEFT JOIN deposit_type dt ON dai.acct_type_code = dt.deposit_id AND dt.data_dt = dai.data_dt
LEFT JOIN loan_application la ON c.id = la.customer_id
LEFT JOIN loan_type lt ON la.loan_type_id = lt.id
GROUP BY 
    dt.deposit_type_name, lt.loan_type_name
ORDER BY 
    customer_count DESC;	1833243393
SELECT c.customer_name AS "客户姓名", lr.repayment_amount AS "还款金额"
FROM loan_repayment lr
JOIN loan_application la ON lr.loan_application_id = la.id
JOIN customer c ON la.customer_id = c.id
WHERE lr.repayment_date = '2021-11-10' AND lr.repayment_amount > 20
ORDER BY lr.repayment_amount DESC;	3824204712
SELECT lt.loan_type_name, AVG(lc.credit_score) AS avg_credit_score
FROM loan_type lt
LEFT JOIN loan_application la ON lt.id = la.loan_type_id
LEFT JOIN loan_credit lc ON la.customer_id = lc.customer_id
GROUP BY lt.loan_type_name;	3260667731
SELECT 
    loan_type_code AS "贷款类型代码",
    loan_type_name AS "贷款类型名称"
FROM 
    loan_type
WHERE 
    loan_type_code IS NOT NULL;	732762958
SELECT ls.loan_status_name, COUNT(la.id) AS loan_application_count 
FROM loan_status ls 
LEFT JOIN loan_application la ON ls.loan_status_code = la.status 
GROUP BY ls.loan_status_name;	330418458
SELECT customer_id AS "客户ID", description AS "信用评分描述" FROM loan_credit;	245397134
SELECT 
    d.cust_name AS 客户姓名,
    d.cert_code AS 证件号码,
    c.phone_number AS 联系电话,
    dc.card_no AS 借记卡卡号,
    dc.current_bal AS 活期余额
FROM 
    deposit_account_info d
JOIN 
    debit_card_information dc ON d.cust_no = dc.cust_no AND d.org_no = dc.org_no
JOIN
    customer c ON d.cert_code = c.id_number
WHERE 
    d.org_no = 'BANK_00201' 
    AND d.data_dt = '2024-07-15'::timestamp 
    AND dc.data_dt = '2024-07-15'::timestamp
    AND d.bank_date::date = '2024-07-15'::date
    AND dc.open_date::date = '2024-07-15'::date;	2669572809
SELECT 
    CASE 
        WHEN dai.cust_type = '对私' THEN '个人客户' 
        WHEN dai.cust_type = '对公' THEN '企业客户' 
    END AS 客户类型名称,
    SUM(ldi.loan_amount) AS 贷款总金额
FROM 
    loan_detail_info ldi
JOIN 
    deposit_account_info dai ON ldi.cust_id = dai.cust_no
GROUP BY 
    dai.cust_type
ORDER BY 
    客户类型名称;	2085255506
SELECT 
    iou_no AS loan_identifier,
    cust_id AS customer_id,
    cust_type AS customer_type,
    loan_type AS loan_type_code,
    account_state AS loan_status,
    loan_amount AS total_loan_amount,
    loan_balance AS outstanding_balance,
    (loan_balance / NULLIF(loan_amount, 0)) * 100 AS balance_percentage
FROM 
    loan_detail_info
WHERE 
    loan_amount > 0
ORDER BY 
    balance_percentage DESC
LIMIT 10;	1984536651
SELECT 
    la.customer_id AS rejected_customer_id,
    SUM(la.loan_amount) AS total_rejected_mortgage_amount
FROM 
    loan_application la
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
WHERE 
    lt.loan_type_code = 'MORTGAGE'
    AND la.status = 'REJECTED'
    AND la.apply_date BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY 
    la.customer_id;	258245311
SELECT 
    bank_level AS bank_level,
    bank_id AS bank_identifier,
    bank_name AS bank_name,
    bank_parent AS parent_bank_identifier,
    data_dt AS data_date
FROM bank_orgnization;	1895651034
SELECT 
    ldi.iou_no AS loan_contract_number,
    ldi.cust_id AS customer_id,
    ldi.loan_balance AS outstanding_loan_amount,
    ldi.blc_capital AS principal_balance,
    c.curr_full_name AS currency_full_name,
    flc.rs_type_name AS risk_classification_name
FROM 
    loan_detail_info ldi
LEFT JOIN 
    currency c ON ldi.currency_type = c.curr_code AND c.data_dt = '2024-07-22'
LEFT JOIN 
    five_level_classification flc ON ldi.judgelevel = flc.rs_type_id AND flc.data_dt = '2024-07-22'
WHERE 
    ldi.dw_date = '2024-07-22' 
    AND ldi.blc_capital > 10000;	134489693
SELECT 
    card_state AS card_status, 
    open_date AS account_opening_date 
FROM 
    debit_card_information 
WHERE 
    card_state = '正常';	2899938404
SELECT 
    c.customer_name AS "客户姓名",
    t.transfer_amount AS "转账金额",
    t.transfer_date AS "转账日期"
FROM 
    transfer t
JOIN 
    customer c ON t.source_customer_id = c.id OR t.target_customer_id = c.id
WHERE 
    t.transfer_date = '2023-06-30'
ORDER BY 
    t.transfer_amount DESC;	1614542471
SELECT bank_name AS "银行名称", bank_level AS "银行层级" 
FROM bank_orgnization 
WHERE data_dt = '2023-06-30';	2860028194
SELECT 
    cust_no AS customer_id, 
    SUM(wealth_bal_t) AS total_non_guaranteed_wealth_balance
FROM 
    financial_products
WHERE 
    data_dt = '2024-07-02' 
    AND wealth_bal_t > 0
GROUP BY 
    cust_no
ORDER BY 
    total_non_guaranteed_wealth_balance DESC;	2112082105
SELECT SUM(loan_amount) AS rejected_loan_total_amount
FROM loan_application
WHERE status = 'REJECTED' 
AND EXTRACT(YEAR FROM apply_date) = 2019;	1900105170
SELECT 
    bo.bank_name AS branch_name,
    COALESCE(SUM(dai.acct_bal), 0) AS corporate_deposit_balance
FROM 
    bank_orgnization bo
LEFT JOIN 
    deposit_account_info dai ON bo.bank_id = dai.org_no AND dai.data_dt = '2024-07-21' AND dai.cust_type = '2'
WHERE 
    bo.bank_parent LIKE '%杭州分行%' AND bo.data_dt = '2024-07-21'
GROUP BY 
    bo.bank_name;	3724611031
SELECT 
    c.id AS customer_id,
    c.customer_name,
    COALESCE(SUM(lr.repayment_amount), 0) AS total_repayment,
    COUNT(DISTINCT ub.id) AS behavior_count,
    COALESCE(AVG(lr.repayment_amount), 0) AS avg_repayment
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
GROUP BY 
    c.id, c.customer_name;	3179484363
SELECT bank_name AS "银行名称", bank_level AS "机构层级", data_dt AS "数据日期" FROM bank_orgnization;	3200437107
WITH customer_deposits AS (
    SELECT 
        cust_no AS customer_id,
        cust_name AS customer_name,
        acct_bal AS deposit_balance
    FROM deposit_account_info
    ORDER BY acct_bal DESC
),
total_customers AS (
    SELECT COUNT(*) AS total_count FROM customer_deposits
),
top_10_percent AS (
    SELECT 
        customer_id,
        customer_name,
        deposit_balance
    FROM customer_deposits
    LIMIT (SELECT total_count * 0.1 FROM total_customers)
),
loan_applicants AS (
    SELECT DISTINCT customer_id::text 
    FROM loan_application
    JOIN customer ON loan_application.customer_id = customer.id
)
SELECT 
    t.customer_name AS client_name,
    t.deposit_balance AS account_balance,
    c.occupation_id AS profession_code
FROM top_10_percent t
LEFT JOIN customer c ON t.customer_id = c.id_number
LEFT JOIN loan_applicants l ON t.customer_id = l.customer_id
WHERE l.customer_id IS NULL;	2071923254
SELECT 
    bo.bank_name AS organization_name,
    COUNT(CASE WHEN la.status = 'APPROVED' THEN 1 END) * 100.0 / COUNT(*) AS approval_rate_percentage
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
JOIN 
    debit_card_information d ON c.id_number = d.cust_id
JOIN 
    bank_orgnization bo ON d.org_no = bo.bank_id
GROUP BY 
    bo.bank_name;	3565838054
SELECT 
    c.customer_name AS customer_name,
    d.acct_bal AS deposit_balance
FROM 
    customer c
JOIN 
    deposit_account_info d ON c.id_number = d.cert_code
WHERE 
    d.data_dt >= '2023-07-01' AND d.data_dt <= '2023-07-31';	1893298039
SELECT 
    d.org_nm AS bank_name, 
    d.cust_name AS customer_name, 
    d.acct_bal AS account_balance, 
    d.cur_type AS currency_type
FROM 
    deposit_account_info d
WHERE 
    d.data_dt = '2023-06-30' 
    AND d.cur_type = 'USD' 
    AND d.acct_bal > 100000;	2315630941
SELECT 
    d.cust_name AS customer_name,
    d.acct_type_code AS account_type_code,
    d.acct_bal AS account_balance,
    c.curr_full_name AS currency_full_name
FROM 
    deposit_account_info d
JOIN 
    currency c ON d.cur_type = c.curr_code
WHERE 
    d.data_dt = '2024-07-19'::timestamp 
    AND d.acct_bal > 100000;	870110560
SELECT cust_nm AS customer_name, card_no AS debit_card_number
FROM debit_card_information
WHERE card_state = '正常' AND open_date > '2024-07-01'
ORDER BY open_date DESC;	1308562229
SELECT deposit_name AS "存款类型产品名称", deposit_type_id AS "存款类型产品组号" FROM deposit_type ORDER BY deposit_name;	1986404179
SELECT 
    source_customer_id AS customer_id,
    COUNT(*) AS transfer_count,
    MODE() WITHIN GROUP (ORDER BY transfer_amount) AS most_frequent_amount
FROM transfer
GROUP BY source_customer_id
ORDER BY transfer_count DESC
LIMIT 10;	2032902123
SELECT COUNT(DISTINCT c.id) AS customer_count, COALESCE(SUM(ldi.loan_balance), 0) AS total_loan_balance
FROM customer c
JOIN credit_card_data ccd ON c.id_number = ccd.custr_nbr
LEFT JOIN loan_detail_info ldi ON c.id_number = ldi.cust_id AND ldi.account_state = '正常'
WHERE c.province = '上海市' 
  AND ccd.acct_sts = '正常';	3109098948
SELECT 
    ldi.iou_no AS loan_identifier,
    ldi.loan_balance AS outstanding_balance,
    flc.rs_type_name AS risk_classification,
    CASE 
        WHEN ldi.loan_type = '个人消费贷款' THEN '个人贷款'
        WHEN ldi.loan_type = '个人经营贷款' THEN '个人贷款'
        ELSE ldi.loan_type
    END AS product_type
FROM 
    loan_detail_info ldi
LEFT JOIN 
    five_level_classification flc ON ldi.judgelevel = flc.rs_type_id
WHERE 
    ldi.dw_date = '2024-07-22'::timestamp 
    AND ldi.loan_balance > 15000;	188271146
SELECT COUNT(DISTINCT c.id) AS customer_count
FROM customer c
JOIN loan_application la1 ON c.id = la1.customer_id
JOIN loan_type lt1 ON la1.loan_type_id = lt1.id AND lt1.loan_type_code = 'MORTGAGE'
JOIN loan_application la2 ON c.id = la2.customer_id
JOIN loan_type lt2 ON la2.loan_type_id = lt2.id AND lt2.loan_type_code = 'CAR'
WHERE la1.loan_amount > la2.loan_amount;	7209425
SELECT 
    d.cust_nm AS customer_name, 
    SUM(d.current_bal) AS total_debit_card_balance
FROM 
    debit_card_information d
JOIN 
    bank_orgnization b ON d.org_no = b.bank_id
WHERE 
    b.bank_name LIKE '%杭州上城区支行%' 
    AND d.data_dt = '2024-07-19'::timestamp
GROUP BY 
    d.cust_nm
ORDER BY 
    total_debit_card_balance DESC;	1065176696
SELECT 
    vouch_type AS "担保方式",
    AVG(loan_amount) AS "平均贷款金额",
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY loan_amount) AS "中位数贷款金额",
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY loan_amount) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY loan_amount) AS "贷款金额四分位差"
FROM 
    loan_detail_info
GROUP BY 
    vouch_type;	953680810
SELECT SUM(t.transfer_amount) AS total_transfer_amount
FROM transfer t
JOIN loan_credit lc1 ON t.source_customer_id = lc1.customer_id
JOIN loan_credit lc2 ON t.target_customer_id = lc2.customer_id
WHERE t.transfer_date = '2020-11-03'
  AND lc1.credit_score > 0.8
  AND lc2.credit_score > 0.8;	2393859347
SELECT COUNT(DISTINCT c.id) AS nurse_customers_with_high_loan_applications
FROM customer c
JOIN occupation o ON c.occupation_id = o.id
JOIN loan_application la ON c.id = la.customer_id
WHERE o.occupation_name = '护士' AND la.loan_amount > 50000;	749612150
SELECT c.id AS customer_id, la.loan_amount
FROM loan_application la
JOIN customer c ON la.customer_id = c.id
WHERE la.apply_date BETWEEN '2024-07-01' AND '2024-07-31';	3260359700
SELECT 
    EXTRACT(YEAR FROM apply_date) AS year,
    EXTRACT(MONTH FROM apply_date) AS month,
    COUNT(*) AS total_applications,
    COUNT(CASE WHEN status = 'APPROVED' THEN 1 END) AS approved_applications,
    ROUND(COUNT(CASE WHEN status = 'APPROVED' THEN 1 END) * 100.0 / COUNT(*), 2) AS approval_rate_percentage
FROM 
    loan_application
GROUP BY 
    year, month
ORDER BY 
    year, month;	2869045188
SELECT org_nm AS bank_org_name, SUM(wealth_bal) AS total_financial_balance
FROM financial_products
WHERE data_dt = '2024-07-02' AND cast_type = '对公'
GROUP BY org_nm;	2139894777
SELECT 
    c.customer_name AS 客户姓名,
    ls.loan_status_name AS 贷款状态
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_status ls ON la.status = ls.loan_status_code;	2426521027
SELECT 
    lt.loan_type_name AS loan_type,
    COUNT(DISTINCT la.customer_id) AS customer_count,
    SUM(la.loan_amount) AS total_loan_amount
FROM 
    loan_application la
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
GROUP BY 
    lt.loan_type_name;	3310012060
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 0 AND 20 THEN '0-20'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 21 AND 40 THEN '21-40'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 41 AND 60 THEN '41-60'
        ELSE '61+'
    END AS age_group,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS approval_rate
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
GROUP BY 
    age_group
ORDER BY 
    age_group;	1454101538
SELECT repayment_amount AS "还款金额", repayment_date AS "还款日期" FROM loan_repayment WHERE loan_application_id = 323803;	1355579742
SELECT c.id AS customer_id, lc.credit_score AS highest_credit_score
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE c.address LIKE '%杭州上城区%'
AND lc.credit_date <= '2023-06-30'
ORDER BY lc.credit_score DESC
LIMIT 1;	2730549341
SELECT 
    id AS repayment_id, 
    loan_application_id AS loan_app_id, 
    repayment_amount AS amount, 
    repayment_date AS date, 
    description AS repayment_desc 
FROM 
    loan_repayment 
WHERE 
    repayment_date < '2020-02-25';	1021718263
SELECT 
    transfer_amount AS "转账金额", 
    transfer_date AS "转账日期" 
FROM 
    transfer 
WHERE 
    source_customer_id = 578484 
    OR target_customer_id = 578484;	405520388
SELECT 
    c.customer_name AS "客户姓名",
    c.id_number AS "身份证号码",
    COALESCE(ls.loan_status_name, '无贷款记录') AS "贷款状态名称"
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_status ls ON la.status = ls.loan_status_code;	1969682603
SELECT 
    id AS behavior_id, 
    customer_id AS associated_customer_id, 
    behavior_type AS behavior_category, 
    behavior_date AS behavior_occurrence_date, 
    description AS behavior_description 
FROM 
    user_behavior 
WHERE 
    behavior_type LIKE '%ILL%';	797442197
SELECT 
    id AS transfer_id,
    source_customer_id AS from_customer_id,
    target_customer_id AS to_customer_id,
    transfer_amount AS amount,
    transfer_date AS transaction_date,
    description AS transaction_description
FROM 
    transfer
ORDER BY 
    transfer_amount ASC;	3086691704
SELECT 
    id AS behavior_id, 
    customer_id AS associated_customer_id, 
    behavior_type AS action_type, 
    behavior_date AS occurrence_date, 
    description AS detailed_description
FROM 
    user_behavior 
WHERE 
    description IS NOT NULL;	1652118460
SELECT d.current_bal AS debit_card_balance
FROM debit_card_information d
JOIN customer c ON d.cust_id = c.id_number
WHERE c.customer_name ~* 'james.*taylor' 
  AND d.bank_nm ~* '杭州.*上城'
  AND d.data_dt::date = '2024-07-09'
LIMIT 1;	729818388
SELECT id AS loan_type_id, loan_type_code AS type_code, loan_type_name AS type_name, description AS type_description 
FROM loan_type 
WHERE description LIKE '%Loan%';	3319537046
SELECT 
    cc.curr_num AS currency_code,
    c.curr_full_name AS currency_full_name,
    COUNT(cc.xaccount) AS account_count
FROM 
    credit_card_data cc
JOIN 
    currency c ON cc.curr_num = c.curr_code
GROUP BY 
    cc.curr_num, c.curr_full_name;	981960336
SELECT 
    b.bank_name AS bank_name,
    AVG(fp.wealth_sta_m_avg_bal_a) AS avg_monthly_balance
FROM 
    financial_products fp
JOIN 
    bank_orgnization b ON fp.bank_no = b.bank_id
GROUP BY 
    b.bank_name;	446364127
SELECT 
    lt.loan_type_name AS "贷款类型名称",
    lt.description AS "贷款类型描述"
FROM 
    loan_type lt
WHERE 
    lt.id IN (
        SELECT DISTINCT la.loan_type_id 
        FROM loan_application la 
        WHERE la.status = 'APPROVED'
    );	1464013698
SELECT 
    c.customer_name AS name,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) AS age,
    l.loan_amount AS loan_amount
FROM 
    customer c
JOIN 
    loan_application l ON c.id = l.customer_id
WHERE 
    EXTRACT(YEAR FROM l.apply_date) = 2023
ORDER BY 
    age DESC
LIMIT 5;	2417924945
SELECT COUNT(DISTINCT c.id) AS high_credit_customer_count
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_score > 0.75
AND c.province = '浙江省'
AND lc.credit_date <= '2023-06-30';	3366689482
SELECT rs_type_name AS classification_type, COUNT(*) AS count 
FROM five_level_classification 
WHERE data_dt = '2024-07-22' 
GROUP BY rs_type_name;	3973811473
SELECT f.rs_type_name AS classification_name, COUNT(ub.id) AS behavior_count 
FROM five_level_classification f
LEFT JOIN loan_detail_info l ON f.rs_type_id = l.judgelevel
LEFT JOIN customer c ON l.cust_id = c.id_number
LEFT JOIN user_behavior ub ON c.id = ub.customer_id
GROUP BY f.rs_type_name;	1905559813
SELECT 
    id AS transfer_id, 
    source_customer_id AS from_customer_id, 
    target_customer_id AS to_customer_id, 
    transfer_amount AS amount, 
    transfer_date AS transaction_date, 
    description AS transfer_notes 
FROM 
    transfer 
ORDER BY 
    transfer_date;	6017603
SELECT 
    card_type AS "卡种类代码", 
    card_type_nm AS "卡种类名称", 
    card_state AS "卡状态"
FROM debit_card_information 
WHERE cust_nm = 'James Taylor' 
AND bank_nm LIKE '%杭州上城区支行%' 
AND data_dt BETWEEN '2024-07-01' AND '2024-07-31';	2286869285
SELECT SUM(wealth_bal) AS total_usd_wealth_balance 
FROM financial_products 
WHERE data_dt = '2024-07-02' AND currency = 'USD';	1590803091
SELECT 
    c.id AS customer_id, 
    COUNT(ub.id) AS behavior_count, 
    (SELECT lc.credit_score 
     FROM loan_credit lc 
     WHERE lc.customer_id = c.id 
     ORDER BY lc.credit_date DESC 
     LIMIT 1) AS latest_credit_score
FROM 
    customer c
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
GROUP BY 
    c.id
ORDER BY 
    c.id;	3414285101
SELECT 
    t.transfer_amount AS transfer_amount,
    c1.customer_name AS source_customer_name,
    c2.customer_name AS target_customer_name
FROM 
    transfer t
JOIN 
    customer c1 ON t.source_customer_id = c1.id
JOIN 
    customer c2 ON t.target_customer_id = c2.id
WHERE 
    t.transfer_date = '2023-06-30' 
    AND t.transfer_amount > 1000;	3246518573
SELECT 
    id AS customer_id, 
    customer_name AS name, 
    id_number AS id_card, 
    phone_number AS phone, 
    email AS email_address, 
    address AS residence_address, 
    birth_date AS birth_date, 
    gender AS gender, 
    occupation_id AS occupation_id, 
    province AS province 
FROM customer 
WHERE customer_name = '饶丽';	104815069
SELECT d.card_no AS debit_card_number, d.cust_nm AS customer_name
FROM debit_card_information d
WHERE d.card_state = '正常' 
  AND d.data_dt = '2024-07-14'::timestamp;	3801446621
SELECT 
    l.cust_id AS customer_id,
    l.loan_balance AS loan_balance_amount,
    f.rs_type_name AS loan_risk_classification_name,
    c.curr_full_name AS currency_full_name
FROM 
    loan_detail_info l
JOIN 
    five_level_classification f ON l.judgelevel = f.rs_type_id
JOIN 
    currency c ON l.currency_type = c.curr_code
WHERE 
    l.dw_date = '2024-07-19'::timestamp 
    AND l.loan_balance > 500000
ORDER BY 
    l.loan_balance DESC;	368801370
SELECT COUNT(DISTINCT d.cust_no) AS male_customers_with_high_balance
FROM deposit_account_info d
JOIN bank_orgnization b ON d.org_no = b.bank_id
WHERE d.data_dt = '2024-07-19'::timestamp 
  AND b.bank_name LIKE '%沈阳%' 
  AND b.bank_level = '分行'
  AND d.gender_code = '1' 
  AND d.acct_bal > 100000;	852089580
SELECT 
    id AS loan_type_id, 
    loan_type_code AS type_code, 
    loan_type_name AS type_name, 
    description AS type_description 
FROM loan_type 
WHERE loan_type_name = '汽车贷款';	1377442693
SELECT 
    c.customer_name AS "客户姓名",
    la.loan_amount AS "贷款金额"
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
WHERE 
    la.loan_amount > 10000;	2349708736
SELECT 
    c.id AS customer_id,
    c.customer_name,
    COALESCE(SUM(d.acct_bal), 0) AS total_deposit_balance,
    COALESCE(AVG(lc.credit_score), 0) AS average_credit_score,
    COALESCE(SUM(lr.repayment_amount) / NULLIF(SUM(la.loan_amount), 0), 0) AS loan_repayment_ratio,
    (COALESCE(SUM(d.acct_bal), 0) * 0.4 + 
     COALESCE(AVG(lc.credit_score), 0) * 0.3 + 
     COALESCE(SUM(lr.repayment_amount) / NULLIF(SUM(la.loan_amount), 0), 0) * 0.3) AS composite_score
FROM 
    customer c
LEFT JOIN 
    deposit_account_info d ON c.id_number = d.cert_code
LEFT JOIN 
    loan_credit lc ON c.id = lc.customer_id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
GROUP BY 
    c.id, c.customer_name
ORDER BY 
    composite_score DESC
LIMIT 20;	3911124385
SELECT occupation_code AS "职业代码", description AS "职业描述" FROM occupation WHERE occupation_name LIKE '%护士%';	3773516021
SELECT 
    c.id AS customer_id, 
    c.customer_name, 
    ub.behavior_type, 
    ub.behavior_date, 
    lc.credit_score
FROM 
    customer c
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id 
    AND ub.behavior_date BETWEEN '2021-08-01' AND '2021-08-31'
LEFT JOIN 
    loan_credit lc ON c.id = lc.customer_id 
    AND lc.credit_date = (
        SELECT MAX(credit_date) 
        FROM loan_credit 
        WHERE customer_id = c.id AND credit_date <= '2021-08-31'
    )
WHERE 
    (ub.id IS NOT NULL OR lc.id IS NOT NULL)
ORDER BY 
    c.id, 
    ub.behavior_date;	1642595147
SELECT 
    lt.loan_type_name AS "贷款类型名称",
    ls.loan_status_name AS "贷款状态名称",
    lt.description AS "贷款类型描述",
    ls.description AS "贷款状态描述"
FROM 
    loan_type lt
CROSS JOIN 
    loan_status ls;	2547804030
SELECT b.bank_name AS jurisdiction_bank_name, SUM(f.wealth_bal) AS corporate_wealth_balance_total
FROM financial_products f
JOIN bank_orgnization b ON f.org_no = b.bank_id
WHERE f.cast_type = '对公' AND f.data_dt = '2024-07-02'::timestamp
GROUP BY b.bank_name;	1574302461
SELECT 
    c.id AS customer_id,
    lt.loan_type_name AS loan_type,
    la.loan_amount AS loan_amount,
    la.loan_term AS loan_term,
    la.apply_date AS apply_date,
    la.status AS application_status
FROM 
    loan_application la
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
JOIN 
    customer c ON la.customer_id = c.id
WHERE 
    la.apply_date BETWEEN '2019-01-01' AND '2019-12-31'
    AND lt.loan_type_name = '住房贷款'
    AND la.status = 'REJECTED';	576649992
SELECT cust_no AS customer_number, wealth_bal AS financial_product_balance
FROM financial_products 
WHERE data_dt = '2024-07-19' AND wealth_bal_f > 100000 
ORDER BY financial_product_balance DESC;	278921693
SELECT customer_name AS "客户姓名", email AS "电子邮箱地址" FROM customer;	2923698873
SELECT 
    c.customer_name,
    DATE_TRUNC('quarter', la.apply_date) AS quarter,
    ROUND(SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS current_quarter_success_rate,
    LAG(ROUND(SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), 1) OVER (PARTITION BY c.id ORDER BY DATE_TRUNC('quarter', la.apply_date)) AS previous_quarter_success_rate,
    ROUND(
        (ROUND(SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) - 
        LAG(ROUND(SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), 1) OVER (PARTITION BY c.id ORDER BY DATE_TRUNC('quarter', la.apply_date))) /
        NULLIF(LAG(ROUND(SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), 1) OVER (PARTITION BY c.id ORDER BY DATE_TRUNC('quarter', la.apply_date)), 0) * 100, 
    2) AS success_rate_change_percentage
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
GROUP BY 
    c.id, c.customer_name, DATE_TRUNC('quarter', la.apply_date)
ORDER BY 
    c.customer_name, quarter;	2256662449
SELECT DISTINCT d.cust_name, d.acct_bal 
FROM deposit_account_info d
WHERE d.cur_type = 'USD' 
AND d.data_dt = '2024-07-19'::timestamp
ORDER BY d.acct_bal DESC;	956063573
SELECT 
    customer_name AS 客户姓名, 
    id_number AS 身份证号码, 
    phone_number AS 手机号码, 
    email AS 电子邮件地址 
FROM 
    customer 
WHERE 
    birth_date > '1980-01-01';	568233943
SELECT 
    c.customer_name AS customer_name,
    o.occupation_name AS occupation,
    la.loan_amount AS loan_amount
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
JOIN 
    occupation o ON c.occupation_id = o.id
ORDER BY 
    la.loan_amount DESC
LIMIT 5;	665248378
SELECT 
    cust_type AS customer_category, 
    SUM(loan_balance) AS total_outstanding_loan 
FROM 
    loan_detail_info 
GROUP BY 
    cust_type;	1030650241
SELECT 
    COALESCE(SUM(CASE WHEN dai.re_aclg = '1' THEN dai.acct_bal ELSE 0 END), 0) AS total_current_balance,
    COALESCE(SUM(CASE WHEN dai.re_aclg = '2' THEN dai.acct_bal ELSE 0 END), 0) AS total_fixed_balance
FROM 
    debit_card_information dci
LEFT JOIN 
    deposit_account_info dai ON dci.cust_no = dai.cust_no AND dai.data_dt = '2023-06-30'::timestamp
JOIN 
    bank_orgnization bo ON dci.org_no = bo.bank_id
WHERE 
    bo.bank_name = '杭州上城区支行'
    AND dci.data_dt = '2023-06-30'::timestamp;	1979307069
AMBIGUOUS_QUERY	645950570
SELECT 
    customer_name AS "客户姓名",
    id_number AS "身份证号码", 
    phone_number AS "电话号码",
    email AS "电子邮箱",
    address AS "居住地址",
    birth_date AS "出生日期",
    gender AS "性别",
    o.occupation_name AS "职业名称",
    province AS "所在省份"
FROM customer c
LEFT JOIN occupation o ON c.occupation_id = o.id
WHERE id_number = 'c839d762-6392-4005-8386-ed4e2c50997a';	3312818819
SELECT 
    lc.credit_score AS credit_score,
    lc.description AS credit_description
FROM 
    loan_credit lc
WHERE 
    lc.credit_date = '2003-06-22';	527420496
SELECT 
    cust_name AS customer_name,
    acct_bal AS current_balance
FROM 
    deposit_account_info
WHERE 
    org_no = 'BANK_00301'
    AND data_dt = '2024-07-21'::timestamp
    AND acct_bal > 50000;	2918505586
SELECT 
    d.cust_id AS customer_id, 
    d.loan_balance AS outstanding_loan_balance, 
    COALESCE(a.acct_bal, 0) AS deposit_account_balance
FROM 
    loan_detail_info d 
LEFT JOIN 
    deposit_account_info a ON d.cust_id = a.cert_code 
WHERE 
    d.loan_balance > 10000;	1280121870
SELECT 
    f.rs_type_name AS classification_name,
    COUNT(DISTINCT l.cust_id) AS customer_count,
    SUM(l.loan_balance) AS total_loan_balance
FROM 
    loan_detail_info l
JOIN 
    five_level_classification f ON l.judgelevel = f.rs_type_id
GROUP BY 
    f.rs_type_name
ORDER BY 
    f.rs_type_name;	2006837077
SELECT deposit_name FROM deposit_type WHERE data_dt = '2024-07-22';	938785076
SELECT 
    id AS transfer_id, 
    source_customer_id AS sender_id, 
    target_customer_id AS receiver_id, 
    transfer_amount AS amount, 
    transfer_date AS transaction_date, 
    description AS transaction_description 
FROM 
    transfer 
WHERE 
    transfer_amount > 500;	182531082
SELECT 
    c.customer_name AS name, 
    c.id_number AS id_number, 
    lc.credit_score AS credit_score
FROM 
    customer c
JOIN 
    loan_credit lc ON c.id = lc.customer_id
WHERE 
    c.province = '河北省' 
    AND lc.credit_score > 0.8
ORDER BY 
    lc.credit_score DESC;	1098966204
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 20 AND 30 THEN '20-30岁'
        WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 31 AND 40 THEN '31-40岁'
        WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 41 AND 50 THEN '41-50岁'
        WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) > 50 THEN '51岁以上'
        ELSE '未知年龄'
    END AS age_group,
    lt.loan_type_name AS loan_type,
    COUNT(*) AS total_applications,
    ROUND(100.0 * SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
GROUP BY 
    age_group, loan_type
ORDER BY 
    age_group, loan_type;	2906434348
SELECT 
    ls.loan_status_name AS loan_status,
    o.occupation_name AS occupation
FROM 
    customer c
JOIN 
    occupation o ON c.occupation_id = o.id
JOIN 
    loan_application la ON c.id = la.customer_id
JOIN 
    loan_status ls ON la.status = ls.loan_status_code
WHERE 
    o.occupation_code = 'NURSE'
    AND ls.loan_status_name = 'Approved';	4018894094
SELECT 
    o.occupation_name AS occupation_name,
    COUNT(DISTINCT c.id) AS customer_count,
    AVG(l.loan_amount) AS avg_loan_amount
FROM 
    customer c
JOIN 
    occupation o ON c.occupation_id = o.id
LEFT JOIN 
    loan_application l ON c.id = l.customer_id
GROUP BY 
    o.occupation_name
HAVING 
    COUNT(DISTINCT c.id) > 100
ORDER BY 
    customer_count DESC;	2317494329
SELECT 
    f.cust_no AS customer_number,
    b.bank_name AS branch_name,
    f.currency AS currency_type,
    f.wealth_bal AS financial_product_balance
FROM 
    financial_products f
JOIN 
    bank_orgnization b ON f.org_no = b.bank_id
JOIN 
    currency c ON f.currency = c.curr_code
WHERE 
    f.data_dt = '2024-07-14'::timestamp
    AND b.bank_name = '沈阳余淮支行'
    AND f.cast_type = '非保本'
    AND c.curr_full_name = '新加坡元';	2459941756
SELECT id_number AS "身份证号", phone_number AS "手机号" FROM customer;	627241378
SELECT cust_nm AS customer_name, open_date AS account_opening_date 
FROM debit_card_information 
WHERE open_date >= '2024-07-05'::timestamp;	3818857737
WITH top_wealth_customers AS (
    SELECT cust_no, wealth_bal,
           NTILE(10) OVER (ORDER BY wealth_bal DESC) AS percentile
    FROM financial_products
    WHERE data_dt = (SELECT MAX(data_dt) FROM financial_products)
)
SELECT t.cust_no AS financial_customer_id
FROM top_wealth_customers t
JOIN user_behavior u ON t.cust_no = u.customer_id::text
WHERE t.percentile = 1
AND u.behavior_type = 'login'
AND u.behavior_date >= CURRENT_DATE - INTERVAL '30 days';	1788527678
SELECT 
    c.id AS customer_id,
    lc.credit_score AS credit_score,
    ub.description AS behavior_description
FROM customer c
LEFT JOIN loan_credit lc ON c.id = lc.customer_id AND lc.credit_date = '2023-12-10'
LEFT JOIN user_behavior ub ON c.id = ub.customer_id AND ub.behavior_date = '2023-12-10'
WHERE (lc.credit_score IS NOT NULL OR ub.description IS NOT NULL)
ORDER BY c.id;	1240825133
SELECT DISTINCT bank_id AS institution_id, bank_name AS institution_name FROM bank_orgnization;	1225880496
SELECT 
    lr.repayment_amount AS "还款金额",
    la.loan_amount AS "贷款金额"
FROM 
    loan_repayment lr
JOIN 
    loan_application la ON lr.loan_application_id = la.id
WHERE 
    lr.repayment_date = '2024-01-20';	1895296880
SELECT 
    c.curr_code AS currency_code,
    c.curr_full_name AS currency_name,
    COUNT(t.id) AS transfer_count
FROM 
    currency c
LEFT JOIN 
    transfer t ON t.description LIKE '%' || c.curr_code || '%'
WHERE 
    c.curr_class = '外币'
    AND c.data_dt = '2023-06-30'
    AND (t.transfer_date IS NULL OR t.transfer_date < '2023-06-30')
GROUP BY 
    c.curr_code, c.curr_full_name;	1454533076
SELECT repayment_amount 
FROM loan_repayment 
WHERE loan_application_id = 742969 
AND repayment_date = '2021-11-10';	3316681947
SELECT 
    dt.deposit_type_name AS deposit_type,
    AVG(ldi.loan_amount) AS average_loan_amount,
    STDDEV(ldi.loan_amount) AS loan_amount_stddev
FROM 
    loan_detail_info ldi
JOIN 
    deposit_account_info dai ON ldi.cust_id = dai.cust_no
JOIN 
    deposit_type dt ON dai.acct_type_code = dt.deposit_id
GROUP BY 
    dt.deposit_type_name;	2982717712
SELECT 
    c.customer_name AS 客户姓名,
    o.occupation_name AS 职业名称,
    lr.repayment_date AS 还款日期
FROM 
    customer c
JOIN 
    occupation o ON c.occupation_id = o.id
JOIN 
    loan_application la ON c.id = la.customer_id
JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id;	279794629
SELECT 
    lt.loan_type_name AS "贷款类型名称",
    AVG(la.loan_amount) AS "平均贷款金额",
    AVG(dai.acct_bal) AS "平均存款余额"
FROM 
    loan_type lt
LEFT JOIN 
    loan_application la ON lt.id = la.loan_type_id
LEFT JOIN 
    customer c ON la.customer_id = c.id
LEFT JOIN 
    deposit_account_info dai ON c.id_number = dai.cert_code
GROUP BY 
    lt.loan_type_name;	2733048479
SELECT COUNT(DISTINCT la.customer_id) AS rejected_customers_with_login_behavior
FROM loan_application la
JOIN user_behavior ub ON la.customer_id = ub.customer_id
WHERE la.apply_date = '2019-01-10' 
  AND la.status = 'REJECTED'
  AND ub.behavior_type = 'LOGIN'
  AND ub.behavior_date = '2017-10-24';	1486729335
SELECT 
    c.customer_name AS customer_name,
    la.loan_amount AS loan_amount
FROM 
    loan_application la
JOIN 
    loan_credit lc ON la.customer_id = lc.customer_id
JOIN 
    customer c ON la.customer_id = c.id
WHERE 
    EXTRACT(YEAR FROM la.apply_date) = 2019
    AND lc.credit_score > 0.8
ORDER BY 
    la.loan_amount DESC;	760463294
SELECT 
    reportid AS 贷款报告标识,
    cust_id AS 客户编号,
    cust_type AS 客户类型,
    iou_no AS 借据编号,
    loan_type AS 贷款类型,
    loan_orgno AS 贷款机构编号,
    vouch_type AS 担保类型,
    currency_type AS 币种类型,
    account_state AS 账户状态,
    loan_amount AS 贷款金额,
    loan_balance AS 贷款余额,
    blc_capital AS 本金余额,
    blc_inner AS 表内余额,
    blc_off AS 表外余额,
    judgelevel AS 五级分类等级,
    loandate_s AS 贷款开始日期,
    loandate_e AS 贷款结束日期
FROM 
    loan_detail_info
WHERE 
    loan_balance > 500000
ORDER BY 
    loan_balance DESC;	84990606
SELECT customer_id, credit_score 
FROM loan_credit 
WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	2524485514
SELECT customer_name AS "客户姓名", birth_date AS "出生日期" 
FROM customer 
WHERE birth_date >= '1990-01-01';	3030054295
SELECT 
    lc.customer_id AS customer_id,
    MAX(lc.credit_score) - MIN(lc.credit_score) AS credit_score_increase,
    MAX(lc.credit_score) AS current_credit_score
FROM 
    loan_credit lc
WHERE 
    lc.credit_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    lc.customer_id
ORDER BY 
    credit_score_increase DESC
LIMIT 5;	2842932086
SELECT behavior_type, COUNT(DISTINCT customer_id) AS user_count 
FROM user_behavior 
GROUP BY behavior_type;	2650630480
SELECT 
    dt.deposit_name AS deposit_type_name,
    COUNT(DISTINCT dai.cust_no) AS initial_customer_count,
    COUNT(DISTINCT CASE WHEN dai.data_dt >= CURRENT_DATE - INTERVAL '1 year' THEN dai.cust_no END) AS retained_customer_count,
    ROUND(COUNT(DISTINCT CASE WHEN dai.data_dt >= CURRENT_DATE - INTERVAL '1 year' THEN dai.cust_no END) * 100.0 / 
          NULLIF(COUNT(DISTINCT dai.cust_no), 0), 2) AS customer_retention_rate
FROM 
    deposit_account_info dai
JOIN 
    deposit_type dt ON dai.acct_type_code = dt.deposit_id
GROUP BY 
    dt.deposit_name
ORDER BY 
    customer_retention_rate DESC;	3532447015
SELECT SUM(t.transfer_amount) AS total_transfer_amount
FROM transfer t
JOIN customer c ON t.source_customer_id = c.id OR t.target_customer_id = c.id
JOIN bank_orgnization b ON c.province = '辽宁省' AND b.bank_name = '沈阳分行'
WHERE t.transfer_date = '2024-07-19';	2513228683
SELECT s.store_name, s.manager_name, SUM(ss.profit) AS total_profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-06'
GROUP BY s.store_name, s.manager_name
ORDER BY total_profit DESC
LIMIT 1;	3023054014
SELECT profit AS "盈利金额", sales_quantity AS "销售商品数量" FROM salesstatistics;	252107871
AMBIGUOUS_QUERY	2902085248
SELECT 
    e.name AS employee_name,
    e.position AS employee_position,
    s.store_name,
    SUM(so.total_amount) AS total_order_amount
FROM 
    employees e
JOIN 
    salesorders so ON e.employee_id = so.employee_id
JOIN 
    stores s ON e.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-05' 
    AND s.store_name = '数码广场店'
GROUP BY 
    e.name, e.position, s.store_name
HAVING 
    SUM(so.total_amount) > 7000;	1743968577
SELECT 
    s.statistic_id AS sales_statistic_id,
    st.store_name AS store_name,
    p.product_name AS product_name,
    e.name AS employee_name,
    s.date AS sales_date,
    s.sales_quantity AS quantity_sold,
    s.sales_amount AS total_amount,
    s.profit AS profit_amount
FROM 
    salesstatistics s
JOIN 
    stores st ON s.store_id = st.store_id
JOIN 
    products p ON s.product_id = p.product_id
JOIN 
    employees e ON s.employee_id = e.employee_id
ORDER BY 
    s.profit DESC
LIMIT 1;	3620145899
SELECT s.store_name, e.name AS employee_name, SUM(ss.sales_amount) AS total_sales_amount, p.product_name
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31'
AND p.supplier_name = '苹果官方旗舰店'
GROUP BY s.store_name, e.name, p.product_name, e.employee_id
HAVING SUM(ss.sales_amount) > 10000
ORDER BY total_sales_amount DESC;	2283742907
SELECT p.product_name AS "商品名称", p.supplier_name AS "供应商名称"
FROM products p
JOIN orderdetails od ON p.product_id = od.product_id
JOIN salesorders so ON od.order_id = so.order_id
JOIN stores s ON so.store_id = s.store_id
WHERE s.store_name = '电子城旗舰店'
GROUP BY p.product_name, p.supplier_name;	3238938312
SELECT s.store_name, e.name AS employee_name, e.position
FROM salesorders so
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN employees e ON so.employee_id = e.employee_id
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-09' 
AND p.product_name = 'iPad Air';	2878333594
SELECT s.store_name, s.manager_name
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-05'
GROUP BY s.store_name, s.manager_name
HAVING SUM(ss.sales_amount) > 10000;	754309478
SELECT e.name AS employee_name, SUM(so.total_amount) AS total_order_amount
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
WHERE so.order_date = '2023-05-07'
GROUP BY e.employee_id, e.name
HAVING SUM(so.total_amount) > 10000;	711957819
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
WHERE 
    ss.product_id IN (
        SELECT product_id 
        FROM products 
        WHERE product_name = '索尼WH-1000XM4'
    )
    AND ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, e.name
HAVING 
    SUM(ss.profit) > 5000;	1769127756
SELECT DISTINCT e.employee_id AS employee_unique_id, e.name AS employee_name
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = 'Nintendo Switch'
  AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
  AND so.total_amount > 5000;	435444064
SELECT p.product_name AS "商品名称", ss.profit AS "利润"
FROM salesstatistics ss
JOIN products p ON ss.product_id = p.product_id
WHERE ss.sales_amount = (SELECT MAX(sales_amount) FROM salesstatistics)
LIMIT 1;	2637911653
SELECT 
    od.order_detail_id AS "订单明细ID",
    p.product_name AS "商品名称",
    so.total_amount AS "订单总金额"
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    salesorders so ON od.order_id = so.order_id;	424774041
SELECT e.name AS employee_name, s.store_name AS store_name
FROM employees e
JOIN stores s ON e.store_id = s.store_id;	1958922267
SELECT s.store_name, s.manager_name, SUM(so.total_amount) AS total_sales_amount
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
WHERE so.order_date = '2023-05-08'
GROUP BY s.store_name, s.manager_name;	1850407582
SELECT s.order_id AS order_identifier, e.name AS employee_name
FROM salesorders s
JOIN employees e ON s.employee_id = e.employee_id
WHERE s.total_amount > 7000;	3887504470
SELECT 
    s.store_name AS "门店名称",
    e.name AS "员工姓名",
    SUM(ss.sales_amount) AS "销售总金额",
    p.product_name AS "商品名称"
FROM 
    salesstatistics ss
    JOIN stores s ON ss.store_id = s.store_id
    JOIN employees e ON ss.employee_id = e.employee_id
    JOIN products p ON ss.product_id = p.product_id
WHERE 
    ss.date BETWEEN '2023-05-01' AND '2023-05-31'
    AND p.supplier_name = '苹果官方旗舰店'
GROUP BY 
    s.store_name, 
    e.name, 
    p.product_name,
    s.store_id,
    e.employee_id,
    p.product_id
HAVING 
    SUM(ss.sales_amount) > 10000
ORDER BY 
    "销售总金额" DESC;	3068871934
AMBIGUOUS_QUERY	2869270561
SELECT 
    order_id AS "订单唯一标识", 
    store_id AS "所属门店标识", 
    employee_id AS "负责员工标识", 
    order_date AS "订单创建日期", 
    total_amount AS "订单总金额" 
FROM 
    salesorders 
WHERE 
    order_id = 'b8b62bfe-a35d-4ff5-9bc9-654b5f67fed2';	3219161296
SELECT 
    e.name AS employee_name, 
    SUM(so.total_amount) AS total_sales_amount
FROM 
    employees e
JOIN 
    salesorders so ON e.employee_id = so.employee_id
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    total_sales_amount DESC;	4084880534
SELECT 
    product_name AS "商品名称", 
    sale_price AS "销售价格", 
    purchase_price AS "采购价格" 
FROM 
    products;	758163770
SELECT 
    e.name AS employee_name, 
    s.manager_name AS store_manager_name
FROM 
    employees e
JOIN 
    salesorders so ON e.employee_id = so.employee_id
JOIN 
    stores s ON e.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    e.employee_id, e.name, s.manager_name
HAVING 
    SUM(so.total_amount) > 10000;	2553064409
AMBIGUOUS_QUERY	2558715347
SELECT s.store_name, e.name AS employee_name, p.product_name, ss.profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-07' AND p.product_name = 'Apple Watch Series 7';	2334672967
SELECT DISTINCT s.store_name, e.name AS manager_name
FROM stores s
JOIN employees e ON s.store_id = e.store_id AND e.position = '销售经理'
JOIN salesorders so ON s.store_id = so.store_id
WHERE so.order_date = '2023-05-05'
AND so.order_id IN (
    SELECT od.order_id
    FROM orderdetails od
    JOIN products p ON od.product_id = p.product_id
    WHERE p.sale_price > 5000
)
GROUP BY s.store_name, e.name
HAVING SUM(so.total_amount) > 10000;	3673770320
SELECT 
    od.order_detail_id AS "订单明细ID",
    p.product_name AS "商品名称",
    od.quantity AS "销售数量"
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id;	1434650665
SELECT 
    order_id AS "订单ID",
    store_id AS "门店ID",
    employee_id AS "员工ID",
    order_date AS "订单日期",
    total_amount AS "订单总金额"
FROM 
    salesorders
WHERE 
    store_id = '0887d06a-27a8-46b4-98d6-514702e698da';	4072489559
SELECT e.employee_id AS employee_unique_id, e.name AS employee_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM salesstatistics ss
    WHERE ss.employee_id = e.employee_id
    AND ss.date BETWEEN '2023-05-01' AND '2023-05-31'
    AND ss.sales_quantity > (
        SELECT COALESCE(SUM(od.quantity), 0)
        FROM orderdetails od
        JOIN salesorders so ON od.order_id = so.order_id
        WHERE so.employee_id = e.employee_id
        AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
    )
);	3987499786
SELECT s.store_name, e.name AS employee_name, SUM(so.total_amount) AS total_sales_amount
FROM salesorders so
JOIN employees e ON so.employee_id = e.employee_id
JOIN stores s ON so.store_id = s.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-01' AND p.product_name = 'iPad Air'
GROUP BY s.store_name, e.name;	3272650586
SELECT 
    p.product_name AS "商品名称",
    SUM(od.quantity) AS "销售总量",
    so.order_date AS "订单日期"
FROM 
    products p
JOIN 
    orderdetails od ON p.product_id = od.product_id
JOIN 
    salesorders so ON od.order_id = so.order_id
GROUP BY 
    p.product_name, so.order_date
ORDER BY 
    p.product_name, so.order_date;	1170763492
SELECT 
    s.store_name AS store_name,
    s.manager_name AS manager_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales_amount DESC
LIMIT 1;	3307597619
AMBIGUOUS_QUERY	2824509879
SELECT s.store_name, s.manager_name, SUM(so.total_amount) AS total_sales
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-07'
GROUP BY s.store_name, s.manager_name
ORDER BY total_sales DESC
LIMIT 1;	348511856
SELECT 
    s.store_name AS "门店名称", 
    e.name AS "员工姓名", 
    SUM(od.quantity * od.unit_price) AS "销售总金额"
FROM 
    stores s
    JOIN employees e ON s.store_id = e.store_id
    JOIN salesorders so ON e.employee_id = so.employee_id
    JOIN orderdetails od ON so.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
WHERE 
    so.order_date = '2023-05-01' 
    AND p.product_name = '索尼WH-1000XM4'
GROUP BY 
    s.store_name, e.name
HAVING 
    SUM(od.quantity * od.unit_price) > 8000;	3403500771
SELECT 
    product_id,
    purchase_price AS cost_price,
    sale_price AS retail_price
FROM 
    products;	1837973022
SELECT 
    product_id AS product_identifier, 
    unit_price AS sales_price, 
    quantity AS sales_quantity 
FROM 
    orderdetails;	1041289855
SELECT e.name AS employee_name, s.store_name AS store_name
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN stores s ON e.store_id = s.store_id
WHERE so.order_date = '2023-05-06'
AND p.product_name = 'Apple Watch Series 7';	2902800338
SELECT 
    s.store_name AS store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.sales_amount) AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
GROUP BY 
    s.store_name
ORDER BY 
    total_sales_quantity DESC
LIMIT 1;	2465572579
SELECT DISTINCT e.name AS employee_name, p.category_name AS product_category
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
AND so.total_amount > 10000
ORDER BY e.name, p.category_name;	4232056788
SELECT 
    e.name AS employee_name, 
    s.store_name, 
    SUM(so.total_amount) AS total_order_amount
FROM 
    employees e
JOIN 
    stores s ON e.store_id = s.store_id
JOIN 
    salesorders so ON e.employee_id = so.employee_id
GROUP BY 
    e.name, s.store_name
ORDER BY 
    e.name;	3813879652
SELECT 
    s.store_name AS store_name,
    s.manager_name AS manager_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, s.manager_name;	1308038325
SELECT 
    p.product_name AS product_name, 
    SUM(od.quantity) AS total_sales_quantity
FROM 
    products p
JOIN 
    orderdetails od ON p.product_id = od.product_id
JOIN 
    salesorders so ON od.order_id = so.order_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    p.product_name
HAVING 
    SUM(od.quantity) > 5;	3746071071
SELECT p.product_name AS "商品名称", 
       COALESCE(SUM(od.quantity), 0) AS "总销售数量", 
       p.sale_price AS "销售价格"
FROM products p
LEFT JOIN orderdetails od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name, p.sale_price
ORDER BY p.product_name;	2561670271
SELECT s.store_name, e.name AS manager_name, ss.profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id AND e.position = '销售经理'
JOIN products p ON ss.product_id = p.product_id AND p.product_name = '佳能EOS R6'
WHERE ss.date = '2023-05-01';	3159630797
SELECT store_name AS "门店名称", phone AS "联系电话", address AS "详细地址" FROM stores;	4216280203
SELECT so.order_id AS order_identifier, p.product_name AS product_name
FROM salesorders so
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.total_amount < 5000;	731373976
SELECT 
    s.store_name AS store_name,
    e.name AS sales_consultant_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
WHERE 
    ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, e.name
ORDER BY 
    total_sales_quantity DESC
LIMIT 1;	170942591
SELECT s.store_name, SUM(ss.profit) AS total_profit
FROM stores s
JOIN salesstatistics ss ON s.store_id = ss.store_id
JOIN products p ON ss.product_id = p.product_id
WHERE p.product_name = '小米电视4A'
AND ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY s.store_name;	3730467553
SELECT e.name AS employee_name, SUM(ss.profit) AS total_profit
FROM salesstatistics ss
JOIN employees e ON ss.employee_id = e.employee_id
JOIN stores s ON ss.store_id = s.store_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-06'
  AND s.store_name = '智慧街店'
  AND p.product_name = '小米电视4A'
GROUP BY e.name;	2909047140
SELECT store_name AS "门店名称", phone AS "联系电话" FROM stores;	2998787786
SELECT s.store_name AS "门店名称", s.manager_name AS "店长姓名"
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-08'
GROUP BY s.store_name, s.manager_name
HAVING SUM(ss.profit) > 1000;	3020408935
SELECT p.category_name AS category_name, SUM(od.quantity) AS total_sales_quantity
FROM products p
JOIN orderdetails od ON p.product_id = od.product_id
GROUP BY p.category_name;	3729612424
SELECT s.store_name AS store_name, e.name AS employee_name
FROM stores s
JOIN employees e ON s.store_id = e.store_id;	1558062721
SELECT order_id 
FROM salesorders 
WHERE total_amount > (SELECT AVG(total_amount) FROM salesorders);	3748358677
AMBIGUOUS_QUERY	281510090
SELECT 
    e.name AS employee_name, 
    s.order_date AS order_date, 
    s.total_amount AS order_total_amount
FROM 
    employees e
LEFT JOIN 
    salesorders s ON e.employee_id = s.employee_id
ORDER BY 
    e.name, s.order_date;	930082852
SELECT 
    e.name AS employee_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    employees e
JOIN 
    salesorders so ON e.employee_id = so.employee_id
GROUP BY 
    e.name;	874677465
SELECT 
    e.name AS employee_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.profit) AS total_profit
FROM 
    employees e
JOIN 
    salesstatistics ss ON e.employee_id = ss.employee_id
GROUP BY 
    e.name
ORDER BY 
    e.name;	1675790879
SELECT DISTINCT s.store_name
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = '佳能EOS R6'
  AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
  AND EXISTS (
    SELECT 1
    FROM salesorders so2
    JOIN orderdetails od2 ON so2.order_id = od2.order_id
    WHERE so2.store_id = s.store_id
      AND od2.product_id = p.product_id
      AND so2.order_date BETWEEN '2023-05-01' AND '2023-05-31'
    GROUP BY so2.store_id
    HAVING SUM(od2.quantity * od2.unit_price) > 10000
  );	1635802249
SELECT 
    s.store_name AS store_name,
    s.manager_name AS manager_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-05'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales_amount DESC
LIMIT 1;	2425848754
SELECT 
    s.store_name AS store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.sales_amount) AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
GROUP BY 
    s.store_name;	2746220287
SELECT 
    s.store_name AS store_name,
    s.manager_name AS manager_name,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales_quantity DESC
LIMIT 1;	4181874210
AMBIGUOUS_QUERY	1518878415
SELECT 
    od.order_detail_id AS "订单明细ID", 
    od.unit_price AS "销售单价"
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    p.product_name = 'Nintendo Switch';	729031894
SELECT 
    s.store_name AS store_name,
    SUM(ss.sales_amount) AS total_sales_amount,
    ss.date AS statistic_date
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
GROUP BY 
    s.store_name, ss.date
ORDER BY 
    s.store_name, ss.date;	415457057
SELECT p.product_name
FROM products p
JOIN salesstatistics ss ON p.product_id = ss.product_id
JOIN stores s ON ss.store_id = s.store_id
WHERE s.store_name = '未来城店' AND p.purchase_price > 4000;	2711834209
SELECT 
    s.store_name AS store_name,
    s.manager_name AS manager_name,
    SUM(so.total_amount) AS daily_sales_total
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-09'
GROUP BY 
    s.store_name, s.manager_name
HAVING 
    SUM(so.total_amount) > 10000;	1625040088
SELECT 
    s.store_name AS store_name,
    s.manager_name AS manager_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-02'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales_amount DESC
LIMIT 1;	3394370453
SELECT s.store_name, s.manager_name
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-09'
GROUP BY s.store_name, s.manager_name
HAVING SUM(so.total_amount) > 1000;	1323956071
SELECT DISTINCT e.name AS employee_name, p.category_name AS product_category
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
AND so.total_amount > 10000
ORDER BY e.name, p.category_name;	3696477446
SELECT s.store_name, SUM(ss.profit) AS total_profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
GROUP BY s.store_name;	4263762934
SELECT s.store_name, e.name AS employee_name, SUM(ss.sales_amount) AS total_sales_amount, p.product_name
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31'
AND p.supplier_name = '索尼官方旗舰店'
GROUP BY s.store_name, e.name, p.product_name
HAVING SUM(ss.sales_amount) > 10000
ORDER BY total_sales_amount DESC;	1452830768
SELECT 
    so.order_id AS order_identifier,
    so.total_amount AS order_total_amount,
    od.product_id AS product_identifier,
    od.quantity AS purchase_quantity
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
WHERE 
    so.total_amount > 5000;	4210000185
AMBIGUOUS_QUERY	2309159488
SELECT s.store_name, SUM(ss.sales_quantity) AS may_sales_quantity
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY s.store_name;	3856696435
SELECT 
    product_name AS "商品名称", 
    sale_price AS "销售价格", 
    purchase_price AS "采购价格" 
FROM 
    products;	3385775144
SELECT s.store_name, SUM(ss.sales_quantity) AS total_sales_quantity
FROM salesstatistics ss
JOIN products p ON ss.product_id = p.product_id
JOIN stores s ON ss.store_id = s.store_id
WHERE p.category_name = '智能手表' 
  AND p.supplier_name = '索尼官方旗舰店'
  AND ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY s.store_name
HAVING SUM(ss.sales_quantity) > 10;	898352649
SELECT s.store_name, s.manager_name, AVG(so.total_amount) AS avg_order_amount
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY s.store_name, s.manager_name
HAVING AVG(so.total_amount) > 10000;	1057968799
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    p.product_name AS product_name,
    ss.sales_quantity AS sales_quantity,
    ss.sales_amount AS sales_amount,
    ss.profit AS profit
FROM 
    salesstatistics ss
    JOIN stores s ON ss.store_id = s.store_id
    JOIN employees e ON ss.employee_id = e.employee_id
    JOIN products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-02' 
    AND p.product_name = 'iPad Air';	1042797521
AMBIGUOUS_QUERY	2349214824
SELECT 
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.sales_amount) AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name
ORDER BY 
    total_sales_quantity DESC
LIMIT 1;	1437353225
SELECT 
    s.store_name AS "门店名称", 
    e.name AS "员工姓名", 
    SUM(so.total_amount) AS "销售总金额"
FROM 
    stores s
    JOIN employees e ON s.store_id = e.store_id
    JOIN salesorders so ON e.employee_id = so.employee_id
    JOIN orderdetails od ON so.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
WHERE 
    so.order_date = '2023-05-09' 
    AND p.product_name = 'Apple Watch Series 7'
GROUP BY 
    s.store_name, e.name;	2159290753
SELECT 
    quantity AS sales_quantity,
    unit_price AS product_unit_price
FROM 
    orderdetails;	3028653636
SELECT DISTINCT s.store_name, e.name AS employee_name, e.position
FROM salesorders so
JOIN employees e ON so.employee_id = e.employee_id
JOIN stores s ON so.store_id = s.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = 'Nintendo Switch'
  AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	699540097
SELECT 
    s.statistic_id AS sales_record_id,
    st.store_name AS store_name,
    p.product_name AS product_name,
    e.name AS employee_name,
    s.date AS sales_date,
    s.sales_quantity AS quantity_sold,
    s.sales_amount AS total_amount,
    s.profit AS profit_amount
FROM 
    salesstatistics s
JOIN 
    stores st ON s.store_id = st.store_id
JOIN 
    products p ON s.product_id = p.product_id
JOIN 
    employees e ON s.employee_id = e.employee_id
WHERE 
    s.sales_quantity > 1;	1931659377
SELECT 
    s.store_name AS store_name,
    SUM(ss.profit) AS total_profit
FROM 
    stores s
JOIN 
    salesstatistics ss ON s.store_id = ss.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_name = 'Nintendo Switch'
    AND ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name;	3746361325
SELECT order_date AS "订单日期", total_amount AS "销售总额" FROM salesorders;	716876897
SELECT 
    s.store_name AS store_name,
    SUM(so.total_amount) AS total_sales_amount,
    COUNT(so.order_id) AS total_orders
FROM 
    stores s
LEFT JOIN 
    salesorders so ON s.store_id = so.store_id
GROUP BY 
    s.store_name;	2607128675
SELECT 
    order_detail_id AS "订单详情ID", 
    order_id AS "订单编号", 
    product_id AS "产品编号", 
    quantity AS "销售数量", 
    unit_price AS "单价" 
FROM 
    orderdetails 
WHERE 
    quantity = 2;	285217611
SELECT DISTINCT s.store_name, e.name AS employee_name, e.position
FROM salesorders so
JOIN employees e ON so.employee_id = e.employee_id
JOIN stores s ON so.store_id = s.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-01'
AND p.product_name = '戴尔灵越15';	780164755
SELECT 
    e.name AS employee_name,
    e.position AS job_title,
    s.store_name AS store_name
FROM 
    employees e
JOIN 
    stores s ON e.store_id = s.store_id;	936656745
SELECT s.store_name, e.name AS employee_name, SUM(ss.profit) AS total_profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE p.product_name = '佳能EOS R6'
  AND ss.date = '2023-05-03'
GROUP BY s.store_name, e.name;	1245782625
AMBIGUOUS_QUERY	1283619082
SELECT s.store_name, e.name AS employee_name, ss.sales_quantity
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-06' 
AND p.product_name = '华为Mate 40 Pro'
AND ss.sales_quantity > 1;	1656453304
SELECT 
    od.order_detail_id AS "订单明细ID",
    p.product_name AS "商品名称",
    od.quantity AS "销售数量"
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id;	366199293
SELECT 
    e.name AS employee_name, 
    e.position AS job_title, 
    s.phone AS store_contact_number
FROM 
    employees e
JOIN 
    stores s ON e.store_id = s.store_id;	3334478107
SELECT s.store_name, e.name AS employee_name, ss.sales_quantity
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-05' 
  AND p.product_name = '戴尔灵越15'
  AND ss.sales_quantity > 1;	4270219527
SELECT 
    so.order_id AS order_identifier,
    so.total_amount AS order_total_amount,
    od.product_id AS product_identifier,
    od.quantity AS purchase_quantity
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
WHERE 
    so.total_amount > 5000;	1514093143
SELECT 
    e.name AS employee_name, 
    s.order_id AS sales_order_id, 
    s.total_amount AS order_total_amount
FROM 
    employees e
JOIN 
    salesorders s ON e.employee_id = s.employee_id;	2669644548
SELECT statistic_id AS sales_statistic_id, date AS sales_date 
FROM salesstatistics 
WHERE profit > 3000 
ORDER BY sales_date DESC;	805828737
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    so.total_amount AS sales_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
WHERE 
    so.order_date = '2023-05-01'
    AND od.product_id = '4e4e9946-d36e-42fe-bc12-a0fff7357155'
    AND so.total_amount > 7000
GROUP BY 
    s.store_name, e.name, so.total_amount;	3997676800
SELECT 
    product_name AS "商品名称", 
    remaining_quantity AS "当前库存数量", 
    category_name AS "分类名称" 
FROM 
    products;	4161491201
SELECT DISTINCT 
    e.employee_id AS employee_unique_id, 
    e.name AS employee_name, 
    e.position AS employee_position
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-07' 
AND p.category_name = '相机' 
AND so.total_amount > 15000;	1127435173
AMBIGUOUS_QUERY	2902593996
SELECT 
    s.store_name AS store_name,
    s.manager_name AS manager_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-08'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales_amount DESC
LIMIT 1;	3388599532
SELECT 
    e.name AS employee_name,
    SUM(od.quantity) AS nintendo_switch_sales_quantity,
    SUM(od.quantity * od.unit_price) AS nintendo_switch_sales_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.store_id = '95eead28-167c-4b82-8c1d-b7e537f2968f'
    AND so.order_date = '2023-05-03'
    AND p.product_name = 'Nintendo Switch'
GROUP BY 
    e.name;	4098005311
SELECT s.store_name, e.name AS employee_name
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-05'
  AND p.product_name = '戴森V11'
  AND ss.profit > 500
GROUP BY s.store_name, e.name
ORDER BY s.store_name, e.name;	923028298
SELECT s.store_name AS "门店名称", s.manager_name AS "店长姓名"
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-09'
GROUP BY s.store_name, s.manager_name
HAVING SUM(so.total_amount) > 2000;	1361891626
SELECT s.store_name, s.manager_name
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-01'
GROUP BY s.store_name, s.manager_name
HAVING SUM(so.total_amount) > 10000;	1630147030
AMBIGUOUS_QUERY	3263175989
AMBIGUOUS_QUERY	378330460
SELECT store_name AS "门店名称", address AS "详细地址", phone AS "联系电话" FROM stores;	4052285642
SELECT s.store_name, e.name AS employee_name, so.total_amount
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
JOIN employees e ON so.employee_id = e.employee_id
WHERE so.order_date = '2023-05-02' AND so.total_amount > 2000;	1549729846
SELECT 
    store_id AS store_identifier,
    SUM(sales_quantity) AS total_sales_quantity,
    SUM(profit) AS total_profit
FROM 
    salesstatistics
GROUP BY 
    store_id;	3935894550
SELECT 
    s.store_name AS "门店名称",
    ss.total_profit AS "销售利润金额",
    s.manager_name AS "店长姓名"
FROM 
    stores s
JOIN (
    SELECT 
        store_id, 
        SUM(profit) AS total_profit 
    FROM 
        salesstatistics 
    WHERE 
        date = '2023-05-07' 
    GROUP BY 
        store_id 
    HAVING 
        SUM(profit) > 1000
) ss ON s.store_id = ss.store_id;	3331362186
SELECT s.store_name AS store_name, 
       s.manager_name AS manager_name, 
       SUM(ss.sales_quantity) AS total_sales_quantity
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-08'
GROUP BY s.store_name, s.manager_name
ORDER BY total_sales_quantity DESC
LIMIT 1;	1128623969
SELECT s.store_id, SUM(ss.profit) AS total_profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-09'
GROUP BY s.store_id
ORDER BY total_profit DESC
LIMIT 1;	2501471268
SELECT s.store_name AS "门店名称", e.name AS "员工姓名", SUM(so.total_amount) AS "销售总金额"
FROM stores s
JOIN employees e ON s.store_id = e.store_id
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = '佳能EOS R6'
  AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY s.store_name, e.name
HAVING SUM(so.total_amount) > 5000;	1462073315
SELECT DISTINCT s.store_name, e.name AS employee_name, e.position
FROM salesorders so
JOIN employees e ON so.employee_id = e.employee_id
JOIN stores s ON so.store_id = s.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = 'iPad Air'
  AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	1581647710
SELECT category_name AS "商品类别", sale_price AS "销售价格" FROM products;	801232665
SELECT s.store_name, COUNT(DISTINCT e.employee_id) AS manager_count
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
JOIN employees e ON s.store_id = e.store_id
WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
AND e.position = '销售经理'
GROUP BY s.store_id, s.store_name
HAVING SUM(so.total_amount) > 10000;	456965504
SELECT p.product_name AS "商品名称",
       p.remaining_quantity AS "当前库存数量",
       COALESCE(SUM(od.quantity), 0) AS "已销售数量"
FROM products p
LEFT JOIN orderdetails od ON p.product_id = od.product_id
LEFT JOIN salesorders so ON od.order_id = so.order_id
GROUP BY p.product_id, p.product_name, p.remaining_quantity;	3382493010
SELECT 
    order_id AS "订单ID", 
    order_date AS "下单日期", 
    total_amount AS "订单总金额" 
FROM 
    salesorders;	571189478
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    p.product_name AS product_name,
    ss.sales_quantity AS sales_quantity
FROM 
    salesstatistics ss
    JOIN stores s ON ss.store_id = s.store_id
    JOIN employees e ON ss.employee_id = e.employee_id
    JOIN products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-06'
    AND p.product_name = '华为Mate 40 Pro'
    AND ss.sales_quantity > 1;	3197967117
SELECT 
    s.store_name AS store_name, 
    e.name AS employee_name, 
    e.position AS employee_position
FROM 
    stores s
JOIN 
    employees e ON s.store_id = e.store_id
ORDER BY 
    s.store_name, 
    e.name;	426781097
SELECT e.name AS employee_name, SUM(ss.sales_amount) AS total_sales_amount
FROM salesstatistics ss
JOIN employees e ON ss.employee_id = e.employee_id
JOIN stores s ON ss.store_id = s.store_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-01'
AND s.store_name = '创客空间店'
AND p.product_name = '华为Mate 40 Pro'
GROUP BY e.name;	3095201302
SELECT s.store_name, e.name AS employee_name, e.position
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
WHERE ss.product_id = '35710343-90e8-47c1-9546-5abcff309bbd'
  AND ss.date BETWEEN '2023-05-01' AND '2023-05-31';	3814813462
SELECT 
    od.product_id AS product_unique_id, 
    p.product_name AS product_name, 
    od.quantity AS purchase_quantity
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id;	609043667
SELECT DISTINCT e.employee_id AS employee_identifier, e.name AS employee_name
FROM employees e
JOIN salesstatistics ss ON e.employee_id = ss.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-06' 
  AND ss.sales_quantity > 1 
  AND p.supplier_name = '戴尔官方旗舰店';	1259543351
SELECT product_name AS "商品名称", sale_price AS "销售价格" FROM products;	3115466033
SELECT store_name AS "门店名称", manager_name AS "店长姓名", phone AS "联系电话" FROM stores;	1445435683
SELECT so.total_amount AS "销售订单总金额", s.store_name AS "门店名称"
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.employee_id = 'd7a2363e-d8fb-498a-a892-4249d6f17b0d' 
AND so.order_date = '2023-05-07';	1024575513
SELECT s.store_name, SUM(ss.sales_amount) AS total_sales_amount
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN products p ON ss.product_id = p.product_id
WHERE p.product_name = 'Apple Watch Series 7'
  AND ss.date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY s.store_name
HAVING SUM(ss.sales_amount) > 10000;	1356118157
SELECT 
    s.store_name AS store_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name;	2779355161
SELECT s.store_name AS store_name, s.manager_name AS manager_name FROM stores s;	3800488480
SELECT product_name AS "商品名称", sale_price AS "销售单价", remaining_quantity AS "剩余数量" FROM products;	52927163
AMBIGUOUS_QUERY	4140737645
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    SUM(od.quantity * od.unit_price) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
WHERE 
    so.order_date = '2023-05-08'
    AND od.product_id = 'f5e347cb-f674-4e33-834c-4d0760682240'
GROUP BY 
    s.store_name, e.name
HAVING 
    SUM(od.quantity * od.unit_price) > 15000;	3812947992
SELECT s.store_name, s.manager_name, SUM(ss.sales_quantity) AS total_sales_quantity
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-09'
GROUP BY s.store_name, s.manager_name
ORDER BY total_sales_quantity DESC
LIMIT 1;	2237439168
SELECT SUM(profit) AS total_profit FROM salesstatistics;	3083869006
AMBIGUOUS_QUERY	106112262
SELECT s.store_name, SUM(ss.sales_quantity) AS total_sales_quantity
FROM salesstatistics ss
JOIN employees e ON ss.employee_id = e.employee_id
JOIN stores s ON ss.store_id = s.store_id
WHERE e.name = '黄萍'
  AND ss.date >= '2023-05-01'
  AND ss.date <= '2023-05-31'
GROUP BY s.store_name
ORDER BY total_sales_quantity DESC
LIMIT 1;	886303610
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    ss.profit AS sales_profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-08' 
AND p.product_name = 'Nintendo Switch';	1529918379
SELECT s.store_name, e.name AS employee_name, so.total_amount
FROM salesorders so
JOIN employees e ON so.employee_id = e.employee_id
JOIN stores s ON so.store_id = s.store_id
JOIN orderdetails od ON so.order_id = od.order_id
WHERE so.order_date = '2023-05-05' 
AND od.product_id = 'f5e347cb-f674-4e33-834c-4d0760682240';	3470071233
SELECT e.name AS employee_name, 
       e.position AS employee_position,
       p.product_name AS sold_product_name
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-05'
  AND p.supplier_name = '小米官方旗舰店'
  AND s.store_name = '智能生活馆'
GROUP BY e.name, e.position, p.product_name;	616988720
SELECT s.store_name AS "门店名称", s.manager_name AS "店长姓名"
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-07'
GROUP BY s.store_name, s.manager_name
ORDER BY SUM(ss.profit) DESC
LIMIT 1;	4131869213
SELECT 
    s.store_name AS "门店名称",
    e.name AS "员工姓名",
    p.product_name AS "产品名称",
    ss.profit AS "销售利润"
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-09' 
    AND p.product_name = '索尼WH-1000XM4';	2632379040
AMBIGUOUS_QUERY	1347772939
SELECT s.store_name, SUM(so.total_amount) AS total_sales_amount
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-03'
GROUP BY s.store_name;	2314844420
SELECT 
    order_detail_id AS "订单明细ID", 
    order_id AS "订单ID", 
    product_id AS "产品ID", 
    quantity AS "销售数量", 
    unit_price AS "单价" 
FROM 
    orderdetails 
WHERE 
    quantity > 1;	1029843679
AMBIGUOUS_QUERY	973958071
SELECT 
    s.order_id AS order_identifier, 
    s.total_amount AS transaction_amount, 
    st.store_name AS store_name
FROM 
    salesorders s
JOIN 
    stores st ON s.store_id = st.store_id
WHERE 
    s.order_date = '2023-05-05';	3235376159
SELECT p.product_name AS product_name, od.order_id AS order_id 
FROM orderdetails od
JOIN products p ON od.product_id = p.product_id
WHERE od.quantity > 1;	590339570
SELECT 
    order_id AS "订单编号", 
    order_date AS "下单日期", 
    total_amount AS "订单总金额"
FROM 
    salesorders 
WHERE 
    order_date BETWEEN '2023-05-01' AND '2023-05-31'
ORDER BY 
    order_date;	947155024
SELECT 
    employee_id,
    SUM(sales_quantity) AS total_sales_quantity 
FROM 
    salesstatistics 
GROUP BY 
    employee_id;	143868964
SELECT 
    category_name AS category, 
    remaining_quantity AS current_stock 
FROM 
    products;	801054820
SELECT 
    e.name AS employee_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    s.store_name AS store_name
FROM 
    employees e
JOIN 
    salesstatistics ss ON e.employee_id = ss.employee_id
JOIN 
    stores s ON e.store_id = s.store_id
GROUP BY 
    e.name, s.store_name;	956049949
SELECT order_id AS order_identifier, product_id AS product_identifier FROM orderdetails;	1812261268
AMBIGUOUS_QUERY	573573963
AMBIGUOUS_QUERY	2726627092
SELECT DISTINCT e.name AS employee_name
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = 'Apple Watch Series 7'
AND p.supplier_name = '任天堂官方旗舰店'
AND so.order_date = '2023-05-09';	3682087832
SELECT 
    s.total_amount AS order_total_amount, 
    st.store_name AS store_name
FROM 
    salesorders s
JOIN 
    stores st ON s.store_id = st.store_id
WHERE 
    s.order_date = '2023-05-06';	994704464
AMBIGUOUS_QUERY	2258930244
SELECT e.name AS employee_name, 
       s.store_name AS store_name, 
       p.product_name AS product_name, 
       SUM(ss.sales_amount) AS order_total_amount
FROM employees e
JOIN salesstatistics ss ON e.employee_id = ss.employee_id
JOIN products p ON ss.product_id = p.product_id
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-07'
  AND s.store_name = '智慧街店'
  AND p.product_name = '佳能EOS R6相机'
GROUP BY e.name, s.store_name, p.product_name;	251367692
SELECT 
    s.store_name AS store_name,
    SUM(od.quantity) AS total_sales_quantity,
    SUM(od.quantity * od.unit_price) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    stores s ON so.store_id = s.store_id
GROUP BY 
    s.store_name;	4178948313
SELECT 
    s.store_name AS "门店名称", 
    e.name AS "员工姓名", 
    SUM(so.total_amount) AS "订单总金额"
FROM 
    stores s
    JOIN employees e ON s.store_id = e.store_id
    JOIN salesorders so ON e.employee_id = so.employee_id
    JOIN orderdetails od ON so.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
WHERE 
    so.order_date = '2023-05-05' 
    AND p.product_name = '佳能EOS R6'
GROUP BY 
    s.store_name, 
    e.name;	635779591
SELECT 
    product_id AS "商品ID",
    product_name AS "商品名称",
    category_name AS "商品分类",
    purchase_price AS "进货价格",
    sale_price AS "销售价格",
    remaining_quantity AS "库存数量",
    supplier_name AS "供应商名称",
    description AS "商品描述"
FROM 
    products
WHERE 
    sale_price > 15000;	2326522926
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    p.product_name AS product_name,
    ss.sales_quantity AS sales_quantity
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-08' 
    AND p.product_name = '索尼WH-1000XM4'
    AND ss.sales_quantity > 1;	845825777
SELECT 
    s.store_name AS "门店名称",
    e.name AS "员工姓名",
    p.product_name AS "商品名称",
    ss.sales_amount AS "销售金额"
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-01' 
    AND ss.sales_amount > 1000 
    AND p.supplier_name = '戴森官方旗舰店';	1519890808
AMBIGUOUS_QUERY	624803127
SELECT s.store_name, SUM(so.total_amount) AS total_sales_amount
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
GROUP BY s.store_name;	4067103855
AMBIGUOUS_QUERY	2670659765
SELECT 
    s.order_id AS "订单ID", 
    s.order_date AS "订单日期", 
    e.name AS "员工姓名"
FROM 
    salesorders s
JOIN 
    employees e ON s.employee_id = e.employee_id;	4067388605
SELECT product_name AS "商品名称", supplier_name AS "供应商名称" FROM products;	383590974
SELECT product_name AS "商品名称", sale_price AS "售价", supplier_name AS "供应商名称" FROM products;	4056403376
SELECT 
    od.order_detail_id AS "订单明细ID", 
    p.product_name AS "商品名称", 
    od.unit_price AS "商品单价"
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id;	3670992366
SELECT 
    s.store_name AS store_name,
    s.phone AS contact_phone
FROM 
    stores s
JOIN 
    salesorders so ON s.store_id = so.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, s.phone
HAVING 
    SUM(so.total_amount) > 3000;	2335581270
SELECT s.store_name AS store_name, s.manager_name AS manager_name FROM stores s;	2535524828
SELECT e.name AS employee_name, s.phone AS store_phone
FROM employees e
JOIN stores s ON e.store_id = s.store_id;	120259515
SELECT e.name AS employee_name, ss.sales_quantity, ss.profit
FROM salesstatistics ss
JOIN employees e ON ss.employee_id = e.employee_id
JOIN stores s ON ss.store_id = s.store_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-09' 
  AND s.store_name = '创新路专卖店' 
  AND p.product_name = 'iPad Air';	1670319692
SELECT e.name AS employee_name, 
       e.position AS employee_position, 
       s.store_name AS store_name, 
       SUM(so.total_amount) AS total_order_amount
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN stores s ON e.store_id = s.store_id
WHERE so.order_date = '2023-05-07' 
  AND s.store_name = '未来城店'
GROUP BY e.name, e.position, s.store_name
HAVING SUM(so.total_amount) > 15000;	4086419825
SELECT product_name AS "商品名称", (sale_price - purchase_price) AS "售价与进货价差异" FROM products;	3256730396
SELECT s.store_name, s.manager_name
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY s.store_id, s.store_name, s.manager_name
HAVING SUM(so.total_amount) > 10000;	2107889479
SELECT 
    s.store_name AS store_name,
    SUM(ss.profit) AS total_profit,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    stores s
JOIN 
    salesstatistics ss ON s.store_id = ss.store_id
GROUP BY 
    s.store_name;	595252998
SELECT 
    order_id AS "订单ID", 
    store_id AS "门店ID", 
    employee_id AS "员工ID", 
    order_date AS "订单日期", 
    total_amount AS "订单总金额" 
FROM 
    salesorders 
WHERE 
    store_id = '64921abb-1d54-4e03-a15e-ea42f058f31c';	2271451016
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    p.product_name AS product_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.order_date = '2023-05-06'
    AND p.product_name = '小米电视4A'
GROUP BY 
    s.store_name, e.name, p.product_name
HAVING 
    SUM(so.total_amount) > 10000;	3431877623
SELECT DISTINCT s.store_name
FROM stores s
JOIN salesstatistics ss ON s.store_id = ss.store_id
JOIN products p ON ss.product_id = p.product_id
WHERE p.product_name = 'Nintendo Switch'
  AND ss.date BETWEEN '2023-05-01' AND '2023-05-31'
  AND ss.profit > 1000;	1818716672
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    ss.sales_quantity AS sales_quantity,
    ss.sales_amount AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-09'
    AND p.product_name = '索尼WH-1000XM4';	3062953566
AMBIGUOUS_QUERY	3908942610
SELECT s.store_name, s.manager_name, SUM(so.total_amount) AS total_sales
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-03'
GROUP BY s.store_name, s.manager_name
ORDER BY total_sales DESC
LIMIT 1;	208218356
SELECT 
    s.store_name AS store_name,
    s.manager_name AS manager_name,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date = '2023-05-03'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales_quantity DESC
LIMIT 1;	4174482566
SELECT s.store_name, e.name AS employee_name, ss.sales_amount AS total_amount
FROM salesstatistics ss
JOIN employees e ON ss.employee_id = e.employee_id
JOIN stores s ON ss.store_id = s.store_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-01'
AND p.product_name = 'iPad Air';	1762340720
SELECT 
    s.store_id AS store_identifier,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    stores s
LEFT JOIN 
    salesorders so ON s.store_id = so.store_id
GROUP BY 
    s.store_id;	1734342716
SELECT e.position AS position, COUNT(so.order_id) AS order_count
FROM employees e
LEFT JOIN salesorders so ON e.employee_id = so.employee_id
GROUP BY e.position, e.employee_id;	3698654694
AMBIGUOUS_QUERY	3114650274
SELECT s.store_name AS store_name, 
       s.manager_name AS manager_name, 
       SUM(so.total_amount) AS total_sales_amount
FROM salesorders so
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY s.store_name, s.manager_name
HAVING SUM(so.total_amount) > 10000;	2085424302
SELECT DISTINCT s.store_name
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-02'
AND p.supplier_name = '华为官方旗舰店'
GROUP BY s.store_name, so.order_id
HAVING SUM(od.quantity * od.unit_price) > 10000;	662177839
AMBIGUOUS_QUERY	3976972213
AMBIGUOUS_QUERY	783788015
SELECT 
    s.store_name AS highest_sales_store,
    s.manager_name AS store_manager,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-04'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales_amount DESC
LIMIT 1;	2306528451
SELECT DISTINCT s.store_name, e.name AS employee_name, e.position
FROM salesorders so
JOIN orderdetails od ON so.order_id = od.order_id
JOIN stores s ON so.store_id = s.store_id
JOIN employees e ON so.employee_id = e.employee_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = '华为Mate 40 Pro'
  AND so.order_date = '2023-05-01';	1834111948
SELECT e.name AS employee_name, s.manager_name AS store_manager_name
FROM salesstatistics ss
JOIN employees e ON ss.employee_id = e.employee_id
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-06' AND ss.sales_amount > 10000;	1718600359
SELECT 
    s.store_name AS store_name,
    e.name AS employee_name,
    so.total_amount AS order_total_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    p.product_name = '戴尔灵越15'
    AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
    AND so.total_amount > 5000
ORDER BY 
    s.store_name, e.name;	2900121322
SELECT product_id AS "商品ID", remaining_quantity AS "当前库存数量", sale_price AS "销售价格" FROM products;	1605466649
SELECT 
    s.store_name AS store_name, 
    COUNT(e.employee_id) AS employee_count
FROM 
    stores s
LEFT JOIN 
    employees e ON s.store_id = e.store_id
GROUP BY 
    s.store_name;	330758085
SELECT 
    e.name AS employee_name, 
    e.position AS employee_position, 
    ss.sales_quantity AS sales_quantity
FROM 
    salesstatistics ss
    JOIN employees e ON ss.employee_id = e.employee_id
    JOIN stores s ON ss.store_id = s.store_id
    JOIN products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-05'
    AND s.store_name = '科技中心店'
    AND p.product_name = '戴森V11'
    AND ss.sales_quantity > 1;	1887568974
SELECT s.order_id AS "订单编号", s.total_amount AS "订单总金额"
FROM salesorders s
JOIN stores st ON s.store_id = st.store_id
WHERE st.store_name = '数码广场店';	1544829110
SELECT 
    ra.assessment_id AS "风险评估ID",
    ra.risk_level AS "风险等级", 
    ra.impact_score AS "影响程度评分",
    re.event_type AS "风险事件类型",
    re.event_description AS "风险事件描述"
FROM 
    risk_assessments ra
JOIN 
    risk_events re ON ra.event_id = re.event_id
WHERE 
    ra.risk_level = '高' 
    AND ra.impact_score > 8;	1389319035
SELECT 
    event_id AS risk_event_id
FROM 
    risk_events
WHERE 
    event_type = '合规风险';	955757206
SELECT 
    re.event_description AS 风险事件描述,
    a.status AS 预警状态,
    au.audit_result AS 审核结果,
    au.audit_comments AS 审核意见
FROM 
    risk_events re
JOIN 
    alerts a ON re.event_id = a.event_id
LEFT JOIN 
    audit_logs au ON a.alert_id = au.alert_id
WHERE 
    a.alert_type = '欺诈嫌疑';	1687223871
SELECT 
    rr.report_type AS report_type,
    AVG(re.severity) AS avg_severity
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.approval_status = 'approved'
GROUP BY 
    rr.report_type;	948809000
SELECT 
    risk_level AS "风险等级", 
    COUNT(*) AS "客户数量", 
    AVG(credit_score) AS "平均信用评分" 
FROM 
    customers 
GROUP BY 
    risk_level 
ORDER BY 
    risk_level;	2131857844
SELECT 
    ri.indicator_id AS indicator_identifier,
    ri.indicator_name AS indicator_name,
    rml.monitoring_date AS monitoring_date,
    rml.actual_value AS monitored_value
FROM 
    risk_indicators ri
LEFT JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
WHERE 
    rml.monitoring_date >= '2023-10-01' 
    AND rml.monitoring_date < '2023-11-01';	1810509227
SELECT 
    report_id AS "报告ID",
    report_date AS "报告日期",
    author AS "作者",
    event_id AS "关联风险事件ID"
FROM 
    risk_reports
WHERE 
    approval_status = '已批准'
LIMIT 100;	2704266530
SELECT 
    c.risk_level AS "客户风险等级",
    t.transaction_type AS "交易类型",
    CASE 
        WHEN t.amount < 1000 THEN '0-999'
        WHEN t.amount >= 1000 AND t.amount < 5000 THEN '1000-4999'
        WHEN t.amount >= 5000 AND t.amount < 10000 THEN '5000-9999'
        ELSE '10000及以上'
    END AS "金额区间",
    COUNT(*) AS "交易次数",
    AVG(t.risk_score) AS "平均风险评分"
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.risk_level, 
    t.transaction_type,
    CASE 
        WHEN t.amount < 1000 THEN '0-999'
        WHEN t.amount >= 1000 AND t.amount < 5000 THEN '1000-4999'
        WHEN t.amount >= 5000 AND t.amount < 10000 THEN '5000-9999'
        ELSE '10000及以上'
    END
ORDER BY 
    c.risk_level, 
    t.transaction_type,
    "金额区间";	3816194798
AMBIGUOUS_QUERY	3476903471
SELECT 
    r.report_id AS "报告ID",
    r.report_type AS "报告类型",
    re.event_description AS "事件描述",
    ra.risk_level AS "风险等级"
FROM 
    risk_reports r
JOIN 
    risk_events re ON r.event_id = re.event_id
LEFT JOIN 
    risk_assessments ra ON r.event_id = ra.event_id
WHERE 
    r.author = '周婷';	451357687
SELECT 
    report_id AS "报告ID",
    report_date AS "报告日期",
    author AS "作者",
    approval_status AS "审批状态"
FROM 
    risk_reports
WHERE 
    report_date >= '2023-01-01';	880512967
SELECT 
    re.event_id AS "风险事件ID",
    re.event_description AS "风险事件描述",
    ra.risk_level AS "风险等级",
    ra.impact_score AS "影响程度评分",
    ra.probability_score AS "发生概率评分",
    ra.mitigation_plan AS "缓解措施方案"
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    re.event_description LIKE '%系统%';	4205370122
SELECT 
    ri.indicator_id AS "风险指标ID",
    ri.indicator_name AS "风险指标名称",
    current_data.actual_value AS "当前数值",
    past_data.actual_value AS "30天前数值",
    CASE 
        WHEN past_data.actual_value = 0 OR past_data.actual_value IS NULL THEN NULL
        ELSE ROUND(((current_data.actual_value - past_data.actual_value) / past_data.actual_value) * 100, 2)
    END AS "变化百分比"
FROM 
    risk_indicators ri
LEFT JOIN (
    SELECT 
        indicator_id, 
        actual_value,
        monitoring_date
    FROM 
        risk_monitoring_logs
    WHERE 
        (indicator_id, monitoring_date) IN (
            SELECT 
                indicator_id, 
                MAX(monitoring_date)
            FROM 
                risk_monitoring_logs
            GROUP BY 
                indicator_id
        )
) current_data ON ri.indicator_id = current_data.indicator_id
LEFT JOIN (
    SELECT 
        indicator_id, 
        actual_value,
        monitoring_date
    FROM 
        risk_monitoring_logs
    WHERE 
        (indicator_id, monitoring_date) IN (
            SELECT 
                indicator_id, 
                MAX(monitoring_date)
            FROM 
                risk_monitoring_logs
            WHERE 
                monitoring_date <= CURRENT_TIMESTAMP - INTERVAL '30 days'
            GROUP BY 
                indicator_id
        )
) past_data ON ri.indicator_id = past_data.indicator_id
WHERE 
    current_data.actual_value IS NOT NULL
    OR past_data.actual_value IS NOT NULL;	2721513399
SELECT 
    re.event_id AS "风险事件ID",
    re.event_description AS "事件描述",
    ra.risk_level AS "风险等级",
    ra.mitigation_plan AS "缓解计划"
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    (ra.risk_level = '高风险' OR ra.risk_level = 'High Risk')
    AND ra.assessor LIKE '%曾%';	1697295436
SELECT DISTINCT c.customer_name AS customer_name
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.transaction_type = '投资' AND t.risk_score > 60;	2228217319
SELECT 
    event_id AS "风险事件ID", 
    occurrence_time AS "发生时间", 
    status AS "当前状态" 
FROM risk_events;	1939667217
SELECT 
    c.customer_name AS customer_name,
    t.risk_score AS transaction_risk_score
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.credit_score < 600;	2175309220
SELECT t.amount AS transaction_amount, c.customer_name AS customer_name
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
WHERE t.status = '成功' 
  AND t.transaction_date >= '2023-12-01' 
  AND t.transaction_date < '2024-01-01';	1016775966
SELECT alert_type AS "预警类型", alert_content AS "预警内容" FROM alerts;	629791557
SELECT 
    report_id AS "风险报告ID", 
    report_type AS "报告类型", 
    approved_by AS "审批人" 
FROM 
    risk_reports;	4191869630
SELECT 
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = '成功' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate_percentage,
    AVG(risk_score) AS average_risk_score
FROM transactions
GROUP BY transaction_type;	3240782233
SELECT 
    a.alert_id AS "预警ID", 
    a.alert_content AS "预警内容", 
    r.rule_description AS "规则描述"
FROM alerts a
JOIN rule_configurations r ON a.rule_id = r.rule_id;	1390189932
SELECT 
    c.customer_id AS customer_identifier,
    c.customer_name AS customer_name,
    t.status AS latest_transaction_status
FROM 
    customers c
LEFT JOIN LATERAL (
    SELECT 
        status
    FROM 
        transactions
    WHERE 
        customer_id = c.customer_id
    ORDER BY 
        transaction_date DESC
    LIMIT 1
) t ON true;	2842460105
SELECT 
    ri.indicator_id AS "风险指标ID",
    ri.indicator_name AS "风险指标名称",
    AVG(rml.actual_value) AS "平均实际值",
    STDDEV(rml.actual_value) AS "标准差",
    (STDDEV(rml.actual_value) / NULLIF(AVG(rml.actual_value), 0)) AS "变异系数"
FROM 
    risk_indicators ri
LEFT JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
GROUP BY 
    ri.indicator_id, ri.indicator_name;	3963285376
SELECT DISTINCT c.customer_id AS customer_unique_id, 
                c.customer_name AS customer_full_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM transactions t 
    WHERE t.customer_id = c.customer_id 
    AND t.risk_score >= 70 
    AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
)
AND EXISTS (
    SELECT 1 FROM transactions t
    JOIN audit_logs a ON t.transaction_id = a.transaction_id
    WHERE t.customer_id = c.customer_id
    AND t.amount > 500000
    AND a.audit_result = 'FAILED'
    AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
);	2546181421
SELECT AVG(impact_score) AS average_impact_score 
FROM risk_assessments 
WHERE mitigation_plan IS NULL OR mitigation_plan = '';	2755620243
SELECT alert_id AS "预警标识符", alert_content AS "预警内容描述", status AS "当前状态" FROM alerts;	3751427783
SELECT 
    c.customer_name AS customer_name,
    (COUNT(CASE WHEN t.risk_score >= 70 AND t.transaction_date >= CURRENT_DATE - INTERVAL '90 days' THEN 1 END) * 2 + 
     COUNT(CASE WHEN a.status = 'OPEN' THEN 1 END) * 3 + 
     (1.0 / NULLIF(c.credit_score, 0)) * 1000) AS risk_index
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
LEFT JOIN 
    alerts a ON c.customer_id = a.assigned_to
GROUP BY 
    c.customer_id, c.customer_name, c.credit_score
ORDER BY 
    risk_index DESC
LIMIT 10;	2897506811
SELECT 
    event_type AS risk_event_type,
    COUNT(*) AS occurrence_count,
    AVG(severity) AS average_severity
FROM 
    risk_events
WHERE 
    occurrence_time BETWEEN '2023-01-01' AND '2023-12-31 23:59:59'
GROUP BY 
    event_type
ORDER BY 
    occurrence_count DESC;	1765860698
SELECT 
    rr.report_id AS "报告ID",
    rr.report_type AS "报告类型",
    rr.report_date AS "报告日期",
    rr.report_content AS "报告内容",
    rr.author AS "作者",
    rr.approval_status AS "审批状态",
    re.event_id AS "事件ID",
    re.event_type AS "事件类型",
    re.event_description AS "事件描述"
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.report_content LIKE '%合规风险%';	2186954842
SELECT 
    indicator_id AS "风险指标ID",
    update_frequency AS "更新频率",
    data_source AS "数据来源"
FROM 
    risk_indicators;	1001861352
SELECT 
    re.event_id AS risk_event_id,
    re.event_type AS risk_event_type,
    re.status AS risk_event_status,
    rr.report_content AS latest_report_content,
    rr.report_date AS latest_report_date
FROM 
    risk_events re
LEFT JOIN LATERAL (
    SELECT 
        report_content,
        report_date
    FROM 
        risk_reports
    WHERE 
        event_id = re.event_id
    ORDER BY 
        report_date DESC
    LIMIT 1
) rr ON true
WHERE 
    re.status != 'Resolved'
ORDER BY 
    re.event_id;	3688441488
SELECT 
    rc.rule_type AS "规则类型",
    COUNT(a.alert_id)::numeric / NULLIF(COUNT(DISTINCT rc.rule_id), 0) AS "平均触发次数",
    MAX(rc.updated_at) AS "最近更新时间"
FROM 
    rule_configurations rc
LEFT JOIN 
    alerts a ON rc.rule_id = a.rule_id
GROUP BY 
    rc.rule_type;	2337622346
SELECT event_type AS risk_type, COUNT(*) AS event_count 
FROM risk_events 
GROUP BY event_type 
ORDER BY event_count DESC;	1820971007
SELECT DISTINCT 
    c.customer_id AS customer_identifier, 
    c.customer_name AS customer_name, 
    c.credit_score AS credit_score
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE c.credit_score < 700 
  AND t.transaction_date >= '2023-01-01' 
  AND t.transaction_date < '2024-01-01';	3328333298
SELECT 
    re.event_id AS risk_event_id, 
    re.event_type AS risk_event_type, 
    rr.report_id AS risk_report_id
FROM 
    risk_events re
LEFT JOIN 
    risk_reports rr ON re.event_id = rr.event_id;	547790744
SELECT COUNT(*) AS rejected_reports_count 
FROM risk_reports 
WHERE approval_status = 'rejected' 
  AND report_date BETWEEN '2023-01-01' AND '2023-12-31';	3644288071
SELECT 
    assessment_id AS "风险评估ID",
    mitigation_plan AS "缓解措施方案",
    assessor AS "评估人员"
FROM risk_assessments;	3802320452
SELECT 
    rml.log_id AS "监控日志ID",
    rml.actual_value AS "实际检测值",
    rml.is_exceeding_threshold AS "是否超出阈值"
FROM risk_monitoring_logs rml
JOIN (
    SELECT indicator_id, MAX(monitoring_date) AS latest_date
    FROM risk_monitoring_logs
    GROUP BY indicator_id
) latest ON rml.indicator_id = latest.indicator_id AND rml.monitoring_date = latest.latest_date;	3489018825
SELECT 
    rc.rule_id AS rule_identifier,
    rc.rule_name AS rule_name,
    COUNT(a.alert_id) AS alert_count
FROM 
    rule_configurations rc
LEFT JOIN 
    alerts a ON rc.rule_id = a.rule_id
GROUP BY 
    rc.rule_id, rc.rule_name;	2505821643
SELECT 
    re.event_id AS "风险事件ID",
    re.event_description AS "风险事件描述",
    t.transaction_id AS "交易编号",
    t.amount AS "交易金额"
FROM 
    risk_events re
JOIN 
    transactions t ON re.event_id = t.event_id
WHERE 
    re.event_type = '信用风险'
    AND t.status = '成功';	3072597279
SELECT risk_level AS "风险等级", COUNT(*) AS "客户数量" FROM customers GROUP BY risk_level;	260033616
SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY t.amount) AS median_transaction_amount
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.registration_date < '2019-01-01' 
    AND c.risk_level = '高';	2369245761
SELECT DISTINCT rc.rule_name AS "触发规则名称", re.event_description AS "风险事件详细说明"
FROM alerts a
JOIN rule_configurations rc ON a.rule_id = rc.rule_id
JOIN risk_events re ON a.event_id = re.event_id
WHERE a.alert_level = '高';	1787317276
SELECT 
    event_id AS "事件ID",
    created_at AS "创建时间",
    status AS "当前状态"
FROM 
    risk_events;	1447865488
WITH monthly_counts AS (
    SELECT 
        event_type,
        EXTRACT(YEAR FROM occurrence_time) AS year,
        EXTRACT(MONTH FROM occurrence_time) AS month,
        COUNT(*) AS current_month_count
    FROM 
        risk_events
    GROUP BY 
        event_type, 
        EXTRACT(YEAR FROM occurrence_time), 
        EXTRACT(MONTH FROM occurrence_time)
)
SELECT 
    mc1.year AS year,
    mc1.month AS month,
    mc1.event_type AS risk_event_type,
    mc1.current_month_count AS current_month_occurrences,
    mc2.current_month_count AS previous_month_occurrences,
    CASE 
        WHEN mc2.current_month_count = 0 THEN NULL
        ELSE ROUND((mc1.current_month_count - mc2.current_month_count) * 100.0 / mc2.current_month_count, 2)
    END AS monthly_growth_rate
FROM 
    monthly_counts mc1
LEFT JOIN 
    monthly_counts mc2 ON mc1.event_type = mc2.event_type 
    AND (
        (mc1.year = mc2.year AND mc1.month = mc2.month + 1)
        OR (mc1.year = mc2.year + 1 AND mc1.month = 1 AND mc2.month = 12)
    )
ORDER BY 
    mc1.event_type, 
    mc1.year, 
    mc1.month;	3560291801
SELECT 
    DATE_TRUNC('month', transaction_date) AS month_period,
    AVG(amount) AS avg_transaction_amount,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY DATE_TRUNC('month', transaction_date)
ORDER BY month_period;	2152701139
SELECT 
    r.report_id AS "报告ID", 
    r.report_type AS "报告类型", 
    r.approved_by AS "审批人", 
    e.event_description AS "事件描述", 
    e.severity AS "事件严重程度"
FROM risk_reports r
JOIN risk_events e ON r.event_id = e.event_id
WHERE r.approval_status = '已批准';	558233205
SELECT 
    c.customer_name AS "客户名称",
    c.risk_level AS "风险评估等级",
    t.status AS "交易状态"
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id;	3381293646
SELECT 
    c.customer_name AS customer_name,
    t.transaction_type AS transaction_type,
    t.status AS transaction_status
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.risk_level = '高'
LIMIT 100;	3077667667
SELECT 
    report_id AS "报告ID",
    report_type AS "报告类型",
    report_date AS "报告日期",
    report_content AS "报告内容",
    author AS "作者",
    approval_status AS "审批状态",
    approved_by AS "审批人",
    event_id AS "关联事件ID"
FROM 
    risk_reports
WHERE 
    author = '孙宇' 
    AND (approval_status IS NULL OR approval_status != 'approved');	2339616488
SELECT 
    a.alert_content AS alert_details, 
    re.event_description AS risk_event_description
FROM 
    alerts a
JOIN 
    risk_events re ON a.event_id = re.event_id
WHERE 
    a.status = '未处理';	1797007792
SELECT risk_level AS "风险等级", COUNT(*) AS "客户数量" FROM customers WHERE risk_level IN ('中', '高') GROUP BY risk_level;	298505495
SELECT 
    c.customer_id AS customer_identifier,
    c.customer_name AS customer_name,
    COUNT(t.transaction_id) AS transaction_count,
    AVG(t.risk_score) AS average_risk_score
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.customer_id, c.customer_name;	612300483
SELECT 
    DATE_TRUNC('month', registration_date) AS month_timestamp,
    COUNT(*) AS high_risk_customer_count
FROM customers
WHERE risk_level = '高'
GROUP BY DATE_TRUNC('month', registration_date)
ORDER BY month_timestamp;	3872938276
SELECT 
    ri.indicator_name AS high_risk_indicator_name,
    rml.monitoring_date AS latest_monitoring_date,
    rml.actual_value AS current_value,
    a.alert_level AS associated_alert_level,
    a.alert_content AS alert_details,
    a.alert_id AS unique_alert_identifier,
    al.audit_result AS review_outcome,
    al.audit_comments AS review_notes
FROM 
    risk_indicators ri
JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
LEFT JOIN 
    rule_configurations rc ON ri.indicator_id = rc.indicator_id
LEFT JOIN 
    alerts a ON rc.rule_id = a.rule_id
LEFT JOIN 
    audit_logs al ON a.alert_id = al.alert_id
WHERE 
    ri.threshold_value < rml.actual_value
    AND rml.monitoring_date = (
        SELECT MAX(monitoring_date) 
        FROM risk_monitoring_logs 
        WHERE indicator_id = ri.indicator_id
    );	4293195588
SELECT 
    risk_level AS 风险等级, 
    COUNT(*) AS 客户数量, 
    AVG(credit_score) AS 平均信用评分
FROM 
    customers
GROUP BY 
    risk_level;	3735769324
SELECT 
    a.alert_type AS alert_type,
    MAX(EXTRACT(EPOCH FROM (al.audit_time - a.alert_time))/3600) AS max_processing_hours
FROM 
    alerts a
JOIN 
    audit_logs al ON a.alert_id = al.alert_id
WHERE 
    a.status = 'RESOLVED' 
    AND al.audit_type = 'RESOLUTION' 
    AND al.audit_result = 'APPROVED'
GROUP BY 
    a.alert_type
ORDER BY 
    max_processing_hours DESC
LIMIT 100;	3555900229
SELECT 
    c.customer_name AS "客户名称",
    t.amount AS "交易金额",
    t.transaction_date AS "交易日期"
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.transaction_date >= '2023-11-01' 
    AND t.transaction_date < '2023-12-01'
    AND t.amount > 100000
ORDER BY 
    t.amount DESC;	390806390
SELECT SUM(threshold_value) AS total_threshold_value 
FROM risk_indicators 
WHERE indicator_name LIKE '%财务%';	2736578842
SELECT customer_name AS "客户名称", credit_score AS "信用评分" FROM customers;	453782697
SELECT 
    c.customer_id AS customer_identifier,
    c.customer_name AS customer_name,
    t.transaction_id AS latest_transaction_id,
    t.transaction_date AS transaction_datetime,
    t.risk_score AS transaction_risk_score
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.transaction_date = (
        SELECT MAX(transaction_date) 
        FROM transactions 
        WHERE customer_id = c.customer_id
    )
ORDER BY 
    c.customer_id;	605680231
SELECT 
    log_id AS "日志ID", 
    actual_value AS "实际监测值" 
FROM 
    risk_monitoring_logs 
WHERE 
    is_exceeding_threshold = true;	591035595
SELECT 
    t.transaction_id AS "交易ID",
    t.transaction_date AS "交易日期",
    t.amount AS "交易金额",
    t.risk_score AS "风险评分",
    (SELECT AVG(t2.risk_score) 
     FROM transactions t2 
     JOIN customers c2 ON t2.customer_id = c2.customer_id 
     WHERE c2.risk_level = '高') AS "平均风险评分"
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
WHERE c.risk_level = '高';	154773295
SELECT 
    t.transaction_id AS "交易ID",
    t.risk_score AS "风险评分"
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id;	2894945358
SELECT report_type AS "报告类型", COUNT(*) AS "被拒绝报告数量" 
FROM risk_reports 
WHERE approval_status = '已拒绝' 
GROUP BY report_type;	3936841885
SELECT 
    customer_id AS "客户ID", 
    customer_name AS "客户名称", 
    credit_score AS "信用评分", 
    risk_level AS "风险等级" 
FROM 
    customers 
WHERE 
    risk_level = '高' 
    AND credit_score < 600;	2451684746
SELECT 
    c.risk_level AS "风险等级",
    COALESCE(AVG(t.amount), 0) AS "平均交易金额",
    CASE 
        WHEN COUNT(DISTINCT t.customer_id) = 0 THEN 0
        ELSE COUNT(t.transaction_id)::float / COUNT(DISTINCT t.customer_id)
    END AS "每位客户平均交易数量"
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
    AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    c.risk_level;	1650691143
SELECT 
    r.report_id AS "报告唯一标识",
    r.report_type AS "报告类型", 
    r.report_date AS "创建日期", 
    r.report_content AS "详细内容", 
    r.author AS "提交人信息", 
    r.approval_status AS "审批状态", 
    r.approved_by AS "审批人", 
    r.event_id AS "关联风险事件标识"
FROM 
    risk_reports r
JOIN 
    risk_events e ON r.event_id = e.event_id
WHERE 
    e.event_type = '流动性风险';	3897186376
SELECT 
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COALESCE(SUM(t.amount), 0) AS total_transaction_amount
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.credit_score BETWEEN 600 AND 800;	1076275288
SELECT report_content AS "风险报告内容" 
FROM risk_reports 
WHERE approved_by = '王思远' 
  AND report_date BETWEEN '2023-03-01' AND '2023-03-31';	1120727301
SELECT 
    re.event_id AS "风险事件ID", 
    rr.report_id AS "报告编号", 
    rr.approval_status AS "审批状态"
FROM 
    risk_events re
LEFT JOIN 
    risk_reports rr ON re.event_id = rr.event_id
WHERE 
    re.event_type = '合规风险';	1080125465
SELECT 
    t.transaction_id AS transaction_identifier,
    t.customer_id AS customer_identifier,
    t.transaction_type AS transaction_category,
    t.amount AS transaction_amount,
    t.transaction_date AS transaction_timestamp,
    t.status AS transaction_status,
    t.risk_score AS risk_assessment_score,
    t.event_id AS related_event_identifier
FROM 
    transactions t
WHERE 
    t.transaction_date >= '2023-06-01' 
    AND t.transaction_date < '2023-07-01';	136539419
SELECT 
    re.event_id AS risk_event_id,
    re.event_type AS risk_event_type,
    re.event_description AS risk_event_description,
    al.audit_id AS audit_record_id,
    al.audit_type AS audit_type,
    al.audit_result AS audit_result
FROM 
    risk_events re
JOIN 
    audit_logs al ON re.event_id = al.event_id
WHERE 
    re.severity = 3;	3750047672
SELECT 
    ri.indicator_name AS "风险指标名称",
    ri.threshold_value AS "预设阈值",
    rml.actual_value AS "实际监测值"
FROM 
    risk_indicators ri
JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
WHERE 
    rml.is_exceeding_threshold = true;	3909298542
SELECT 
    c.customer_id AS "客户ID", 
    c.customer_name AS "客户名称", 
    c.credit_score AS "信用评分", 
    t.status AS "交易状态"
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id;	2762771801
SELECT 
    re.event_id AS risk_event_id,
    re.event_description AS risk_event_description,
    a.alert_level AS alert_severity,
    a.alert_content AS alert_details
FROM 
    risk_events re
INNER JOIN 
    alerts a ON re.event_id = a.event_id
WHERE 
    a.alert_level = '高';	2830564670
SELECT 
    re.event_id AS risk_event_id, 
    re.event_description AS risk_event_description, 
    a.alert_id AS alert_id, 
    a.alert_time AS alert_time
FROM 
    risk_events re
LEFT JOIN 
    alerts a ON re.event_id = a.event_id
ORDER BY 
    a.alert_time;	942591775
SELECT 
    c.risk_level AS "风险等级",
    COALESCE(AVG(t.amount), 0) AS "平均交易金额",
    COALESCE(COUNT(t.transaction_id)::numeric / NULLIF(COUNT(DISTINCT t.customer_id), 0), 0) AS "平均交易次数"
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
    AND t.transaction_date >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY 
    c.risk_level;	3295587616
SELECT 
    customer_id AS "客户ID", 
    customer_name AS "客户姓名", 
    credit_score AS "信用评分" 
FROM 
    customers 
WHERE 
    risk_level = '高' 
    AND credit_score < 700;	3932804573
SELECT 
    c.customer_id AS customer_identifier,
    c.credit_score AS credit_score_value,
    t.transaction_id AS latest_failed_transaction_id,
    t.status AS latest_transaction_status
FROM 
    customers c
LEFT JOIN (
    SELECT 
        transaction_id, 
        customer_id, 
        status,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_date DESC) AS rn
    FROM 
        transactions
    WHERE 
        status = '失败'
) t ON c.customer_id = t.customer_id AND t.rn = 1
ORDER BY 
    c.customer_id;	862533692
SELECT 
    ra.assessment_id AS assessment_identifier,
    ra.event_id AS event_identifier,
    c.customer_id AS customer_identifier,
    c.customer_name AS customer_name,
    c.credit_score AS credit_score
FROM 
    risk_assessments ra
LEFT JOIN 
    risk_events re ON ra.event_id = re.event_id
LEFT JOIN 
    transactions t ON re.event_id = t.event_id
LEFT JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    ra.risk_level = 'high'
    AND c.credit_score > 700;	2759801136
SELECT 
    customer_id AS customer_identifier,
    customer_name AS customer_name,
    customer_type AS customer_category,
    credit_score AS credit_rating,
    risk_level AS risk_category,
    registration_date AS registration_date,
    last_update_date AS last_updated_date
FROM customers
WHERE customer_type = 'Enterprise'
ORDER BY credit_score DESC
LIMIT 10;	1448319074
SELECT 
    EXTRACT(YEAR FROM created_at) AS year,
    EXTRACT(MONTH FROM created_at) AS month,
    COUNT(*) AS new_rules_count,
    AVG(CASE WHEN is_active THEN 1 ELSE 0 END) AS avg_active_rules
FROM rule_configurations
GROUP BY year, month
ORDER BY year, month;	2148910450
SELECT author AS report_author, approval_status AS report_approval_status 
FROM risk_reports 
WHERE approval_status = '已批准';	3303778848
SELECT 
    c.customer_name AS customer_name,
    t.amount AS transaction_amount,
    t.status AS transaction_status
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id;	2919479377
SELECT 
    re.event_id AS "风险事件ID", 
    ra.assessment_id AS "评估结果ID", 
    ra.risk_level AS "风险等级"
FROM 
    risk_events re
LEFT JOIN 
    risk_assessments ra ON re.event_id = ra.event_id;	3408098582
SELECT 
    ri.indicator_id AS "风险指标ID",
    ri.indicator_name AS "风险指标名称",
    ri.threshold_value AS "阈值",
    AVG(rm.actual_value) AS "平均实际值"
FROM 
    risk_indicators ri
LEFT JOIN 
    risk_monitoring_logs rm ON ri.indicator_id = rm.indicator_id
GROUP BY 
    ri.indicator_id, ri.indicator_name, ri.threshold_value
ORDER BY 
    ri.indicator_id;	3536942222
SELECT r.report_id AS "报告ID", 
       r.report_type AS "报告类型", 
       r.report_content AS "报告内容",
       e.event_type AS "事件类型", 
       e.event_description AS "事件描述"
FROM risk_reports r
JOIN risk_events e ON r.event_id = e.event_id
WHERE r.approval_status = '已批准';	3025435441
SELECT DISTINCT t.customer_id AS customer_identifier, 
                c.customer_name AS customer_name, 
                t.transaction_date::date AS transaction_date
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN alerts a ON t.event_id = a.event_id
WHERE t.risk_score >= 80 
  AND a.alert_level IN ('CRITICAL', 'HIGH')
  AND t.transaction_date::date = a.alert_time::date;	3761432717
SELECT 
    t.transaction_id AS transaction_identifier,
    c.customer_name AS customer_name
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    t.risk_score > 70;	3404778014
SELECT 
    re.event_description AS event_description,
    ra.assessment_date AS assessment_date
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    ra.risk_level = '高';	3200534548
SELECT c.customer_name, t.status AS last_transaction_status
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE c.risk_level = 'high'
AND t.transaction_date = (
    SELECT MAX(transaction_date) 
    FROM transactions 
    WHERE customer_id = c.customer_id
)
AND t.status = 'failed';	698660188
SELECT 
    event_id AS risk_event_id,
    COUNT(*) AS transaction_count
FROM 
    transactions
GROUP BY 
    event_id;	756643276
SELECT 
    t.transaction_id AS "交易ID",
    t.amount AS "交易金额",
    t.transaction_date AS "交易日期",
    c.customer_name AS "客户名称",
    c.risk_level AS "客户风险等级"
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    c.risk_level = '高'
    AND t.amount > 500000
    AND t.transaction_date >= '2023-01-01' 
    AND t.transaction_date < '2023-04-01';	1961596891
SELECT 
    re.event_id AS "风险事件ID",
    re.event_description AS "事件描述",
    re.severity AS "严重程度等级",
    ra.risk_level AS "风险等级评估",
    ra.mitigation_plan AS "缓解措施"
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    EXTRACT(YEAR FROM re.occurrence_time) = 2023
    AND re.severity IN (4, 5);	1488802626
SELECT 
    log_id AS "监控日志ID", 
    notes AS "备注信息" 
FROM 
    risk_monitoring_logs 
WHERE 
    is_exceeding_threshold = false;	3027811751
SELECT 
    rr.report_id AS "报告ID",
    rr.report_type AS "报告类型",
    rr.author AS "报告作者",
    re.event_type AS "风险事件类型",
    re.severity AS "事件严重程度",
    al.audit_result AS "最新审核结果",
    al.audit_comments AS "审核意见"
FROM 
    risk_reports rr
LEFT JOIN 
    risk_events re ON rr.event_id = re.event_id
LEFT JOIN (
    SELECT 
        related_id, 
        audit_result, 
        audit_comments,
        ROW_NUMBER() OVER (PARTITION BY related_id ORDER BY audit_time DESC) AS rn
    FROM 
        audit_logs
    WHERE 
        audit_type = '风险报告审核'
) al ON rr.report_id = al.related_id AND al.rn = 1
WHERE 
    rr.approval_status = '待审批';	1296190191
SELECT 
    customer_id AS "客户唯一标识",
    customer_name AS "客户名称",
    credit_score AS "信用评分",
    risk_level AS "风险等级"
FROM 
    customers
WHERE 
    EXTRACT(YEAR FROM registration_date) = 2021 
    AND risk_level = '高' 
    AND credit_score < 550;	2631012035
AMBIGUOUS_QUERY	2342271424
SELECT event_type AS risk_type, COUNT(*) AS event_count 
FROM risk_events 
GROUP BY event_type;	2292865545
SELECT 
    c.customer_name AS customer_name,
    rc.rule_name AS rule_name,
    COUNT(a.alert_id) AS trigger_count
FROM 
    customers c
    JOIN transactions t ON c.customer_id = t.customer_id
    JOIN alerts a ON t.event_id = a.event_id
    JOIN rule_configurations rc ON a.rule_id = rc.rule_id
WHERE 
    c.risk_level = '高'
GROUP BY 
    c.customer_name, 
    rc.rule_name
ORDER BY 
    trigger_count DESC;	3057920994
SELECT 
    EXTRACT(YEAR FROM occurrence_time) AS event_year,
    EXTRACT(MONTH FROM occurrence_time) AS event_month,
    event_type AS risk_event_type,
    COUNT(*) AS event_count,
    AVG(severity) AS avg_severity,
    ROUND(100.0 * SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END) / COUNT(*), 2) AS resolution_rate
FROM 
    risk_events
GROUP BY 
    EXTRACT(YEAR FROM occurrence_time),
    EXTRACT(MONTH FROM occurrence_time),
    event_type
ORDER BY 
    event_year, event_month, risk_event_type;	1563461822
SELECT 
    rml.monitoring_date AS "监测日期",
    rml.actual_value AS "实际监测值", 
    ri.threshold_value AS "设定阈值"
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id;	2699040253
SELECT 
    c.risk_level AS 客户风险等级, 
    t.transaction_type AS 交易类型, 
    AVG(t.amount) AS 平均交易金额
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.risk_level, t.transaction_type
ORDER BY 
    c.risk_level, t.transaction_type;	2609391365
SELECT COUNT(*) AS active_rule_count FROM rule_configurations WHERE is_active = true;	1646275357
SELECT 
    customer_id AS "客户ID",
    customer_name AS "客户名称",
    risk_level AS "风险等级",
    credit_score AS "信用评分"
FROM 
    customers;	3640375109
SELECT 
    COUNT(*) AS total_indicators,
    AVG(CASE 
        WHEN update_frequency = 'daily' THEN 1
        WHEN update_frequency = 'weekly' THEN 7
        WHEN update_frequency = 'monthly' THEN 30
        WHEN update_frequency = 'quarterly' THEN 90
        WHEN update_frequency = 'yearly' THEN 365
        ELSE NULL
    END) AS avg_update_days_interval
FROM risk_indicators
WHERE threshold_value > 100;	1137138067
SELECT customer_name AS "客户名称", registration_date AS "注册日期" FROM customers;	674388735
SELECT 
    ri.indicator_id AS risk_indicator_id,
    ri.indicator_name AS risk_indicator_name,
    rml.log_id AS monitoring_log_id,
    rml.actual_value AS monitored_value,
    rml.is_exceeding_threshold AS threshold_exceeded
FROM 
    risk_indicators ri
JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id;	2598937105
SELECT 
    ri.indicator_id AS "风险指标ID",
    ri.indicator_name AS "风险指标名称",
    ri.data_source AS "数据来源",
    AVG(rml.actual_value) AS "平均值",
    STDDEV(rml.actual_value) AS "标准差"
FROM 
    risk_indicators ri
JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
GROUP BY 
    ri.indicator_id, ri.indicator_name, ri.data_source
ORDER BY 
    ri.indicator_id, ri.data_source;	62865185
SELECT 
    audit_id AS "审核记录ID", 
    audit_result AS "审核结果状态", 
    auditor AS "审核人员" 
FROM 
    audit_logs 
WHERE 
    audit_result = '拒绝';	185839438
SELECT alert_type AS "预警类型", alert_content AS "预警内容" FROM alerts;	3165460471
SELECT 
    a.alert_id AS "预警ID",
    a.alert_type AS "预警类型",
    a.alert_content AS "预警内容",
    re.event_description AS "风险事件描述",
    al.audit_result AS "最近审核结果",
    al.audit_comments AS "审核意见"
FROM 
    alerts a
LEFT JOIN 
    risk_events re ON a.event_id = re.event_id
LEFT JOIN 
    (SELECT 
        alert_id, 
        audit_result, 
        audit_comments,
        ROW_NUMBER() OVER (PARTITION BY alert_id ORDER BY audit_time DESC) AS rn
     FROM 
        audit_logs
    ) al ON a.alert_id = al.alert_id AND al.rn = 1
WHERE 
    a.status = '未处理';	3849483796
SELECT AVG(EXTRACT(EPOCH FROM (NOW() - alert_time))/3600) AS avg_unprocessed_alert_duration_hours
FROM alerts
WHERE status != 'PROCESSED' OR status IS NULL;	1990473038
SELECT 
    c.customer_id AS "客户ID",
    c.customer_name AS "客户名称",
    c.risk_level AS "风险等级",
    (COUNT(DISTINCT ra.assessment_id) * COALESCE(AVG(ra.impact_score * ra.probability_score), 0) + 
     COUNT(DISTINCT a.alert_id) * 2) AS "综合风险指数"
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
LEFT JOIN 
    risk_assessments ra ON t.event_id = ra.event_id
LEFT JOIN 
    alerts a ON t.event_id = a.event_id
GROUP BY 
    c.customer_id, c.customer_name, c.risk_level
ORDER BY 
    "综合风险指数" DESC;	3119334868
SELECT 
    event_type AS risk_type, 
    COUNT(*) AS event_count 
FROM 
    risk_events 
WHERE 
    status = '未处理' 
GROUP BY 
    event_type;	2458967882
SELECT 
    t.transaction_id AS "交易记录标识符",
    t.customer_id AS "客户标识符",
    t.transaction_type AS "交易类型",
    t.amount AS "金额",
    t.transaction_date AS "交易日期",
    t.status AS "状态",
    t.risk_score AS "风险评分",
    t.event_id AS "事件标识符"
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    c.risk_level = '低' 
    AND c.credit_score > 700;	4081376750
SELECT 
    a.alert_id AS "预警ID",
    a.alert_type AS "预警类型",
    a.alert_content AS "预警内容",
    a.alert_level AS "预警级别",
    e.event_id AS "风险事件ID",
    e.event_type AS "风险事件类型",
    e.severity AS "风险事件严重程度"
FROM 
    alerts a
JOIN 
    risk_events e ON a.event_id = e.event_id
WHERE 
    a.status != '已处理' 
    AND (a.alert_level = '高级' OR a.alert_level = '高')
LIMIT 100;	2952805928
SELECT a.alert_id AS "预警ID", 
       a.alert_content AS "预警内容", 
       a.alert_time AS "触发时间", 
       a.status AS "处理状态", 
       r.rule_name AS "规则名称", 
       r.rule_description AS "规则描述"
FROM alerts a
JOIN rule_configurations r ON a.rule_id = r.rule_id
WHERE r.rule_type IN ('交易监控', '客户风险');	790231894
SELECT 
    c.customer_id AS customer_identifier,
    c.risk_level AS customer_risk_level,
    SUM(t.amount) AS total_transaction_amount
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.risk_level = '高' AND t.risk_score >= 8
GROUP BY 
    c.customer_id, c.risk_level
ORDER BY 
    total_transaction_amount DESC;	76184048
SELECT report_content AS report_content_text 
FROM risk_reports 
WHERE report_type = '月度风险报告' AND approval_status = '已拒绝';	291950371
SELECT event_type AS "风险事件类型", COUNT(*) AS "事件数量" FROM risk_events GROUP BY event_type;	2809252635
SELECT 
    c.customer_name AS "客户姓名",
    t.amount AS "交易金额",
    t.transaction_date AS "交易日期"
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.transaction_type = '转账'
    AND t.transaction_date::date = '2023-05-04'
    AND t.amount > 200000;	184311181
SELECT 
    a.alert_id AS "预警ID", 
    a.alert_content AS "预警内容详情", 
    a.alert_level AS "预警级别", 
    a.assigned_to AS "处理人员姓名", 
    re.event_description AS "风险事件描述"
FROM 
    alerts a
LEFT JOIN 
    risk_events re ON a.event_id = re.event_id
WHERE 
    (a.status IS NULL OR a.status != '已处理') 
    AND a.alert_level = '高级'
LIMIT 100;	1539184065
SELECT 
    report_id AS "报告ID",
    report_content AS "报告内容"
FROM 
    risk_reports
WHERE 
    report_date BETWEEN '2023-04-01' AND '2023-04-30'
    AND approved_by = '高志远';	3408938184
SELECT 
    transaction_type AS transaction_type,
    SUM(CASE WHEN status = 'success' THEN 1 ELSE 0 END) AS successful_transactions,
    SUM(CASE WHEN status = 'failure' THEN 1 ELSE 0 END) AS failed_transactions
FROM 
    transactions
GROUP BY 
    transaction_type;	547284006
SELECT 
    re.event_id AS event_id,
    latest_ra.risk_level AS latest_risk_level
FROM 
    risk_events re
LEFT JOIN (
    SELECT 
        event_id, 
        risk_level,
        ROW_NUMBER() OVER (PARTITION BY event_id ORDER BY assessment_date DESC) AS rn
    FROM 
        risk_assessments
) latest_ra ON re.event_id = latest_ra.event_id AND latest_ra.rn = 1;	2791172353
SELECT 
    c.customer_name,
    COUNT(DISTINCT ra.assessment_id) AS high_risk_assessment_count,
    COUNT(DISTINCT t.transaction_id) AS large_transaction_count
FROM 
    customers c
WHERE 
    EXISTS (
        SELECT 1 FROM risk_assessments ra
        JOIN risk_events re ON ra.event_id = re.event_id
        JOIN transactions t2 ON t2.event_id = re.event_id
        WHERE t2.customer_id = c.customer_id
        AND ra.risk_level = 'High'
        AND ra.assessment_date >= CURRENT_DATE - INTERVAL '1 year'
    )
    AND EXISTS (
        SELECT 1 FROM transactions t
        WHERE t.customer_id = c.customer_id
        AND t.amount > 500000
        AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
    )
GROUP BY 
    c.customer_id, c.customer_name;	616009086
AMBIGUOUS_QUERY	2755424699
SELECT event_id, MAX(severity) AS max_severity 
FROM risk_events 
GROUP BY event_id;	3357225905
SELECT 
    c.risk_level AS "风险等级", 
    COUNT(DISTINCT c.customer_id) AS "客户数量", 
    AVG(t.amount) AS "平均交易金额"
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.risk_level;	2507883319
SELECT a.audit_time AS "审核操作时间", a.audit_result AS "审核判定结果"
FROM audit_logs a
JOIN alerts al ON a.alert_id = al.alert_id
WHERE a.auditor = '张强'
LIMIT 100;	2171757699
SELECT 
    rml.log_id AS monitoring_record_id,
    rml.actual_value AS measured_value,
    rml.is_exceeding_threshold AS threshold_exceeded,
    ri.indicator_name AS risk_indicator_name
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id;	1791933892
SELECT 
    ri.indicator_name AS "风险指标名称",
    COUNT(*) AS "超过阈值次数",
    AVG((rml.actual_value - ri.threshold_value) / ri.threshold_value * 100) AS "平均超出幅度百分比"
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id
WHERE 
    rml.is_exceeding_threshold = true
    AND rml.monitoring_date >= '2023-01-01' 
    AND rml.monitoring_date < '2024-01-01'
GROUP BY 
    ri.indicator_name
ORDER BY 
    "超过阈值次数" DESC;	4281611752
SELECT 
    alert_id AS "预警ID",
    alert_content AS "预警内容",
    status AS "处理状态"
FROM 
    alerts
WHERE 
    alert_time >= '2023-01-01' 
    AND alert_time < '2024-01-01';	2403947927
SELECT 
    ri.indicator_id AS risk_indicator_id,
    ri.indicator_name AS risk_indicator_name,
    rml.monitoring_date AS latest_monitoring_date,
    rml.actual_value AS actual_measurement_value
FROM 
    risk_indicators ri
LEFT JOIN LATERAL (
    SELECT 
        monitoring_date,
        actual_value
    FROM 
        risk_monitoring_logs
    WHERE 
        indicator_id = ri.indicator_id
    ORDER BY 
        monitoring_date DESC
    LIMIT 1
) rml ON true
ORDER BY 
    ri.indicator_id;	3007794799
SELECT 
    ri.indicator_name AS "风险指标名称",
    ri.threshold_value AS "预设阈值标准",
    COUNT(CASE WHEN rml.is_exceeding_threshold THEN 1 END) AS "超过阈值次数",
    COUNT(*) AS "总检查次数",
    ROUND(COUNT(CASE WHEN rml.is_exceeding_threshold THEN 1 END) * 100.0 / COUNT(*), 2) AS "超过阈值百分比"
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id
WHERE 
    rml.monitoring_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    ri.indicator_name, ri.threshold_value
ORDER BY 
    "超过阈值次数" DESC
LIMIT 10;	3478580962
SELECT risk_level AS "风险等级", COUNT(*) AS "客户数量" FROM customers GROUP BY risk_level;	2835641813
SELECT 
    c.customer_id AS "客户ID",
    t.risk_score AS "交易风险评分",
    t.status AS "交易状态"
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id;	3556405805
SELECT 
    ra.assessment_id AS "风险评估ID",
    ra.risk_level AS "风险等级",
    t.transaction_id AS "交易ID",
    t.risk_score AS "交易风险评分"
FROM 
    risk_assessments ra
JOIN 
    transactions t ON ra.event_id = t.event_id
WHERE 
    ra.risk_level = '高' 
    AND t.risk_score < 50;	1912282533
SELECT transaction_type, COUNT(*) AS successful_transaction_count 
FROM transactions 
WHERE status = '成功' 
GROUP BY transaction_type 
ORDER BY successful_transaction_count DESC 
LIMIT 100;	966675168
SELECT 
    t.transaction_id AS "交易ID",
    t.amount AS "交易金额",
    t.status AS "交易状态"
FROM 
    transactions t
JOIN 
    risk_events re ON t.event_id = re.event_id
WHERE 
    t.status = '失败' 
    AND re.status = '已解决';	1657330121
SELECT 
    t.transaction_id AS "交易ID",
    c.customer_name AS "客户名称"
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    t.status = '处理中';	2427884877
SELECT 
    t.transaction_id AS "交易ID",
    t.amount AS "交易金额",
    re.event_description AS "风险事件描述"
FROM 
    transactions t
JOIN 
    risk_events re ON t.event_id = re.event_id
WHERE 
    t.amount > 1000;	2050953540
SELECT 
    t.transaction_id AS "交易ID",
    t.amount AS "交易金额",
    t.transaction_date AS "交易日期",
    c.customer_name AS "客户名称",
    re.event_type AS "事件类型",
    re.event_description AS "事件描述"
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
LEFT JOIN 
    risk_events re ON t.event_id = re.event_id
WHERE 
    t.amount > 100000 
    AND c.risk_level = '高'
    AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
LIMIT 100;	2088100618
SELECT assessment_id AS "风险评估ID", mitigation_plan AS "缓解计划内容" 
FROM risk_assessments 
WHERE mitigation_plan IS NOT NULL AND mitigation_plan != '';	4242999593
SELECT 
    t.transaction_id AS "交易ID", 
    t.risk_score AS "风险评分"
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    c.risk_level = '高';	4243946175
SELECT 
    rml.actual_value AS monitored_value,
    ri.indicator_name AS risk_indicator_name
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id
WHERE 
    rml.actual_value < ri.threshold_value;	1679294343
SELECT 
    rr.report_content AS "报告内容",
    re.event_type AS "风险事件类型",
    re.status AS "事件状态"
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.approval_status = '已拒绝';	1824329950
SELECT DISTINCT c.customer_name AS "企业名称", 
                c.credit_score AS "信用评分", 
                c.registration_date AS "注册日期", 
                MAX(t.transaction_date) AS "最近交易日期"
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE c.registration_date BETWEEN '2021-01-01' AND '2021-12-31'
  AND c.credit_score > 700
  AND t.transaction_date >= (CURRENT_DATE - INTERVAL '1 year')
GROUP BY c.customer_name, c.credit_score, c.registration_date
ORDER BY "最近交易日期" DESC;	888703769
SELECT 
    a.alert_id AS "预警ID",
    a.alert_type AS "预警类型",
    a.alert_content AS "预警内容",
    re.event_id AS "风险事件ID",
    re.event_type AS "风险事件类型",
    t.transaction_id AS "交易ID",
    t.amount AS "交易金额"
FROM 
    alerts a
LEFT JOIN 
    risk_events re ON a.event_id = re.event_id
LEFT JOIN 
    transactions t ON re.event_id = t.event_id
WHERE 
    a.assigned_to = '陈强';	411280576
SELECT 
    report_id AS "报告ID",
    report_type AS "报告类型",
    report_date AS "报告日期",
    report_content AS "报告内容",
    author AS "撰写人",
    approval_status AS "审批状态",
    approved_by AS "审批人",
    event_id AS "关联事件ID"
FROM 
    risk_reports
WHERE 
    report_content LIKE '%合规%';	452369014
SELECT 
    EXTRACT(YEAR FROM re.occurrence_time) AS event_year,
    EXTRACT(MONTH FROM re.occurrence_time) AS event_month,
    COUNT(DISTINCT re.event_id) AS monthly_risk_event_count,
    ROUND(AVG(re.severity)::numeric, 2) AS avg_event_severity,
    COUNT(DISTINCT a.alert_id) AS related_alert_count
FROM 
    risk_events re
LEFT JOIN 
    alerts a ON re.event_id = a.event_id
GROUP BY 
    event_year, event_month
ORDER BY 
    event_year, event_month;	865900816
SELECT indicator_name AS "风险指标名称", threshold_value AS "阈值数值" FROM risk_indicators;	92424187
SELECT 
    ri.indicator_name AS "风险指标名称",
    ri.indicator_id AS "风险指标ID",
    rml.log_id AS "监控记录ID",
    rml.monitoring_date AS "最近监控日期",
    rml.actual_value AS "实际监测值",
    rml.is_exceeding_threshold AS "是否超过阈值",
    rml.notes AS "备注信息"
FROM 
    risk_indicators ri
LEFT JOIN LATERAL (
    SELECT *
    FROM risk_monitoring_logs
    WHERE indicator_id = ri.indicator_id
    ORDER BY monitoring_date DESC
    LIMIT 1
) rml ON true
ORDER BY 
    ri.indicator_name;	2998508313
SELECT 
    t.transaction_id AS "交易ID",
    t.amount AS "交易金额",
    c.customer_name AS "客户名称",
    c.customer_type AS "客户类型"
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    t.amount > 100000;	1024168357
SELECT 
    report_id AS "报告唯一标识符", 
    report_type AS "报告类型分类", 
    report_date AS "报告创建日期", 
    report_content AS "报告详细内容", 
    author AS "报告提交人", 
    approval_status AS "审批状态", 
    approved_by AS "审批人", 
    event_id AS "关联事件标识符" 
FROM 
    risk_reports 
WHERE 
    approval_status = '已批准';	2422412797
SELECT transaction_type, AVG(risk_score) AS average_risk_score FROM transactions GROUP BY transaction_type;	3918852865
SELECT 
    event_type AS 风险事件类型,
    AVG(CASE WHEN status = '未处理' THEN EXTRACT(EPOCH FROM (NOW() - created_at)) ELSE NULL END) / 3600 AS 平均未处理持续时间_小时,
    AVG(CASE WHEN status = '处理中' THEN EXTRACT(EPOCH FROM (NOW() - created_at)) ELSE NULL END) / 3600 AS 平均处理中持续时间_小时,
    AVG(CASE WHEN status = '已解决' THEN EXTRACT(EPOCH FROM (occurrence_time - created_at)) ELSE NULL END) / 3600 AS 平均已解决持续时间_小时,
    AVG(CASE WHEN status = '已解决' THEN EXTRACT(EPOCH FROM (occurrence_time - created_at)) ELSE NULL END) / 3600 AS 平均总处理时间_小时
FROM 
    risk_events
GROUP BY 
    event_type;	2671276850
SELECT 
    a.alert_type AS "预警类型",
    COUNT(a.alert_id) AS "预警数量",
    AVG(EXTRACT(EPOCH FROM (al.audit_time - a.alert_time))/3600) AS "平均处理时长(小时)"
FROM alerts a
LEFT JOIN audit_logs al ON a.alert_id = al.alert_id
GROUP BY a.alert_type;	3873676880
SELECT 
    re.event_type AS risk_event_type,
    AVG(EXTRACT(EPOCH FROM (a.alert_time - re.created_at))/86400)::numeric(10,2) AS avg_resolution_days
FROM risk_events re
JOIN alerts a ON re.event_id = a.event_id
WHERE a.status = 'RESOLVED' 
    AND a.alert_time IS NOT NULL 
    AND re.created_at IS NOT NULL
GROUP BY re.event_type;	3957865555
SELECT 
    a.alert_id AS "预警ID",
    a.alert_content AS "预警内容",
    a.alert_time AS "预警时间",
    a.status AS "预警状态",
    re.status AS "风险事件状态"
FROM 
    alerts a
JOIN 
    risk_events re ON a.event_id = re.event_id
WHERE 
    a.rule_id IS NOT NULL;	4127521896
SELECT 
    c.customer_name AS "客户名称",
    COUNT(DISTINCT t.transaction_id) AS "高风险交易次数",
    COUNT(DISTINCT a.alert_id) AS "高级别预警次数"
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
LEFT JOIN 
    risk_events re ON t.event_id = re.event_id
LEFT JOIN 
    alerts a ON re.event_id = a.event_id AND a.alert_level = '高'
WHERE 
    t.risk_score > 80
    AND t.transaction_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    c.customer_name
HAVING 
    COUNT(DISTINCT a.alert_id) > 0;	4089186720
SELECT 
    re.event_id AS risk_event_id, 
    re.severity AS event_severity, 
    ra.risk_level AS assessment_result
FROM 
    risk_events re
LEFT JOIN 
    risk_assessments ra ON re.event_id = ra.event_id;	907497664
AMBIGUOUS_QUERY	4046233588
SELECT customer_type, COUNT(*) AS customer_count FROM customers GROUP BY customer_type;	950586637
SELECT 
    ra.assessment_id AS "风险评估ID", 
    re.event_description AS "风险事件描述"
FROM 
    risk_assessments ra
JOIN 
    risk_events re ON ra.event_id = re.event_id;	1374953478
AMBIGUOUS_QUERY	3381418272
SELECT 
    c.customer_id AS customer_identifier,
    c.customer_name AS customer_name,
    c.risk_level AS risk_level,
    latest_transaction.transaction_date AS last_transaction_date,
    latest_transaction.amount AS transaction_amount,
    latest_transaction.risk_score AS transaction_risk_score
FROM 
    customers c
LEFT JOIN LATERAL (
    SELECT 
        t.transaction_date,
        t.amount,
        t.risk_score
    FROM 
        transactions t
    WHERE 
        t.customer_id = c.customer_id
    ORDER BY 
        t.transaction_date DESC
    LIMIT 1
) AS latest_transaction ON true
WHERE 
    c.risk_level = '高'
ORDER BY 
    c.customer_id;	2179442925
SELECT 
    transaction_type AS transaction_type,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'success' THEN 1 ELSE 0 END) AS successful_transactions
FROM 
    transactions
GROUP BY 
    transaction_type;	1859945760
SELECT 
    re.event_id AS "事件ID",
    re.event_type AS "事件类型",
    ra.risk_level AS "风险等级",
    ra.mitigation_plan AS "缓解措施",
    ra.assessor AS "评估负责人"
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    ra.risk_level = '高';	2798341435
SELECT 
    customer_id AS "客户ID", 
    customer_name AS "客户姓名", 
    credit_score AS "信用评分" 
FROM 
    customers 
WHERE 
    risk_level = '高' 
    AND credit_score < 700;	2480313897
SELECT 
    customer_id AS "客户ID",
    customer_name AS "客户名称",
    customer_type AS "客户类型",
    credit_score AS "信用评分",
    risk_level AS "风险等级",
    registration_date AS "注册日期",
    last_update_date AS "最后更新日期"
FROM 
    customers
WHERE 
    risk_level = '高' 
    AND credit_score < 600;	4249746696
SELECT 
    c.customer_id AS "客户ID",
    c.risk_level AS "风险等级",
    SUM(t.amount) AS "交易金额总和"
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.status = '成功'
GROUP BY 
    c.customer_id, c.risk_level;	3634061359
SELECT 
    rr.report_id AS "报告ID",
    rr.report_type AS "报告类型",
    rr.approval_status AS "审批状态",
    re.event_type AS "风险事件类型",
    re.event_description AS "风险事件描述"
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.approval_status = '已批准';	1094205818
SELECT author AS author_name, COUNT(*) AS report_count 
FROM risk_reports 
GROUP BY author 
ORDER BY report_count DESC 
LIMIT 1;	4008892599
SELECT 
    event_id AS "风险事件ID", 
    event_type AS "风险事件类型", 
    reporter AS "报告人姓名" 
FROM 
    risk_events 
WHERE 
    status != '已处理';	1522060162
SELECT 
    customer_name AS "客户名称", 
    last_update_date AS "最后更新日期" 
FROM 
    customers 
WHERE 
    registration_date >= '2021-01-01' 
ORDER BY 
    last_update_date DESC;	2054103027
SELECT 
    r.report_id AS "报告ID",
    r.report_type AS "报告类型",
    r.report_date AS "报告日期",
    r.report_content AS "报告内容",
    r.author AS "报告作者",
    r.approval_status AS "审批状态",
    e.event_id AS "事件ID",
    e.event_type AS "事件类型",
    e.event_description AS "事件描述"
FROM 
    risk_reports r
JOIN 
    risk_events e ON r.event_id = e.event_id
WHERE 
    r.approved_by = '高志远';	3283769605
SELECT 
    ri.indicator_id AS "风险指标ID",
    ri.indicator_name AS "指标名称",
    ri.threshold_value AS "设定阈值",
    rml.actual_value AS "当前实际值",
    rml.monitoring_date AS "最后更新时间"
FROM 
    risk_indicators ri
LEFT JOIN LATERAL (
    SELECT 
        actual_value,
        monitoring_date
    FROM 
        risk_monitoring_logs
    WHERE 
        indicator_id = ri.indicator_id
    ORDER BY 
        monitoring_date DESC
    LIMIT 1
) rml ON true;	747719750
SELECT 
    rml.log_id AS "监控日志ID",
    rml.actual_value AS "实际监控值",
    ri.indicator_name AS "风险指标名称"
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id;	334580003
SELECT 
    AVG(impact_score) AS avg_impact_score, 
    AVG(probability_score) AS avg_probability_score 
FROM risk_assessments;	388467912
SELECT 
    re.event_id AS "风险事件ID", 
    re.event_description AS "事件描述", 
    ra.assessor AS "评估人"
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    ra.assessor IS NOT NULL;	3589660339
SELECT SUM(amount) AS total_refund_amount 
FROM transactions 
WHERE transaction_type = '退款';	1785182803
SELECT 
    ri.indicator_id AS indicator_id,
    ri.indicator_name AS indicator_name,
    ri.indicator_description AS indicator_description,
    ri.measurement_unit AS measurement_unit,
    ri.threshold_value AS threshold_value,
    rml.actual_value AS latest_actual_value,
    rml.monitoring_date AS latest_monitoring_date
FROM 
    risk_indicators ri
LEFT JOIN LATERAL (
    SELECT 
        actual_value,
        monitoring_date
    FROM 
        risk_monitoring_logs
    WHERE 
        indicator_id = ri.indicator_id
    ORDER BY 
        monitoring_date DESC
    LIMIT 1
) rml ON true
ORDER BY 
    ri.indicator_name;	3949045999
SELECT 
    re.event_type AS risk_type, 
    AVG(EXTRACT(EPOCH FROM (ra.assessment_date - re.occurrence_time))/3600) AS avg_mitigation_hours
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    ra.assessment_date >= re.occurrence_time
GROUP BY 
    re.event_type;	1365503712
SELECT event_type AS risk_type, COUNT(*) AS event_count 
FROM risk_events 
GROUP BY event_type;	454781039
SELECT 
    ra.assessment_id AS "风险评估ID",
    re.event_description AS "风险事件描述",
    ra.assessor AS "评估人"
FROM 
    risk_assessments ra
JOIN 
    risk_events re ON ra.event_id = re.event_id;	312146930
SELECT 
    rml.log_id AS monitoring_log_id,
    rml.indicator_id AS risk_indicator_id,
    rml.monitoring_date AS monitoring_timestamp,
    rml.actual_value AS measured_value,
    rml.is_exceeding_threshold AS threshold_exceeded,
    rml.notes AS monitoring_notes,
    (SELECT COUNT(*) FROM risk_monitoring_logs WHERE is_exceeding_threshold = TRUE) AS total_exceeded_records
FROM 
    risk_monitoring_logs rml
WHERE 
    rml.is_exceeding_threshold = TRUE;	3050678212
SELECT 
    re.event_id AS "风险事件ID", 
    ra.assessment_id AS "评估记录ID", 
    ra.mitigation_plan AS "缓解措施方案"
FROM 
    risk_events re
LEFT JOIN 
    risk_assessments ra ON re.event_id = ra.event_id;	2500244814
SELECT 
    report_id AS "报告ID", 
    report_type AS "报告类型", 
    report_date AS "报告日期", 
    author AS "作者" 
FROM 
    risk_reports 
WHERE 
    approval_status = '已批准';	2753692877
SELECT 
    customer_id AS "客户唯一标识",
    customer_name AS "客户名称",
    customer_type AS "客户类型",
    credit_score AS "信用评分",
    risk_level AS "风险等级",
    registration_date AS "注册日期",
    last_update_date AS "最后更新日期"
FROM customers
WHERE risk_level = '高' 
AND credit_score > (SELECT AVG(credit_score) FROM customers);	2701292510
SELECT 
    alert_id AS "预警ID", 
    alert_content AS "预警内容", 
    assigned_to AS "处理人" 
FROM alerts;	3788454929
SELECT 
    event_id AS "风险事件ID",
    event_description AS "事件描述",
    severity AS "严重程度",
    created_at AS "创建时间",
    occurrence_time AS "解决时间",
    (occurrence_time - created_at) AS "处理时长"
FROM 
    risk_events 
WHERE 
    status = 'RESOLVED' 
ORDER BY 
    "处理时长" DESC 
LIMIT 10;	1494274200
SELECT 
    rc.rule_id AS rule_identifier,
    rc.rule_name AS rule_name,
    rc.rule_description AS rule_description,
    rc.rule_type AS rule_type,
    rc.rule_condition AS rule_condition,
    rc.rule_action AS rule_action,
    rc.is_active AS is_active,
    rc.created_at AS rule_creation_time,
    rc.updated_at AS rule_update_time,
    ri.indicator_id AS risk_indicator_identifier,
    ri.indicator_name AS risk_indicator_name
FROM 
    rule_configurations rc
LEFT JOIN 
    risk_indicators ri ON rc.indicator_id = ri.indicator_id
WHERE 
    rc.is_active = true;	2741655674
SELECT risk_level AS "风险等级", COUNT(*) AS "客户总数" FROM customers GROUP BY risk_level;	4006191467
SELECT 
    event_id AS "风险事件ID", 
    event_description AS "风险事件描述", 
    reporter AS "报告人姓名"
FROM 
    risk_events 
WHERE 
    status != '已处理';	1366443289
SELECT event_id, created_at AS event_creation_time FROM risk_events WHERE severity >= 3;	2713864982
SELECT 
    assessment_id AS "风险评估ID", 
    mitigation_plan AS "缓解措施方案", 
    assessor AS "评估人员" 
FROM 
    risk_assessments;	4176420377
SELECT 
    a.alert_id AS "预警ID", 
    a.alert_content AS "预警内容详情", 
    a.alert_level AS "预警级别", 
    re.event_description AS "风险事件描述", 
    latest_audit.audit_comments AS "最新审核意见", 
    latest_audit.audit_time AS "审核时间"
FROM 
    alerts a
JOIN 
    risk_events re ON a.event_id = re.event_id
LEFT JOIN LATERAL (
    SELECT 
        al.audit_comments, 
        al.audit_time
    FROM 
        audit_logs al
    WHERE 
        al.alert_id = a.alert_id
    ORDER BY 
        al.audit_time DESC
    LIMIT 1
) AS latest_audit ON true
WHERE 
    a.status != '已解决' AND a.alert_level = '高'
LIMIT 100;	2609744326
SELECT 
    ra.assessment_id AS "风险评估ID",
    ra.risk_level AS "风险等级",
    ra.mitigation_plan AS "缓解措施方案",
    re.event_id AS "事件ID",
    re.event_type AS "事件类型",
    re.event_description AS "事件描述"
FROM 
    risk_assessments ra
JOIN 
    risk_events re ON ra.event_id = re.event_id
WHERE 
    ra.risk_level = '高';	1472140605
SELECT DISTINCT c.customer_id AS "客户唯一标识", 
       c.customer_name AS "客户名称", 
       t.amount AS "交易金额"
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE c.risk_level = 'high'
  AND t.amount > 100000
  AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	4016844576
SELECT assessment_id AS "风险评估ID", event_id AS "关联事件ID" FROM risk_assessments WHERE impact_score > 8 AND risk_level = '高';	1206095116
SELECT 
    re.event_id AS risk_event_id, 
    rr.report_type AS report_type, 
    rr.report_content AS report_content
FROM 
    risk_events re
LEFT JOIN 
    risk_reports rr ON re.event_id = rr.event_id;	747204718
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.report_type = '季度报告'
  AND r.approval_status = '需修改'
  AND n.npl_ratio > 0.02
  AND r.report_date BETWEEN '2023-07-01' AND '2023-09-30'
  AND n.report_date BETWEEN '2023-07-01' AND '2023-09-30';	380031248
SELECT 
    report_id AS "监管报告ID", 
    institution_id AS "机构ID", 
    report_date AS "报告日期", 
    report_type AS "报告类型", 
    submission_date AS "提交日期", 
    approval_status AS "审批状态", 
    comments AS "备注" 
FROM 
    regulatory_reports 
WHERE 
    submission_date = '2023-11-01';	796615861
SELECT DISTINCT fii.institution_name AS financial_institution_name
FROM financial_institution_info fii
JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id
JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id
WHERE DATE_TRUNC('month', car.report_date) = '2023-06-01' 
  AND DATE_TRUNC('month', npl.report_date) = '2023-06-01'
  AND car.total_car < 12
  AND npl.npl_ratio > 2;	226307394
SELECT 
    f.institution_name AS institution_name
FROM 
    risk_exposure r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
ORDER BY 
    (r.market_risk_exposure / NULLIF(r.total_risk_exposure, 0)) DESC
LIMIT 1;	2186232166
SELECT 
    f.institution_name AS "金融机构名称",
    r.report_id AS "报告标识符",
    r.report_type AS "报告类型",
    r.approval_status AS "审批状态",
    f.registered_capital AS "注册资本"
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    r.report_date BETWEEN '2023-07-01' AND '2023-09-30'
    AND r.report_type = '季度报告'
    AND r.approval_status = '需修改'
    AND f.registered_capital > 50000000;	3832687129
SELECT 
    f.institution_name AS "机构名称",
    c.risk_weighted_assets / b.total_assets AS "风险加权资产密度"
FROM 
    financial_institution_info f
JOIN 
    capital_adequacy_ratio c ON f.institution_id = c.institution_id
JOIN 
    balance_sheet b ON f.institution_id = b.institution_id AND c.report_date = b.report_date
WHERE 
    c.risk_weighted_assets IS NOT NULL 
    AND b.total_assets IS NOT NULL
    AND b.total_assets > 0
ORDER BY 
    "风险加权资产密度" DESC
LIMIT 1;	3593789396
SELECT 
    liquidity_coverage_ratio AS short_term_liquidity_risk_coverage,
    net_stable_funding_ratio AS medium_long_term_funding_stability
FROM 
    liquidity_ratio;	3734281326
SELECT DISTINCT fii.institution_id AS institution_identifier
FROM financial_institution_info fii
JOIN compliance_records cr ON fii.institution_id = cr.institution_id
WHERE cr.record_date BETWEEN '2023-12-01' AND '2023-12-31'
AND cr.status != 'Resolved';	2976622725
SELECT 
    b.institution_id AS institution_id,
    b.loans_and_advances AS total_loans,
    b.deposits AS total_deposits
FROM 
    balance_sheet b
WHERE 
    b.report_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY 
    b.institution_id;	3196242817
SELECT 
    institution_id AS financial_institution_id,
    report_date AS balance_sheet_date,
    total_assets AS total_assets_amount,
    total_liabilities AS total_liabilities_amount,
    total_equity AS total_shareholders_equity,
    cash_and_equivalents AS cash_equivalents_amount,
    loans_and_advances AS total_loans_amount,
    deposits AS total_deposits_amount
FROM balance_sheet
WHERE report_date = '2039-06-08';	1889616376
SELECT COUNT(DISTINCT institution_id) AS high_risk_institution_count 
FROM non_performing_loans 
WHERE npl_ratio > 3;	453935379
SELECT 
    net_interest_income AS "净利息收入", 
    non_interest_income AS "非利息收入"
FROM 
    income_statement 
WHERE 
    report_date = '2023-03-01';	44191459
SELECT 
    npl_amount AS non_performing_loan_amount,
    total_loans AS total_loan_amount,
    (npl_amount / total_loans) AS non_performing_loan_ratio
FROM non_performing_loans;	584013962
SELECT DISTINCT f.institution_name AS financial_institution
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.report_type = '季度报告'
  AND r.approval_status = '需修改'
  AND EXTRACT(YEAR FROM r.report_date) = 2023
  AND EXTRACT(YEAR FROM n.report_date) = 2023
  AND n.npl_ratio > 1;	2733428482
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
WHERE r.report_date = '2023-10-01'
  AND r.report_type = '半年度报告'
  AND r.approval_status = '待审核';	951459633
SELECT 
    institution_name AS "金融机构名称",
    registered_capital AS "注册资本金额"
FROM 
    financial_institution_info 
WHERE 
    institution_type != '银行' 
ORDER BY 
    registered_capital DESC 
LIMIT 5;	1829456676
SELECT COUNT(*) AS qualifying_institutions_count
FROM (
    SELECT fi.institution_id
    FROM financial_institution_info fi
    JOIN balance_sheet bs ON fi.institution_id = bs.institution_id
    ORDER BY bs.total_assets DESC
    LIMIT 500
) AS top_500_assets
JOIN non_performing_loans npl ON top_500_assets.institution_id = npl.institution_id
WHERE npl.npl_ratio < 1 AND npl.provision_coverage_ratio > 200;	1953695337
SELECT DISTINCT f.institution_name AS non_compliant_institution_name
FROM financial_institution_info f
WHERE EXISTS (
    SELECT 1 FROM capital_adequacy_ratio c 
    WHERE c.institution_id = f.institution_id 
    AND c.report_date = '2023-12-01' 
    AND c.core_tier_1_ratio < 10
)
AND EXISTS (
    SELECT 1 FROM regulatory_reports r 
    WHERE r.institution_id = f.institution_id 
    AND r.report_date = '2023-12-01' 
    AND r.approval_status = '待审核'
);	1414930652
SELECT 
    i.institution_name
FROM 
    financial_institution_info i
JOIN 
    income_statement curr_inc ON i.institution_id = curr_inc.institution_id
JOIN 
    income_statement prev_inc ON i.institution_id = prev_inc.institution_id
    AND prev_inc.report_date = (
        SELECT MAX(report_date) 
        FROM income_statement 
        WHERE institution_id = i.institution_id 
        AND report_date < curr_inc.report_date
        AND report_date >= CURRENT_DATE - INTERVAL '2 years'
    )
WHERE 
    curr_inc.report_date >= CURRENT_DATE - INTERVAL '2 years'
    AND prev_inc.report_date IS NOT NULL
ORDER BY 
    (curr_inc.net_interest_income + curr_inc.non_interest_income - prev_inc.net_interest_income - prev_inc.non_interest_income) / NULLIF(prev_inc.net_interest_income + prev_inc.non_interest_income, 0) DESC,
    (curr_inc.net_profit - prev_inc.net_profit) / NULLIF(prev_inc.net_profit, 0) ASC
LIMIT 1;	364214965
SELECT report_id AS "监管报告ID", approval_status AS "审批状态" 
FROM regulatory_reports 
WHERE report_date = '2023-07-01';	419882166
SELECT fi.institution_id, fi.institution_name
FROM financial_institution_info fi
JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id
WHERE car.core_tier_1_ratio > (SELECT AVG(core_tier_1_ratio) FROM capital_adequacy_ratio)
  AND car.tier_1_ratio > (SELECT AVG(tier_1_ratio) FROM capital_adequacy_ratio)
  AND car.total_car > (SELECT AVG(total_car) FROM capital_adequacy_ratio);	3742684421
SELECT 
    record_id AS "合规记录ID", 
    institution_id AS "机构ID", 
    record_date AS "记录日期", 
    compliance_type AS "合规类型", 
    description AS "问题描述", 
    severity AS "严重程度", 
    status AS "当前状态", 
    resolution_date AS "解决日期" 
FROM 
    compliance_records 
WHERE 
    status = '已解决' 
    AND record_date BETWEEN '2023-01-01' AND '2023-12-31';	2448874069
SELECT report_type, COUNT(*) AS submission_count 
FROM regulatory_reports 
WHERE report_date BETWEEN '2023-07-01' AND '2023-09-30' 
GROUP BY report_type 
ORDER BY submission_count DESC 
LIMIT 1;	3679648301
SELECT 
    tier_1_ratio AS tier_1_capital_adequacy_ratio,
    COUNT(*) AS institution_count,
    MIN(tier_1_ratio) AS min_tier_1_ratio,
    MAX(tier_1_ratio) AS max_tier_1_ratio,
    AVG(tier_1_ratio) AS avg_tier_1_ratio,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY tier_1_ratio) AS percentile_25_tier_1_ratio,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY tier_1_ratio) AS median_tier_1_ratio,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY tier_1_ratio) AS percentile_75_tier_1_ratio
FROM capital_adequacy_ratio
GROUP BY tier_1_ratio
ORDER BY tier_1_ratio;	293590145
SELECT 
    f.institution_name AS institution_name,
    l.report_date AS report_date
FROM 
    financial_institution_info f
JOIN 
    liquidity_ratio l ON f.institution_id = l.institution_id
WHERE 
    l.liquidity_coverage_ratio > 100;	685587392
SELECT 
    fii.institution_name AS "金融机构名称",
    STDDEV(bs.total_liabilities / NULLIF(bs.total_assets, 0)) AS "资产负债率波动程度",
    (MAX(lr.liquidity_coverage_ratio) - MIN(lr.liquidity_coverage_ratio)) / NULLIF(MIN(lr.liquidity_coverage_ratio), 0) * 100 AS "流动性覆盖率变化百分比"
FROM 
    financial_institution_info fii
JOIN 
    balance_sheet bs ON fii.institution_id = bs.institution_id
JOIN 
    liquidity_ratio lr ON fii.institution_id = lr.institution_id
WHERE 
    bs.report_date >= CURRENT_DATE - INTERVAL '2 years'
    AND lr.report_date >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY 
    fii.institution_id, fii.institution_name
HAVING 
    COUNT(DISTINCT bs.report_date) > 1
    AND COUNT(DISTINCT lr.report_date) > 1
    AND STDDEV(bs.total_liabilities / NULLIF(bs.total_assets, 0)) IS NOT NULL
ORDER BY 
    "资产负债率波动程度" DESC
LIMIT 5;	727742801
SELECT 
    record_id AS "合规记录ID",
    institution_id AS "所属机构ID", 
    record_date AS "记录日期",
    resolution_date AS "解决日期",
    description AS "问题描述",
    severity AS "严重程度",
    status AS "当前状态",
    compliance_type AS "合规类型"
FROM compliance_records
WHERE record_date >= '2023-03-01' AND record_date <= '2023-03-31';	3429671168
SELECT 
    cr.institution_id AS institution_identifier,
    cr.record_date AS compliance_submission_date,
    cr.description AS compliance_description,
    cr.severity AS violation_severity_level
FROM 
    compliance_records cr
WHERE 
    cr.record_date BETWEEN '2024-01-01' AND '2024-12-31';	3200376501
SELECT report_type AS regulatory_report_type 
FROM regulatory_reports 
WHERE report_date = '2023-10-01' 
GROUP BY report_type;	1891907399
SELECT 
    record_id AS "合规记录ID",
    institution_id AS "机构ID",
    record_date AS "记录日期",
    compliance_type AS "合规类型",
    description AS "详细描述",
    severity AS "严重程度",
    status AS "当前状态",
    resolution_date AS "解决日期"
FROM compliance_records
WHERE severity = '中' AND record_date BETWEEN '2023-01-01' AND '2023-12-31';	11596427
SELECT 
    record_id AS compliance_record_id,
    institution_id AS financial_institution_id,
    record_date AS compliance_date,
    compliance_type AS compliance_category,
    description AS compliance_details,
    severity AS severity_level,
    status AS current_status,
    resolution_date AS resolution_date
FROM 
    compliance_records
WHERE 
    record_date = '2023-10-01';	3129849565
SELECT 
    f.institution_id,
    f.institution_name
FROM 
    financial_institution_info f
JOIN (
    SELECT 
        institution_id,
        AVG(liquidity_coverage_ratio) AS avg_liquidity_coverage_ratio,
        AVG(net_stable_funding_ratio) AS avg_net_stable_funding_ratio,
        AVG(loan_to_deposit_ratio) AS avg_loan_to_deposit_ratio
    FROM 
        liquidity_ratio
    GROUP BY 
        institution_id
) l ON f.institution_id = l.institution_id
WHERE 
    l.avg_liquidity_coverage_ratio > (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio)
    AND l.avg_net_stable_funding_ratio > (SELECT AVG(net_stable_funding_ratio) FROM liquidity_ratio)
    AND l.avg_loan_to_deposit_ratio < (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio);	3154891263
SELECT 
    fii.institution_name AS "机构名称",
    rr.report_type AS "报告类型",
    rr.submission_date AS "提交日期"
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fii ON rr.institution_id = fii.institution_id
WHERE 
    rr.approval_status = '需修改'
    AND rr.submission_date BETWEEN '2023-07-01' AND '2023-09-30'
ORDER BY 
    rr.submission_date DESC;	1874414819
SELECT DISTINCT f.institution_name
FROM financial_institution_info f
JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE c.total_car <= (SELECT percentile_cont(0.25) WITHIN GROUP (ORDER BY total_car) FROM capital_adequacy_ratio)
AND n.npl_ratio < (SELECT AVG(npl_ratio) FROM non_performing_loans);	495816064
SELECT 
    institution_name AS "金融机构名称",
    registered_capital AS "注册资本",
    institution_type AS "机构类型"
FROM 
    financial_institution_info;	4161304037
SELECT establishment_date AS "成立时间", legal_representative AS "负责人姓名" FROM financial_institution_info;	1631317162
SELECT 
    record_id AS "合规记录ID", 
    institution_id AS "机构ID", 
    record_date AS "记录日期", 
    compliance_type AS "合规类型", 
    description AS "问题描述", 
    severity AS "严重程度", 
    status AS "当前状态", 
    resolution_date AS "解决日期" 
FROM 
    compliance_records 
WHERE 
    status = '已解决';	2784626903
SELECT DISTINCT 
    f.institution_name AS "金融机构名称", 
    r.approval_status AS "监管报告状态", 
    n.npl_ratio AS "不良贷款比率"
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.approval_status = '需修改'
  AND n.npl_ratio > 1
  AND r.report_date BETWEEN '2023-07-01' AND '2023-07-31'
  AND n.report_date BETWEEN '2023-07-01' AND '2023-07-31';	1450759690
SELECT 
    b.institution_id AS financial_institution_id,
    f.institution_name AS financial_institution_name,
    ABS(b.loans_and_advances / NULLIF(b.deposits, 0) - 1) AS loan_to_deposit_deviation,
    (b.loans_and_advances / NULLIF(b.deposits, 0)) AS actual_ratio
FROM 
    balance_sheet b
JOIN 
    financial_institution_info f ON b.institution_id = f.institution_id
WHERE 
    b.deposits > 0
ORDER BY 
    loan_to_deposit_deviation ASC
LIMIT 1;	862814083
SELECT DISTINCT 
    n.institution_id AS financial_institution_id, 
    f.institution_name AS financial_institution_name
FROM non_performing_loans n
JOIN financial_institution_info f ON n.institution_id = f.institution_id
WHERE n.total_loans > 100000000000;	2681992996
SELECT cash_and_equivalents AS immediate_liquid_assets 
FROM balance_sheet 
WHERE report_date = '2026-04-27';	3797835240
SELECT DISTINCT 
    f.institution_id AS institution_id, 
    f.institution_name AS institution_name
FROM 
    financial_institution_info f
JOIN 
    capital_adequacy_ratio c ON f.institution_id = c.institution_id
WHERE 
    c.core_tier_1_ratio < 9;	788537141
SELECT 
    f.institution_name AS "金融机构名称",
    r.report_type AS "报告类型",
    r.approval_status AS "审批状态",
    n.npl_ratio AS "不良贷款率"
FROM 
    financial_institution_info f
    JOIN regulatory_reports r ON f.institution_id = r.institution_id
    JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE 
    r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.report_type = '季度报告'
    AND r.approval_status = '已拒绝'
    AND n.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND n.npl_ratio > 2;	2511418954
WITH top_risk_weighted_institutions AS (
    SELECT 
        car.institution_id,
        car.risk_weighted_assets / bs.total_assets AS risk_weighted_assets_ratio,
        re.market_risk_exposure
    FROM capital_adequacy_ratio car
    JOIN balance_sheet bs ON car.institution_id = bs.institution_id AND car.report_date = bs.report_date
    JOIN risk_exposure re ON car.institution_id = re.institution_id AND car.report_date = re.report_date
    ORDER BY risk_weighted_assets_ratio DESC
    LIMIT 10
)
SELECT 
    COUNT(*) AS high_risk_institution_count
FROM top_risk_weighted_institutions
WHERE market_risk_exposure > 7.704337197451174e+11;	133973236
SELECT NULL AS avg_branch_count_per_institution;
REASONING: 数据库结构中未发现包含分支机构信息的表或字段，无法计算该指标;	580723534
SELECT DISTINCT fii.institution_id AS institution_id, fii.institution_name AS institution_name
FROM financial_institution_info fii
JOIN risk_exposure re ON fii.institution_id = re.institution_id
JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id
WHERE (re.market_risk_exposure / NULLIF(re.total_risk_exposure, 0)) > 0.2
AND car.core_tier_1_ratio < 8.5;	627590872
SELECT 
    f.institution_name AS "金融机构名称",
    c.core_tier_1_ratio AS "核心一级资本充足率",
    c.tier_1_ratio AS "一级资本充足率",
    c.total_car AS "总资本充足率"
FROM 
    capital_adequacy_ratio c
JOIN 
    financial_institution_info f ON c.institution_id = f.institution_id
WHERE 
    c.report_date = '2023-12-01' 
    AND c.core_tier_1_ratio < 10 
    AND c.total_car < 12;	3208012990
SELECT COUNT(*) AS high_severity_compliance_issues_count 
FROM compliance_records 
WHERE severity = '高' 
AND record_date BETWEEN '2023-01-01' AND '2023-12-31';	377707744
SELECT 
    f.institution_name AS highest_cash_ratio_institution
FROM 
    financial_institution_info f
JOIN 
    balance_sheet b ON f.institution_id = b.institution_id
ORDER BY 
    (b.cash_and_equivalents / NULLIF(b.total_assets, 0)) DESC
LIMIT 1;	2467976254
SELECT 
    f.institution_name AS financial_institution_name
FROM 
    risk_exposure r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    (r.market_risk_exposure / NULLIF(r.total_risk_exposure, 0)) > 0.4;	416448494
SELECT 
    f.institution_name AS "机构名称",
    r.approval_status AS "监管审批状态",
    r.comments AS "透明度评述"
FROM 
    financial_institution_info f
JOIN 
    regulatory_reports r ON f.institution_id = r.institution_id
WHERE 
    r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.approval_status = '已批准'
ORDER BY 
    r.comments DESC
LIMIT 100;	1582694445
SELECT DISTINCT f.institution_name AS non_compliant_institution
FROM financial_institution_info f
JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id
JOIN regulatory_reports r ON f.institution_id = r.institution_id
WHERE c.core_tier_1_ratio < 8
  AND r.approval_status = '已批准'
  AND c.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND r.report_date BETWEEN '2023-01-01' AND '2023-12-31';	3631241992
SELECT 
    r.institution_id AS institution_identifier,
    r.credit_risk_exposure AS credit_risk_exposure_amount,
    r.operational_risk_exposure AS operational_risk_exposure_amount
FROM 
    risk_exposure r
WHERE 
    r.report_date >= '2024-01-01' 
    AND r.report_date < '2024-02-01';	3632342709
SELECT 
    record_id AS "合规记录ID", 
    institution_id AS "机构ID", 
    record_date AS "记录日期", 
    resolution_date AS "解决日期", 
    description AS "描述内容", 
    severity AS "严重程度", 
    status AS "当前状态", 
    compliance_type AS "合规类型" 
FROM 
    compliance_records 
WHERE 
    record_date = '2023-04-02';	2274602916
SELECT 
    npl.report_date AS report_date,
    npl.npl_ratio AS non_performing_loan_ratio,
    car.total_car AS capital_adequacy_ratio
FROM 
    non_performing_loans npl
JOIN 
    capital_adequacy_ratio car ON npl.institution_id = car.institution_id AND npl.report_date = car.report_date
ORDER BY 
    npl.report_date DESC
LIMIT 100;	3547022021
SELECT 
    n.institution_id AS financial_institution_id,
    n.provision_coverage_ratio AS coverage_ratio
FROM 
    non_performing_loans n
WHERE 
    n.provision_coverage_ratio > 1.5;	4106988075
SELECT 
    transaction_id AS "交易唯一标识",
    institution_id AS "机构编号", 
    transaction_date AS "交易日期",
    related_party AS "相关方信息",
    transaction_type AS "交易类型",
    transaction_amount AS "交易金额",
    approval_status AS "审批状态"
FROM 
    related_party_transactions
WHERE 
    transaction_date = '2023-12-22';	1714782457
SELECT DISTINCT f.institution_name
FROM financial_institution_info f
JOIN liquidity_ratio l ON f.institution_id = l.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE l.liquidity_coverage_ratio > 110 AND n.npl_ratio < 1.5;	663454855
SELECT DISTINCT 
    r.institution_id AS institution_id,
    f.institution_name AS institution_name,
    r.report_type AS report_type,
    r.approval_status AS approval_status,
    n.npl_ratio AS npl_ratio
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
JOIN 
    non_performing_loans n ON r.institution_id = n.institution_id 
    AND DATE_TRUNC('year', r.report_date) = DATE_TRUNC('year', n.report_date)
WHERE 
    DATE_TRUNC('year', r.report_date) = '2023-01-01'::date
    AND r.report_type = '季度报告'
    AND r.approval_status = '需修改'
    AND n.npl_ratio > 2
ORDER BY 
    n.npl_ratio DESC;	1930062711
SELECT 
    i.institution_id AS institution_identifier,
    AVG(i.net_profit / NULLIF((i.net_interest_income + i.non_interest_income), 0)) AS average_net_profit_margin,
    f.institution_name AS institution_name
FROM 
    income_statement i
JOIN 
    financial_institution_info f ON i.institution_id = f.institution_id
WHERE 
    i.report_date >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY 
    i.institution_id, f.institution_name
ORDER BY 
    average_net_profit_margin DESC
LIMIT 5;	166707732
SELECT 
    fi.institution_type AS "金融机构类型",
    AVG(npl.npl_ratio) AS "平均不良贷款率"
FROM 
    financial_institution_info fi
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE 
    EXTRACT(YEAR FROM npl.report_date) = 2023
GROUP BY 
    fi.institution_type;	833967887
WITH market_risk_growth AS (
    SELECT 
        r1.institution_id,
        (r2.market_risk_exposure - r1.market_risk_exposure) / r1.market_risk_exposure * 100 AS growth_rate
    FROM 
        risk_exposure r1
    JOIN 
        risk_exposure r2 ON r1.institution_id = r2.institution_id
    WHERE 
        r1.report_date = (SELECT MIN(report_date) FROM risk_exposure WHERE institution_id = r1.institution_id AND report_date >= CURRENT_DATE - INTERVAL '1 year')
        AND r2.report_date = (SELECT MAX(report_date) FROM risk_exposure WHERE institution_id = r1.institution_id AND report_date >= CURRENT_DATE - INTERVAL '1 year')
        AND r1.market_risk_exposure > 0
),
car_change AS (
    SELECT 
        c1.institution_id,
        (c2.total_car - c1.total_car) AS car_change
    FROM 
        capital_adequacy_ratio c1
    JOIN 
        capital_adequacy_ratio c2 ON c1.institution_id = c2.institution_id
    WHERE 
        c1.report_date = (SELECT MIN(report_date) FROM capital_adequacy_ratio WHERE institution_id = c1.institution_id AND report_date >= CURRENT_DATE - INTERVAL '1 year')
        AND c2.report_date = (SELECT MAX(report_date) FROM capital_adequacy_ratio WHERE institution_id = c1.institution_id AND report_date >= CURRENT_DATE - INTERVAL '1 year')
        AND c1.total_car > 0
)
SELECT 
    COUNT(DISTINCT m.institution_id) AS qualifying_institutions_count
FROM 
    market_risk_growth m
JOIN 
    car_change c ON m.institution_id = c.institution_id
WHERE 
    m.growth_rate > 50
    AND c.car_change < 1;	4204116228
SELECT 
    institution_id AS "机构ID",
    total_assets AS "总资产",
    total_liabilities AS "总负债"
FROM 
    balance_sheet;	771560804
SELECT 
    fii.institution_name AS "金融机构名称",
    rr.approval_status AS "监管报告状态",
    rpt.transaction_amount AS "关联交易金额"
FROM 
    financial_institution_info fii
JOIN 
    regulatory_reports rr ON fii.institution_id = rr.institution_id
JOIN 
    related_party_transactions rpt ON fii.institution_id = rpt.institution_id
WHERE 
    rr.report_date BETWEEN '2023-07-01' AND '2023-07-31'
    AND rr.approval_status = '需修改'
    AND rpt.transaction_amount > 5000000
    AND rpt.transaction_date BETWEEN '2023-07-01' AND '2023-07-31';	1414769749
SELECT AVG(car.total_car) AS average_capital_adequacy_ratio
FROM capital_adequacy_ratio car
WHERE car.institution_id IN (
    SELECT DISTINCT bs.institution_id 
    FROM balance_sheet bs 
    WHERE bs.total_assets > 1000000000000
    AND bs.report_date = (
        SELECT MAX(report_date) 
        FROM balance_sheet 
        WHERE institution_id = bs.institution_id
    )
);	2946947084
SELECT 
    risk_exposure_id AS "风险暴露ID",
    institution_id AS "机构ID",
    report_date AS "报告日期",
    credit_risk_exposure AS "信用风险暴露金额",
    market_risk_exposure AS "市场风险暴露金额",
    operational_risk_exposure AS "操作风险暴露金额",
    total_risk_exposure AS "总风险暴露金额"
FROM 
    risk_exposure
WHERE 
    report_date = '2023-10-01';	68375114
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN related_party_transactions r ON f.institution_id = r.institution_id
JOIN regulatory_reports rr ON f.institution_id = rr.institution_id
WHERE r.transaction_date = '2023-06-01' 
  AND r.transaction_amount > 5000000
  AND rr.approval_status = '已批准';	1086344523
SELECT 
    CORR(b.total_assets, c.total_car) AS asset_capital_adequacy_correlation
FROM 
    balance_sheet b
JOIN 
    capital_adequacy_ratio c ON b.institution_id = c.institution_id AND b.report_date = c.report_date
WHERE 
    b.total_assets IS NOT NULL 
    AND c.total_car IS NOT NULL;	1266365033
SELECT 
    f.institution_name AS "金融机构名称",
    COUNT(CASE WHEN r.approval_status != 'approved' THEN 1 END) * 100.0 / COUNT(*) AS "未通过审批比例(%)"
FROM 
    related_party_transactions r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    EXTRACT(YEAR FROM r.transaction_date) = 2023
GROUP BY 
    f.institution_id, f.institution_name
HAVING 
    COUNT(CASE WHEN r.approval_status != 'approved' THEN 1 END) * 100.0 / COUNT(*) > 20
ORDER BY 
    "未通过审批比例(%)" DESC;	152560977
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.report_date = '2023-07-01'
  AND r.report_type = '季度报告'
  AND r.approval_status = '需修改'
  AND n.npl_ratio > 2.0;	3829846580
SELECT 
    f.institution_id AS institution_identifier,
    r.approval_status AS approval_result_status,
    c.compliance_type AS compliance_category,
    c.severity AS issue_severity_level,
    c.status AS current_processing_status
FROM 
    financial_institution_info f
LEFT JOIN 
    (SELECT DISTINCT ON (institution_id) institution_id, approval_status 
     FROM regulatory_reports 
     WHERE EXTRACT(YEAR FROM report_date) = 2023 
     ORDER BY institution_id, report_date DESC) r 
    ON f.institution_id = r.institution_id
LEFT JOIN 
    (SELECT DISTINCT ON (institution_id) institution_id, compliance_type, severity, status 
     FROM compliance_records 
     WHERE EXTRACT(YEAR FROM record_date) = 2023 
     ORDER BY institution_id, record_date DESC) c 
    ON f.institution_id = c.institution_id
WHERE 
    r.approval_status IS NOT NULL OR c.compliance_type IS NOT NULL
ORDER BY 
    f.institution_id
LIMIT 100;	3809349460
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.report_date = '2023-10-01' 
  AND r.report_type = '半年度报告'
  AND n.npl_ratio > 2;	3887529815
SELECT 
    lr.institution_id AS institution_id,
    lr.liquidity_coverage_ratio AS liquidity_coverage_ratio,
    lr.net_stable_funding_ratio AS net_stable_funding_ratio
FROM liquidity_ratio lr
WHERE lr.report_date BETWEEN '2023-05-01' AND '2023-05-31';	1095324516
SELECT 
    i.institution_id AS institution_id,
    SUM(s.non_interest_income) AS total_non_interest_income
FROM 
    financial_institution_info i
JOIN 
    income_statement s ON i.institution_id = s.institution_id
WHERE 
    s.report_date = '2023-03-01'
GROUP BY 
    i.institution_id;	2608079409
SELECT 
    risk_exposure_id AS "风险暴露唯一标识",
    institution_id AS "所属机构标识",
    report_date AS "报告日期",
    credit_risk_exposure AS "信用风险暴露值",
    market_risk_exposure AS "市场风险暴露值",
    operational_risk_exposure AS "操作风险暴露值",
    total_risk_exposure AS "风险暴露总值"
FROM 
    risk_exposure
WHERE 
    report_date = '2023-02-01';	1384996686
SELECT COUNT(*) AS transaction_count 
FROM related_party_transactions 
WHERE transaction_type = '资产转移' 
  AND transaction_amount > 500000000 
  AND EXTRACT(YEAR FROM transaction_date) = 2023;	2903384914
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
WHERE EXISTS (
    SELECT 1 FROM regulatory_reports r 
    WHERE r.institution_id = f.institution_id 
    AND r.report_date = '2023-08-01' 
    AND r.approval_status = '需修改'
)
AND EXISTS (
    SELECT 1 FROM related_party_transactions t 
    WHERE t.institution_id = f.institution_id 
    AND t.transaction_amount > 5000000
);	1640671061
SELECT DISTINCT f.institution_id AS institution_id, 
                f.institution_name AS institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN income_statement i ON f.institution_id = i.institution_id
WHERE r.report_type = '季度报告'
  AND r.approval_status = '已拒绝'
  AND EXTRACT(YEAR FROM r.report_date) = 2023
  AND EXTRACT(YEAR FROM i.report_date) = 2023
  AND EXTRACT(QUARTER FROM i.report_date) = 1
  AND i.net_profit > 10000000;	3904574419
SELECT DISTINCT f.institution_name AS financial_institution
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
WHERE r.report_date = '2023-07-01' 
  AND r.report_type = 'Quarterly'
  AND r.approval_status = 'Needs Modification';	493525183
SELECT 
    record_id AS "合规记录ID", 
    institution_id AS "机构ID", 
    record_date AS "记录日期", 
    compliance_type AS "合规类型", 
    description AS "描述", 
    severity AS "严重程度", 
    status AS "当前状态", 
    resolution_date AS "解决日期" 
FROM 
    compliance_records 
WHERE 
    compliance_type = '内控管理';	3146074594
SELECT DISTINCT 
    f.institution_name AS institution_name, 
    r.report_type AS report_type, 
    r.approval_status AS approval_status, 
    n.npl_ratio AS npl_ratio
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.report_date BETWEEN '2023-10-01' AND '2023-10-31'
  AND r.report_type = '半年度报告'
  AND r.approval_status = '待审核'
  AND n.npl_ratio > 1.0;	2337714646
SELECT 
    fi.institution_type AS institution_type,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl.npl_ratio) AS median_npl_ratio
FROM 
    financial_institution_info fi
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
GROUP BY 
    fi.institution_type;	2791588181
SELECT 
    car_id AS "资本充足率记录ID", 
    institution_id AS "金融机构ID", 
    report_date AS "报告日期", 
    core_tier_1_ratio AS "核心一级资本充足率", 
    tier_1_ratio AS "一级资本充足率", 
    total_car AS "总资本充足率", 
    risk_weighted_assets AS "风险加权资产总额" 
FROM 
    capital_adequacy_ratio 
WHERE 
    core_tier_1_ratio < 8;	833263523
SELECT 
    f.institution_id AS institution_id, 
    f.institution_name AS institution_name, 
    f.registered_capital AS registered_capital, 
    r.report_type AS report_type, 
    r.approval_status AS approval_status
FROM 
    financial_institution_info f
JOIN 
    regulatory_reports r ON f.institution_id = r.institution_id
WHERE 
    r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.report_type = '半年度报告'
    AND r.approval_status = '待审核'
    AND f.registered_capital > 50000000;	3179741002
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN related_party_transactions r ON f.institution_id = r.institution_id
WHERE r.transaction_date = '2023-06-01'
  AND r.transaction_amount > 5000000
  AND r.approval_status = '待审批';	2065261887
SELECT 
    fi.institution_id,
    fi.institution_name
FROM 
    liquidity_ratio lr
JOIN 
    financial_institution_info fi ON lr.institution_id = fi.institution_id
GROUP BY 
    fi.institution_id, fi.institution_name
HAVING 
    AVG(lr.loan_to_deposit_ratio) > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio)
    AND AVG(lr.liquidity_coverage_ratio) < (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio);	2360476437
SELECT fi.institution_name AS financial_institution_name
FROM financial_institution_info fi
JOIN income_statement ist ON fi.institution_id = ist.institution_id
WHERE ist.report_date = '2023-04-01' 
  AND ist.net_interest_income > 1000000000;	1635102268
SELECT DISTINCT r.institution_id AS institution_identifier,
       r.report_id AS report_identifier,
       r.report_type AS report_category,
       r.approval_status AS approval_state,
       n.npl_ratio AS non_performing_loan_ratio
FROM regulatory_reports r
JOIN non_performing_loans n ON r.institution_id = n.institution_id
WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND r.report_type = '季度报告'
  AND r.approval_status = '需修改'
  AND n.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND n.npl_ratio > 1.0;	890576370
SELECT 
    f.institution_name AS "金融机构名称",
    r.total_risk_exposure AS "总风险暴露金额",
    c.core_tier_1_ratio AS "核心一级资本充足率"
FROM 
    financial_institution_info f
JOIN 
    risk_exposure r ON f.institution_id = r.institution_id
JOIN 
    capital_adequacy_ratio c ON f.institution_id = c.institution_id
WHERE 
    r.report_date = '2023-10-01' 
    AND c.report_date = '2023-10-01'
    AND r.total_risk_exposure > 300000000000
    AND c.core_tier_1_ratio < 8;	1878253672
SELECT COUNT(DISTINCT re1.institution_id) AS significant_change_institutions_count
FROM risk_exposure re1
JOIN risk_exposure re2 ON re1.institution_id = re2.institution_id
WHERE re1.report_date >= CURRENT_DATE - INTERVAL '1 year'
  AND re2.report_date >= CURRENT_DATE - INTERVAL '1 year'
  AND re1.report_date < re2.report_date
  AND ABS((re1.market_risk_exposure / NULLIF(re1.credit_risk_exposure, 0)) - 
          (re2.market_risk_exposure / NULLIF(re2.credit_risk_exposure, 0))) > 0.1;	860852233
SELECT DISTINCT fi.institution_id AS institution_identifier, fi.institution_name AS financial_institution_name
FROM balance_sheet bs
JOIN financial_institution_info fi ON bs.institution_id = fi.institution_id
WHERE bs.loans_and_advances > bs.deposits;	3387337626
SELECT 
    f.institution_name AS "机构名称",
    r.report_date AS "报告日期",
    r.approval_status AS "审批状态"
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.report_type = '季度报告'
    AND r.approval_status = '已拒绝';	1310122613
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN income_statement i ON f.institution_id = i.institution_id
WHERE i.report_date = '2023-04-01' AND i.non_interest_income > 200000000;	663309404
SELECT 
    fii.institution_name AS institution_name,
    COUNT(*) AS transaction_count
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fii ON rpt.institution_id = fii.institution_id
WHERE 
    rpt.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    fii.institution_name
ORDER BY 
    transaction_count DESC
LIMIT 1;	3052564664
SELECT 
    f.institution_name AS "机构名称",
    (r.credit_risk_exposure / r.total_risk_exposure * 100) AS "信用风险暴露占比(%)"
FROM 
    risk_exposure r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
ORDER BY 
    "信用风险暴露占比(%)" DESC
LIMIT 1;	3564915606
SELECT DISTINCT fii.institution_id AS financial_institution_id
FROM financial_institution_info fii
JOIN risk_exposure re ON fii.institution_id = re.institution_id
WHERE re.report_date BETWEEN '2023-01-01' AND '2023-12-31';	197691923
SELECT 
    fi.institution_id AS institution_id,
    fi.institution_name AS institution_name
FROM 
    financial_institution_info fi
WHERE 
    fi.institution_id IN (
        SELECT 
            car.institution_id
        FROM 
            capital_adequacy_ratio car
        WHERE 
            car.report_date BETWEEN '2023-11-01' AND '2023-11-30'
            AND car.risk_weighted_assets > 120000000000
    );	4129983532
SELECT 
    severity AS severity_level,
    AVG(resolution_date - record_date) AS average_resolution_days
FROM compliance_records
WHERE status = 'Resolved' 
    AND resolution_date IS NOT NULL 
    AND record_date IS NOT NULL
GROUP BY severity
ORDER BY severity;	2233736633
SELECT COUNT(DISTINCT lr.institution_id) AS compliant_institutions_count
FROM liquidity_ratio lr
WHERE lr.liquidity_coverage_ratio > 100 
  AND lr.net_stable_funding_ratio > 100;	2305237654
SELECT 
    AVG(npl.npl_ratio) AS avg_non_performing_loan_ratio,
    AVG(npl.provision_coverage_ratio) AS avg_provision_coverage_ratio,
    AVG(car.total_car) AS avg_capital_adequacy_ratio
FROM 
    financial_institution_info fi
JOIN 
    balance_sheet bs ON fi.institution_id = bs.institution_id
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id AND bs.report_date = npl.report_date
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id AND bs.report_date = car.report_date
WHERE 
    fi.institution_id IN (
        SELECT institution_id 
        FROM balance_sheet 
        WHERE report_date = (SELECT MAX(report_date) FROM balance_sheet)
        ORDER BY total_assets DESC 
        LIMIT 1000
    );	2186326450
SELECT 
    f.institution_name AS institution_name,
    r.report_type AS report_type,
    n.npl_ratio AS npl_ratio
FROM 
    financial_institution_info f
JOIN 
    regulatory_reports r ON f.institution_id = r.institution_id
JOIN 
    non_performing_loans n ON f.institution_id = n.institution_id
WHERE 
    r.report_date = '2023-07-01'
    AND r.report_type = '季度报告'
    AND n.report_date = '2023-07-01'
    AND n.npl_ratio > 1.5;	2638456489
SELECT DISTINCT f.institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.report_date = '2024-01-01'
  AND r.report_type = '年度报告'
  AND r.approval_status = '已批准'
  AND n.npl_ratio > 1.0;	3113756288
SELECT 
    lr.liquidity_coverage_ratio AS liquidity_risk_short_term,
    lr.net_stable_funding_ratio AS funding_stability_long_term,
    lr.loan_to_deposit_ratio AS asset_liability_structure
FROM 
    liquidity_ratio lr
WHERE 
    lr.report_date = (SELECT MAX(report_date) FROM liquidity_ratio);	1220868379
SELECT DISTINCT f.institution_name
FROM financial_institution_info f
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE n.report_date BETWEEN '2023-12-01' AND '2023-12-31'
AND n.npl_ratio > 1.5;	576576905
SELECT DISTINCT f.institution_name
FROM financial_institution_info f
JOIN liquidity_ratio l ON f.institution_id = l.institution_id
WHERE l.loan_to_deposit_ratio > 75 AND l.liquidity_coverage_ratio < 120;	4037291156
SELECT 
    report_id AS "报告唯一标识符",
    institution_id AS "机构标识符",
    report_date AS "报告日期",
    report_type AS "报告类型",
    submission_date AS "提交日期",
    approval_status AS "审批状态",
    comments AS "附加说明"
FROM 
    regulatory_reports
WHERE 
    report_type = '半年度报告';	163054391
SELECT 
    cr.record_id AS "案例ID",
    cr.institution_id AS "所属机构ID",
    cr.record_date AS "创建日期",
    cr.compliance_type AS "合规类型",
    cr.description AS "问题描述",
    cr.severity AS "严重程度",
    cr.status AS "当前状态",
    cr.resolution_date AS "解决日期"
FROM compliance_records cr
WHERE cr.resolution_date IS NOT NULL
ORDER BY (cr.resolution_date - cr.record_date) DESC
LIMIT 5;	3390154129
SELECT 
    r.institution_id AS institution_id,
    r.report_id AS regulatory_report_id,
    r.report_type AS report_type,
    r.approval_status AS approval_status,
    n.npl_ratio AS non_performing_loan_ratio
FROM 
    regulatory_reports r
JOIN 
    non_performing_loans n ON r.institution_id = n.institution_id
WHERE 
    r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND n.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.report_type = '季度报告'
    AND r.approval_status = '已拒绝'
    AND n.npl_ratio > 2;	1510688156
SELECT 
    fi.institution_name AS "机构名称",
    rr.report_id AS "报告ID",
    rr.report_date AS "报告日期",
    rr.comments AS "备注信息"
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '已拒绝';	776982448
SELECT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN liquidity_ratio l ON f.institution_id = l.institution_id
WHERE l.loan_to_deposit_ratio BETWEEN 60 AND 80;	3735593182
SELECT 
    car.institution_id AS institution_id,
    fi.institution_name AS institution_name,
    ABS(car.core_tier_1_ratio - car.total_car) AS capital_adequacy_difference
FROM 
    capital_adequacy_ratio car
JOIN 
    financial_institution_info fi ON car.institution_id = fi.institution_id
ORDER BY 
    capital_adequacy_difference ASC
LIMIT 1;	1403047777
SELECT 
    b.institution_id AS institution_identifier,
    b.total_liabilities AS total_liabilities_amount,
    f.registered_capital AS registered_capital_amount
FROM 
    balance_sheet b
JOIN 
    financial_institution_info f ON b.institution_id = f.institution_id
WHERE 
    b.report_date >= '2024-01-01' AND b.report_date <= '2024-12-31';	2008864858
SELECT 
    CORR(re.credit_risk_exposure, npl.npl_ratio) AS credit_risk_npl_correlation
FROM 
    risk_exposure re
JOIN 
    non_performing_loans npl ON re.institution_id = npl.institution_id AND re.report_date = npl.report_date;	4061107202
SELECT DISTINCT f.institution_name AS approved_institution_with_high_car
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id
WHERE r.report_type = '年度报告' 
  AND r.approval_status = 'Approved'
  AND EXTRACT(YEAR FROM r.report_date) = 2023
  AND c.total_car > 10
  AND EXTRACT(YEAR FROM c.report_date) = 2023;	1821132508
SELECT 
    npl.institution_id AS financial_institution_id,
    npl.npl_ratio AS non_performing_loan_ratio,
    fi.institution_name AS financial_institution_name
FROM non_performing_loans npl
JOIN financial_institution_info fi ON npl.institution_id = fi.institution_id
WHERE npl.report_date = '2023-06-01';	1128459706
SELECT DISTINCT f.institution_name AS financial_institution
FROM financial_institution_info f
JOIN risk_exposure r ON f.institution_id = r.institution_id
WHERE r.market_risk_exposure > 20000000000
AND r.report_date >= '2023-05-01' 
AND r.report_date <= '2023-05-31';	4259113020
SELECT 
    f.institution_name AS institution_name,
    r.report_date AS report_date,
    r.approval_status AS approval_status
FROM 
    financial_institution_info f
JOIN 
    regulatory_reports r ON f.institution_id = r.institution_id
WHERE 
    r.report_type = '年度报告'
    AND r.approval_status = '已批准'
    AND r.report_date >= '2024-01-01' 
    AND r.report_date <= '2024-12-31';	3886257211
SELECT 
    car_id AS capital_adequacy_id, 
    institution_id, 
    report_date, 
    core_tier_1_ratio, 
    tier_1_ratio, 
    total_car AS total_capital_adequacy_ratio, 
    risk_weighted_assets
FROM 
    capital_adequacy_ratio
WHERE 
    report_date = '2023-11-01';	1168290373
SELECT 
    corr(lr.net_stable_funding_ratio, car.core_tier_1_ratio) AS correlation_coefficient,
    covar_pop(lr.net_stable_funding_ratio, car.core_tier_1_ratio) AS covariance,
    regr_r2(lr.net_stable_funding_ratio, car.core_tier_1_ratio) AS r_squared,
    regr_slope(lr.net_stable_funding_ratio, car.core_tier_1_ratio) AS regression_slope,
    regr_intercept(lr.net_stable_funding_ratio, car.core_tier_1_ratio) AS regression_intercept
FROM 
    liquidity_ratio lr
JOIN 
    capital_adequacy_ratio car 
    ON lr.institution_id = car.institution_id 
    AND lr.report_date = car.report_date;	2077067574
SELECT 
    f.institution_name AS institution_name, 
    r.report_date AS report_submission_date
FROM regulatory_reports r
JOIN financial_institution_info f ON r.institution_id = f.institution_id
WHERE r.report_type = '年度报告' 
  AND r.approval_status = '已批准'
  AND r.report_date >= '2024-01-01' 
  AND r.report_date <= '2024-12-31';	2225198432
SELECT 
    car_id AS "资本充足率记录ID", 
    institution_id AS "金融机构ID", 
    report_date AS "报告日期", 
    core_tier_1_ratio AS "核心一级资本充足率", 
    tier_1_ratio AS "一级资本充足率", 
    total_car AS "总资本充足率", 
    risk_weighted_assets AS "风险加权资产" 
FROM 
    capital_adequacy_ratio 
WHERE 
    report_date = '2023-11-01';	1600202324
SELECT 
    core_tier_1_ratio AS "核心一级资本充足率(%)",
    tier_1_ratio AS "一级资本充足率(%)", 
    total_car AS "总资本充足率(%)", 
    risk_weighted_assets AS "风险加权资产(元)", 
    report_date AS "报告日期"
FROM capital_adequacy_ratio 
WHERE institution_id = 2162;	1999653381
SELECT 
    n.institution_id AS institution_id,
    n.total_loans AS total_loan_amount_2023,
    n.npl_amount AS non_performing_loan_amount_2023
FROM 
    non_performing_loans n
WHERE 
    EXTRACT(YEAR FROM n.report_date) = 2023;	4241341417
SELECT 
    CORR(
        (re.market_risk_exposure / NULLIF(re.total_risk_exposure, 0)),
        (i.non_interest_income / NULLIF((i.net_interest_income + i.non_interest_income), 0))
    ) AS market_risk_to_trading_income_correlation
FROM 
    risk_exposure re
JOIN 
    income_statement i ON re.institution_id = i.institution_id AND re.report_date = i.report_date;	885949604
SELECT 
    fi.institution_id AS financial_institution_id,
    fi.institution_name AS financial_institution_name,
    npl.provision_coverage_ratio AS loan_loss_provision_coverage_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
ORDER BY 
    npl.provision_coverage_ratio DESC
LIMIT 1;	2230661366
SELECT 
    fi.institution_id,
    fi.institution_name,
    lr.report_date,
    lr.liquidity_coverage_ratio AS liquidity_coverage_ratio,
    lr.net_stable_funding_ratio AS net_stable_funding_ratio,
    lr.loan_to_deposit_ratio AS loan_to_deposit_ratio,
    car.core_tier_1_ratio AS core_tier_1_ratio,
    car.tier_1_ratio AS tier_1_ratio,
    car.total_car AS total_capital_adequacy_ratio
FROM 
    financial_institution_info fi
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id AND lr.report_date = car.report_date
WHERE 
    EXTRACT(YEAR FROM lr.report_date) = 2023;	2148224764
SELECT 
    f.institution_name AS institution_name,
    i.operating_expenses AS operating_expenses
FROM 
    income_statement i
JOIN 
    financial_institution_info f ON i.institution_id = f.institution_id
WHERE 
    i.report_date = '2023-04-01'
ORDER BY 
    i.operating_expenses DESC
LIMIT 10;	1163520286
SELECT 
    i.institution_id AS institution_id,
    i.institution_name AS institution_name,
    SUM(s.non_interest_income) AS total_non_interest_income,
    SUM(s.net_profit) AS total_net_profit
FROM 
    financial_institution_info i
JOIN 
    income_statement s ON i.institution_id = s.institution_id
WHERE 
    EXTRACT(YEAR FROM s.report_date) = 2023
GROUP BY 
    i.institution_id, i.institution_name;	3770945123
SELECT 
    f.institution_name AS "金融机构名称",
    r.report_type AS "报告类型",
    r.approval_status AS "审批状态",
    n.npl_ratio AS "不良贷款率"
FROM 
    financial_institution_info f
    JOIN regulatory_reports r ON f.institution_id = r.institution_id
    JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE 
    r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.report_type = '季度报告'
    AND r.approval_status = '已拒绝'
    AND n.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND n.npl_ratio > 2;	3353540268
SELECT DISTINCT f.institution_name AS financial_institution
FROM financial_institution_info f
JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id
WHERE c.report_date BETWEEN '2023-12-01' AND '2023-12-31'
AND c.core_tier_1_ratio < 9;	2078748822
SELECT 
    fi.institution_id AS financial_institution_id, 
    fi.institution_name AS financial_institution_name
FROM liquidity_ratio lr
JOIN financial_institution_info fi ON lr.institution_id = fi.institution_id
WHERE lr.report_date BETWEEN '2023-11-01' AND '2023-11-30'
AND lr.liquidity_coverage_ratio < 110
GROUP BY fi.institution_id, fi.institution_name;	953035312
SELECT 
    re.market_risk_exposure AS market_risk_exposure_value,
    npl.provision_coverage_ratio AS provision_coverage_ratio_percentage
FROM 
    risk_exposure re
JOIN 
    non_performing_loans npl ON re.institution_id = npl.institution_id AND re.report_date = npl.report_date
WHERE 
    re.report_date = '2023-03-01';	2823110481
SELECT 
    legal_representative AS legal_representative_name, 
    contact_number AS institution_contact_number 
FROM financial_institution_info;	1671662541
SELECT 
    f.institution_name AS financial_institution,
    COUNT(DISTINCT r.related_party) AS distinct_counterparties_count
FROM 
    financial_institution_info f
JOIN 
    related_party_transactions r ON f.institution_id = r.institution_id
WHERE 
    r.transaction_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    f.institution_id, f.institution_name
ORDER BY 
    distinct_counterparties_count DESC;	2071522801
SELECT 
    SUBSTRING(address FROM '^([^市]+市)') AS region,
    AVG(lr.liquidity_coverage_ratio) AS avg_liquidity_coverage_ratio
FROM financial_institution_info fi
JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id
GROUP BY SUBSTRING(address FROM '^([^市]+市)')
ORDER BY avg_liquidity_coverage_ratio DESC;	205800859
SELECT 
    EXTRACT(QUARTER FROM report_date) AS report_quarter,
    AVG(LENGTH(comments)) AS avg_comment_word_count
FROM regulatory_reports
WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY report_quarter
ORDER BY report_quarter;	3274370781
SELECT 
    fi.institution_name AS institution_name,
    npl.provision_coverage_ratio AS provision_coverage_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
ORDER BY 
    npl.provision_coverage_ratio DESC
LIMIT 1;	1230704489
SELECT legal_representative AS legal_representative_name, contact_number AS contact_phone 
FROM financial_institution_info;	1986352436
SELECT 
    f.institution_name AS "机构名称",
    r.report_date AS "报告日期",
    r.submission_date AS "提交日期"
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.report_type = '季度报告'
    AND r.approval_status = '需修改';	171565062
SELECT 
    f.institution_name AS "金融机构名称",
    c.total_car AS "资本充足率",
    n.npl_ratio AS "不良贷款率"
FROM 
    financial_institution_info f
JOIN 
    capital_adequacy_ratio c ON f.institution_id = c.institution_id
JOIN 
    non_performing_loans n ON f.institution_id = n.institution_id
WHERE 
    c.total_car > 12 
    AND n.npl_ratio < 2;	1038814840
SELECT 
    f.institution_id AS financial_institution_id, 
    f.institution_name AS institution_name
FROM 
    financial_institution_info f
JOIN 
    liquidity_ratio l ON f.institution_id = l.institution_id
WHERE 
    l.net_stable_funding_ratio > (SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY net_stable_funding_ratio) FROM liquidity_ratio)
    AND l.loan_to_deposit_ratio < (SELECT PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY loan_to_deposit_ratio) FROM liquidity_ratio)
ORDER BY 
    l.net_stable_funding_ratio DESC, 
    l.loan_to_deposit_ratio ASC
LIMIT 10;	1181628181
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN risk_exposure r ON f.institution_id = r.institution_id
WHERE r.credit_risk_exposure > 50000000000
AND EXTRACT(YEAR FROM r.report_date) = 2023;	3568939453
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE n.npl_ratio > 2.0;	716682341
SELECT 
    car_id AS "资本充足率记录ID", 
    institution_id AS "金融机构ID", 
    report_date AS "报告日期", 
    core_tier_1_ratio AS "核心一级资本充足率", 
    tier_1_ratio AS "一级资本充足率", 
    total_car AS "总资本充足率", 
    risk_weighted_assets AS "风险加权资产" 
FROM 
    capital_adequacy_ratio 
WHERE 
    report_date = '2023-05-01';	2344870041
SELECT 
    cr.institution_id AS institution_id,
    cr.severity AS severity_level,
    COUNT(*) AS record_count
FROM 
    compliance_records cr
WHERE 
    cr.record_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    cr.institution_id, cr.severity
ORDER BY 
    cr.institution_id, record_count DESC;	79705771
SELECT 
    f.institution_name AS "机构名称",
    r.report_date AS "报告日期",
    r.comments AS "备注信息"
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.report_type = '季度报告'
    AND r.approval_status = '已拒绝';	3897795864
SELECT 
    fi.institution_id AS institution_id,
    rpt.transaction_id AS transaction_id,
    rpt.transaction_amount AS transaction_amount
FROM related_party_transactions rpt
JOIN financial_institution_info fi ON rpt.institution_id = fi.institution_id;	3910780788
SELECT 
    f.institution_name AS "金融机构名称",
    r.report_type AS "监管报告类型",
    SUM(t.transaction_amount) AS "关联交易总金额"
FROM 
    financial_institution_info f
JOIN 
    regulatory_reports r ON f.institution_id = r.institution_id
JOIN 
    related_party_transactions t ON f.institution_id = t.institution_id
WHERE 
    r.report_date = '2023-10-01' 
    AND r.report_type = '半年度报告'
GROUP BY 
    f.institution_name, r.report_type
HAVING 
    SUM(t.transaction_amount) > 10000000;	463284912
SELECT 
    f.institution_name AS "机构名称",
    r.report_id AS "报告ID", 
    r.report_date AS "报告日期", 
    r.comments AS "审批意见"
FROM regulatory_reports r
JOIN financial_institution_info f ON r.institution_id = f.institution_id
WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND r.report_type = '季度报告'
    AND r.approval_status = '已拒绝';	3023341474
SELECT 
    f.institution_name AS "金融机构名称",
    r.report_type AS "报告类型",
    r.approval_status AS "审批状态",
    r.submission_date AS "提交日期"
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    EXTRACT(YEAR FROM r.report_date) = 2023
    AND r.report_type = '季度报告'
    AND r.approval_status = '已拒绝';	100349185
SELECT 
    n.npl_ratio AS non_performing_loan_ratio,
    f.address AS institution_region
FROM 
    non_performing_loans n
JOIN 
    financial_institution_info f ON n.institution_id = f.institution_id
ORDER BY 
    n.npl_ratio DESC;	1713055268
SELECT 
    r.report_id AS "监管报告ID",
    r.institution_id AS "金融机构ID",
    r.report_date AS "报告日期",
    r.report_type AS "报告类型",
    r.approval_status AS "审批状态"
FROM 
    regulatory_reports r
WHERE 
    r.report_date BETWEEN '2024-01-01' AND '2024-12-31';	1241000114
SELECT 
    fi.institution_type AS institution_type,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lr.liquidity_coverage_ratio) AS median_liquidity_coverage_ratio
FROM 
    financial_institution_info fi
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id
GROUP BY 
    fi.institution_type;	2918395057
SELECT DISTINCT f.institution_id AS institution_identifier,
       r.report_id AS report_identifier,
       r.report_type AS report_type,
       r.approval_status AS approval_status,
       c.core_tier_1_ratio AS core_tier_1_capital_ratio
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id
WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND r.report_type = '季度报告'
  AND r.approval_status = '已拒绝'
  AND c.report_date = '2023-06-01'
  AND c.core_tier_1_ratio < 8;	3292170043
SELECT AVG(npl.npl_ratio) AS avg_non_performing_loan_ratio
FROM (
    SELECT institution_id, report_date, total_car
    FROM capital_adequacy_ratio
    WHERE report_date BETWEEN '2023-07-01' AND '2023-09-30'
    ORDER BY total_car DESC
    LIMIT 10
) AS top_car
JOIN non_performing_loans npl ON top_car.institution_id = npl.institution_id 
    AND top_car.report_date = npl.report_date;	759134662
SELECT fi.institution_name AS institution_with_most_unresolved_compliance
FROM financial_institution_info fi
JOIN compliance_records cr ON fi.institution_id = cr.institution_id
WHERE cr.status != 'Resolved' OR cr.status IS NULL
GROUP BY fi.institution_name
ORDER BY COUNT(cr.record_id) DESC
LIMIT 1;	4264132838
SELECT 
    transaction_id AS "交易唯一标识",
    institution_id AS "机构标识",
    transaction_date AS "交易日期",
    related_party AS "关联方信息",
    transaction_type AS "交易类型",
    transaction_amount AS "交易金额",
    approval_status AS "审批状态"
FROM 
    related_party_transactions
WHERE 
    transaction_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND transaction_amount > 5000000;	2605714275
SELECT DISTINCT fii.institution_id AS financial_institution_id
FROM financial_institution_info fii
JOIN risk_exposure re ON fii.institution_id = re.institution_id
WHERE (re.market_risk_exposure / NULLIF(re.total_risk_exposure, 0)) > 0.25;	1937284507
SELECT 
    f.institution_name AS "机构名称", 
    r.transaction_amount AS "交易金额", 
    r.transaction_type AS "交易类型"
FROM 
    related_party_transactions r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    r.transaction_date BETWEEN '2023-08-01' AND '2023-08-31'
    AND r.transaction_amount > 5000000
    AND r.approval_status = '待审批';	2934397812
SELECT DISTINCT fii.institution_id AS institution_identifier, 
       fii.institution_name AS financial_institution_name
FROM financial_institution_info fii
JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id
JOIN income_statement ist ON fii.institution_id = ist.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '需修改'
  AND ist.report_date BETWEEN '2023-01-01' AND '2023-03-31'
  AND ist.net_profit > 50000000;	508885744
SELECT 
    fi.institution_name AS "金融机构名称"
FROM 
    financial_institution_info fi
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id
WHERE 
    npl.npl_ratio > (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl_ratio) FROM non_performing_loans)
    AND npl.provision_coverage_ratio > (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY provision_coverage_ratio) FROM non_performing_loans)
    AND car.total_car > (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_car) FROM capital_adequacy_ratio)
GROUP BY 
    fi.institution_name;	1632272828
SELECT related_party AS largest_transaction_party
FROM related_party_transactions
ORDER BY transaction_amount DESC
LIMIT 1;	1799492050
SELECT DISTINCT f.institution_name AS pending_approval_institutions
FROM financial_institution_info f
JOIN related_party_transactions rpt ON f.institution_id = rpt.institution_id
WHERE rpt.transaction_date = '2023-10-01' AND rpt.approval_status = '待审批';	2216482912
SELECT DISTINCT f.institution_name AS institution_name
FROM financial_institution_info f
JOIN risk_exposure r ON f.institution_id = r.institution_id
WHERE r.report_date BETWEEN '2023-05-01' AND '2023-05-31'
AND r.total_risk_exposure > 15000000000;	1256154419
SELECT DISTINCT f.institution_id, f.institution_name, f.registered_capital
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND r.report_type = '季度报告'
  AND r.approval_status = '需修改'
  AND f.registered_capital > 50000000;	4262674456
SELECT 
    institution_id AS institution_identifier,
    report_date AS report_date,
    market_risk_exposure AS market_risk_exposure_value,
    credit_risk_exposure AS credit_risk_exposure_value
FROM risk_exposure
WHERE report_date BETWEEN '2023-11-01' AND '2023-11-30';	710647517
SELECT 
    re.institution_id AS institution_id,
    re.credit_risk_exposure AS credit_risk_exposure,
    re.total_risk_exposure AS total_risk_exposure
FROM 
    risk_exposure re
WHERE 
    re.report_date = '2023-09-01';	58767252
SELECT 
    f.institution_name AS "金融机构名称",
    r.transaction_amount AS "交易金额(元)",
    r.approval_status AS "审批状态"
FROM 
    financial_institution_info f 
JOIN 
    related_party_transactions r ON f.institution_id = r.institution_id 
WHERE 
    r.transaction_date BETWEEN '2023-05-01' AND '2023-05-31'
    AND r.transaction_amount > 5000000
    AND r.approval_status = '已批准'
ORDER BY 
    r.transaction_amount DESC;	637645661
SELECT DISTINCT institution_id AS financial_institution_id
FROM capital_adequacy_ratio
WHERE risk_weighted_assets > 800000000000;	3688064451
SELECT COUNT(DISTINCT fii.institution_id) AS qualified_institutions_count
FROM financial_institution_info fii
JOIN balance_sheet bs ON fii.institution_id = bs.institution_id
WHERE fii.registered_capital < 1000000000 AND bs.total_assets > 100000000000;	3547661219
SELECT f.institution_name AS financial_institution_name,
       car.total_car AS capital_adequacy_ratio,
       npl.npl_ratio AS non_performing_loan_ratio
FROM financial_institution_info f
JOIN capital_adequacy_ratio car ON f.institution_id = car.institution_id
JOIN non_performing_loans npl ON f.institution_id = npl.institution_id
WHERE car.report_date BETWEEN '2023-07-01' AND '2023-09-30'
  AND npl.report_date BETWEEN '2023-07-01' AND '2023-09-30'
  AND car.total_car < 12
  AND npl.npl_ratio > 2;	162610329
SELECT 
    submission_date AS report_submission_date,
    approval_status AS report_approval_status
FROM 
    regulatory_reports;	1552788455
SELECT f.institution_name AS highest_asset_institution
FROM financial_institution_info f
JOIN balance_sheet b ON f.institution_id = b.institution_id
WHERE EXTRACT(YEAR FROM b.report_date) = 2024
ORDER BY b.total_assets DESC
LIMIT 1;	116844122
SELECT 
    compliance_type AS "合规类型",
    AVG(resolution_date - record_date) AS "平均解决天数"
FROM 
    compliance_records
WHERE 
    severity = '严重' 
    AND record_date >= '2023-01-01' 
    AND record_date <= '2023-12-31'
    AND resolution_date IS NOT NULL
GROUP BY 
    compliance_type
ORDER BY 
    "平均解决天数" DESC
LIMIT 1;	4240691021
SELECT 
    f.institution_name AS "金融机构名称",
    r.report_type AS "监管报告类型",
    t.transaction_amount AS "关联交易金额"
FROM 
    financial_institution_info f
JOIN 
    regulatory_reports r ON f.institution_id = r.institution_id
JOIN 
    related_party_transactions t ON f.institution_id = t.institution_id
WHERE 
    r.report_date = '2023-10-01'
    AND r.report_type = '半年度报告'
    AND t.transaction_amount > 5000000;	1677817776
SELECT AVG(non_interest_income) AS avg_non_interest_income
FROM income_statement
WHERE report_date = '2023-01-01';	1301409349
SELECT 
    report_date AS report_date, 
    npl_amount AS non_performing_loan_amount
FROM 
    non_performing_loans
WHERE 
    report_date >= '2023-06-01' 
    AND report_date <= '2023-06-30';	948022455
SELECT 
    fi.institution_id AS institution_id,
    fi.institution_name AS institution_name
FROM 
    financial_institution_info fi
WHERE 
    fi.institution_id IN (
        SELECT DISTINCT npl.institution_id 
        FROM non_performing_loans npl 
        WHERE npl.provision_coverage_ratio < 200
    );	3714986713
SELECT AVG(car.total_car) AS avg_capital_adequacy_ratio_top10
FROM capital_adequacy_ratio car
JOIN (
    SELECT i.institution_id
    FROM income_statement i
    WHERE i.report_date BETWEEN '2023-10-01' AND '2023-12-31'
    ORDER BY i.net_profit DESC
    LIMIT 10
) top_institutions ON car.institution_id = top_institutions.institution_id
WHERE car.report_date BETWEEN '2023-10-01' AND '2023-12-31';	3771907244
SELECT DISTINCT f.institution_name AS compliant_institution_name
FROM financial_institution_info f
JOIN compliance_records c ON f.institution_id = c.institution_id
WHERE c.description LIKE '%客户投诉%';	1867865451
SELECT 
    i.institution_id AS institution_identifier,
    i.institution_name AS financial_institution,
    s.net_interest_income AS interest_based_income,
    s.non_interest_income AS non_interest_based_income
FROM 
    financial_institution_info i
JOIN 
    income_statement s ON i.institution_id = s.institution_id
WHERE 
    s.report_date BETWEEN '2023-07-01' AND '2023-07-31'
ORDER BY 
    i.institution_id;	246993905
SELECT 
    rr.institution_id AS financial_institution_id,
    rr.report_id AS regulatory_report_id,
    rr.report_type AS report_category,
    rr.approval_status AS approval_status,
    npl.npl_ratio AS non_performing_loan_ratio
FROM 
    regulatory_reports rr
JOIN 
    non_performing_loans npl ON rr.institution_id = npl.institution_id
WHERE 
    rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '已拒绝'
    AND npl.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND npl.npl_ratio > 1.0;	1509764635
SELECT 
    npl_amount AS non_performing_loan_amount, 
    provision_coverage_ratio AS provision_coverage_ratio
FROM 
    non_performing_loans
WHERE 
    report_date = '2023-03-01';	3372111545
SELECT 
    f.institution_id AS "机构ID",
    f.registered_capital AS "注册资本规模(元)",
    c.total_car AS "资本充足水平(%)",
    l.liquidity_coverage_ratio AS "流动性覆盖程度(%)",
    n.npl_ratio AS "不良贷款比例(%)"
FROM 
    financial_institution_info f
LEFT JOIN 
    capital_adequacy_ratio c ON f.institution_id = c.institution_id 
    AND c.report_date = (SELECT MAX(report_date) FROM capital_adequacy_ratio WHERE institution_id = f.institution_id)
LEFT JOIN 
    liquidity_ratio l ON f.institution_id = l.institution_id 
    AND l.report_date = (SELECT MAX(report_date) FROM liquidity_ratio WHERE institution_id = f.institution_id)
LEFT JOIN 
    non_performing_loans n ON f.institution_id = n.institution_id 
    AND n.report_date = (SELECT MAX(report_date) FROM non_performing_loans WHERE institution_id = f.institution_id)
WHERE 
    c.total_car IS NOT NULL 
    AND l.liquidity_coverage_ratio IS NOT NULL 
    AND n.npl_ratio IS NOT NULL
ORDER BY 
    f.registered_capital DESC;	1509942542
SELECT DISTINCT f.institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND r.report_type = '季度报告'
  AND r.approval_status = 'Rejected';	2196231862
SELECT 
    COUNT(DISTINCT fi.institution_id) AS qualifying_institutions_count
FROM 
    financial_institution_info fi
WHERE 
    EXISTS (
        SELECT 1
        FROM non_performing_loans npl1
        JOIN non_performing_loans npl2 ON npl1.institution_id = npl2.institution_id
        WHERE 
            npl1.institution_id = fi.institution_id
            AND EXTRACT(YEAR FROM npl1.report_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
            AND EXTRACT(YEAR FROM npl2.report_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 2
            AND npl2.total_loans > 0
            AND (npl1.total_loans - npl2.total_loans) / npl2.total_loans > 0.2
    )
    AND EXISTS (
        SELECT 1
        FROM capital_adequacy_ratio car1
        JOIN capital_adequacy_ratio car2 ON car1.institution_id = car2.institution_id
        WHERE 
            car1.institution_id = fi.institution_id
            AND EXTRACT(YEAR FROM car1.report_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
            AND EXTRACT(YEAR FROM car2.report_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 2
            AND car1.total_car < car2.total_car
    );	2728172184
SELECT DISTINCT f.institution_name AS financial_institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
WHERE r.report_type = '季度报告'
  AND r.approval_status = '需修改'
  AND r.report_date BETWEEN '2023-07-01' AND '2023-09-30';	3768872221
SELECT DISTINCT f.institution_name AS financial_institution
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.report_date = '2023-07-01' 
  AND r.report_type = '季度报告'
  AND n.report_date = '2023-07-01'
  AND n.npl_ratio > 1;	2784905980
SELECT DISTINCT fii.institution_id AS institution_identifier, fii.institution_name AS institution_name
FROM related_party_transactions rpt
JOIN financial_institution_info fii ON rpt.institution_id = fii.institution_id
WHERE rpt.transaction_date BETWEEN '2023-10-01' AND '2023-10-31';	678545000
SELECT DISTINCT f.institution_name
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN non_performing_loans n ON f.institution_id = n.institution_id
WHERE r.report_date = '2023-07-01' 
  AND r.report_type = '季度报告'
  AND n.report_date = '2023-07-01'
  AND n.npl_ratio > 2;	3037348782
SELECT 
    car.report_date AS report_date,
    car.total_car AS total_capital_adequacy_ratio,
    car.risk_weighted_assets AS total_risk_weighted_assets
FROM 
    capital_adequacy_ratio car
ORDER BY 
    car.report_date DESC,
    car.institution_id;	1162073522
SELECT 
    fi.institution_id AS institution_id,
    fi.institution_name AS institution_name,
    lr.liquidity_coverage_ratio AS liquidity_coverage_ratio,
    rr.approval_status AS regulatory_approval_status
FROM 
    financial_institution_info fi
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id
LEFT JOIN 
    regulatory_reports rr ON fi.institution_id = rr.institution_id 
    AND lr.report_date = rr.report_date
    AND rr.report_type = 'Liquidity'
WHERE 
    EXTRACT(YEAR FROM lr.report_date) = 2023;	1324283532
SELECT DISTINCT 
    f.institution_name AS "机构名称", 
    r.report_date AS "报告提交日期", 
    r.approval_status AS "审批状态"
FROM 
    financial_institution_info f
JOIN 
    regulatory_reports r ON f.institution_id = r.institution_id
WHERE 
    r.report_date > '2023-07-01' 
    AND r.report_type = '季度报告'
    AND r.approval_status = '需修改';	3789302325
SELECT COUNT(*) AS rejected_reports_count
FROM regulatory_reports
WHERE report_date BETWEEN '2023-04-01' AND '2023-06-30'
AND approval_status = 'Rejected';	3524683857
SELECT 
    risk_exposure_id AS "风险暴露ID",
    institution_id AS "机构ID", 
    report_date AS "报告日期",
    credit_risk_exposure AS "信用风险金额",
    market_risk_exposure AS "市场风险金额",
    operational_risk_exposure AS "操作风险金额",
    total_risk_exposure AS "总风险金额"
FROM 
    risk_exposure
WHERE 
    report_date = '2023-10-01';	1676740080
SELECT 
    f.institution_name AS institution_name,
    (b2.loans_and_advances - b1.loans_and_advances) / b1.loans_and_advances * 100 AS loan_growth_rate_percentage
FROM 
    balance_sheet b1
JOIN 
    balance_sheet b2 ON b1.institution_id = b2.institution_id
JOIN 
    financial_institution_info f ON b1.institution_id = f.institution_id
WHERE 
    b1.report_date = (SELECT MIN(report_date) FROM balance_sheet WHERE institution_id = b1.institution_id)
    AND b2.report_date = (SELECT MAX(report_date) FROM balance_sheet WHERE institution_id = b2.institution_id)
    AND b1.loans_and_advances > 0
ORDER BY 
    loan_growth_rate_percentage DESC
LIMIT 1;	3743576610
SELECT 
    f.institution_name AS "金融机构名称",
    (r.market_risk_exposure / (b.total_liabilities + b.total_equity)) * 100 AS "市场风险资本占比(%)"
FROM 
    financial_institution_info f
JOIN 
    risk_exposure r ON f.institution_id = r.institution_id
JOIN 
    balance_sheet b ON f.institution_id = b.institution_id
WHERE 
    EXTRACT(YEAR FROM r.report_date) = 2023
    AND EXTRACT(YEAR FROM b.report_date) = 2023
    AND (r.market_risk_exposure / (b.total_liabilities + b.total_equity)) * 100 > 15
ORDER BY 
    "市场风险资本占比(%)" DESC;	763017611
SELECT 
    f.institution_name AS "机构名称",
    r.report_type AS "报告类型",
    r.submission_date AS "提交日期"
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    r.approval_status = '需修改'
    AND r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY 
    r.submission_date DESC;	227811783
SELECT 
    f.institution_name AS institution_name,
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM related_party_transactions t 
            WHERE t.institution_id = f.institution_id 
            AND t.transaction_date BETWEEN '2023-01-01' AND '2023-12-31'
            AND t.transaction_amount > 10000000
        ) THEN '是' 
        ELSE '否' 
    END AS has_large_transactions_flag
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND r.report_type = '季度报告'
  AND r.approval_status = '需修改'
GROUP BY f.institution_id, f.institution_name
ORDER BY f.institution_name;	636265180
SELECT 
    fii.institution_name AS institution_name,
    fii.institution_type AS institution_category,
    lr.liquidity_coverage_ratio AS liquidity_risk_indicator,
    CASE 
        WHEN fii.institution_name LIKE '%国际%' OR fii.institution_name LIKE '%海外%' OR fii.institution_name LIKE '%跨境%' THEN '国际化机构'
        ELSE '本土机构'
    END AS cross_border_feature
FROM 
    financial_institution_info fii
JOIN 
    liquidity_ratio lr ON fii.institution_id = lr.institution_id;	3904345596
SELECT DISTINCT f.institution_id AS institution_identifier, 
                f.institution_name AS institution_name
FROM financial_institution_info f
JOIN related_party_transactions r ON f.institution_id = r.institution_id
WHERE r.transaction_date BETWEEN '2023-10-01' AND '2023-10-31'
AND r.transaction_amount > 10000000;	2375076145
SELECT 
    f.institution_name AS institution_name,
    COUNT(CASE WHEN r.approval_status != 'approved' THEN 1 END) * 100.0 / COUNT(*) AS rejection_rate_percentage
FROM 
    related_party_transactions r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    r.transaction_date >= '2023-01-01'
GROUP BY 
    f.institution_name
ORDER BY 
    rejection_rate_percentage DESC
LIMIT 1;	1557709908
SELECT 
    f.institution_name AS "机构名称",
    (r.operational_risk_exposure / r.total_risk_exposure * 100) AS "操作风险占比(%)"
FROM 
    risk_exposure r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    EXTRACT(YEAR FROM r.report_date) = 2023
ORDER BY 
    "操作风险占比(%)" DESC
LIMIT 1;	963481309
SELECT DISTINCT f.institution_id AS institution_identifier
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31'
AND r.comments IS NOT NULL
AND r.report_type = 'Annual Report';	3447512985
SELECT 
    npl.npl_id AS "不良贷款唯一标识",
    npl.institution_id AS "机构标识",
    npl.report_date AS "报告日期",
    npl.total_loans AS "贷款总额",
    npl.npl_amount AS "不良贷款金额",
    npl.npl_ratio AS "不良贷款比率",
    npl.provision_coverage_ratio AS "拨备覆盖率",
    fi.institution_name AS "机构名称"
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
WHERE 
    npl.report_date = '2023-03-01';	3623964040
SELECT institution_name AS "机构名称"
FROM financial_institution_info
WHERE legal_representative LIKE '王%';	478636896
SELECT DISTINCT f.institution_name AS financial_institution_name, 
                c.total_car AS total_capital_adequacy_ratio
FROM financial_institution_info f
JOIN regulatory_reports r ON f.institution_id = r.institution_id
JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id
WHERE r.report_date BETWEEN '2023-01-01' AND '2023-03-31'
  AND (r.report_type LIKE '%资本充足率%' OR r.comments LIKE '%资本充足率%')
  AND c.report_date BETWEEN '2023-01-01' AND '2023-03-31'
  AND c.total_car > 10;	1733036868
