SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'  -- 客户服务部的department_id
  AND ar.date = '2024-10-13'  -- 指定日期
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 15;  -- 计算工作时间是否超过15小时;	3457299966
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-10-11'
  AND ar.check_in > '09:00:00';	1044893251
SELECT COUNT(*) AS late_days
FROM attendance_records
WHERE employee_id = 'H03961'
  AND EXTRACT(YEAR FROM date) = 2024
  AND check_in > '09:00:00';	3626797096
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24'
  AND ar.check_in < '08:30:00'
  AND pe.rating = 'A+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	207527642
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
    ar.date = '2024-10-05'
ORDER BY 
    e.name;	4093748071
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id 
    AND ar.date = '2024-09-21'
ORDER BY 
    d.name;	4123999737
WITH 
-- 获取所有试用期员工总数
total_probation AS (
    SELECT COUNT(*) AS total_count
    FROM probation_employees
),
-- 获取未满三个月就离职的试用期员工数量
early_leavers AS (
    SELECT COUNT(*) AS early_leavers_count
    FROM probation_employees
    WHERE status = '离职' 
    AND (end_date - start_date) < 90  -- 三个月约90天
)
-- 计算比例
SELECT 
    (early_leavers.early_leavers_count * 100.0 / 
     NULLIF(total_probation.total_count, 0)) AS early_leaving_percentage
FROM 
    total_probation, 
    early_leavers;	560968712
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'  -- 客户服务部的department_id
  AND ar.date = '2024-10-08'      -- 指定日期
  AND ar.check_in > '09:00:00'    -- 迟到条件（上班时间晚于9:00）
ORDER BY ar.check_in;	2123418406
SELECT e.name, e.hire_date
FROM employees e
JOIN probation_employees pe ON e.employee_id = pe.employee_id
WHERE pe.status = 'probation';	2685336973
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-09-22'
  AND ar.check_in > '09:00:00'
  AND e.remaining_annual_leave < 5;	1786804299
SELECT 
    e.employee_id,
    e.name,
    ar.date AS attendance_date,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
LEFT JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    EXTRACT(YEAR FROM e.hire_date) = 2023
    AND ar.date = '2024-10-05'
ORDER BY 
    e.employee_id;	187164736
SELECT 
    e.employee_id,
    e.name,
    ar.date AS attendance_date,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
LEFT JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    EXTRACT(YEAR FROM e.hire_date) = 2023
    AND ar.date = '2024-09-26'
ORDER BY 
    e.employee_id;	16656251
SELECT COUNT(*) 
FROM attendance_records 
WHERE employee_id = 'H05598' 
  AND date BETWEEN '2024-01-01' AND '2024-12-31' 
  AND check_out < '18:00:00';	3745687130
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-28'
    AND ar.check_in > '09:00:00'
ORDER BY 
    e.employee_id;	2706374430
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00007'
  AND ar.date = '2024-10-12'
  AND ar.check_in > '09:00:00';	1934436050
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-10-11'
AND ar.check_in > '09:00:00';	3074190923
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部'
  AND ar.date = '2024-09-21'
  AND ar.check_in > '09:00:00';	511554832
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-12-11'
AND pe.rating = 'C';	2699770862
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-22'
AND ar.check_in > '09:00:00';	2054121283
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '创新奖'
  AND p.rating = 'A+'
  AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	1458867293
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'
  AND ar.date = '2024-10-09'
  AND ar.check_in > '08:30:00'
ORDER BY ar.check_in;	3998131614
SELECT COUNT(DISTINCT a.employee_id) AS award_recipients_in_probation
FROM awards a
JOIN probation_employees p ON a.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '优秀员工'
  AND (
      (p.start_date <= '2023-12-31' AND p.end_date >= '2023-01-01') -- 试用期跨越2023年
      OR (EXTRACT(YEAR FROM p.start_date) = 2023) -- 试用期开始于2023年
      OR (EXTRACT(YEAR FROM p.end_date) = 2023) -- 试用期结束于2023年
  );	3232263409
SELECT e.employee_id, e.name, a.award_name, a.year
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2021
AND a.year = 2022;	3292642794
SELECT 
    ar.employee_id,
    e.name AS employee_name,
    ar.date,
    COUNT(*) AS record_count
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
GROUP BY 
    ar.employee_id, e.name, ar.date
HAVING 
    COUNT(*) > 1
ORDER BY 
    ar.date, ar.employee_id;	1309577663
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-09-24'
  AND ar.check_in > '09:30:00'
  AND e.remaining_annual_leave < 10;	3488243740
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部'
  AND ar.date = '2024-09-19'
  AND ar.check_in > '09:00:00';	651157477
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-26'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'C'
ORDER BY d.name;	53102733
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2021
  AND EXTRACT(YEAR FROM a.year) = 2021
  AND pe.rating = 'B';	3108523290
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部'
  AND ar.date = '2024-10-03'
  AND ar.check_in > '09:00:00';	840538968
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN probation_employees p ON e.employee_id = p.employee_id
WHERE a.year = 2020 
  AND a.award_name = '优秀员工'
  AND p.status = '在职'
  AND CURRENT_DATE BETWEEN p.start_date AND p.end_date;	3192644686
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2023
  AND EXTRACT(YEAR FROM a.year) = 2023
  AND pe.rating = 'A+';	1597119407
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    probation_employees pe ON e.employee_id = pe.employee_id
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id AND ar.date = '2024-09-19'
WHERE 
    '2024-09-19' BETWEEN pe.start_date AND pe.end_date
    AND pe.status = '在职';	3355699316
SELECT 
    e.employee_id,
    e.name,
    e.hire_date,
    -- 假设每年标准年假为15天，根据入职年限计算应得年假
    (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.hire_date)) * 15 AS entitled_annual_leave,
    e.remaining_annual_leave,
    -- 计算已使用年假 = 应得年假 - 剩余年假
    (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.hire_date)) * 15 - e.remaining_annual_leave AS used_annual_leave
FROM 
    employees e
ORDER BY 
    e.employee_id;	1396580707
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2022 
  AND a.award_name = '技术突破奖'
  AND ar.date BETWEEN '2022-01-01' AND '2022-12-31'
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10
GROUP BY e.employee_id, e.name
HAVING COUNT(DISTINCT ar.date) = (
    SELECT COUNT(DISTINCT ar2.date) 
    FROM attendance_records ar2 
    WHERE ar2.employee_id = e.employee_id 
    AND ar2.date BETWEEN '2022-01-01' AND '2022-12-31'
);	2385394779
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00010'
  AND ar.date = '2024-09-20'
  AND (ar.check_out - ar.check_in) > INTERVAL '8 hours';	3598287205
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-09-25'
  AND ar.check_in < '09:00:00';	1157360763
SELECT e.employee_id, e.name, 
       AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) as avg_work_hours
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE pe.rating = 'A+'
GROUP BY e.employee_id, e.name
ORDER BY avg_work_hours DESC
LIMIT 1;	1456890377
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部'
  AND ar.date = '2024-10-04'
  AND ar.check_in > '09:00:00';	455172185
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-18'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'D'
ORDER BY ar.check_in;	4212530835
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-25'
  AND ar.check_in > '08:30:00'
  AND pe.rating = 'B+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	1240612673
SELECT 
    e.employee_id,
    e.name,
    i.interview_date,
    i.interview_count
FROM 
    employees e
JOIN 
    interviews i ON e.employee_id = i.employee_id
WHERE 
    EXTRACT(YEAR FROM i.interview_date) = 2024
ORDER BY 
    i.interview_count DESC;	2857901445
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-10'
  AND ar.check_in > '08:30:00'
  AND pe.rating = 'A+'
ORDER BY e.employee_id;	71265646
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-09-27'
  AND ar.check_in > '09:00:00'
  AND e.remaining_annual_leave < 10;	2168264130
SELECT e.name, p.evaluation_date
FROM employees e
LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id;	1505285087
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.date,
    ar.check_in,
    ar.check_out
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
WHERE 
    ar.date = '2024-10-07'
    AND ar.check_in > '09:00:00'
    AND ar.check_out < '17:00:00'
ORDER BY 
    e.name;	1736090929
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-05'
ORDER BY 
    e.name;	816170327
SELECT 
    d.name AS department_name, 
    AVG(i.interview_count) AS avg_interview_count
FROM 
    departments d
JOIN 
    employees e ON d.department_id = e.department_id
JOIN 
    interviews i ON e.employee_id = i.employee_id
GROUP BY 
    d.name
ORDER BY 
    avg_interview_count DESC
LIMIT 1;	3913837113
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-27'
AND pe.rating = 'A+';	578427607
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.employee_id IN (
    SELECT employee_id 
    FROM awards 
    WHERE year = 2024 AND award_name = '最佳团队奖'
)
AND ar.date = '2024-10-09'
AND ar.check_in > '09:00:00'
ORDER BY ar.check_in;	2435455132
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00010'
  AND ar.date = '2024-10-14'
  AND ar.check_in > '09:00:00'
ORDER BY e.employee_id;	801113743
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24'
  AND ar.check_out > '13:00:00'
  AND pe.rating = 'B+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	879816496
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-10-08'
AND ar.check_in > '09:00:00'
ORDER BY e.employee_id;	2367322111
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
    a.year = 2022
ORDER BY 
    e.name;	247458622
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-12'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'D'
ORDER BY ar.check_in;	570267133
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-10-13'
  AND ar.check_in < '09:30:00';	137546085
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '客户服务部'
  AND ar.date = '2024-09-22';	4072264422
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '质量改进奖'
  AND p.rating = 'A+'
  AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	4121529769
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-10-05'
  AND ar.check_in > '08:30:00'
  AND d.manager_id = 'H05487';	437939056
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00009'
  AND ar.date = '2024-10-02'
  AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	2108794903
SELECT d.name AS department_name, e.name AS employee_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.evaluation_date = '2023-03-31'
AND pe.rating = 'D'
ORDER BY d.name, e.name;	2803368869
SELECT e.name, e.car_plate
FROM employees e
WHERE e.employee_type = '正式员工';	408783378
SELECT e.employee_id, e.name, a.check_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00010'
  AND a.date = '2024-09-19'
  AND a.check_in > '09:00:00'
ORDER BY a.check_in;	1719343281
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2022 
  AND a.award_name = '客户满意度奖'
  AND ar.date = '2024-10-12'
  AND ar.check_in > '09:00:00';	2395193694
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-10-11'
  AND ar.check_in > '09:00:00'
  AND d.manager_id = 'H00842';	2461283805
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.year = 2023 AND a.award_name = '领导力奖';	1004841644
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.employee_id IN (
    SELECT employee_id 
    FROM awards 
    WHERE year = 2023 AND award_name = '领导力奖'
)
AND ar.date = '2024-10-09'
AND ar.check_in > '09:00:00'
ORDER BY ar.check_in;	958025096
SELECT 
    e.employee_id AS intern_id,
    e.name AS intern_name,
    d.name AS department_name,
    m.employee_id AS manager_id,
    m.name AS manager_name
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    employees m ON d.manager_id = m.employee_id
WHERE 
    e.employee_type = '实习生'
    AND ar.date = '2024-10-02'
    AND ar.check_in BETWEEN '09:00:00' AND '10:00:00';	4156394932
SELECT 
    d.name AS department_name,
    AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.birth_date)) AS average_age
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
GROUP BY 
    d.name
ORDER BY 
    average_age DESC
LIMIT 1;	5535555
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-16'
AND pe.rating = 'C';	1584866592
SELECT e.employee_id, e.name, a.check_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00001'
  AND a.date = '2024-10-08'
  AND a.check_in > '09:00:00'
ORDER BY a.check_in;	4123927043
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00004'  -- 财务部的department_id
  AND ar.date = '2024-09-20'  -- 指定日期
  AND ar.check_in > '09:00:00'  -- 迟到条件（上班时间晚于09:00）
ORDER BY e.employee_id;	2642437739
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00005'  -- 人力资源部的department_id
  AND ar.date = '2024-10-05'
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 8;	1412040002
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-14'
AND pe.rating = 'A+';	467771706
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00009'  -- 行政部的department_id
  AND ar.date = '2024-09-27'     -- 指定日期
  AND ar.check_in > '09:00:00'   -- 迟到条件（上班时间晚于9:00）
ORDER BY e.employee_id;	416599650
SELECT 
    d.name AS department_name,
    COUNT(e.employee_id) AS employee_count
FROM 
    departments d
LEFT JOIN 
    employees e ON d.department_id = e.department_id
GROUP BY 
    d.name
ORDER BY 
    d.name;	2074887228
SELECT e.employee_id, e.name, e.hire_date
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.rating = 'A+'
ORDER BY e.hire_date DESC
LIMIT 1;	4204863942
WITH employee_attendance AS (
    SELECT 
        e.employee_id,
        e.name,
        e.department_id,
        AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) AS avg_hours_worked
    FROM 
        employees e
    JOIN 
        attendance_records ar ON e.employee_id = ar.employee_id
    GROUP BY 
        e.employee_id, e.name, e.department_id
),
department_avg AS (
    SELECT 
        e.department_id,
        AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) AS dept_avg_hours
    FROM 
        employees e
    JOIN 
        attendance_records ar ON e.employee_id = ar.employee_id
    GROUP BY 
        e.department_id
)
SELECT 
    ea.employee_id,
    ea.name,
    ea.department_id,
    d.name AS department_name,
    ea.avg_hours_worked,
    da.dept_avg_hours,
    ABS(ea.avg_hours_worked - da.dept_avg_hours) AS hours_difference
FROM 
    employee_attendance ea
JOIN 
    department_avg da ON ea.department_id = da.department_id
JOIN 
    departments d ON ea.department_id = d.department_id
ORDER BY 
    hours_difference DESC
LIMIT 10;	603993474
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00001'  -- 研发部的department_id
  AND ar.date = '2024-10-05'
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10;	4133405205
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
    a.date = '2024-10-12'
ORDER BY 
    e.name;	1822156377
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00003'  -- 销售部的department_id
  AND ar.date = '2024-10-11'::date
  AND ar.check_in > '09:00:00'::time
  AND e.employee_type != '离职';  -- 假设我们只关心在职员工;	3941104083
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in AS check_in_time,
    a.award_name AS award_name
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    awards a ON e.employee_id = a.employee_id
WHERE 
    ar.date = '2024-09-26'
    AND ar.check_in > '09:00:00'
    AND a.year = 2024
    AND EXTRACT(MONTH FROM a.year || '-01-01'::date) = 9
    AND EXTRACT(DAY FROM a.year || '-01-01'::date) = 26;	1448803792
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-05'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'A+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	2348295774
SELECT e.employee_id, e.name, a.check_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00005'  -- 人力资源部的department_id
AND a.date = DATE '2024-10-07'   -- 指定日期
AND a.check_in > TIME '09:00:00' -- 迟到条件
ORDER BY a.check_in;	1351044911
SELECT e.name AS 姓名, d.name AS 部门名称, ar.check_in AS 上班时间
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_type = '实习生'
  AND ar.date = '2024-10-11'
  AND ar.check_in < '09:00:00'
ORDER BY ar.check_in;	1269433479
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023
AND a.award_name = '优秀员工奖'
AND p.rating = 'A+';	2181400574
WITH high_potential_employees AS (
    SELECT 
        e.employee_id,
        e.name,
        e.department_id,
        d.name AS department_name
    FROM 
        employees e
    JOIN 
        performance_evaluations pe ON e.employee_id = pe.employee_id
    JOIN 
        departments d ON e.department_id = d.department_id
    WHERE 
        pe.rating IN ('A', 'A+')
        AND pe.evaluation_date >= CURRENT_DATE - INTERVAL '5 years'
),

core_employees AS (
    SELECT 
        e.employee_id,
        e.department_id
    FROM 
        employees e
    WHERE 
        e.position LIKE '%Manager%' 
        OR e.position LIKE '%Director%' 
        OR e.position LIKE '%VP%'
)

SELECT 
    hpe.department_id,
    hpe.department_name,
    COUNT(DISTINCT hpe.employee_id) AS high_potential_count,
    COUNT(DISTINCT CASE WHEN ce.employee_id IS NOT NULL THEN hpe.employee_id END) AS became_core_count,
    ROUND(COUNT(DISTINCT CASE WHEN ce.employee_id IS NOT NULL THEN hpe.employee_id END) * 100.0 / 
          NULLIF(COUNT(DISTINCT hpe.employee_id), 0), 2) AS promotion_rate
FROM 
    high_potential_employees hpe
LEFT JOIN 
    core_employees ce ON hpe.employee_id = ce.employee_id AND hpe.department_id = ce.department_id
GROUP BY 
    hpe.department_id, hpe.department_name
ORDER BY 
    became_core_count DESC;	2992677261
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2024 
  AND a.award_name = '新人奖'
  AND ar.date = '2024-10-08';	1583766775
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-02'
  AND ar.check_in > '09:00:00'  -- 假设9:00为上班时间
  AND pe.rating = 'A+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date) 
    FROM performance_evaluations 
    WHERE employee_id = e.employee_id
  );	2928703740
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.year = 2024 AND a.award_name = '新人奖';	2166514841
WITH first_management_dates AS (
    SELECT 
        e.employee_id,
        e.hire_date,
        MIN(pe.evaluation_date) AS first_management_date
    FROM 
        employees e
    JOIN 
        performance_evaluations pe ON e.employee_id = pe.employee_id
    WHERE 
        pe.rating IN ('经理', '主管')  -- 根据查询2结果确定的管理职位
    GROUP BY 
        e.employee_id, e.hire_date
    HAVING 
        MIN(pe.evaluation_date) IS NOT NULL
)
SELECT 
    AVG(first_management_date - hire_date) AS avg_days_to_first_management
FROM 
    first_management_dates;	2864760744
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '研发部'
  AND ar.date = '2024-10-06'
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10;	2860391364
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '技术突破奖'
  AND p.rating = 'A+'
  AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	1852490763
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-17'
  AND ar.check_in > '09:00:00'  -- 假设9点为上班时间
  AND pe.rating = 'D'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date) 
    FROM performance_evaluations 
    WHERE employee_id = e.employee_id
  );	2494653166
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2024 
  AND a.award_name = '项目管理奖'
  AND ar.date = '2024-10-03'
  AND ar.check_in IS NOT NULL;	3084451002
SELECT e.employee_id, e.name, e.hire_date
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.award_name = '领导力奖' 
  AND a.year = 2023
  AND e.hire_date > '2017-12-31';	408688532
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-09-16'
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 8;	4036648411
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '领导力奖'
  AND p.evaluation_date = '2023-06-04'
  AND p.rating = 'D';	548473863
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'  -- 客户服务部的department_id
  AND ar.date = DATE '2024-10-12'  -- 指定日期
  AND ar.check_in > TIME '09:00:00'  -- 迟到条件（晚于9:00）
ORDER BY ar.check_in;	2286968533
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-21'
  AND ar.check_in > '09:00:00'  -- 假设9点为上班时间
  AND pe.rating = 'B'
ORDER BY e.employee_id;	3284637113
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'C'
ORDER BY d.name;	773404511
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00009'
  AND ar.date = '2024-10-05'
  AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	2149393306
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00004'  -- 财务部的department_id
  AND ar.date = '2024-10-06'      -- 指定日期
  AND ar.check_in > '09:00:00'    -- 迟到条件
ORDER BY ar.check_in;	2477803619
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    m.name AS manager_name
FROM 
    employees e
JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    employees m ON d.manager_id = m.employee_id
WHERE 
    pe.rating = 'A+'
    AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023;	821353235
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-28'
  AND ar.check_in > '09:00:00'  -- 假设9:00为上班时间
  AND pe.rating = 'A';	907163187
SELECT ar.* 
FROM attendance_records ar
JOIN (
    SELECT employee_id 
    FROM awards 
    WHERE year = 2023 AND award_name = '销售冠军'
) award_employees ON ar.employee_id = award_employees.employee_id
WHERE ar.date = '2024-10-01';	811463423
WITH a_plus_employees AS (
    SELECT 
        pe.employee_id,
        e.name,
        d.name AS department_name,
        pe.evaluation_date,
        e.hire_date,
        (pe.evaluation_date - e.hire_date) AS days_to_a_plus
    FROM 
        performance_evaluations pe
    JOIN 
        employees e ON pe.employee_id = e.employee_id
    JOIN 
        departments d ON e.department_id = d.department_id
    WHERE 
        pe.rating = 'A+'
),
ranked_employees AS (
    SELECT 
        employee_id,
        name,
        department_name,
        days_to_a_plus,
        RANK() OVER (PARTITION BY department_name ORDER BY days_to_a_plus ASC) AS rank
    FROM 
        a_plus_employees
)
SELECT 
    employee_id,
    name,
    department_name,
    days_to_a_plus
FROM 
    ranked_employees
WHERE 
    rank = 1
ORDER BY 
    department_name;	2913040945
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-22'
AND ar.check_in > '09:00:00'
ORDER BY e.employee_id;	1736656854
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2024
  AND a.award_name = '优秀员工'
  AND p.rating = 'A+';	2339817132
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    pe.rating AS performance_rating
FROM 
    performance_evaluations pe
JOIN 
    employees e ON pe.employee_id = e.employee_id
LEFT JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    pe.evaluation_date = '2023-10-29';	2218878981
SELECT e.employee_id, e.name, e.university, ar.date, ar.check_in, ar.check_out,
       (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) AS working_hours
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-09-17'
  AND ar.check_out IS NOT NULL
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 9
ORDER BY working_hours DESC;	1785434408
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2022-06-16'
AND pe.rating = 'C';	2274426817
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2022 
  AND a.award_name = '优秀员工'
  AND p.evaluation_date = '2022-10-30'
  AND p.rating = 'A+';	1121061015
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-15'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'B';	1822740611
SELECT e.name, e.position
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.name = '销售部';	3049098373
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-23'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'D';	2137629249
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE d.name = '客户服务部'
AND pe.rating = 'D'
AND pe.evaluation_date <= '2024-10-14'
AND NOT EXISTS (
    SELECT 1
    FROM performance_evaluations pe2
    WHERE pe2.employee_id = pe.employee_id
    AND pe2.evaluation_date > pe.evaluation_date
    AND pe2.evaluation_date <= '2024-10-14'
);	2240615465
SELECT e.employee_id, e.name, e.hire_date, a.award_name, a.year
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.award_name = '领导力奖' 
  AND a.year = 2023
  AND e.hire_date >= '2019-01-01';	1309270874
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'A+'
ORDER BY d.name;	2420332715
SELECT e.employee_id, e.name, pe.rating, d.name AS department
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
JOIN probation_employees prob ON e.employee_id = prob.employee_id
WHERE pe.rating IN ('B', 'C')  -- 假设B和C代表"一般"绩效
AND prob.status = '转正'  -- 转正状态表示在同事评价或团队贡献方面表现突出
ORDER BY pe.rating, e.name;	60966118
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20'
  AND ar.check_in BETWEEN '08:00:00' AND '09:00:00'
  AND pe.rating = 'B'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	1965264110
SELECT e.employee_id, e.name
FROM employees e
JOIN (
    SELECT employee_id, MAX(evaluation_date) as last_evaluation_date
    FROM performance_evaluations
    GROUP BY employee_id
) latest_eval ON e.employee_id = latest_eval.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id 
    AND latest_eval.last_evaluation_date = pe.evaluation_date
WHERE pe.rating = 'B'
    AND pe.evaluation_date < '2024-01-01';	1436736406
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-19'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'B+';	2263195811
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-24'
    AND (ar.check_out - ar.check_in) > INTERVAL '12 hours';	1079007714
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-09-29'
  AND ar.check_in < '09:00:00';	2835428087
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-11'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'A';	2600324766
SELECT date, check_in, check_out
FROM attendance_records
WHERE employee_id = 'H03961'
ORDER BY date DESC;	1290741288
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '厦门大学'
  AND ar.date = '2024-09-23'
  AND ar.check_in > '09:00:00'
ORDER BY e.employee_id;	3714812669
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-19'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'D'
ORDER BY e.employee_id;	4217899403
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-10-11'
  AND ar.check_in > '08:30:00';	1946117596
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-10'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'D';	1268105110
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2024
  AND a.year = 2024
  AND a.award_name = '新人奖'
  AND pe.rating = 'A'
  AND EXTRACT(YEAR FROM pe.evaluation_date) = 2024;	910719964
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-26'
  AND ar.check_in BETWEEN '08:00:00' AND '09:00:00'
  AND pe.rating = 'B+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	4215983699
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 
  AND a.award_name = '创新奖'
  AND ar.date = '2024-09-25'
  AND ar.check_in IS NOT NULL;	3022631781
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'D'
ORDER BY ar.check_in;	1326215630
SELECT 
    d.name AS department_name,
    AVG(e.remaining_annual_leave) AS average_annual_leave
FROM 
    departments d
JOIN 
    employees e ON d.department_id = e.department_id
WHERE 
    d.manager_id = 'H03372'
    AND EXTRACT(YEAR FROM CURRENT_DATE) = 2024
GROUP BY 
    d.name;	2739991096
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-12'
AND pe.rating = 'A+';	3094758858
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.employee_id IN (
    SELECT employee_id 
    FROM awards 
    WHERE year = 2023 AND award_name = '质量改进奖'
)
AND ar.date = '2024-10-03'
AND ar.check_in > '09:00:00'
ORDER BY ar.check_in;	3240116959
SELECT e.employee_id, e.name
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
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00010'
  AND ar.date = '2024-09-21'
  AND ar.check_in > '09:00:00'
ORDER BY ar.check_in;	3037862925
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部'
  AND ar.date = '2024-09-25'
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 8;	1991610345
SELECT e.name, pe.rating
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2022 
  AND a.award_name = '技术突破奖'
  AND pe.evaluation_date > '2022-07-13'
  AND EXTRACT(YEAR FROM pe.evaluation_date) = 2022;	3421802959
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00004'
  AND ar.date = '2024-10-11'
  AND ar.check_in > '09:00:00';	3350855518
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00001'  -- 研发部的department_id
  AND ar.date = '2024-10-12'::date
  AND ar.check_in > '09:00:00'::time
ORDER BY e.employee_id;	1481678835
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.rating = 'C'
AND pe.evaluation_date = '2023-08-06';	1832961045
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out,
    (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) AS working_hours
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-01'
    AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 12
ORDER BY 
    working_hours DESC;	3794832374
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-09'
  AND ar.check_in > '09:00:00'  -- 假设9点为上班时间
  AND pe.rating = 'A+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date) 
    FROM performance_evaluations 
    WHERE employee_id = e.employee_id
  );	4131389571
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00005'  -- 人力资源部的department_id
  AND ar.date = '2024-09-24'::date
  AND ar.check_in > '09:00:00'::time
ORDER BY e.employee_id;	2592420070
SELECT e.employee_id, e.name, a.check_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00003'
  AND a.date = '2024-10-02'
  AND a.check_in > '09:00:00'
ORDER BY e.employee_id;	1526114356
SELECT e.employee_id, e.name, ar.check_out
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-11'
  AND ar.check_out > '21:00:00'
  AND pe.rating = 'B+'
ORDER BY ar.check_out DESC;	906637391
SELECT e.name AS employee_name, d.name AS department_name, e.hire_date
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM pe.evaluation_date) = 2022
  AND pe.rating = 'B'
ORDER BY e.hire_date;	3180358031
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-22'
    AND d.name = '客户服务部';	1427670664
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'B'
ORDER BY d.name;	2517372671
SELECT e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-10-02'
ORDER BY ar.check_in ASC
LIMIT 1;	2374975326
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2023
  AND ar.date = '2024-10-10'
  AND pe.rating = 'B+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	1399658957
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '财务部'
  AND ar.date = '2024-10-04'
  AND ar.check_in > '09:00:00';	1337508734
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-17'
AND pe.rating = 'A+';	2509046712
WITH extended_counts AS (
    SELECT 
        employee_id, 
        COUNT(*) AS extension_count
    FROM 
        probation_employees
    WHERE 
        status = 'extended'
    GROUP BY 
        employee_id
    ORDER BY 
        extension_count DESC
    LIMIT 3
)
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    ec.extension_count
FROM 
    employees e
JOIN 
    extended_counts ec ON e.employee_id = ec.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
ORDER BY 
    ec.extension_count DESC;	1196649212
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00004'  -- 财务部的department_id
  AND ar.date = '2024-10-04'      -- 指定日期
  AND ar.check_in > '09:00:00'    -- 迟到条件（上班时间晚于9:00）
ORDER BY e.employee_id;	3455582973
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE a.award_name = '优秀员工' AND a.year = 2023;	2169239057
SELECT COUNT(DISTINCT e.employee_id) AS employee_count
FROM employees e
JOIN probation_employees pe ON e.employee_id = pe.employee_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.award_name = '客户满意度奖'
  AND a.year = 2023
  AND pe.start_date <= '2023-12-31'
  AND pe.end_date >= '2023-01-01';	329969630
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'C'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	1957766738
SELECT e.name, a.award_name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id;	701997867
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00008'  -- 法务部的department_id
  AND ar.date = '2024-10-13'      -- 指定日期
  AND ar.check_in < '08:30:00'    -- 8:30之前打卡
ORDER BY ar.check_in;	906781191
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00010'
  AND ar.date = '2024-09-17'
  AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	388401260
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id 
    AND ar.date = '2024-09-26'
WHERE 
    e.remaining_annual_leave > 10
ORDER BY 
    e.name;	1988310183
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00004'  -- 财务部的department_id
  AND ar.date = '2024-10-09'      -- 指定日期
  AND ar.check_in > '09:00:00'    -- 假设9点为上班时间，超过即为迟到
ORDER BY e.employee_id;	2363197929
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'  -- 客户服务部的department_id
  AND ar.date = '2024-10-10'      -- 指定日期
  AND ar.check_in > '09:00:00'    -- 迟到条件（上班时间晚于9:00）
ORDER BY ar.check_in DESC;	935583315
SELECT 
    AVG(pe.rating) AS avg_rating,
    COUNT(DISTINCT a.employee_id) AS innovators_count,
    COUNT(DISTINCT CASE WHEN pe.rating = '优秀' THEN pe.employee_id END) AS top_performers_count
FROM 
    performance_evaluations pe
LEFT JOIN
    awards a ON pe.employee_id = a.employee_id AND (a.award_name LIKE '%创新%' OR a.award_name LIKE '%孵化%')
WHERE 
    pe.evaluation_date >= CURRENT_DATE - INTERVAL '2 years';	3679145520
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-25'
    AND ar.check_in > '09:00:00'
ORDER BY 
    ar.check_in;	1647521458
SELECT e.employee_id, e.name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE e.department_id = 'D00006'
  AND pe.rating = 'A+'
  AND '2024-09-28' >= e.start_work_date
  AND (e.end_work_date IS NULL OR '2024-09-28' <= e.end_work_date);	2154404311
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00008'  -- 法务部的department_id
  AND ar.date = '2024-10-07'     -- 指定日期
  AND ar.check_in > '09:00:00'   -- 迟到条件（上班时间晚于9:00）
ORDER BY e.employee_id;	1956887122
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-14'
ORDER BY 
    e.name;	541499305
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2021 
  AND a.award_name = '优秀员工'
  AND ar.date > '2021-01-01';	607760760
SELECT 
    e.employee_id,
    e.name,
    e.hire_date,
    AVG(e.remaining_annual_leave) AS average_remaining_annual_leave
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id
WHERE 
    a.year = 2024
    AND a.award_name = '领导力奖'
    AND e.hire_date > '2017-12-31'
GROUP BY 
    e.employee_id, e.name, e.hire_date;	3786409554
SELECT DISTINCT e.employee_id, e.name, e.university, e.major, e.position,
       COUNT(a.id) AS award_count,
       (SELECT COUNT(*) FROM performance_evaluations pe 
        WHERE pe.employee_id = e.employee_id AND pe.rating = '优秀') AS excellent_evaluations
FROM employees e
LEFT JOIN awards a ON e.employee_id = a.employee_id
WHERE e.position NOT LIKE '%经理%' 
  AND e.position NOT LIKE '%总监%'
  AND e.position NOT LIKE '%主管%'
  AND e.university IN (
    SELECT university 
    FROM employees 
    GROUP BY university 
    HAVING COUNT(*) > 5  -- 常见大学
  )
GROUP BY e.employee_id, e.name, e.university, e.major, e.position
HAVING COUNT(a.id) > 0 OR 
       (SELECT COUNT(*) FROM performance_evaluations pe 
        WHERE pe.employee_id = e.employee_id AND pe.rating = '优秀') > 0
ORDER BY award_count DESC, excellent_evaluations DESC;	1833538335
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-12-07'
AND pe.rating = 'B';	2571560082
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    a.award_name
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    awards a ON e.employee_id = a.employee_id
WHERE 
    EXTRACT(YEAR FROM e.hire_date) = 2023
    AND EXTRACT(YEAR FROM a.year) = 2023
ORDER BY 
    e.name;	3184081384
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部'
  AND ar.date = '2024-09-25'
  AND ar.check_in > '09:00:00';	3265054996
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00010'
  AND ar.date = '2024-09-20'
  AND ar.check_in > '09:00:00'
ORDER BY ar.check_in;	1987469456
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'
  AND ar.date = '2024-09-29'
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10;	3475714298
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-04'
  AND ar.check_in > '08:30:00'
  AND pe.rating = 'A+'
ORDER BY ar.check_in;	3158837504
SELECT 
    e.employee_id,
    e.name,
    COUNT(CASE WHEN a.check_in > '09:30:00' THEN 1 END) AS late_days
FROM 
    employees e
LEFT JOIN 
    attendance_records a ON e.employee_id = a.employee_id
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    e.employee_id;	1341335041
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-15'
AND pe.rating = 'A+';	1248129462
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.award_name = '最佳团队奖' 
  AND a.year = 2021
  AND ar.date = '2024-09-19'
  AND ar.check_in IS NOT NULL;	2929076718
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'
  AND ar.date = '2024-09-21'
  AND ar.check_in IS NOT NULL;	860593492
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '财务部'
  AND ar.date = '2024-09-23'
  AND ar.check_in < '09:30:00';	803138423
SELECT e.employee_id, e.name, ar.date, ar.check_in
FROM employees e
JOIN probation_employees pe ON e.employee_id = pe.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-10-09'
  AND ar.check_in > '09:00:00'
  AND pe.status = 'Active';	1392351924
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023
  AND a.award_name = '项目管理奖'
  AND ar.date = '2024-09-23'
  AND ar.check_in IS NOT NULL;	2647170145
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2022
  AND EXTRACT(YEAR FROM a.year) = 2023
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
    d.department_id = 'D00005'  -- 人力资源部的department_id
    AND ar.date = DATE '2024-10-13'
ORDER BY 
    e.name;	2697889458
SELECT e.employee_id, e.name, a.check_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00009'
  AND a.date = '2024-09-18'
  AND a.check_in > '09:00:00'
ORDER BY a.check_in;	3387668548
-- 综合分析新员工成长因素的查询
WITH new_employees AS (
    SELECT employee_id, name, hire_date, department_id, position
    FROM employees
    WHERE hire_date >= CURRENT_DATE - INTERVAL '1 year'  -- 假设1年内入职的为新员工
    AND employee_type IN ('实习生', '正式员工')  -- 排除外包员工
)

SELECT 
    'Performance Evaluation' AS factor_type,
    pe.rating,
    COUNT(DISTINCT ne.employee_id) AS employee_count,
    ROUND(AVG(DATEDIFF('day', ne.hire_date, pe.evaluation_date))) AS avg_days_to_evaluation
FROM new_employees ne
JOIN performance_evaluations pe ON ne.employee_id = pe.employee_id
GROUP BY pe.rating

UNION ALL

SELECT 
    'Awards' AS factor_type,
    a.award_name,
    COUNT(DISTINCT ne.employee_id) AS employee_count,
    ROUND(AVG(DATEDIFF('day', ne.hire_date, a.year::date))) AS avg_days_to_award
FROM new_employees ne
JOIN awards a ON ne.employee_id = a.employee_id
GROUP BY a.award_name

UNION ALL

SELECT 
    'Attendance' AS factor_type,
    CASE 
        WHEN AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 9 THEN 'High Engagement'
        WHEN AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 8 THEN 'Medium Engagement'
        ELSE 'Low Engagement'
    END AS attendance_level,
    COUNT(DISTINCT ne.employee_id) AS employee_count,
    ROUND(AVG(DATEDIFF('day', ne.hire_date, ar.date))) AS avg_days_worked
FROM new_employees ne
JOIN attendance_records ar ON ne.employee_id = ar.employee_id
GROUP BY attendance_level

UNION ALL

SELECT 
    'Probation Status' AS factor_type,
    p.status,
    COUNT(DISTINCT ne.employee_id) AS employee_count,
    ROUND(AVG(DATEDIFF('day', ne.hire_date, p.end_date))) AS avg_probation_duration
FROM new_employees ne
JOIN probation_employees p ON ne.employee_id = p.employee_id
GROUP BY p.status

ORDER BY factor_type, employee_count DESC;	1417292000
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE d.name = '销售部'
  AND ar.date = '2024-09-20'
  AND ar.check_in > '08:00:00';	1597423542
SELECT 
    d.name AS department_name,
    e.name AS employee_name,
    e.birth_date,
    e.employee_id
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    (e.department_id, e.birth_date) IN (
        SELECT 
            department_id, 
            MIN(birth_date) AS oldest_birth_date
        FROM 
            employees
        GROUP BY 
            department_id
    )
ORDER BY 
    d.name;	3397723976
SELECT e.employee_id, e.name, a.check_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00005'  -- 人力资源部的department_id
  AND a.date = '2024-09-30'::date
  AND a.check_in > '09:00:00'::time
ORDER BY a.check_in;	339893232
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00001'
  AND ar.date = '2024-09-18'
  AND ar.check_in > '09:00:00'
ORDER BY e.employee_id;	244305078
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-28'
  AND ar.check_in > '09:30:00'
  AND pe.rating = 'A+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	2030661443
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-17'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'B'
ORDER BY e.employee_id;	2290320497
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-22'
AND pe.rating = 'D';	2134005508
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-03'
AND pe.rating = 'A+';	3179866905
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'  -- 客户服务部的department_id
  AND ar.date = '2024-10-07'      -- 指定日期
  AND ar.check_in > '09:00:00'    -- 迟到条件（上班时间晚于9:00）
ORDER BY e.employee_id;	1447725797
SELECT 
    e.employee_id,
    e.name,
    ar.date,
    ar.check_in,
    ar.check_out,
    pe.evaluation_date,
    pe.rating
FROM 
    employees e
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
LEFT JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
ORDER BY 
    e.employee_id, ar.date, pe.evaluation_date;	3166523944
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE ar.date = '2024-10-05'
  AND ar.check_in > '09:00:00'
  AND a.year = 2021;	3133264714
SELECT e.employee_id, e.name, a.check_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00010'  -- 质量控制部的department_id
  AND a.date = '2024-09-25'::date
  AND a.check_in > '08:30:00'::time
ORDER BY a.check_in;	2850698943
WITH quarterly_top_performers AS (
    -- 识别每个季度产出最高的员工（假设绩效评估中的高rating代表高产出）
    SELECT 
        e.employee_id,
        e.name,
        EXTRACT(YEAR FROM pe.evaluation_date) AS year,
        EXTRACT(QUARTER FROM pe.evaluation_date) AS quarter,
        pe.rating,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM pe.evaluation_date), EXTRACT(QUARTER FROM pe.evaluation_date) ORDER BY pe.rating DESC) AS performance_rank
    FROM 
        performance_evaluations pe
    JOIN 
        employees e ON pe.employee_id = e.employee_id
    WHERE 
        pe.evaluation_date >= CURRENT_DATE - INTERVAL '3 years'
),

attendance_compliance AS (
    -- 计算每个员工的工作时间遵守情况（按时打卡）
    SELECT 
        ar.employee_id,
        EXTRACT(YEAR FROM ar.date) AS year,
        EXTRACT(QUARTER FROM ar.date) AS quarter,
        COUNT(*) AS total_days,
        SUM(CASE WHEN ar.check_in <= '09:00:00' AND ar.check_out >= '17:00:00' THEN 1 ELSE 0 END) AS compliant_days,
        SUM(CASE WHEN ar.check_in <= '09:00:00' AND ar.check_out >= '17:00:00' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS compliance_rate
    FROM 
        attendance_records ar
    WHERE 
        ar.date >= CURRENT_DATE - INTERVAL '3 years'
    GROUP BY 
        ar.employee_id, EXTRACT(YEAR FROM ar.date), EXTRACT(QUARTER FROM ar.date)
),

quarterly_compliance_ranking AS (
    -- 对每个季度的员工按工作时间遵守情况进行排名
    SELECT 
        ac.employee_id,
        ac.year,
        ac.quarter,
        ac.compliance_rate,
        RANK() OVER (PARTITION BY ac.year, ac.quarter ORDER BY ac.compliance_rate DESC) AS compliance_rank
    FROM 
        attendance_compliance ac
)

-- 最终查询：比较每个季度产出最高的员工是否也是工作时间遵守最好的
SELECT 
    qtp.year,
    qtp.quarter,
    qtp.employee_id AS top_performer_id,
    qtp.name AS top_performer_name,
    qtp.rating,
    qcr.employee_id AS most_compliant_id,
    e.name AS most_compliant_name,
    qcr.compliance_rate,
    CASE WHEN qtp.employee_id = qcr.employee_id THEN 'Yes' ELSE 'No' END AS is_same_person
FROM 
    quarterly_top_performers qtp
LEFT JOIN 
    quarterly_compliance_ranking qcr ON qtp.year = qcr.year AND qtp.quarter = qcr.quarter AND qcr.compliance_rank = 1
LEFT JOIN 
    employees e ON qcr.employee_id = e.employee_id
WHERE 
    qtp.performance_rank = 1
ORDER BY 
    qtp.year, qtp.quarter;	2860363666
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023
AND p.rating = 'A+';	3284872060
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2022
  AND a.award_name = '质量改进奖'
  AND ar.date = '2024-10-04'
  AND ar.check_in > '09:00:00';	1370529433
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'
  AND ar.date = '2024-10-03'
  AND ar.check_in > '09:00:00'
ORDER BY ar.check_in;	4101493476
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00005'  -- 人力资源部的department_id
  AND ar.date = '2024-10-02'::date
  AND ar.check_in > '09:00:00'::time
ORDER BY e.employee_id;	1724137514
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023 
  AND a.award_name = '优秀员工'
  AND p.rating = 'A+';	3595600525
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.rating = 'A+'
AND pe.evaluation_date = '2023-05-31';	815548435
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-02'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'A+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date) 
    FROM performance_evaluations 
    WHERE employee_id = e.employee_id
  );	2061849622
SELECT ar.* 
FROM attendance_records ar
JOIN (
    SELECT employee_id 
    FROM awards 
    WHERE year = 2021 AND award_name = '销售冠军'
) award_employees ON ar.employee_id = award_employees.employee_id
WHERE ar.date = '2024-09-18';	1250267679
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-05-27'
AND pe.rating = 'A+';	1929429344
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-16'
    AND ar.check_in > '09:00:00'
ORDER BY 
    ar.check_in;	3689323727
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;	2977986068
SELECT e.name, e.position, e.hire_date
FROM employees e
WHERE e.position = '助理'  -- 根据查询1结果，助理是最低职位级别
ORDER BY e.hire_date ASC
LIMIT 1;	3402561235
SELECT e.employee_id, e.name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE e.department_id = 'D00007'
  AND EXTRACT(YEAR FROM pe.evaluation_date) = 2024
  AND pe.rating = 'A';	3958686389
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.award_name = '创新奖' 
  AND a.year = 2022
  AND ar.date = '2024-10-12' 
  AND ar.check_in > '09:00:00';	3786147845
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE ar.date = '2024-09-23'
AND ar.check_in > '09:00:00'
ORDER BY e.name;	1159542995
SELECT COUNT(DISTINCT e.employee_id) AS employee_count
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2023
  AND a.award_name = '质量改进奖'
  AND pe.rating = 'A+';	3254827737
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-09-23'
  AND ar.check_in > '08:00:00'
  AND ar.check_out < '18:00:00'
ORDER BY d.name;	3909320290
SELECT DISTINCT d.department_id, d.name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN interviews i ON e.employee_id = i.employee_id
JOIN awards a ON e.employee_id = a.employee_id
WHERE i.interview_date = '2023-10-09'
AND a.award_name = '优秀员工奖'
AND EXTRACT(YEAR FROM a.year) = 2023;	628072208
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-12'
  AND ar.check_in < '09:00:00'
  AND pe.rating = 'B+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	3286899081
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20'
  AND ar.check_in > '09:00:00' -- 假设9点为上班时间
  AND pe.rating = 'A+'
ORDER BY e.employee_id;	2517269758
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2021 
  AND a.award_name = '质量改进奖'
  AND p.rating = 'B+';	3866100328
SELECT e.employee_id, e.name, a.check_in
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00006'
  AND a.date = '2024-09-29'
  AND a.check_in > '08:30:00'
ORDER BY a.check_in;	3469101707
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    m.name AS manager_name
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    employees m ON d.manager_id = m.employee_id
WHERE 
    ar.date = '2024-09-16'
    AND ar.check_in > '08:30:00';	2797510377
SELECT e.employee_id, e.name, e.position, ar.date, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-10-01'
  AND ar.check_in > '09:00:00'
  AND e.position = '顾问';	2587625643
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'  -- 客户服务部的department_id
  AND ar.date = '2024-09-23'      -- 指定日期
  AND ar.check_in > '09:00:00'    -- 迟到条件（晚于9:00）
ORDER BY ar.check_in;	2556819995
-- 首先确认奖项名称（修正初始查询）
SELECT DISTINCT a.award_name 
FROM awards a
WHERE a.award_name LIKE '%技术%创新%';

-- 然后查询过去五年技术创新奖获得者及其对公司业务的影响
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    a.award_name,
    a.year AS award_year,
    pe.rating AS performance_rating,
    COUNT(DISTINCT ar.date) AS attendance_days,
    COUNT(DISTINCT i.id) AS interview_count
FROM 
    awards a
JOIN 
    employees e ON a.employee_id = e.employee_id
LEFT JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id 
    AND pe.evaluation_date >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '5 years'
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id 
    AND ar.date >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '5 years'
LEFT JOIN 
    interviews i ON e.employee_id = i.employee_id 
    AND i.interview_date >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '5 years'
WHERE 
    a.award_name LIKE '%技术%创新%'
    AND a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5
GROUP BY 
    e.employee_id, e.name, d.name, a.award_name, a.year, pe.rating
ORDER BY 
    a.year DESC, e.name;	2163155798
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00004'  -- 财务部的department_id
  AND ar.date = '2024-10-06'      -- 指定日期
  AND ar.check_in > '09:00:00'    -- 迟到条件（上班时间晚于09:00）
ORDER BY e.employee_id;	1599035554
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-04'
    AND ar.check_in > '09:00:00'
ORDER BY 
    ar.check_in;	3248411469
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE a.date = '2024-10-04';	2257279104
SELECT 
    e.employee_id,
    a.award_name,
    p.rating AS performance_rating,
    p.evaluation_date
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id AND a.year = 2023
JOIN 
    performance_evaluations p ON e.employee_id = p.employee_id 
    AND EXTRACT(YEAR FROM p.evaluation_date) = 2023
ORDER BY 
    e.employee_id;	2036213054
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE ar.date = '2024-10-10'
AND ar.check_in > '09:30:00';	2231439732
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id 
    AND ar.date = '2024-09-19'
ORDER BY 
    e.name;	1852561007
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00009'
  AND ar.date = '2024-10-03'
  AND ar.check_in > '09:00:00'
ORDER BY e.employee_id;	3057784484
SELECT 
    d.name AS department_name,
    AVG(e.remaining_annual_leave) AS avg_remaining_annual_leave
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
GROUP BY 
    d.name
ORDER BY 
    avg_remaining_annual_leave DESC
LIMIT 1;	604055577
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-27'
  AND ar.check_in < '10:00:00'
  AND pe.rating = 'A+'
  AND pe.evaluation_date = (
    SELECT MAX(evaluation_date)
    FROM performance_evaluations
    WHERE employee_id = e.employee_id
  );	1799658813
SELECT 
    i.employee_id,
    e.name AS employee_name,
    i.interview_date,
    i.interview_count
FROM 
    interviews i
JOIN 
    employees e ON i.employee_id = e.employee_id
WHERE 
    EXTRACT(YEAR FROM i.interview_date) = 2024
ORDER BY 
    i.interview_date;	556306212
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-09-20'
    AND ar.check_in > '09:00:00'  -- 假设9:00是迟到的标准时间
ORDER BY 
    ar.check_in DESC;	3669286537
SELECT e.employee_id, e.name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE d.name = '研发部'
AND pe.rating = 'B+'
AND pe.evaluation_date <= '2024-09-29'
AND NOT EXISTS (
    SELECT 1
    FROM performance_evaluations pe2
    WHERE pe2.employee_id = pe.employee_id
    AND pe2.evaluation_date > pe.evaluation_date
    AND pe2.evaluation_date <= '2024-09-29'
);	1975822937
SELECT ar.* 
FROM attendance_records ar
JOIN (
    SELECT employee_id 
    FROM awards 
    WHERE year = 2022 AND award_name = '销售冠军'
) award_employees ON ar.employee_id = award_employees.employee_id
WHERE ar.date = '2024-10-10';	1362951886
SELECT e.employee_id, e.name, e.hire_date
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
WHERE a.award_name = '客户满意度奖' 
  AND a.year = 2023
  AND e.hire_date > '2020-06-19';	2799760973
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-22'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'A+';	1692765210
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE pe.rating = 'C'
AND pe.evaluation_date = '2022-06-20';	804998806
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2024 
  AND a.award_name = '客户满意度奖'
  AND p.rating = 'C';	170694593
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 
  AND a.award_name = '项目管理奖'
  AND EXTRACT(YEAR FROM ar.date) = 2023
GROUP BY e.employee_id, e.name
HAVING AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10;	2091607073
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.evaluation_date = '2023-03-09'
AND pe.rating = 'D';	2894384990
SELECT 
    e.employee_id,
    e.name,
    e.position,
    e.employee_type,
    e.hire_date,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.hire_date) AS years_of_service,
    e.university,
    e.major,
    COUNT(a.id) AS award_count,
    STRING_AGG(DISTINCT a.award_name, ', ') AS awards_received,
    pe.rating AS performance_rating,
    d.name AS department_name,
    COUNT(DISTINCT ar.date) AS days_attended,
    COUNT(DISTINCT i.id) AS interview_participation_count
FROM 
    employees e
LEFT JOIN 
    awards a ON e.employee_id = a.employee_id
LEFT JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
LEFT JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
LEFT JOIN 
    interviews i ON e.employee_id = i.employee_id
WHERE 
    e.employee_type = 'Expert' OR 
    e.position LIKE '%Senior%' OR 
    e.position LIKE '%Specialist%' OR 
    e.position LIKE '%Expert%'
GROUP BY 
    e.employee_id, e.name, e.position, e.employee_type, e.hire_date, e.university, e.major, pe.rating, d.name
ORDER BY 
    years_of_service DESC, award_count DESC, performance_rating DESC;	1149281173
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    ar.check_in,
    ar.check_out
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    ar.date = '2024-10-08'
ORDER BY 
    e.name;	1884200158
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00005'
  AND ar.date = '2024-09-26'
  AND ar.check_in > '09:00:00';	2557740373
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-28'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'A+';	3799739588
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00001'
  AND ar.date = '2024-09-20'
  AND ar.check_in > '09:00:00'
ORDER BY e.employee_id;	1074403791
SELECT DISTINCT d.name AS department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-13'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'A+'
ORDER BY d.name;	1640643914
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2023
  AND a.award_name = '销售冠军'
  AND p.rating IN ('A', 'B', 'S')  -- 假设'S'代表比'A'更高的评级
  AND p.evaluation_date >= '2023-01-01'  -- 确保评估是在获奖后或同年进行的
ORDER BY e.employee_id;	3875469036
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00004'  -- 财务部的department_id
  AND ar.date = '2024-09-17'
  AND (ar.check_out - ar.check_in) > INTERVAL '9 hours';	1182082319
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    m.name AS manager_name
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    employees m ON d.manager_id = m.employee_id
WHERE 
    ar.date = '2024-09-18'
    AND ar.check_in > '09:00:00'
ORDER BY 
    e.employee_id;	219564979
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 
  AND a.award_name = '技术突破奖'
  AND ar.date = '2024-09-23'
  AND ar.check_in > '09:00:00';	2296352057
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records a ON e.employee_id = a.employee_id
WHERE e.department_id = 'D00007'
  AND a.date = '2024-09-26';	3848854887
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2020
  AND a.award_name = '优秀员工'
  AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023
  AND pe.rating = 'C';	4144781586
SELECT e.employee_id, e.name, ar.check_in, pe.rating
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-03'
  AND ar.check_in > '09:00:00'
  AND pe.rating = 'C'
ORDER BY ar.check_in;	543593806
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00008'
  AND ar.date = '2024-10-12'
  AND ar.check_in > '09:00:00'
ORDER BY e.employee_id;	3302179394
WITH yearly_department_stats AS (
    SELECT 
        EXTRACT(YEAR FROM i.interview_date) AS year,
        d.name AS department_name,
        COUNT(DISTINCT i.employee_id) AS interviewed_candidates,
        COUNT(DISTINCT e.employee_id) AS hired_employees,
        COUNT(DISTINCT e.employee_id) * 100.0 / NULLIF(COUNT(DISTINCT i.employee_id), 0) AS hiring_rate
    FROM 
        interviews i
    LEFT JOIN 
        employees e ON i.employee_id = e.employee_id
    LEFT JOIN 
        departments d ON e.department_id = d.department_id
    WHERE 
        i.interview_date >= CURRENT_DATE - INTERVAL '5 years'
    GROUP BY 
        EXTRACT(YEAR FROM i.interview_date), d.name
),
ranked_departments AS (
    SELECT 
        year,
        department_name,
        hiring_rate,
        RANK() OVER (PARTITION BY year ORDER BY hiring_rate DESC) AS rank
    FROM 
        yearly_department_stats
    WHERE 
        interviewed_candidates > 0  -- 确保有面试数据
)
SELECT 
    year,
    department_name AS highest_hiring_rate_department,
    hiring_rate AS hiring_rate_percentage
FROM 
    ranked_departments
WHERE 
    rank = 1
ORDER BY 
    year DESC;	1798514231
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
AND ar.date = '2024-10-12'
AND ar.check_in IS NOT NULL;	2882208186
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.employee_id IN (
    SELECT DISTINCT employee_id 
    FROM awards 
    WHERE award_name LIKE '%领导力%' AND year = 2023
)
AND ar.date = '2024-10-01'
AND ar.check_in > '09:00:00';	2752876678
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2023 
  AND a.award_name = '销售冠军'
  AND ar.date = '2024-09-22'
  AND ar.check_in > '09:00:00';	2550918549
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00005'
  AND ar.date = '2024-10-10'
  AND ar.check_in > '09:00:00';	2654497153
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE pe.rating = 'D'
AND pe.evaluation_date = '2023-04-20';	776263740
WITH 
-- 获取近两年内获得奖项的员工
awarded_employees AS (
    SELECT DISTINCT a.employee_id
    FROM awards a
    WHERE a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 1
),

-- 获取近两年内绩效提升的员工
promoted_employees AS (
    SELECT DISTINCT pe.employee_id
    FROM performance_evaluations pe
    WHERE pe.evaluation_date >= CURRENT_DATE - INTERVAL '2 years'
    AND pe.rating IN ('Excellent', 'Outstanding', 'Improved')  -- 假设这些评级表示绩效提升
),

-- 计算总员工数
total_employees AS (
    SELECT COUNT(*) AS total_count
    FROM employees
    WHERE hire_date <= CURRENT_DATE - INTERVAL '2 years'  -- 只考虑入职超过2年的员工
)

-- 计算比例
SELECT 
    COUNT(DISTINCT ae.employee_id) AS awarded_and_promoted_count,
    te.total_count AS total_employee_count,
    ROUND(COUNT(DISTINCT ae.employee_id) * 100.0 / NULLIF(te.total_count, 0), 2) AS percentage
FROM 
    awarded_employees ae
JOIN 
    promoted_employees pe ON ae.employee_id = pe.employee_id
CROSS JOIN 
    total_employees te
GROUP BY 
    te.total_count;	1728657056
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE EXTRACT(YEAR FROM e.hire_date) = 2023
  AND EXTRACT(YEAR FROM a.year) = 2023
  AND a.award_name = '优秀员工奖'
  AND pe.rating = 'A+'
  AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023;	4069271992
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'
  AND ar.date = '2024-09-21'
  AND ar.check_in > '09:00:00';	2408826226
SELECT 
    e.employee_id,
    e.name,
    ar.date,
    ar.check_in,
    ar.check_out,
    EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600 AS working_hours
FROM 
    employees e
LEFT JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
ORDER BY 
    e.employee_id, ar.date;	2252548426
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00006'
  AND ar.date = '2024-09-15'
  AND ar.check_in > '09:00:00';	141603518
SELECT e.employee_id, e.name, ar.check_in
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2021 
  AND a.award_name = '创新奖'
  AND ar.date = '2024-10-05'
  AND ar.check_in > '09:00:00';	3509550647
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE a.year = 2024
AND pe.rating = 'C';	102704152
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE a.year = 2024
  AND a.award_name = '领导力奖'
  AND p.rating = 'C';	4066261878
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00010'
  AND ar.date = '2024-09-19'
  AND ar.check_in > '09:00:00'
ORDER BY e.name;	7133946
SELECT e.employee_id, e.name
FROM employees e
JOIN awards a ON e.employee_id = a.employee_id
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE a.year = 2024
  AND a.award_name = '项目管理奖'
  AND ar.date = '2024-09-23'
  AND ar.check_in IS NOT NULL;	2339648
SELECT 
    e.name AS employee_name,
    d.name AS department_name,
    pe.rating AS performance_rating
FROM 
    employees e
JOIN 
    attendance_records ar ON e.employee_id = ar.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE 
    ar.date = '2024-09-20'
ORDER BY 
    e.name;	1476916008
SELECT 
    e.employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    m.name AS manager_name
FROM 
    attendance_records ar
JOIN 
    employees e ON ar.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
JOIN 
    employees m ON d.manager_id = m.employee_id
WHERE 
    ar.date = '2024-09-26' 
    AND ar.check_in > '09:30:00';	2848971755
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.university = '清华大学'
  AND ar.date = '2024-10-03'
  AND ar.check_in > '09:00:00';	1510555187
SELECT e.employee_id, e.name
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
WHERE e.department_id = 'D00001'  -- 使用查询1获得的研发部department_id
  AND ar.date = '2024-10-01'
  AND (EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10;	1954114065
SELECT 
    e.employee_id,
    e.name,
    a.award_name,
    p.rating AS performance_rating
FROM 
    employees e
JOIN 
    awards a ON e.employee_id = a.employee_id
JOIN 
    performance_evaluations p ON e.employee_id = p.employee_id
WHERE 
    a.year = 2023 
    AND a.award_name = '优秀员工'
    AND EXTRACT(YEAR FROM p.evaluation_date) = 2023
ORDER BY 
    e.employee_id;	3968556416
SELECT 
    d.cust_no AS customer_id,
    d.acct_bal AS deposit_balance,
    l.loan_balance AS loan_balance,
    lt.loan_type_name AS loan_type
FROM 
    deposit_account_info d
JOIN 
    loan_detail_info l ON d.cust_no = l.cust_id
JOIN 
    loan_type lt ON l.loan_type = lt.loan_type_code
WHERE 
    d.data_dt = '2024-07-19' 
    AND l.dw_date = '2024-07-19'
    AND d.acct_bal > 100000
    AND l.loan_balance > 500000;	2192717523
SELECT 
    fp.cust_no,
    c.customer_name,
    c.id_number,
    fp.wealth_bal AS usd_wealth_balance
FROM 
    financial_products fp
JOIN 
    customer c ON fp.cust_no = c.id_number
WHERE 
    fp.data_dt = '2024-07-02'
    AND fp.currency = 'USD'
    AND fp.wealth_bal > 5000000
ORDER BY 
    fp.wealth_bal DESC;	747211607
SELECT rs_type_name, rs_type_id 
FROM five_level_classification 
WHERE rs_type = '不良' AND data_dt = '2024-07-22';	218132520
SELECT 
    c.customer_name,
    o.occupation_name,
    lr.description AS repayment_description
FROM 
    customer c
JOIN 
    occupation o ON c.occupation_id = o.id
JOIN 
    loan_application la ON c.id = la.customer_id
JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
ORDER BY 
    lr.repayment_amount DESC;	175056471
SELECT 
    c.customer_name,
    c.id_number,
    c.phone_number,
    c.email,
    c.address
FROM 
    customer c
JOIN 
    occupation o ON c.occupation_id = o.id
WHERE 
    o.occupation_name = '护士'
ORDER BY 
    c.customer_name;	334027216
SELECT COUNT(DISTINCT d.cust_no) AS private_customers_with_both
FROM deposit_account_info d
JOIN loan_detail_info l ON d.cust_no = l.cust_id
JOIN bank_orgnization b ON d.org_no = b.bank_id
WHERE b.bank_name = '沈阳分行'
  AND d.cust_type = '2'  -- 假设'2'代表对私客户
  AND d.data_dt = '2024-07-19'
  AND l.dw_date = '2024-07-19';	3272129262
SELECT 
    c.curr_code,
    c.curr_full_name,
    b.bank_name,
    b.bank_level
FROM 
    currency c
JOIN 
    deposit_account_info d ON c.curr_code = d.cur_type
JOIN 
    bank_orgnization b ON d.bank_no = b.bank_id
WHERE 
    c.curr_class != 'CNY' 
    AND c.data_dt = '2023-06-30'
    AND d.data_dt = '2023-06-30'
    AND b.data_dt = '2023-06-30'
GROUP BY 
    c.curr_code, c.curr_full_name, b.bank_name, b.bank_level;	2889578956
SELECT deposit_id, deposit_name 
FROM deposit_type 
WHERE data_dt = '2024-07-22';	88302712
SELECT 
    d.card_no,
    d.card_type_nm,
    d.current_bal,
    d.cust_nm AS customer_name,
    d.residential_address
FROM 
    debit_card_information d
WHERE 
    DATE(d.open_date) = '2024-07-15'
    AND d.current_bal > 2000
    AND d.card_type = '借记卡';	1348647978
SELECT c.id AS customer_id, lc.credit_score
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_date = '2003-06-22'
AND lc.credit_score > 0.75;	1016905624
SELECT 
    c.customer_name,
    c.gender,
    SUM(lr.repayment_amount) AS total_repayment_amount
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
GROUP BY 
    c.customer_name, c.gender
ORDER BY 
    c.gender;	3611732895
SELECT 
    la.id AS loan_application_id,
    la.loan_amount,
    c.id AS customer_id,
    c.customer_name,
    c.id_number,
    c.phone_number,
    c.email,
    c.address,
    c.birth_date,
    c.gender,
    c.province
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
ORDER BY 
    la.loan_amount DESC
LIMIT 1;	1319754722
SELECT COUNT(DISTINCT d.cust_no) AS customer_count
FROM financial_products f
JOIN debit_card_information d ON f.cust_no = d.cust_no
WHERE f.wealth_bal > 1000000
  AND d.card_state = '正常';	2123954700
SELECT 
    d.cust_no AS customer_id,
    d.cust_name AS customer_name,
    d.org_nm AS branch_name,
    d.act_mon_avg_bal AS monthly_avg_balance,
    d.open_date AS account_open_date
FROM 
    deposit_account_info d
WHERE 
    d.data_dt = '2024-07-19'::timestamp
    AND d.org_nm = '沈阳余淮支行'
    AND d.acct_type_code = '活期' -- 假设活期存款的代码为'活期'
    AND d.act_mon_avg_bal > 50000
ORDER BY 
    d.act_mon_avg_bal DESC;	4161720938
SELECT c.customer_name, la.loan_amount
FROM loan_application la
JOIN customer c ON la.customer_id = c.id
WHERE la.loan_amount > 30000 AND la.status = 'PENDING';	1485816909
WITH top_loan_customers AS (
    SELECT 
        ld.cust_id,
        SUM(ld.loan_amount) AS total_loan_amount
    FROM 
        loan_detail_info ld
    GROUP BY 
        ld.cust_id
    ORDER BY 
        total_loan_amount DESC
    LIMIT 20
),
customer_deposit_types AS (
    SELECT 
        tlc.cust_id,
        dt.deposit_type_name
    FROM 
        top_loan_customers tlc
    JOIN 
        deposit_account_info dai ON tlc.cust_id = dai.cust_no
    JOIN 
        deposit_type dt ON dai.acct_type_code = dt.deposit_id
)

SELECT 
    deposit_type_name,
    COUNT(DISTINCT cust_id) AS customer_count
FROM 
    customer_deposit_types
GROUP BY 
    deposit_type_name
ORDER BY 
    customer_count DESC;	864749016
SELECT curr_code, curr_full_name
FROM currency
WHERE curr_d_class_name = '外币'
ORDER BY curr_code ASC;	3380354553
SELECT 
    c.id AS customer_id,
    c.customer_name,
    SUM(la.loan_amount) AS total_loan_amount
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
GROUP BY 
    c.id, c.customer_name
ORDER BY 
    total_loan_amount DESC;	146146439
SELECT 
    fp.cast_type AS customer_type,
    AVG(fp.wealth_sta_m_avg_bal_a) AS avg_monthly_balance
FROM 
    financial_products fp
WHERE 
    EXTRACT(YEAR FROM fp.data_dt) = 2024 
    AND EXTRACT(MONTH FROM fp.data_dt) = 7
GROUP BY 
    fp.cast_type
ORDER BY 
    avg_monthly_balance DESC;	2245911258
SELECT * 
FROM loan_detail_info 
WHERE loandate_s > '2024-04-01';	904046704
WITH age_groups AS (
    SELECT 
        CASE 
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 0 AND 20 THEN '0-20'
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 21 AND 40 THEN '21-40'
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 41 AND 60 THEN '41-60'
            ELSE '61+'
        END AS age_group,
        AVG(l.loan_amount) AS avg_loan_amount
    FROM customer c
    JOIN loan_application l ON c.id = l.customer_id
    GROUP BY age_group
),
customer_loans AS (
    SELECT 
        c.id AS customer_id,
        c.customer_name,
        EXTRACT(YEAR FROM AGE(c.birth_date)) AS age,
        CASE 
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 0 AND 20 THEN '0-20'
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 21 AND 40 THEN '21-40'
            WHEN EXTRACT(YEAR FROM AGE(c.birth_date)) BETWEEN 41 AND 60 THEN '41-60'
            ELSE '61+'
        END AS age_group,
        l.loan_amount
    FROM customer c
    JOIN loan_application l ON c.id = l.customer_id
)
SELECT 
    cl.customer_id,
    cl.customer_name,
    cl.age,
    cl.age_group,
    cl.loan_amount,
    ag.avg_loan_amount AS age_group_avg,
    (cl.loan_amount - ag.avg_loan_amount) / ag.avg_loan_amount * 100 AS percentage_above_avg
FROM customer_loans cl
JOIN age_groups ag ON cl.age_group = ag.age_group
WHERE cl.loan_amount > ag.avg_loan_amount * 1.5
ORDER BY percentage_above_avg DESC;	2037290745
SELECT birth_date, gender FROM customer;	1073845704
SELECT DISTINCT c.id AS customer_id, c.customer_name, c.id_number, c.phone_number
FROM customer c
JOIN loan_detail_info l ON c.id_number = l.cust_id
JOIN bank_orgnization b ON l.loan_orgno = b.bank_id
WHERE l.loan_balance > 500000
  AND b.bank_name LIKE '%沈阳分行%'
  AND l.dw_date::date = '2024-07-19'
  AND l.account_state = '正常';	1970903262
SELECT 
    ldi.*,
    c.curr_full_name AS currency_full_name,
    flc.rs_type_name AS five_level_classification_name
FROM 
    loan_detail_info ldi
LEFT JOIN 
    currency c ON ldi.currency_type = c.curr_code
LEFT JOIN 
    five_level_classification flc ON ldi.judgelevel = flc.rs_type_id
WHERE 
    ldi.loan_balance > 1000000;	2098164166
SELECT 
    c.customer_name,
    curr.curr_full_name,
    ldi.loan_balance
FROM 
    loan_detail_info ldi
JOIN 
    customer c ON ldi.cust_id = c.id_number
JOIN 
    currency curr ON ldi.currency_type = curr.curr_code
WHERE 
    ldi.loan_balance > 1000000
ORDER BY 
    ldi.loan_balance DESC;	3382000879
SELECT 
    c.id,
    c.customer_name,
    COUNT(DISTINCT ub.behavior_type) AS behavior_type_count
FROM 
    customer c
JOIN 
    user_behavior ub ON c.id = ub.customer_id
WHERE 
    ub.behavior_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    c.id, c.customer_name
ORDER BY 
    behavior_type_count DESC
LIMIT 5;	2579167658
SELECT 
    SUM(stm_overdu) AS total_overdue_amount,
    COUNT(DISTINCT xaccount) AS account_count
FROM 
    credit_card_data
WHERE 
    corporation = 'Corp3'
    AND cycle_nbr = '2024-07-03';	1454085576
SELECT * 
FROM loan_detail_info 
WHERE cust_id = '1004';	1846154246
SELECT 
    c.id AS customer_id,
    c.customer_name,
    t.id AS transfer_id,
    t.transfer_amount,
    t.transfer_date,
    t.description
FROM 
    customer c
LEFT JOIN 
    transfer t ON c.id = t.source_customer_id OR c.id = t.target_customer_id
ORDER BY 
    c.id, t.transfer_date;	3291969349
SELECT 
    c.id AS customer_id,
    c.customer_name,
    ub.behavior_type,
    ub.behavior_date,
    ub.description AS behavior_description,
    lr.repayment_amount,
    lr.repayment_date,
    lr.description AS repayment_description
FROM 
    customer c
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
ORDER BY 
    c.id, ub.behavior_date, lr.repayment_date;	3977283654
SELECT 
    d.cust_name AS customer_name,
    d.acct_bal AS account_balance,
    dt.deposit_type_name
FROM 
    deposit_account_info d
JOIN 
    deposit_type dt ON d.acct_type_code = dt.deposit_type_id
WHERE 
    d.data_dt = '2024-07-21'
    AND d.acct_bal > 50000;	2512363543
WITH province_total AS (
    SELECT 
        c.province,
        SUM(la.loan_amount) AS total_province_loan
    FROM 
        loan_application la
    JOIN 
        customer c ON la.customer_id = c.id
    GROUP BY 
        c.province
),
customer_loan AS (
    SELECT 
        c.id AS customer_id,
        c.customer_name,
        c.province,
        SUM(la.loan_amount) AS total_customer_loan
    FROM 
        loan_application la
    JOIN 
        customer c ON la.customer_id = c.id
    GROUP BY 
        c.id, c.customer_name, c.province
)
SELECT 
    cl.customer_id,
    cl.customer_name,
    cl.province,
    cl.total_customer_loan,
    pt.total_province_loan,
    ROUND((cl.total_customer_loan * 100.0 / pt.total_province_loan), 2) AS percentage_of_province
FROM 
    customer_loan cl
JOIN 
    province_total pt ON cl.province = pt.province
ORDER BY 
    cl.province, percentage_of_province DESC;	4035425926
WITH province_loan_stats AS (
    -- 计算每个省份每个职业的贷款申请总数和通过数
    SELECT 
        c.province,
        o.occupation_name,
        COUNT(la.id) AS total_applications,
        SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) AS approved_applications
    FROM 
        loan_application la
        JOIN customer c ON la.customer_id = c.id
        JOIN occupation o ON c.occupation_id = o.id
    GROUP BY 
        c.province, o.occupation_name
),
province_occupation_rates AS (
    -- 计算每个省份每个职业的通过率
    SELECT 
        province,
        occupation_name,
        total_applications,
        approved_applications,
        CASE 
            WHEN total_applications = 0 THEN 0 
            ELSE approved_applications::numeric / total_applications 
        END AS approval_rate
    FROM 
        province_loan_stats
),
ranked_occupations AS (
    -- 为每个省份的职业按通过率排名
    SELECT 
        province,
        occupation_name,
        approval_rate,
        RANK() OVER (PARTITION BY province ORDER BY approval_rate DESC) AS rank
    FROM 
        province_occupation_rates
    WHERE 
        total_applications > 0  -- 只考虑有申请的职业
)
-- 选择每个省份排名第一的职业
SELECT 
    province,
    occupation_name AS highest_approval_rate_occupation,
    approval_rate
FROM 
    ranked_occupations
WHERE 
    rank = 1
ORDER BY 
    province;	82349614
WITH branch_total AS (
    -- 计算每个分行的存款总额
    SELECT 
        org_no,
        org_nm,
        SUM(acct_bal) AS total_balance
    FROM deposit_account_info
    GROUP BY org_no, org_nm
),
top_customers AS (
    -- 找出每个分行存款余额最高的前10名客户
    SELECT 
        org_no,
        org_nm,
        cust_no,
        cust_name,
        acct_bal,
        ROW_NUMBER() OVER (PARTITION BY org_no ORDER BY acct_bal DESC) AS rank
    FROM deposit_account_info
),
top10_sum AS (
    -- 计算每个分行前10名客户的存款合计
    SELECT 
        org_no,
        org_nm,
        SUM(acct_bal) AS top10_balance
    FROM top_customers
    WHERE rank <= 10
    GROUP BY org_no, org_nm
)
-- 计算比例
SELECT 
    t.org_no,
    t.org_nm AS branch_name,
    b.total_balance AS branch_total_balance,
    t.top10_balance AS top10_customers_balance,
    (t.top10_balance / b.total_balance) * 100 AS percentage
FROM top10_sum t
JOIN branch_total b ON t.org_no = b.org_no
ORDER BY percentage DESC;	3816528329
SELECT 
    d.cust_nm AS customer_name,
    d.tel_no AS phone_number
FROM 
    debit_card_information d
WHERE 
    d.cust_nm LIKE '%Lee%';	3967240206
SELECT 
    c.id AS customer_id,
    c.customer_name,
    c.id_number,
    c.phone_number,
    c.email,
    ub.behavior_type,
    ub.behavior_date,
    ub.description AS behavior_description,
    lr.repayment_amount,
    lr.repayment_date,
    lr.description AS repayment_description
FROM 
    customer c
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
ORDER BY 
    c.id, ub.behavior_date, lr.repayment_date;	2555762315
SELECT DISTINCT c.customer_name, lc.credit_score, lr.repayment_amount, lr.repayment_date
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
JOIN loan_application la ON c.id = la.customer_id
JOIN loan_repayment lr ON la.id = lr.loan_application_id
WHERE lc.credit_score > 0.75
AND lr.repayment_date = '2021-11-10'
ORDER BY lc.credit_score DESC;	1472446382
SELECT * FROM loan_repayment WHERE repayment_amount > 900;	837468015
SELECT 
    d.cust_no AS customer_number,
    d.cust_nm AS customer_name,
    d.card_no AS card_number,
    d.residential_address AS address
FROM 
    debit_card_information d
WHERE 
    d.card_state = '正常'
    AND d.residential_address = '987 Willow Street'
    AND d.data_dt = '2024-07-09';	3614707278
SELECT 
    c.id AS customer_id,
    c.customer_name,
    c.id_number,
    l.id AS loan_id,
    lt.loan_type_name,
    la.loan_amount,
    la.loan_term,
    la.apply_date,
    la.status,
    ld.loan_balance,
    ld.account_state,
    ld.judgelevel
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_type lt ON la.loan_type_id = lt.id
LEFT JOIN 
    loan_detail_info ld ON c.id_number = ld.cust_id
ORDER BY 
    c.id, la.apply_date DESC;	3381297740
SELECT 
    ldi.loan_type,
    COUNT(DISTINCT dbi.cust_no) AS debit_card_user_count
FROM 
    loan_detail_info ldi
JOIN 
    debit_card_information dbi ON ldi.cust_id = dbi.cust_id
GROUP BY 
    ldi.loan_type
ORDER BY 
    debit_card_user_count DESC;	3209601254
SELECT 
    lt.loan_type_name,
    COUNT(DISTINCT la.customer_id) AS customer_count
FROM 
    loan_type lt
LEFT JOIN 
    loan_application la ON lt.id = la.loan_type_id
GROUP BY 
    lt.loan_type_name
ORDER BY 
    customer_count DESC;	1181974520
SELECT c.id AS customer_id, c.customer_name, lc.credit_score, lc.description AS credit_description
FROM customer c
LEFT JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_date = '2011-04-13';	4290316983
SELECT 
    SUM(fp.wealth_bal) AS total_wealth_balance,
    SUM(fp.wealth_bal_f) AS total_guaranteed_wealth_balance
FROM 
    financial_products fp
JOIN 
    deposit_account_info dai ON fp.cust_no = dai.cust_no AND fp.data_dt = dai.data_dt
JOIN 
    debit_card_information dci ON dai.cust_no = dci.cust_no AND dai.data_dt = dci.data_dt
WHERE 
    fp.data_dt = '2024-07-14'::timestamp
    AND dai.cust_type = '2' -- 对公客户(假设'2'表示对公客户)
    AND dci.org_nm = '沈阳余淮支行';	4121525980
SELECT c.id AS customer_id, lc.credit_score
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_date = '2003-06-22'
AND lc.credit_score > 0.75;	1634196262
SELECT 
    t.id AS transfer_id,
    t.transfer_amount,
    t.transfer_date,
    t.description,
    t.source_customer_id,
    c1.customer_name AS source_customer_name,
    t.target_customer_id,
    c2.customer_name AS target_customer_name
FROM 
    transfer t
LEFT JOIN 
    customer c1 ON t.source_customer_id = c1.id
LEFT JOIN 
    customer c2 ON t.target_customer_id = c2.id
ORDER BY 
    t.transfer_date DESC;	2019378478
SELECT loan_type_name 
FROM loan_type 
WHERE loan_type_code = 'MORTGAGE';	522536270
SELECT 
    cust_nm AS customer_name,
    card_no
FROM 
    debit_card_information
WHERE 
    card_state = '正常'
    AND data_dt = '2024-07-05'
ORDER BY 
    cust_nm;	126227619
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'financial_products';	2456368123
SELECT deposit_name, deposit_type_id 
FROM deposit_type 
ORDER BY deposit_name;	1564372003
SELECT 
    c.id AS customer_id,
    c.customer_name,
    la.loan_amount,
    ls.loan_status_name AS status
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_status ls ON la.status = ls.loan_status_code
ORDER BY 
    c.id;	2160477527
SELECT c.*
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_score = 0.77;	1462437870
SELECT 
    lt.loan_type_name,
    lt.description AS loan_type_description,
    lr.repayment_amount,
    lr.repayment_date,
    lr.description AS repayment_description
FROM 
    loan_type lt
LEFT JOIN 
    loan_application la ON lt.id = la.loan_type_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
ORDER BY 
    lt.loan_type_name, lr.repayment_date;	4083934626
SELECT rs_type_id AS classification_code, 
       rs_type_name AS classification_name
FROM five_level_classification
WHERE rs_type IN ('S', 'D', 'L')  -- 可疑分类通常包括次级(S)、可疑(D)和损失(L)类
ORDER BY rs_type_id;	2872120818
ERROR: LLM 请求失败	1283326851
SELECT DISTINCT card_type, card_state 
FROM debit_card_information 
WHERE card_type IS NOT NULL;	531921010
SELECT 
    cust_id AS customer_id,
    SUM(loan_balance) AS total_loan_balance
FROM 
    loan_detail_info
WHERE 
    dw_date = '2024-07-19' 
    AND loan_balance > 100000
GROUP BY 
    cust_id
ORDER BY 
    total_loan_balance DESC;	1418289021
WITH bank_branches AS (
    SELECT bank_id, bank_name 
    FROM bank_orgnization 
    WHERE bank_level = '2'  -- 筛选分行级别的银行
),

deposit_balances AS (
    SELECT 
        d.org_no AS bank_id,
        SUM(d.acct_bal) AS total_deposit_balance
    FROM deposit_account_info d
    JOIN bank_branches b ON d.org_no = b.bank_id
    GROUP BY d.org_no
),

loan_balances AS (
    SELECT 
        l.loan_orgno AS bank_id,
        SUM(l.loan_balance) AS total_loan_balance
    FROM loan_detail_info l
    JOIN bank_branches b ON l.loan_orgno = b.bank_id
    GROUP BY l.loan_orgno
),

bank_stats AS (
    SELECT 
        b.bank_id,
        b.bank_name,
        COALESCE(d.total_deposit_balance, 0) AS deposit_balance,
        COALESCE(l.total_loan_balance, 0) AS loan_balance
    FROM bank_branches b
    LEFT JOIN deposit_balances d ON b.bank_id = d.bank_id
    LEFT JOIN loan_balances l ON b.bank_id = l.bank_id
    WHERE d.total_deposit_balance IS NOT NULL 
      AND l.total_loan_balance IS NOT NULL
)

SELECT 
    bank_id,
    bank_name,
    deposit_balance,
    loan_balance,
    (COUNT(*) * SUM(deposit_balance * loan_balance) - SUM(deposit_balance) * SUM(loan_balance)) / 
    (SQRT(COUNT(*) * SUM(deposit_balance * deposit_balance) - SUM(deposit_balance) * SUM(deposit_balance)) * 
     SQRT(COUNT(*) * SUM(loan_balance * loan_balance) - SUM(loan_balance) * SUM(loan_balance))) AS correlation_coefficient
FROM bank_stats
GROUP BY bank_id, bank_name, deposit_balance, loan_balance;	137242606
SELECT 
    DATE_TRUNC('month', t.transfer_date) AS month,
    SUM(t.transfer_amount) AS total_transfer_amount,
    SUM(la.loan_amount) AS total_loan_amount
FROM 
    transfer t
FULL OUTER JOIN 
    loan_application la ON DATE_TRUNC('month', t.transfer_date) = DATE_TRUNC('month', la.apply_date)
GROUP BY 
    DATE_TRUNC('month', t.transfer_date), DATE_TRUNC('month', la.apply_date)
ORDER BY 
    month;	2672242323
SELECT customer_name, phone_number 
FROM customer 
WHERE province = '上海市';	2845015839
SELECT credit_score, credit_date 
FROM loan_credit 
WHERE customer_id = 533302;	1582007502
SELECT * FROM transfer ORDER BY transfer_amount DESC;	283689317
SELECT 
    c.id AS customer_id,
    c.customer_name,
    ub.behavior_type,
    COUNT(*) AS behavior_count
FROM 
    customer c
JOIN 
    user_behavior ub ON c.id = ub.customer_id
GROUP BY 
    c.id, c.customer_name, ub.behavior_type
ORDER BY 
    c.id, behavior_count DESC;	1594346019
WITH shenyang_customers AS (
    -- 获取沈阳分行的客户ID
    SELECT DISTINCT d.cust_no
    FROM deposit_account_info d
    JOIN debit_card_information dc ON d.cust_no = dc.cust_no
    WHERE d.org_nm LIKE '%沈阳%'
    AND d.data_dt = '2024-07-22'
),

high_balance_customers AS (
    -- 存款余额超过100000元的客户
    SELECT cust_no
    FROM deposit_account_info
    WHERE acct_bal > 100000
    AND data_dt = '2024-07-22'
),

overdue_customers AS (
    -- 信用卡逾期金额超过5000元的客户
    SELECT custr_nbr
    FROM credit_card_data
    WHERE stm_overdu > 5000
    AND DATE(cycle_nbr) = '2024-07-22'
)

-- 统计同时满足三个条件的客户数量
SELECT COUNT(DISTINCT s.cust_no) AS customer_count
FROM shenyang_customers s
JOIN high_balance_customers h ON s.cust_no = h.cust_no
JOIN overdue_customers o ON s.cust_no = o.custr_nbr;	3342713409
SELECT 
    card_no AS "卡号",
    cust_nm AS "客户名称"
FROM 
    debit_card_information
WHERE 
    bank_nm = '北京分行'
ORDER BY 
    cust_nm, card_no;	842726032
WITH monthly_applications AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', apply_date) AS application_month,
        LEAD(DATE_TRUNC('month', apply_date), 1) OVER (PARTITION BY customer_id ORDER BY DATE_TRUNC('month', apply_date)) AS next_month,
        LEAD(DATE_TRUNC('month', apply_date), 2) OVER (PARTITION BY customer_id ORDER BY DATE_TRUNC('month', apply_date)) AS month_after_next
    FROM 
        loan_application
    GROUP BY 
        customer_id, DATE_TRUNC('month', apply_date)
),
consecutive_months AS (
    SELECT 
        customer_id,
        application_month,
        CASE 
            WHEN next_month = application_month + INTERVAL '1 month' 
                 AND month_after_next = application_month + INTERVAL '2 months' 
            THEN 1
            ELSE 0
        END AS has_consecutive_three
    FROM 
        monthly_applications
)
SELECT 
    COUNT(DISTINCT customer_id) AS customers_with_consecutive_three_months
FROM 
    consecutive_months
WHERE 
    has_consecutive_three = 1;	236915033
SELECT 
    fp.cust_no AS customer_number,
    bo.bank_name AS bank_name
FROM 
    financial_products fp
JOIN 
    bank_orgnization bo ON fp.bank_no = bo.bank_id
ORDER BY 
    fp.cust_no;	4229311898
SELECT occupation_code, occupation_name 
FROM occupation 
ORDER BY occupation_name;	258690623
SELECT COUNT(DISTINCT fp.cust_no) AS customer_count
FROM financial_products fp
JOIN debit_card_information d ON fp.cust_no = d.cust_no
WHERE fp.wealth_bal > (d.current_bal * 10);	3376193292
SELECT loan_orgno, loan_balance
FROM loan_detail_info
WHERE loan_amount > 70000;	116553538
SELECT 
    lt.id AS loan_type_id,
    lt.loan_type_code,
    lt.loan_type_name,
    ub.id AS behavior_id,
    ub.behavior_type,
    ub.behavior_date,
    ub.description AS behavior_description
FROM 
    loan_type lt
LEFT JOIN 
    loan_application la ON lt.id = la.loan_type_id
LEFT JOIN 
    customer c ON la.customer_id = c.id
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
ORDER BY 
    lt.id, ub.behavior_date DESC;	646950911
ERROR: LLM 请求失败	109259315
SELECT 
    d.card_no,
    d.current_bal AS "活期余额",
    d.fixed_bal AS "定期余额"
FROM 
    debit_card_information d
JOIN 
    customer c ON d.cust_id = c.id_number
WHERE 
    d.org_nm = '北京东单支行'
    AND c.customer_name = 'Olivia Lee'
    AND d.data_dt = '2024-07-15'
    AND d.card_state = '正常';  -- 假设只查询状态正常的卡;	2700778328
SELECT c.customer_name, lc.description
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_date = '2017-10-31' 
  AND lc.credit_score > 0.85
ORDER BY lc.credit_score DESC;	4212764935
SELECT 
    c.id AS customer_id,
    c.customer_name,
    la.loan_amount
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
WHERE 
    lt.loan_type_code = 'CAR';	4269406178
SELECT 
    lt.loan_type_name,
    AVG(lr.repayment_amount) AS average_repayment_amount,
    COUNT(lr.id) AS repayment_count
FROM 
    loan_type lt
LEFT JOIN 
    loan_application la ON lt.id = la.loan_type_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
GROUP BY 
    lt.loan_type_name;	1128360712
SELECT acc_name1, bank, category, day_opened
FROM credit_card_data
WHERE corporation = 'Corp3'
ORDER BY day_opened DESC;	2724005771
SELECT customer_name, address 
FROM customer;	3382134012
WITH bank_loans AS (
    -- 计算各银行2023年的贷款总额
    SELECT 
        l.loan_orgno AS bank_id,
        SUM(l.loan_amount) AS total_loans
    FROM 
        loan_detail_info l
    WHERE 
        EXTRACT(YEAR FROM l.dw_date) = 2023
    GROUP BY 
        l.loan_orgno
),
bank_debit_balances AS (
    -- 计算各银行客户的借记卡总余额
    SELECT 
        d.bank_no AS bank_id,
        SUM(d.current_bal) AS total_debit_balance
    FROM 
        debit_card_information d
    WHERE 
        EXTRACT(YEAR FROM d.data_dt) = 2023
    GROUP BY 
        d.bank_no
)
-- 计算比率并关联银行名称
SELECT 
    b.bank_id,
    bo.bank_name,
    bl.total_loans,
    db.total_debit_balance,
    CASE 
        WHEN db.total_debit_balance = 0 THEN NULL 
        ELSE bl.total_loans / db.total_debit_balance 
    END AS loan_to_debit_ratio
FROM 
    bank_loans bl
JOIN 
    bank_debit_balances db ON bl.bank_id = db.bank_id
JOIN 
    bank_orgnization bo ON bl.bank_id = bo.bank_id
WHERE 
    bo.data_dt = (SELECT MAX(data_dt) FROM bank_orgnization)
ORDER BY 
    loan_to_debit_ratio DESC;	1545912595
WITH avg_repayment AS (
    SELECT AVG(repayment_amount) AS avg_amount
    FROM loan_repayment
)
SELECT lr.*
FROM loan_repayment lr
CROSS JOIN avg_repayment ar
ORDER BY ABS(lr.repayment_amount - ar.avg_amount)
LIMIT 1;	2397640501
SELECT DISTINCT c.id, c.customer_name
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
JOIN financial_products fp ON c.id = fp.cust_no::integer
WHERE lc.credit_score > 0.8
AND fp.data_dt >= '2024-07-01' 
AND fp.data_dt < '2024-08-01'
AND fp.wealth_bal > 0;	561955406
SELECT 
    EXTRACT(YEAR FROM apply_date) AS year,
    EXTRACT(MONTH FROM apply_date) AS month,
    COUNT(CASE WHEN status = 'APPROVED' THEN 1 END) AS approved_count,
    COUNT(*) AS total_count,
    ROUND(COUNT(CASE WHEN status = 'APPROVED' THEN 1 END) * 100.0 / COUNT(*), 2) AS approval_rate
FROM 
    loan_application
GROUP BY 
    EXTRACT(YEAR FROM apply_date),
    EXTRACT(MONTH FROM apply_date)
ORDER BY 
    year, month;	1986127383
WITH new_customers_q1_2024 AS (
    -- 获取2024年第一季度新增客户（通过借记卡开户日期判断）
    SELECT 
        d.bank_no AS bank_id,
        d.bank_nm AS bank_name,
        d.cust_no AS customer_id
    FROM 
        debit_card_information d
    WHERE 
        d.open_date >= '2024-01-01' 
        AND d.open_date < '2024-04-01'
    
    UNION
    
    -- 获取2024年第一季度新增客户（通过存款账户开户日期判断）
    SELECT 
        a.bank_no AS bank_id,
        a.bank_nm AS bank_name,
        a.cust_no AS customer_id
    FROM 
        deposit_account_info a
    WHERE 
        a.bank_date >= '2024-01-01' 
        AND a.bank_date < '2024-04-01'
),

customer_loans AS (
    -- 获取这些新客户的贷款信息
    SELECT 
        n.bank_id,
        n.bank_name,
        n.customer_id,
        COALESCE(SUM(l.loan_amount), 0) AS total_loan_amount
    FROM 
        new_customers_q1_2024 n
    LEFT JOIN 
        loan_detail_info l ON n.customer_id = l.cust_id
    GROUP BY 
        n.bank_id, n.bank_name, n.customer_id
)

-- 最终查询：计算各银行的新增客户数量和平均贷款金额
SELECT 
    b.bank_name,
    COUNT(DISTINCT cl.customer_id) AS new_customer_count,
    CASE 
        WHEN COUNT(DISTINCT cl.customer_id) > 0 
        THEN ROUND(AVG(cl.total_loan_amount), 2) 
        ELSE 0 
    END AS avg_loan_amount
FROM 
    bank_orgnization b
LEFT JOIN 
    customer_loans cl ON b.bank_id = cl.bank_id
GROUP BY 
    b.bank_name
ORDER BY 
    new_customer_count DESC;	1657316021
SELECT 
    bo.bank_id AS governing_bank_id,
    bo.bank_name AS governing_bank_name,
    AVG(la.loan_term) AS average_loan_term,
    AVG(la.loan_amount) AS average_loan_amount
FROM 
    bank_orgnization bo
JOIN 
    loan_detail_info ldi ON bo.bank_id = ldi.loan_orgno
JOIN 
    loan_application la ON ldi.reportid = la.id::varchar
WHERE 
    bo.bank_level = 'governing'  -- 假设管辖行在bank_level字段中标记为'governing'
GROUP BY 
    bo.bank_id, bo.bank_name
ORDER BY 
    average_loan_amount DESC;	2162181589
SELECT c.id AS customer_id, c.customer_name, lc.credit_score, lc.credit_date
FROM customer c
LEFT JOIN loan_credit lc ON c.id = lc.customer_id
ORDER BY c.id;	2307971258
SELECT 
    c.id AS customer_id,
    c.customer_name,
    ld.loan_balance,
    ld.loandate_e AS loan_due_date
FROM 
    customer c
JOIN 
    loan_detail_info ld ON c.id_number = ld.cust_id
WHERE 
    ld.loandate_e < '2026-01-01'
    AND ld.account_state = 'Active'
ORDER BY 
    ld.loandate_e;	2557946358
SELECT id, apply_date 
FROM loan_application;	3214990589
SELECT la.customer_id, la.loan_amount
FROM loan_application la
JOIN loan_type lt ON la.loan_type_id = lt.id
WHERE lt.loan_type_name = '住房贷款' AND la.status = 'APPROVED'
ORDER BY la.loan_amount DESC;	140188268
SELECT 
    d.org_nm AS branch_name,
    b.bank_name AS parent_bank_name,
    SUM(d.acct_bal) AS total_deposit_balance
FROM 
    deposit_account_info d
JOIN 
    bank_orgnization b ON d.org_no = b.bank_id
WHERE 
    b.bank_level = '2'  -- 假设2级是网点级别
GROUP BY 
    d.org_nm, b.bank_name
ORDER BY 
    total_deposit_balance DESC
LIMIT 5;	2839950527
SELECT * FROM loan_repayment WHERE description = '严琳';	2833646672
SELECT 
    rs_type_name AS classification_name,
    COUNT(*) AS count
FROM 
    five_level_classification
GROUP BY 
    rs_type_name;	508839263
SELECT rs_type_name, COUNT(*) as count
FROM five_level_classification
GROUP BY rs_type_name;	3720034566
SELECT 
    bo.bank_id,
    bo.bank_name,
    fp.cust_no,
    fp.wealth_bal
FROM 
    bank_orgnization bo
JOIN 
    financial_products fp ON bo.bank_id = fp.bank_no
ORDER BY 
    bo.bank_id, fp.cust_no;	1167041688
SELECT loan_type_code, loan_type_name, description 
FROM loan_type 
ORDER BY loan_type_code;	1532873158
SELECT 
    b.bank_name AS bank_name,
    p.bank_name AS parent_bank_name
FROM 
    bank_orgnization b
JOIN 
    bank_orgnization p ON b.bank_parent = p.bank_id
WHERE 
    b.bank_level = '2';	2367133121
WITH province_loan_totals AS (
    SELECT 
        c.province,
        c.customer_name,
        SUM(la.loan_amount) AS total_loan_amount,
        ROW_NUMBER() OVER (PARTITION BY c.province ORDER BY SUM(la.loan_amount) DESC) AS rank
    FROM 
        customer c
    JOIN 
        loan_application la ON c.id = la.customer_id
    GROUP BY 
        c.province, c.customer_name
)
SELECT 
    province,
    customer_name,
    total_loan_amount
FROM 
    province_loan_totals
WHERE 
    rank <= 3
ORDER BY 
    province, total_loan_amount DESC;	2982430979
SELECT * FROM transfer WHERE source_customer_id = 376252;	4126585093
SELECT 
    c.customer_name, 
    c.gender, 
    o.occupation_name
FROM 
    customer c
LEFT JOIN 
    occupation o ON c.occupation_id = o.id;	1577554550
WITH shenyang_yuhai_branch AS (
    SELECT org_no 
    FROM bank_orgnization 
    WHERE bank_name = '沈阳余淮支行'
    AND data_dt = '2024-07-31'
),
non_guaranteed_products AS (
    SELECT 
        cust_no,
        SUM(wealth_bal_f) AS total_non_guaranteed_balance
    FROM financial_products
    WHERE data_dt BETWEEN '2024-07-01' AND '2024-07-31'
    AND org_no IN (SELECT org_no FROM shenyang_yuhai_branch)
    AND wealth_bal_f > 0
    GROUP BY cust_no
)
SELECT 
    COUNT(DISTINCT cust_no) AS customer_count,
    COALESCE(SUM(total_non_guaranteed_balance), 0) AS total_balance
FROM non_guaranteed_products;	1654794343
SELECT DISTINCT c.id
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_score > 0.8;	2092588313
SELECT 
    t.id AS transfer_id,
    c1.customer_name AS source_customer_name,
    c2.customer_name AS target_customer_name,
    t.transfer_amount,
    t.transfer_date,
    t.description
FROM 
    transfer t
JOIN 
    customer c1 ON t.source_customer_id = c1.id
JOIN 
    customer c2 ON t.target_customer_id = c2.id
WHERE 
    t.transfer_amount > 5000
ORDER BY 
    t.transfer_date DESC;	2021025668
SELECT DISTINCT c.id, c.customer_name
FROM customer c
JOIN loan_application la ON c.id = la.customer_id
JOIN loan_status ls ON la.status = ls.loan_status_code
WHERE EXTRACT(YEAR FROM la.apply_date) = 2019
AND ls.loan_status_name = 'APPROVED';	891116215
SELECT 
    d.card_type,
    d.card_type_nm AS card_type_name,
    COUNT(DISTINCT d.cust_no) AS customer_count,
    AVG(f.wealth_bal) AS avg_wealth_balance
FROM 
    debit_card_information d
LEFT JOIN 
    financial_products f ON d.cust_no = f.cust_no
WHERE 
    d.card_type IS NOT NULL
GROUP BY 
    d.card_type, d.card_type_nm
ORDER BY 
    d.card_type;	3533102799
SELECT c.customer_name, la.loan_amount
FROM loan_application la
JOIN customer c ON la.customer_id = c.id
ORDER BY la.apply_date ASC;	2160175524
SELECT 
    SUM(acct_bal) AS total_account_balance,
    SUM(act_year_avg_bal) AS total_actual_year_avg_balance
FROM 
    deposit_account_info
WHERE 
    cust_type = '对私'
    AND data_dt = '2024-07-19';	305358980
SELECT c.customer_name, o.occupation_name
FROM customer c
JOIN occupation o ON c.occupation_id = o.id
JOIN loan_application la ON c.id = la.customer_id
JOIN loan_repayment lr ON la.id = lr.loan_application_id
WHERE lr.repayment_amount < 500;	3219483220
SELECT 
    d.data_dt,
    d.bank_no,
    d.bank_nm,
    d.org_no,
    d.org_nm,
    d.cust_no,
    d.cust_name,
    d.cust_type,
    d.cert_typ,
    d.cert_code,
    d.gender_code,
    d.repayment_acc_name,
    d.ci_ref_acct,
    d.acct_type_code,
    d.reality_ir_y,
    d.cur_type,
    d.re_aclg,
    d.acct_bal,
    d.arl_pdp_code,
    d.sta_mon_avg_bal,
    d.act_mon_avg_bal,
    d.sta_year_avg_bal,
    d.act_year_avg_bal,
    d.bank_date,
    d.act_core_bal,
    d.act_base_bal
FROM 
    deposit_account_info d
WHERE 
    d.data_dt = '2023-07-19';	3553634354
WITH max_deposit_customer AS (
    SELECT 
        cust_no,
        cust_name,
        acct_bal,
        ROW_NUMBER() OVER (ORDER BY acct_bal DESC) AS rank
    FROM 
        deposit_account_info
    WHERE 
        acct_bal IS NOT NULL
    LIMIT 1
),
customer_id_mapping AS (
    SELECT 
        c.id AS customer_id,
        d.cust_name,
        d.acct_bal
    FROM 
        customer c
    JOIN 
        max_deposit_customer d ON c.customer_name = d.cust_name
    LIMIT 1
),
latest_loan AS (
    SELECT 
        l.*,
        ROW_NUMBER() OVER (PARTITION BY l.customer_id ORDER BY l.apply_date DESC) AS rn
    FROM 
        loan_application l
    JOIN 
        customer_id_mapping m ON l.customer_id = m.customer_id
)
SELECT 
    m.cust_name AS customer_name,
    m.acct_bal AS max_deposit_balance,
    l.loan_type_id,
    lt.loan_type_name,
    l.loan_amount,
    l.loan_term,
    l.apply_date,
    l.status
FROM 
    customer_id_mapping m
LEFT JOIN 
    latest_loan l ON m.customer_id = l.customer_id AND l.rn = 1
LEFT JOIN 
    loan_type lt ON l.loan_type_id = lt.id;	1610907085
SELECT 
    o.occupation_name,
    COUNT(c.id) AS customer_count
FROM 
    customer c
JOIN 
    occupation o ON c.occupation_id = o.id
GROUP BY 
    o.occupation_name
ORDER BY 
    customer_count DESC;	1410414363
SELECT 
    c.customer_name,
    t.transfer_amount
FROM 
    transfer t
JOIN 
    customer c ON t.source_customer_id = c.id
WHERE 
    t.transfer_date = '2016-06-11'
    AND t.transfer_amount > 5000
ORDER BY 
    t.transfer_amount DESC;	3954115529
SELECT 
    ldi.cust_id AS 客户编号,
    ldi.loan_balance AS 贷款余额,
    lt.loan_type_name AS 贷款种类,
    c.curr_full_name AS 币种全名
FROM 
    loan_detail_info ldi
JOIN 
    loan_type lt ON ldi.loan_type = lt.loan_type_code
JOIN 
    currency c ON ldi.currency_type = c.curr_code
WHERE 
    ldi.loandate_s > '2024-07-01' 
    AND ldi.loan_balance > 1000000
ORDER BY 
    ldi.loan_balance DESC;	1086674624
SELECT * FROM user_behavior WHERE behavior_date = '2018-06-26';	1680159550
SELECT *
FROM loan_repayment
WHERE EXTRACT(DOW FROM repayment_date) IN (0, 6);	2548352227
SELECT 
    dt.deposit_id,
    dt.deposit_name,
    lt.loan_type_code,
    lt.loan_type_name,
    COUNT(DISTINCT c.id) AS customer_count
FROM 
    customer c
LEFT JOIN 
    deposit_account_info dai ON c.id_number = dai.cert_code
LEFT JOIN 
    deposit_type dt ON dai.acct_type_code = dt.deposit_id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_type lt ON la.loan_type_id = lt.id
WHERE 
    dt.deposit_id IS NOT NULL 
    AND lt.id IS NOT NULL
GROUP BY 
    dt.deposit_id,
    dt.deposit_name,
    lt.loan_type_code,
    lt.loan_type_name
ORDER BY 
    customer_count DESC;	1833243393
SELECT c.customer_name, lr.repayment_amount
FROM loan_repayment lr
JOIN loan_application la ON lr.loan_application_id = la.id
JOIN customer c ON la.customer_id = c.id
WHERE lr.repayment_date = '2021-11-10'
AND lr.repayment_amount > 20
ORDER BY lr.repayment_amount DESC;	3824204712
SELECT 
    lt.loan_type_code,
    lt.loan_type_name,
    AVG(lc.credit_score) AS average_credit_score
FROM 
    loan_type lt
JOIN 
    loan_application la ON lt.id = la.loan_type_id
JOIN 
    loan_credit lc ON la.customer_id = lc.customer_id
GROUP BY 
    lt.loan_type_code, lt.loan_type_name
ORDER BY 
    average_credit_score DESC;	3260667731
SELECT loan_type_code, loan_type_name 
FROM loan_type 
WHERE loan_type_code IS NOT NULL;	732762958
SELECT ls.loan_status_name, COUNT(la.id) AS application_count
FROM loan_application la
JOIN loan_status ls ON la.status = ls.loan_status_code
GROUP BY ls.loan_status_name
ORDER BY application_count DESC;	330418458
SELECT customer_id, description 
FROM loan_credit;	245397134
SELECT 
    d.cust_name AS customer_name,
    d.cert_code AS id_number,
    d.tel_no AS phone_number,
    dc.card_no AS debit_card_number,
    dc.current_bal AS current_balance
FROM 
    deposit_account_info d
JOIN 
    debit_card_information dc ON d.cust_no = dc.cust_no
WHERE 
    DATE(d.bank_date) = '2024-07-15'
    AND d.org_nm = '北京东单支行'
    AND dc.card_state = '正常' -- 假设只需要状态正常的借记卡
ORDER BY 
    d.cust_name;	2669572809
SELECT 
    c.cust_type,
    SUM(ld.loan_amount) AS total_loan_amount
FROM 
    loan_detail_info ld
JOIN 
    deposit_account_info d ON ld.cust_id = d.cert_code
JOIN 
    customer c ON d.cust_no = c.id_number
GROUP BY 
    c.cust_type
ORDER BY 
    c.cust_type;	2085255506
SELECT 
    iou_no,
    cust_id,
    loan_amount,
    loan_balance,
    (loan_balance / NULLIF(loan_amount, 0)) * 100 AS balance_ratio_percentage
FROM 
    loan_detail_info
WHERE 
    loan_amount > 0
ORDER BY 
    balance_ratio_percentage DESC
LIMIT 10;	1984536651
SELECT 
    la.customer_id,
    SUM(la.loan_amount) AS total_loan_amount
FROM 
    loan_application la
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
WHERE 
    lt.loan_type_name = '住房贷款'
    AND la.status = 'REJECTED'
    AND EXTRACT(YEAR FROM la.apply_date) = 2019
GROUP BY 
    la.customer_id;	258245311
SELECT * FROM bank_orgnization;	1895651034
SELECT 
    ldi.reportid,
    ldi.cust_id,
    ldi.cust_type,
    ldi.iou_no,
    ldi.loan_type,
    ldi.loan_orgno,
    ldi.vouch_type,
    ldi.currency_type,
    c.curr_full_name,
    ldi.account_state,
    ldi.loan_amount,
    ldi.loan_balance,
    ldi.blc_capital,
    ldi.blc_inner,
    ldi.blc_off,
    ldi.judgelevel,
    flc.rs_type_name AS five_level_classification_name,
    ldi.loandate_s,
    ldi.loandate_e,
    ldi.dw_date
FROM 
    loan_detail_info ldi
JOIN 
    currency c ON ldi.currency_type = c.curr_code
JOIN 
    five_level_classification flc ON ldi.judgelevel = flc.rs_type_id
WHERE 
    ldi.blc_capital > 10000
    AND DATE(ldi.dw_date) = '2024-07-22';	134489693
SELECT card_state, open_date
FROM debit_card_information
WHERE card_state = '正常';	2899938404
SELECT 
    c.customer_name,
    t.transfer_amount,
    t.transfer_date
FROM 
    transfer t
JOIN 
    customer c ON t.source_customer_id = c.id
WHERE 
    t.transfer_date = '2023-06-30'
ORDER BY 
    t.transfer_amount DESC;	1614542471
SELECT bank_level, bank_id, bank_name, bank_parent
FROM bank_orgnization
WHERE data_dt = '2023-06-30';	2860028194
SELECT 
    f.cust_no AS customer_id,
    c.customer_name,
    SUM(f.wealth_bal_f) AS total_non_guaranteed_wealth_balance
FROM 
    financial_products f
JOIN 
    customer c ON f.cust_no = c.id_number
WHERE 
    f.data_dt = '2024-07-02'
    AND f.wealth_bal_f > 0  -- 非保本理财产品
GROUP BY 
    f.cust_no, c.customer_name
ORDER BY 
    total_non_guaranteed_wealth_balance DESC;	2112082105
SELECT SUM(la.loan_amount) AS total_rejected_loan_amount
FROM loan_application la
JOIN loan_status ls ON la.status = ls.loan_status_code
WHERE EXTRACT(YEAR FROM la.apply_date) = 2019
AND ls.loan_status_name = 'REJECTED';	1900105170
SELECT 
    b.org_nm AS branch_name,
    SUM(d.acct_bal) AS total_deposit_balance
FROM 
    deposit_account_info d
JOIN 
    bank_orgnization b ON d.org_no = b.bank_id
WHERE 
    d.data_dt = '2024-07-21'::timestamp
    AND d.cust_type = '2' -- 对公客户(假设'2'表示对公客户)
    AND b.bank_parent = (SELECT bank_id FROM bank_orgnization WHERE bank_name LIKE '%杭州分行%' AND bank_level = '2' LIMIT 1)
GROUP BY 
    b.org_nm
ORDER BY 
    total_deposit_balance DESC;	3724611031
SELECT 
    c.id AS customer_id,
    c.customer_name,
    COALESCE(SUM(lr.repayment_amount), 0) AS total_repayment,
    COUNT(ub.id) AS behavior_count,
    CASE 
        WHEN COUNT(lr.id) = 0 THEN 0 
        ELSE COALESCE(SUM(lr.repayment_amount), 0) / COUNT(lr.id) 
    END AS avg_repayment
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
GROUP BY 
    c.id, c.customer_name
ORDER BY 
    total_repayment DESC;	3179484363
SELECT bank_level, bank_id, bank_name, bank_parent, data_dt
FROM bank_orgnization;	3200437107
WITH top_10_percent_depositors AS (
    SELECT 
        d.cust_no,
        d.cust_name,
        d.acct_bal,
        c.occupation_id,
        o.occupation_name
    FROM deposit_account_info d
    JOIN customer c ON d.cert_code = c.id_number
    LEFT JOIN occupation o ON c.occupation_id = o.id
    WHERE d.acct_bal >= (
        SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY acct_bal) 
        FROM deposit_account_info
    )
),
non_loan_applicants AS (
    SELECT t.*
    FROM top_10_percent_depositors t
    WHERE NOT EXISTS (
        SELECT 1 
        FROM loan_application l 
        JOIN customer c ON l.customer_id = c.id
        WHERE c.id_number = t.cust_no
    )
)
SELECT 
    cust_name AS 客户姓名,
    acct_bal AS 存款余额,
    occupation_name AS 职业
FROM non_loan_applicants
ORDER BY acct_bal DESC;	2071923254
SELECT 
    status,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN status = 'APPROVED' THEN 1 ELSE 0 END) AS approved_applications,
    ROUND(SUM(CASE WHEN status = 'APPROVED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS approval_rate_percentage
FROM 
    loan_application
GROUP BY 
    status
ORDER BY 
    approval_rate_percentage DESC;	3565838054
SELECT 
    c.id AS customer_id,
    c.customer_name,
    d.acct_bal AS deposit_balance,
    d.bank_nm AS bank_name,
    d.org_nm AS branch_name,
    d.data_dt AS date
FROM 
    customer c
JOIN 
    deposit_account_info d ON c.id_number = d.cert_code
WHERE 
    d.data_dt >= '2023-07-01' 
    AND d.data_dt < '2023-08-01'
ORDER BY 
    c.id, d.data_dt;	1893298039
SELECT 
    d.org_nm AS bank_organization_name,
    d.org_no AS bank_organization_code,
    SUM(d.acct_bal) AS total_deposit_balance
FROM 
    deposit_account_info d
WHERE 
    d.data_dt = '2023-06-30'::timestamp
    AND d.cur_type = 'USD'
    AND d.acct_bal > 100000
GROUP BY 
    d.org_nm, d.org_no
HAVING 
    SUM(d.acct_bal) > 100000
ORDER BY 
    total_deposit_balance DESC;	2315630941
SELECT 
    d.cust_name AS customer_name,
    d.acct_type_code AS account_type,
    d.acct_bal AS account_balance,
    c.curr_full_name AS currency_full_name
FROM 
    deposit_account_info d
JOIN 
    currency c ON d.cur_type = c.curr_code
WHERE 
    d.data_dt = '2024-07-19' 
    AND d.acct_bal > 100000;	870110560
SELECT 
    d.cust_nm AS customer_name,
    d.card_no AS card_number
FROM 
    debit_card_information d
WHERE 
    d.card_state = '正常'
    AND d.open_date > '2024-07-01'
ORDER BY 
    d.open_date DESC;	1308562229
SELECT deposit_name, deposit_type_id 
FROM deposit_type 
ORDER BY deposit_name;	1986404179
WITH transfer_counts AS (
    SELECT 
        source_customer_id AS customer_id,
        COUNT(*) AS transfer_count
    FROM 
        transfer
    GROUP BY 
        source_customer_id
    ORDER BY 
        transfer_count DESC
    LIMIT 10
),
common_transfer_amounts AS (
    SELECT 
        t.source_customer_id AS customer_id,
        t.transfer_amount,
        COUNT(*) AS amount_count
    FROM 
        transfer t
    JOIN 
        transfer_counts tc ON t.source_customer_id = tc.customer_id
    GROUP BY 
        t.source_customer_id, t.transfer_amount
),
ranked_amounts AS (
    SELECT 
        customer_id,
        transfer_amount,
        amount_count,
        RANK() OVER (PARTITION BY customer_id ORDER BY amount_count DESC) AS amount_rank
    FROM 
        common_transfer_amounts
)
SELECT 
    c.id AS customer_id,
    c.customer_name,
    tc.transfer_count,
    ra.transfer_amount AS most_common_transfer_amount,
    ra.amount_count AS most_common_amount_count
FROM 
    customer c
JOIN 
    transfer_counts tc ON c.id = tc.customer_id
JOIN 
    ranked_amounts ra ON c.id = ra.customer_id AND ra.amount_rank = 1
ORDER BY 
    tc.transfer_count DESC;	2032902123
WITH shanghai_customers_with_credit_cards AS (
    -- 获取上海市拥有状态为'正常'的信用卡的客户ID
    SELECT DISTINCT c.id
    FROM customer c
    JOIN credit_card_data cc ON c.id_number = cc.custr_nbr
    WHERE c.province = '上海市' 
    AND cc.acct_sts = '正常'
)
SELECT 
    COUNT(DISTINCT sc.id) AS customer_count,
    COALESCE(SUM(ld.loan_balance), 0) AS total_loan_balance
FROM shanghai_customers_with_credit_cards sc
LEFT JOIN loan_detail_info ld ON sc.id::text = ld.cust_id;	3109098948
SELECT 
    ldi.*,
    flc.rs_type_name AS five_level_classification_name,
    lt.loan_type_name
FROM 
    loan_detail_info ldi
JOIN 
    five_level_classification flc ON ldi.judgelevel = flc.rs_type_id
JOIN 
    loan_type lt ON ldi.loan_type = lt.loan_type_code
WHERE 
    ldi.dw_date = '2024-07-22' 
    AND ldi.loan_balance > 15000;	188271146
WITH mortgage_customers AS (
    SELECT 
        customer_id,
        SUM(loan_amount) AS mortgage_amount
    FROM 
        loan_application
    WHERE 
        loan_type_id = (SELECT id FROM loan_type WHERE loan_type_code = 'MORTGAGE')
    GROUP BY 
        customer_id
),
car_customers AS (
    SELECT 
        customer_id,
        SUM(loan_amount) AS car_amount
    FROM 
        loan_application
    WHERE 
        loan_type_id = (SELECT id FROM loan_type WHERE loan_type_code = 'CAR')
    GROUP BY 
        customer_id
)
SELECT 
    COUNT(DISTINCT mc.customer_id) AS customer_count
FROM 
    mortgage_customers mc
JOIN 
    car_customers cc ON mc.customer_id = cc.customer_id
WHERE 
    mc.mortgage_amount > cc.car_amount;	7209425
SELECT 
    c.id AS customer_id,
    c.customer_name,
    SUM(d.current_bal) AS total_debit_card_balance
FROM 
    customer c
JOIN 
    debit_card_information d ON c.id_number = d.cust_id
WHERE 
    c.province = '浙江省' 
    AND c.address LIKE '%杭州%上城%'
    AND d.data_dt = '2024-07-19'
GROUP BY 
    c.id, c.customer_name
ORDER BY 
    total_debit_card_balance DESC;	1065176696
WITH loan_stats AS (
    SELECT 
        vouch_type,
        loan_amount,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY loan_amount) AS q1,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY loan_amount) AS median,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY loan_amount) AS q3
    FROM 
        loan_detail_info
    GROUP BY 
        vouch_type, loan_amount
),
aggregated_stats AS (
    SELECT 
        vouch_type,
        AVG(loan_amount) AS avg_loan_amount,
        MAX(median) AS median_loan_amount,
        MAX(q3) - MAX(q1) AS iqr_loan_amount
    FROM 
        loan_stats
    GROUP BY 
        vouch_type
)
SELECT 
    vouch_type AS "担保方式",
    ROUND(avg_loan_amount, 2) AS "平均贷款金额",
    ROUND(median_loan_amount, 2) AS "中位数贷款金额",
    ROUND(iqr_loan_amount, 2) AS "贷款金额四分位差"
FROM 
    aggregated_stats
ORDER BY 
    vouch_type;	953680810
SELECT SUM(t.transfer_amount) AS total_transfer_amount
FROM transfer t
JOIN loan_credit lc1 ON t.source_customer_id = lc1.customer_id
JOIN loan_credit lc2 ON t.target_customer_id = lc2.customer_id
WHERE t.transfer_date = '2020-11-03'
  AND lc1.credit_score > 0.8
  AND lc2.credit_score > 0.8;	2393859347
SELECT COUNT(DISTINCT c.id) AS customer_count
FROM customer c
JOIN occupation o ON c.occupation_id = o.id
JOIN loan_application la ON c.id = la.customer_id
WHERE la.loan_amount > 50000
AND o.occupation_name = '护士';	749612150
SELECT 
    la.id AS loan_application_id,
    la.loan_amount,
    la.loan_term,
    la.apply_date,
    la.status,
    c.id AS customer_id,
    c.customer_name,
    c.id_number,
    c.phone_number,
    c.email,
    c.address,
    c.birth_date,
    c.gender,
    c.province,
    lt.loan_type_name
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
WHERE 
    la.apply_date BETWEEN '2024-07-01' AND '2024-07-31'
ORDER BY 
    la.apply_date;	3260359700
SELECT 
    EXTRACT(YEAR FROM apply_date) AS year,
    EXTRACT(MONTH FROM apply_date) AS month,
    COUNT(CASE WHEN status = 'APPROVED' THEN 1 END) * 100.0 / COUNT(*) AS approval_rate
FROM 
    loan_application
GROUP BY 
    EXTRACT(YEAR FROM apply_date),
    EXTRACT(MONTH FROM apply_date)
ORDER BY 
    year, month;	2869045188
SELECT 
    b.bank_name,
    SUM(f.wealth_bal) AS total_wealth_balance
FROM 
    financial_products f
JOIN 
    deposit_account_info d ON f.cust_no = d.cust_no AND f.data_dt = d.data_dt
JOIN 
    bank_orgnization b ON f.org_no = b.bank_id AND f.data_dt = b.data_dt
WHERE 
    d.cust_type = '对公'
    AND f.data_dt = '2024-07-02'
GROUP BY 
    b.bank_name
ORDER BY 
    total_wealth_balance DESC;	2139894777
SELECT 
    c.id AS customer_id,
    c.customer_name,
    la.id AS loan_application_id,
    la.loan_amount,
    la.loan_term,
    la.apply_date,
    ls.loan_status_name AS status
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_status ls ON la.status = ls.loan_status_code
ORDER BY 
    c.id, la.apply_date;	2426521027
SELECT 
    lt.loan_type_name,
    COUNT(DISTINCT la.customer_id) AS customer_count,
    SUM(la.loan_amount) AS total_loan_amount
FROM 
    loan_application la
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
GROUP BY 
    lt.loan_type_name
ORDER BY 
    total_loan_amount DESC;	3310012060
WITH age_groups AS (
  SELECT 
    c.id,
    CASE 
      WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 0 AND 20 THEN '0-20'
      WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 21 AND 40 THEN '21-40'
      WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 41 AND 60 THEN '41-60'
      ELSE '61+'
    END AS age_group
  FROM customer c
),
loan_stats AS (
  SELECT 
    ag.age_group,
    COUNT(*) AS total_applications,
    SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) AS approved_applications
  FROM loan_application la
  JOIN age_groups ag ON la.customer_id = ag.id
  GROUP BY ag.age_group
)
SELECT 
  age_group,
  total_applications,
  approved_applications,
  CASE 
    WHEN total_applications = 0 THEN 0 
    ELSE ROUND((approved_applications::numeric / total_applications::numeric) * 100, 2) 
  END AS approval_rate
FROM loan_stats
ORDER BY age_group;	1454101538
SELECT repayment_amount, repayment_date 
FROM loan_repayment 
WHERE loan_application_id = 323803;	1355579742
SELECT c.id AS customer_id, lc.credit_score
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
JOIN debit_card_information d ON c.id_number = d.cust_id
WHERE d.org_no = 'BANK_00301' 
  AND d.data_dt = '2023-06-30'
  AND c.province = '浙江省'
ORDER BY lc.credit_score DESC
LIMIT 1;	2730549341
SELECT * 
FROM loan_repayment 
WHERE repayment_date < '2020-02-25';	1021718263
SELECT t.* 
FROM transfer t
WHERE t.source_customer_id = 578484 OR t.target_customer_id = 578484;	405520388
SELECT 
    c.customer_name,
    c.id_number,
    ls.loan_status_name AS loan_status
FROM 
    customer c
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_status ls ON la.status = ls.loan_status_code;	1969682603
SELECT * 
FROM user_behavior 
WHERE behavior_type LIKE '%ILL%';	797442197
SELECT id, source_customer_id, target_customer_id, transfer_amount, transfer_date, description
FROM transfer
ORDER BY transfer_amount ASC;	3086691704
SELECT * FROM user_behavior WHERE description IS NOT NULL;	1652118460
SELECT d.card_no, d.current_bal
FROM customer c
JOIN debit_card_information d ON c.id_number = d.cust_id
JOIN bank_orgnization b ON d.org_no = b.bank_id
WHERE c.customer_name = 'James Taylor'
  AND b.bank_name = '杭州上城区支行'
  AND d.data_dt = '2024-07-09'
  AND d.card_state = '正常';	729818388
SELECT * FROM loan_type WHERE description LIKE '%Loan%';	3319537046
SELECT 
    c.curr_code,
    c.curr_full_name,
    COUNT(ccd.xaccount) AS account_count
FROM 
    credit_card_data ccd
JOIN 
    currency c ON ccd.curr_num = c.curr_code
GROUP BY 
    c.curr_code, c.curr_full_name
ORDER BY 
    account_count DESC;	981960336
SELECT 
    b.bank_name,
    AVG(f.wealth_sta_m_avg_bal_a) AS avg_guaranteed_monthly_balance
FROM 
    financial_products f
JOIN 
    bank_orgnization b ON f.bank_no = b.bank_id
WHERE 
    f.wealth_bal_t > 0  -- 保本理财余额大于0的记录
GROUP BY 
    b.bank_name
ORDER BY 
    avg_guaranteed_monthly_balance DESC;	446364127
SELECT lt.loan_type_name, lt.description
FROM loan_type lt
JOIN loan_application la ON lt.id = la.loan_type_id
WHERE la.status = 'APPROVED';	1464013698
SELECT 
    c.customer_name,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM c.birth_date) AS age,
    la.loan_amount
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
WHERE 
    EXTRACT(YEAR FROM la.apply_date) = 2023
ORDER BY 
    age DESC
LIMIT 5;	2417924945
SELECT COUNT(DISTINCT c.id) AS high_credit_customers_count
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
JOIN bank_orgnization bo ON c.province = '浙江省' AND c.address LIKE '%杭州上城区%'
WHERE lc.credit_score > 0.75
AND bo.bank_name = '杭州上城区支行'
AND bo.data_dt = '2023-06-30'
AND lc.credit_date <= '2023-06-30';	3366689482
SELECT 
    rs_type AS classification_type,
    COUNT(*) AS count
FROM 
    five_level_classification
WHERE 
    data_dt = '2024-07-22'
GROUP BY 
    rs_type
ORDER BY 
    count DESC;	3973811473
SELECT 
    flc.rs_type_name AS classification_name,
    COUNT(ub.id) AS behavior_count
FROM 
    five_level_classification flc
LEFT JOIN 
    loan_detail_info ldi ON flc.rs_type_name = ldi.judgelevel
LEFT JOIN 
    customer c ON ldi.cust_id = c.id_number
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
GROUP BY 
    flc.rs_type_name
ORDER BY 
    behavior_count DESC;	1905559813
SELECT * 
FROM transfer 
ORDER BY transfer_date;	6017603
SELECT 
    d.card_type,
    d.card_type_nm,
    d.card_state
FROM 
    customer c
JOIN 
    debit_card_information d ON c.id_number = d.cust_id
JOIN 
    bank_orgnization b ON d.org_no = b.bank_id
WHERE 
    c.customer_name = 'James Taylor'
    AND b.bank_name = '杭州上城区支行'
    AND d.open_date >= '2024-07-01' 
    AND d.open_date < '2024-08-01'
    AND d.card_state IS NOT NULL;	2286869285
SELECT SUM(wealth_bal) AS total_usd_wealth_balance
FROM financial_products
WHERE data_dt = '2024-07-02' 
  AND currency = 'USD';	1590803091
SELECT 
    c.id AS customer_id,
    c.customer_name,
    COUNT(ub.id) AS behavior_count,
    MAX(lc.credit_score) AS latest_credit_score
FROM 
    customer c
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id
LEFT JOIN 
    loan_credit lc ON c.id = lc.customer_id
GROUP BY 
    c.id, c.customer_name
ORDER BY 
    c.id;	3414285101
SELECT 
    t.id,
    c1.customer_name AS source_customer_name,
    c2.customer_name AS target_customer_name,
    t.transfer_amount,
    t.transfer_date,
    t.description
FROM 
    transfer t
JOIN 
    customer c1 ON t.source_customer_id = c1.id
JOIN 
    customer c2 ON t.target_customer_id = c2.id
WHERE 
    t.transfer_date = '2023-06-30'
    AND t.transfer_amount > 1000
ORDER BY 
    t.transfer_amount DESC;	3246518573
SELECT * FROM customer WHERE customer_name = '饶丽';	104815069
SELECT 
    d.card_no,
    d.card_no_main,
    d.cust_nm AS customer_name
FROM 
    debit_card_information d
WHERE 
    d.card_state = '正常'
    AND d.data_dt = '2024-07-14';	3801446621
SELECT 
    c.customer_name,
    ld.loan_balance,
    flc.rs_type_name AS five_level_classification,
    cu.curr_full_name AS currency_name
FROM 
    loan_detail_info ld
JOIN 
    customer c ON ld.cust_id = c.id_number
JOIN 
    five_level_classification flc ON ld.judgelevel = flc.rs_type_id
JOIN 
    currency cu ON ld.currency_type = cu.curr_code
WHERE 
    ld.dw_date = '2024-07-19'
    AND ld.loan_balance > 500000
ORDER BY 
    ld.loan_balance DESC;	368801370
SELECT COUNT(DISTINCT c.id) AS male_customers_with_high_balance
FROM customer c
JOIN deposit_account_info d ON c.id_number = d.cert_code
WHERE c.gender = '男'
  AND d.org_no IN ('BANK_006', 'BANK_00601')
  AND d.data_dt = '2024-07-19'
  AND d.acct_bal > 100000;	852089580
SELECT 
    la.id AS loan_application_id,
    la.customer_id,
    c.customer_name,
    c.id_number,
    lt.loan_type_name,
    la.loan_amount,
    la.loan_term,
    la.apply_date,
    la.status,
    ld.loan_amount AS actual_loan_amount,
    ld.loan_balance,
    ld.account_state,
    ld.judgelevel,
    lr.repayment_amount,
    lr.repayment_date
FROM 
    loan_application la
JOIN 
    loan_type lt ON la.loan_type_id = lt.id
JOIN 
    customer c ON la.customer_id = c.id
LEFT JOIN 
    loan_detail_info ld ON c.id_number = ld.cust_id AND ld.loan_type = lt.loan_type_code
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
WHERE 
    la.loan_type_id = 3
ORDER BY 
    la.apply_date DESC;	1377442693
SELECT c.customer_name, la.loan_amount
FROM customer c
JOIN loan_application la ON c.id = la.customer_id
WHERE la.loan_amount > 10000;	2349708736
WITH customer_deposits AS (
    -- 计算每个客户的存款余额总和
    SELECT 
        c.id AS customer_id,
        COALESCE(SUM(d.acct_bal), 0) AS total_deposit_balance
    FROM 
        customer c
    LEFT JOIN 
        deposit_account_info d ON c.id_number = d.cert_code
    GROUP BY 
        c.id
),

customer_credit AS (
    -- 获取每个客户的最新信用评分
    SELECT 
        customer_id,
        credit_score
    FROM (
        SELECT 
            customer_id,
            credit_score,
            ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY credit_date DESC) AS rn
        FROM 
            loan_credit
    ) t
    WHERE rn = 1
),

customer_repayment AS (
    -- 计算每个客户的按时还款率
    SELECT 
        la.customer_id,
        COALESCE(SUM(CASE WHEN lr.repayment_date <= la.apply_date + (la.loan_term * 30) THEN 1 ELSE 0 END) * 1.0 / 
                NULLIF(COUNT(lr.id), 0), 1) AS on_time_repayment_rate
    FROM 
        loan_application la
    LEFT JOIN 
        loan_repayment lr ON la.id = lr.loan_application_id
    GROUP BY 
        la.customer_id
),

customer_scores AS (
    -- 计算综合评分（权重：存款40%，信用评分40%，还款率20%）
    SELECT 
        c.id AS customer_id,
        c.customer_name,
        (COALESCE(cd.total_deposit_balance, 0) / NULLIF((SELECT MAX(total_deposit_balance) FROM customer_deposits), 0) * 40 +
         COALESCE(cc.credit_score, 0) / 100 * 40 +
         COALESCE(cr.on_time_repayment_rate, 1) * 20) AS composite_score
    FROM 
        customer c
    LEFT JOIN 
        customer_deposits cd ON c.id = cd.customer_id
    LEFT JOIN 
        customer_credit cc ON c.id = cc.customer_id
    LEFT JOIN 
        customer_repayment cr ON c.id = cr.customer_id
)

-- 最终查询：获取综合评分最高的20名客户
SELECT 
    customer_id,
    customer_name,
    composite_score
FROM 
    customer_scores
ORDER BY 
    composite_score DESC
LIMIT 20;	3911124385
SELECT occupation_code, description 
FROM occupation 
WHERE occupation_name = '护士';	3773516021
SELECT 
    c.id AS customer_id,
    c.customer_name,
    ub.behavior_type,
    ub.behavior_date,
    ub.description AS behavior_description,
    lc.credit_score,
    lc.credit_date
FROM 
    customer c
LEFT JOIN 
    user_behavior ub ON c.id = ub.customer_id 
    AND ub.behavior_date BETWEEN '2021-08-01' AND '2021-08-31'
LEFT JOIN 
    loan_credit lc ON c.id = lc.customer_id
    AND lc.credit_date <= '2021-08-31'
ORDER BY 
    c.id, ub.behavior_date;	1642595147
SELECT 
    lt.loan_type_name AS "贷款类型",
    ls.loan_status_name AS "状态",
    ls.description AS "状态描述"
FROM 
    loan_type lt
CROSS JOIN 
    loan_status ls
ORDER BY 
    lt.loan_type_name, ls.loan_status_name;	2547804030
SELECT 
    b.org_nm AS 管辖行名称,
    SUM(f.wealth_bal) AS 理财余额总和
FROM 
    financial_products f
JOIN 
    bank_orgnization b ON f.org_no = b.bank_id
WHERE 
    f.data_dt = '2024-07-02'::timestamp
    AND f.cust_no IN (
        SELECT cust_no 
        FROM deposit_account_info 
        WHERE cust_type = '对公' 
        AND data_dt = '2024-07-02'::timestamp
    )
GROUP BY 
    b.org_nm
ORDER BY 
    SUM(f.wealth_bal) DESC;	1574302461
SELECT c.id, c.customer_name, c.id_number
FROM customer c
JOIN loan_application la ON c.id = la.customer_id
JOIN loan_type lt ON la.loan_type_id = lt.id
WHERE lt.loan_type_name = '住房贷款'
  AND la.status = 'REJECTED'
  AND EXTRACT(YEAR FROM la.apply_date) = 2019;	576649992
SELECT 
    cust_no AS customer_number,
    wealth_bal AS financial_product_balance
FROM 
    financial_products
WHERE 
    data_dt = '2024-07-19' 
    AND wealth_bal > 100000
    AND cast_type = '非保本'
ORDER BY 
    wealth_bal DESC;	278921693
SELECT customer_name, email FROM customer;	2923698873
WITH quarterly_stats AS (
    SELECT 
        c.id AS customer_id,
        c.customer_name,
        DATE_TRUNC('quarter', la.apply_date) AS quarter,
        COUNT(*) AS total_applications,
        SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) AS approved_applications
    FROM 
        customer c
    LEFT JOIN 
        loan_application la ON c.id = la.customer_id
    GROUP BY 
        c.id, c.customer_name, DATE_TRUNC('quarter', la.apply_date)
)
SELECT 
    customer_id,
    customer_name,
    quarter,
    total_applications,
    approved_applications,
    CASE 
        WHEN total_applications = 0 THEN 0 
        ELSE ROUND((approved_applications * 100.0 / total_applications), 2) 
    END AS approval_rate_percentage
FROM 
    quarterly_stats
ORDER BY 
    customer_id, quarter;	2256662449
SELECT 
    c.customer_name,
    d.acct_bal AS account_balance
FROM 
    customer c
JOIN 
    deposit_account_info d ON c.id_number = d.cert_code
WHERE 
    d.data_dt = '2024-07-19'::timestamp
    AND d.cur_type = 'F'  -- 假设F代表外币(美元)，根据实际情况可能需要调整
    AND d.currency_type = 'USD'  -- 根据贷款明细表中的查询结果，美元可能是USD
ORDER BY 
    d.acct_bal DESC;	956063573
SELECT customer_name, id_number, phone_number, email
FROM customer
WHERE birth_date > '1980-01-01';	568233943
SELECT 
    o.occupation_name,
    SUM(la.loan_amount) AS total_loan_amount
FROM 
    loan_application la
JOIN 
    customer c ON la.customer_id = c.id
JOIN 
    occupation o ON c.occupation_id = o.id
GROUP BY 
    o.occupation_name
ORDER BY 
    total_loan_amount DESC
LIMIT 5;	665248378
SELECT 
    ld.cust_type AS customer_type,
    SUM(ld.loan_balance) AS total_loan_balance
FROM 
    loan_detail_info ld
GROUP BY 
    ld.cust_type;	1030650241
WITH shangcheng_bank AS (
    SELECT org_no 
    FROM bank_orgnization 
    WHERE bank_name = '杭州上城区支行' 
    AND data_dt = '2023-06-30'
),
debit_customers AS (
    SELECT cust_no
    FROM debit_card_information
    WHERE org_no IN (SELECT org_no FROM shangcheng_bank)
    AND data_dt = '2023-06-30'
)
SELECT 
    SUM(CASE WHEN acct_type_code = '1' THEN acct_bal ELSE 0 END) AS total_current_balance,
    SUM(CASE WHEN acct_type_code = '2' THEN acct_bal ELSE 0 END) AS total_fixed_balance
FROM deposit_account_info
WHERE cust_no IN (SELECT cust_no FROM debit_customers)
AND data_dt = '2023-06-30';	1979307069
SELECT 
    ub.id AS behavior_id,
    c.id AS customer_id,
    c.customer_name,
    ub.behavior_date,
    ub.description AS suspicious_behavior,
    ls.loan_status_name,
    la.status AS loan_application_status
FROM 
    user_behavior ub
JOIN 
    customer c ON ub.customer_id = c.id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_status ls ON la.status = ls.loan_status_code
WHERE 
    ub.behavior_date = '2023-01-01'  -- 替换为特定日期
    AND ub.description LIKE '%可疑%'  -- 假设可疑行为在description中有标记
ORDER BY 
    ub.behavior_date DESC, c.customer_name;	645950570
SELECT * FROM customer WHERE id_number = 'c839d762-6392-4005-8386-ed4e2c50997a';	3312818819
SELECT 
    c.id AS customer_id,
    c.customer_name,
    lc.credit_score,
    lc.description AS credit_description
FROM 
    customer c
LEFT JOIN 
    loan_credit lc ON c.id = lc.customer_id
WHERE 
    lc.credit_date = '2003-06-22';	527420496
SELECT DISTINCT c.id, c.customer_name, c.id_number, c.phone_number
FROM customer c
JOIN deposit_account_info d ON c.id_number = d.cert_code
JOIN bank_orgnization b ON d.org_no = b.bank_id
WHERE d.data_dt = '2024-07-21'
  AND b.bank_name = '杭州分行'
  AND d.acct_bal > 50000
  AND d.cert_typ = '身份证' -- 假设身份证是主要证件类型;	2918505586
SELECT 
    ldc.cust_id AS customer_number,
    ldc.loan_balance,
    dai.acct_bal AS deposit_account_balance
FROM 
    loan_detail_info ldc
JOIN 
    deposit_account_info dai ON ldc.cust_id = dai.cert_code
WHERE 
    ldc.loan_balance > 10000
    AND ldc.account_state = '正常'
    AND dai.data_dt = (SELECT MAX(data_dt) FROM deposit_account_info)
    AND ldc.dw_date = (SELECT MAX(dw_date) FROM loan_detail_info);	1280121870
SELECT 
    f.rs_type_name,
    COUNT(DISTINCT l.cust_id) AS user_count,
    SUM(l.loan_balance) AS total_loan_balance
FROM 
    loan_detail_info l
JOIN 
    five_level_classification f ON l.judgelevel = f.rs_type_id
GROUP BY 
    f.rs_type_name
ORDER BY 
    f.rs_type_name;	2006837077
SELECT deposit_name 
FROM deposit_type 
WHERE data_dt = '2024-07-22';	938785076
SELECT * FROM transfer WHERE transfer_amount > 500;	182531082
SELECT c.customer_name, c.id_number, lc.credit_score
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE c.province = '河北省' AND lc.credit_score > 0.8
ORDER BY lc.credit_score DESC;	1098966204
WITH customer_age_groups AS (
    SELECT 
        id,
        customer_name,
        CASE 
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date)) BETWEEN 20 AND 30 THEN '20-30'
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date)) BETWEEN 31 AND 40 THEN '31-40'
            WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date)) BETWEEN 41 AND 50 THEN '41-50'
            ELSE '51+'
        END AS age_group
    FROM customer
),
loan_stats AS (
    SELECT 
        c.age_group,
        lt.loan_type_name,
        COUNT(*) AS total_applications,
        SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) AS approved_applications
    FROM loan_application la
    JOIN customer_age_groups c ON la.customer_id = c.id
    JOIN loan_type lt ON la.loan_type_id = lt.id
    GROUP BY c.age_group, lt.loan_type_name
)
SELECT 
    age_group,
    loan_type_name,
    total_applications,
    approved_applications,
    CASE 
        WHEN total_applications = 0 THEN 0 
        ELSE ROUND((approved_applications::numeric / total_applications) * 100, 2) 
    END AS approval_rate_percentage
FROM loan_stats
ORDER BY age_group, loan_type_name;	2906434348
SELECT 
    ls.loan_status_name,
    o.occupation_name
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
    AND ls.loan_status_name = 'APPROVED';	4018894094
SELECT 
    o.occupation_name,
    COUNT(DISTINCT c.id) AS customer_count,
    AVG(la.loan_amount) AS avg_loan_amount
FROM 
    customer c
JOIN 
    occupation o ON c.occupation_id = o.id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
GROUP BY 
    o.occupation_name
HAVING 
    COUNT(DISTINCT c.id) > 100
ORDER BY 
    customer_count DESC;	2317494329
SELECT DISTINCT 
    c.id AS customer_id,
    c.customer_name,
    c.id_number,
    c.phone_number
FROM 
    financial_products fp
JOIN 
    bank_orgnization bo ON fp.org_no = bo.bank_id
JOIN 
    currency curr ON fp.currency = curr.curr_code
JOIN 
    customer c ON fp.cust_no = c.id_number
WHERE 
    fp.data_dt = '2024-07-14'
    AND bo.bank_name = '沈阳余淮支行'
    AND fp.cast_type = '非保本'
    AND curr.curr_full_name = 'Singapore Dollar'
    AND fp.wealth_bal > 0;	2459941756
SELECT id_number, phone_number 
FROM customer;	627241378
SELECT 
    d.cust_nm AS customer_name,
    d.open_date AS opening_date
FROM 
    debit_card_information d
WHERE 
    d.open_date >= '2024-07-05';	3818857737
WITH 
-- 计算理财产品客户总数
total_customers AS (
    SELECT COUNT(DISTINCT cust_no) AS count 
    FROM financial_products
),
-- 获取理财产品余额排名前10%的客户
top_10_percent_customers AS (
    SELECT cust_no
    FROM financial_products
    WHERE wealth_bal IS NOT NULL
    ORDER BY wealth_bal DESC
    LIMIT (SELECT (count * 0.1)::integer FROM total_customers)
),
-- 获取过去30天内有登录行为的客户
recent_login_customers AS (
    SELECT DISTINCT u.customer_id
    FROM user_behavior u
    JOIN customer c ON u.customer_id = c.id
    WHERE u.behavior_type = 'LOGIN'
    AND u.behavior_date >= CURRENT_DATE - INTERVAL '30 days'
)

-- 计算满足条件的客户数量
SELECT COUNT(DISTINCT f.cust_no) AS result_count
FROM top_10_percent_customers f
JOIN customer c ON f.cust_no = c.id_number
JOIN recent_login_customers r ON c.id = r.customer_id;	1788527678
SELECT c.id AS customer_id, 
       lc.credit_score, 
       ub.behavior_type, 
       ub.description
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id AND lc.credit_date = '2023-12-10'
LEFT JOIN user_behavior ub ON c.id = ub.customer_id AND ub.behavior_date = '2023-12-10';	1240825133
SELECT bank_id, bank_name FROM bank_orgnization;	1225880496
SELECT lr.id AS repayment_id, 
       lr.repayment_amount, 
       lr.repayment_date, 
       lr.description AS repayment_description,
       la.id AS loan_application_id,
       la.customer_id,
       la.loan_type_id,
       la.loan_amount,
       la.loan_term,
       la.apply_date,
       la.status,
       lt.loan_type_name
FROM loan_repayment lr
JOIN loan_application la ON lr.loan_application_id = la.id
JOIN loan_type lt ON la.loan_type_id = lt.id
WHERE lr.repayment_date = '2024-01-20';	1895296880
SELECT 
    c.curr_code,
    c.curr_full_name,
    COUNT(t.id) AS transfer_count
FROM 
    currency c
LEFT JOIN 
    transfer t ON EXISTS (
        SELECT 1 
        FROM deposit_account_info d 
        WHERE d.cust_no = t.source_customer_id::text 
        AND d.cur_type = c.curr_code
        AND t.transfer_date <= '2023-06-30'
    )
WHERE 
    c.data_dt = '2023-06-30' 
    AND c.curr_class != 'CNY'
GROUP BY 
    c.curr_code, c.curr_full_name
ORDER BY 
    transfer_count DESC;	1454533076
SELECT repayment_amount 
FROM loan_repayment 
WHERE loan_application_id = 742969 
AND repayment_date = '2021-11-10';	3316681947
SELECT 
    dt.deposit_type_name,
    AVG(la.loan_amount) AS avg_loan_amount,
    STDDEV(la.loan_amount) AS stddev_loan_amount
FROM 
    loan_application la
JOIN 
    deposit_account_info dai ON la.customer_id = CAST(dai.cust_no AS INTEGER)
JOIN 
    deposit_type dt ON dai.acct_type_code = dt.deposit_type_id
GROUP BY 
    dt.deposit_type_name
ORDER BY 
    dt.deposit_type_name;	2982717712
SELECT c.customer_name, o.occupation_name, lr.repayment_date
FROM customer c
JOIN occupation o ON c.occupation_id = o.id
JOIN loan_application la ON c.id = la.customer_id
JOIN loan_repayment lr ON la.id = lr.loan_application_id;	279794629
WITH loan_stats AS (
    SELECT 
        lt.loan_type_name AS loan_type,
        AVG(ldi.loan_amount) AS avg_loan_amount,
        COUNT(*) AS loan_count
    FROM loan_detail_info ldi
    JOIN loan_type lt ON ldi.loan_type = lt.loan_type_code
    GROUP BY lt.loan_type_name
),
deposit_stats AS (
    SELECT 
        lt.loan_type_name AS loan_type,
        AVG(dai.acct_bal) AS avg_deposit_balance
    FROM loan_detail_info ldi
    JOIN loan_type lt ON ldi.loan_type = lt.loan_type_code
    JOIN deposit_account_info dai ON ldi.cust_id = dai.cert_code
    GROUP BY lt.loan_type_name
)
SELECT 
    ls.loan_type,
    ls.loan_count,
    ls.avg_loan_amount,
    ds.avg_deposit_balance
FROM loan_stats ls
LEFT JOIN deposit_stats ds ON ls.loan_type = ds.loan_type
ORDER BY ls.loan_type;	2733048479
SELECT COUNT(DISTINCT c.id) AS rejected_customers_with_login_behavior
FROM customer c
JOIN loan_application la ON c.id = la.customer_id
JOIN user_behavior ub ON c.id = ub.customer_id
WHERE la.apply_date = '2019-01-10'
  AND la.status = 'REJECTED'
  AND ub.behavior_type = 'LOGIN'
  AND ub.behavior_date = '2017-10-24';	1486729335
SELECT 
    c.customer_name,
    la.loan_amount
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
JOIN 
    loan_credit lc ON c.id = lc.customer_id
WHERE 
    EXTRACT(YEAR FROM la.apply_date) = 2019
    AND lc.credit_score > 0.8
ORDER BY 
    la.loan_amount DESC;	760463294
SELECT *
FROM loan_detail_info
WHERE loan_balance > 500000
ORDER BY loan_balance DESC;	84990606
SELECT c.id, lc.credit_score
FROM customer c
JOIN loan_credit lc ON c.id = lc.customer_id
WHERE lc.credit_date = '2003-06-22'
AND lc.credit_score > 0.75;	2524485514
SELECT customer_name, birth_date 
FROM customer 
WHERE birth_date > '1989-12-31'
ORDER BY birth_date;	3030054295
WITH credit_changes AS (
    SELECT 
        customer_id,
        MAX(credit_score) - MIN(credit_score) AS score_increase
    FROM 
        loan_credit
    WHERE 
        credit_date >= CURRENT_DATE - INTERVAL '1 year'
    GROUP BY 
        customer_id
    HAVING 
        COUNT(*) > 1  -- 确保有多个评分记录
)
SELECT 
    c.id AS customer_id,
    c.customer_name,
    cc.score_increase
FROM 
    credit_changes cc
JOIN 
    customer c ON cc.customer_id = c.id
ORDER BY 
    cc.score_increase DESC
LIMIT 5;	2842932086
SELECT behavior_type, COUNT(DISTINCT customer_id) AS user_count
FROM user_behavior
GROUP BY behavior_type
ORDER BY user_count DESC;	2650630480
ERROR: 生成最终 SQL 失败	3532447015
SELECT SUM(t.transfer_amount) AS total_transfer_amount
FROM transfer t
JOIN customer c ON t.source_customer_id = c.id OR t.target_customer_id = c.id
WHERE c.province = '辽宁' 
  AND c.address LIKE '%沈阳%'
  AND t.transfer_date = '2024-07-19';	2513228683
SELECT 
    s.store_name,
    s.manager_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date = '2023-05-06'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_profit DESC
LIMIT 1;	3023054014
SELECT sales_quantity, profit
FROM salesstatistics;	252107871
SELECT * FROM salesorders WHERE order_date = '2023-05-08';	2902085248
SELECT DISTINCT e.employee_id, e.name, e.position
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN stores s ON so.store_id = s.store_id
WHERE s.store_name = '数码广场店'
  AND so.order_date = '2023-05-05'
  AND so.total_amount > 7000
ORDER BY e.name;	1743968577
SELECT *
FROM salesstatistics
ORDER BY profit DESC
LIMIT 1;	3620145899
SELECT 
    s.store_name AS "门店名称",
    e.name AS "员工姓名",
    SUM(ss.sales_amount) AS "销售金额",
    p.product_name AS "商品名称"
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date BETWEEN '2023-05-01' AND '2023-05-31'
    AND p.supplier_name = '苹果官方旗舰店'
GROUP BY 
    s.store_name, e.name, p.product_name, ss.employee_id
HAVING 
    SUM(ss.sales_amount) > 10000
ORDER BY 
    "销售金额" DESC;	2283742907
SELECT DISTINCT p.product_name, p.supplier_name
FROM products p
JOIN orderdetails od ON p.product_id = od.product_id
JOIN salesorders so ON od.order_id = so.order_id
JOIN stores s ON so.store_id = s.store_id
WHERE s.store_name = '电子城旗舰店';	3238938312
SELECT 
    s.store_name AS store_name,
    e.position AS employee_position
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-09'
    AND p.product_name = 'iPad Air'
GROUP BY 
    s.store_name, e.position;	2878333594
SELECT s.store_name, s.manager_name
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-05'
GROUP BY s.store_id, s.store_name, s.manager_name
HAVING SUM(ss.sales_amount) > 10000;	754309478
SELECT e.name, SUM(so.total_amount) AS total_order_amount
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
WHERE so.order_date = '2023-05-07'
GROUP BY e.employee_id, e.name
HAVING SUM(so.total_amount) > 10000
ORDER BY total_order_amount DESC;	711957819
WITH sony_product AS (
    SELECT product_id 
    FROM products 
    WHERE product_name LIKE '%索尼WH-1000XM4%'
),
store_profits AS (
    SELECT 
        s.store_id,
        st.store_name,
        SUM(ss.profit) AS total_profit
    FROM salesstatistics ss
    JOIN sony_product sp ON ss.product_id = sp.product_id
    JOIN stores s ON ss.store_id = s.store_id
    JOIN employees e ON ss.employee_id = e.employee_id
    WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31'
    GROUP BY s.store_id, st.store_name
    HAVING SUM(ss.profit) > 5000
)
SELECT 
    sp.store_id,
    sp.store_name,
    sp.total_profit
FROM store_profits sp
ORDER BY sp.total_profit DESC;	1769127756
SELECT DISTINCT e.employee_id, e.name, e.position
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name = 'Nintendo Switch'
  AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
  AND so.total_amount > 5000
ORDER BY e.name;	435444064
SELECT p.product_name, ss.profit
FROM salesstatistics ss
JOIN products p ON ss.product_id = p.product_id
WHERE ss.sales_amount = (SELECT MAX(sales_amount) FROM salesstatistics)
LIMIT 1;	2637911653
SELECT 
    so.order_id,
    so.order_date,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS item_total,
    so.total_amount AS order_total_amount
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
ORDER BY 
    so.order_id, p.product_name;	424774041
SELECT e.name AS employee_name, s.store_name
FROM employees e
JOIN stores s ON e.store_id = s.store_id;	1958922267
SELECT s.store_name, s.manager_name, SUM(so.total_amount) AS total_sales_amount
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
WHERE so.order_date = '2023-05-08'
GROUP BY s.store_name, s.manager_name
ORDER BY total_sales_amount DESC;	1850407582
SELECT so.order_id, e.name AS employee_name
FROM salesorders so
JOIN employees e ON so.employee_id = e.employee_id
WHERE so.total_amount > 7000;	3887504470
SELECT 
    st.store_name,
    e.name AS employee_name,
    SUM(od.quantity * od.unit_price) AS sales_amount,
    p.product_name
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores st ON so.store_id = st.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
    AND p.supplier_name = '苹果官方旗舰店'
GROUP BY 
    st.store_name, e.name, p.product_name
HAVING 
    SUM(od.quantity * od.unit_price) > 10000
ORDER BY 
    sales_amount DESC;	3068871934
SELECT DISTINCT s.store_id, s.store_name
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
JOIN employees e ON so.employee_id = e.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN salesstatistics ss ON s.store_id = ss.store_id 
    AND e.employee_id = ss.employee_id 
    AND p.product_id = ss.product_id
WHERE so.order_date = '2023-05-06'
    AND p.product_name = 'iPhone 13'
    AND ss.profit > 4000;	2869270561
SELECT * FROM salesorders WHERE order_id = 'b8b62bfe-a35d-4ff5-9bc9-654b5f67fed2';	3219161296
SELECT 
    e.employee_id,
    e.name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    employees e
LEFT JOIN 
    salesorders so ON e.employee_id = so.employee_id
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    total_sales_amount DESC;	4084880534
SELECT product_id, product_name, sale_price, purchase_price
FROM products;	758163770
SELECT 
    e.employee_id,
    e.name AS employee_name,
    s.store_name,
    s.manager_name
FROM 
    employees e
JOIN 
    salesorders so ON e.employee_id = so.employee_id
JOIN 
    stores s ON e.store_id = s.store_id
WHERE 
    EXTRACT(YEAR FROM so.order_date) = 2023
    AND EXTRACT(MONTH FROM so.order_date) = 5
GROUP BY 
    e.employee_id, e.name, s.store_name, s.manager_name
HAVING 
    SUM(so.total_amount) > 10000
ORDER BY 
    SUM(so.total_amount) DESC;	2553064409
ERROR: LLM 请求失败	2558715347
ERROR: LLM 请求失败	2334672967
SELECT DISTINCT s.store_id, s.store_name, e.employee_id, e.name AS manager_name
FROM stores s
JOIN employees e ON s.store_id = e.store_id AND e.position = '销售经理'
JOIN salesorders so ON s.store_id = so.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-05'
  AND p.sale_price > 5000
  AND so.order_id IN (
    SELECT so2.order_id
    FROM salesorders so2
    WHERE so2.order_date = '2023-05-05'
    GROUP BY so2.order_id
    HAVING SUM(so2.total_amount) > 10000
  )
ORDER BY s.store_id;	3673770320
SELECT 
    so.order_id,
    p.product_name,
    od.quantity AS sales_quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS total_price,
    so.order_date,
    e.name AS employee_name,
    s.store_name
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
ORDER BY 
    so.order_id, p.product_name;	1434650665
SELECT 
    so.order_id,
    so.order_date,
    so.total_amount,
    e.name AS employee_name,
    e.position AS employee_position,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS item_total
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.store_id = '0887d06a-27a8-46b4-98d6-514702e698da'
ORDER BY 
    so.order_date DESC, so.order_id;	4072489559
ERROR: LLM 请求失败	3987499786
ERROR: LLM 请求失败	3272650586
SELECT 
    p.product_name,
    od.quantity AS sales_quantity,
    so.order_date
FROM 
    products p
JOIN 
    orderdetails od ON p.product_id = od.product_id
JOIN 
    salesorders so ON od.order_id = so.order_id
ORDER BY 
    p.product_name, so.order_date;	1170763492
SELECT 
    s.store_name,
    s.manager_name,
    SUM(so.total_amount) AS total_sales
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales DESC
LIMIT 1;	3307597619
SELECT DISTINCT e.employee_id, e.name, e.position
FROM employees e
JOIN salesstatistics ss ON e.employee_id = ss.employee_id
JOIN products p ON ss.product_id = p.product_id
JOIN stores s ON ss.store_id = s.store_id
WHERE s.store_name = '数码广场店'
  AND p.product_name = 'iPhone 13'
  AND ss.date = '2023-05-03'
  AND ss.sales_quantity > 1
ORDER BY e.name;	2824509879
SELECT 
    s.store_name,
    s.manager_name,
    SUM(so.total_amount) AS total_sales
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-07'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales DESC
LIMIT 1;	348511856
SELECT DISTINCT s.store_id, s.store_name
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-01'
AND (p.product_name LIKE '%索尼WH-1000XM4%' OR p.description LIKE '%索尼WH-1000XM4%')
GROUP BY s.store_id, s.store_name, so.order_id
HAVING SUM(od.quantity * od.unit_price) > 8000;	3403500771
SELECT product_name, purchase_price, sale_price
FROM products
WHERE product_name = '[商品名称]';	1837973022
SELECT 
    p.product_name,
    od.unit_price AS sales_price,
    od.quantity
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id;	1041289855
SELECT DISTINCT e.employee_id, e.name AS employee_name, s.store_name
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN stores s ON e.store_id = s.store_id
WHERE od.product_id IN (
    SELECT product_id 
    FROM products 
    WHERE product_name = 'Apple Watch Series 7'
)
AND so.order_date = '2023-05-06'
ORDER BY e.name;	2902800338
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.sales_amount) AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    total_sales_quantity DESC
LIMIT 1;	2465572579
SELECT 
    e.employee_id,
    e.name AS employee_name,
    p.category_name,
    COUNT(DISTINCT so.order_id) AS order_count,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    e.employee_id, e.name, p.category_name
HAVING 
    SUM(so.total_amount) > 10000
ORDER BY 
    total_sales_amount DESC;	4232056788
SELECT 
    e.employee_id,
    e.name AS employee_name,
    s.store_id,
    s.store_name,
    SUM(so.total_amount) AS total_order_amount
FROM 
    employees e
JOIN 
    stores s ON e.store_id = s.store_id
LEFT JOIN 
    salesorders so ON e.employee_id = so.employee_id
GROUP BY 
    e.employee_id, e.name, s.store_id, s.store_name
ORDER BY 
    e.employee_id;	3813879652
SELECT 
    s.store_id,
    s.store_name,
    SUM(so.total_amount) AS total_sales_amount,
    s.manager_name
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_id, s.store_name, s.manager_name
ORDER BY 
    total_sales_amount DESC;	1308038325
ERROR: LLM 请求失败	3746071071
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_sales_quantity,
    od.unit_price AS sale_price
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id
GROUP BY 
    p.product_name, od.unit_price
ORDER BY 
    p.product_name;	2561670271
SELECT 
    s.store_id,
    s.store_name,
    s.manager_name,
    SUM(ss.sales_amount) AS total_sales_amount,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-01'
    AND p.product_name = '佳能EOS R6'
    AND s.manager_name IN (
        SELECT e.name 
        FROM employees e 
        WHERE e.position = '销售经理'
    )
GROUP BY 
    s.store_id, s.store_name, s.manager_name
ORDER BY 
    total_profit DESC;	3159630797
SELECT store_name, address, phone 
FROM stores;	4216280203
SELECT so.order_id, p.product_name, od.quantity, od.unit_price, (od.quantity * od.unit_price) AS item_amount
FROM salesorders so
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.total_amount < 5000
ORDER BY so.order_id;	731373976
SELECT 
    s.store_name,
    e.name AS sales_consultant,
    SUM(ss.sales_quantity) AS total_quantity_sold,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
WHERE 
    ss.date >= '2023-05-01' AND ss.date <= '2023-05-31'
    AND e.position = '销售顾问'  -- 假设"销售顾问"是position列中的值
GROUP BY 
    s.store_name, e.name
ORDER BY 
    total_quantity_sold DESC
LIMIT 1;	170942591
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_name = '小米电视4A'
    AND ss.date >= '2023-05-01' 
    AND ss.date <= '2023-05-31'
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(ss.profit) > 0
ORDER BY 
    total_profit DESC;	3730467553
SELECT 
    e.employee_id,
    e.name,
    SUM(ss.profit) AS total_profit
FROM 
    employees e
JOIN 
    salesstatistics ss ON e.employee_id = ss.employee_id
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    s.store_name = '智慧街店'
    AND p.product_name = '小米电视4A'
    AND ss.date = '2023-05-06'
GROUP BY 
    e.employee_id, e.name;	2909047140
SELECT store_name, phone FROM stores;	2998787786
SELECT s.store_name, s.manager_name, SUM(ss.profit) AS total_profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-08'
GROUP BY s.store_name, s.manager_name
HAVING SUM(ss.profit) > 1000
ORDER BY total_profit DESC;	3020408935
SELECT p.category_name, SUM(od.quantity) AS total_sales_quantity
FROM orderdetails od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.category_name;	3729612424
SELECT 
    s.store_id,
    s.store_name,
    e.employee_id,
    e.name AS employee_name,
    e.position
FROM 
    stores s
JOIN 
    employees e ON s.store_id = e.store_id
ORDER BY 
    s.store_id, e.employee_id;	1558062721
SELECT order_id
FROM salesorders
WHERE total_amount > (SELECT AVG(total_amount) FROM salesorders);	3748358677
SELECT *
FROM salesorders
WHERE order_date BETWEEN '[开始日期]' AND '[结束日期]'
ORDER BY order_date;	281510090
ERROR: LLM 请求失败	930082852
ERROR: LLM 请求失败	874677465
SELECT 
    e.employee_id,
    e.name AS employee_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.profit) AS total_profit
FROM 
    employees e
JOIN 
    salesstatistics ss ON e.employee_id = ss.employee_id
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    total_profit DESC;	1675790879
SELECT 
    s.store_id,
    st.store_name,
    e.employee_id,
    e.name AS employee_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores st ON so.store_id = st.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
    AND p.product_name LIKE '%佳能%' 
    AND p.product_name LIKE '%EOS R6%'
GROUP BY 
    s.store_id, st.store_name, e.employee_id, e.name
HAVING 
    SUM(so.total_amount) > 10000
ORDER BY 
    total_sales_amount DESC;	1635802249
SELECT 
    s.store_name,
    s.manager_name,
    SUM(so.total_amount) AS total_sales
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-05'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales DESC
LIMIT 1;	2425848754
SELECT 
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.sales_amount) AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
GROUP BY 
    s.store_name
ORDER BY 
    s.store_name;	2746220287
SELECT 
    s.store_name,
    s.manager_name,
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
SELECT 
    so.order_id,
    so.order_date,
    so.total_amount,
    s.store_name,
    e.name AS employee_name
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    e.employee_id = '24afdebe-fb63-4a7d-b6a4-19f810b8cc4e'  -- 胡海燕的员工ID
ORDER BY 
    so.order_date DESC;	1518878415
SELECT 
    od.order_detail_id,
    od.order_id,
    od.product_id,
    p.product_name,
    od.quantity,
    od.unit_price AS sales_unit_price,
    so.order_date,
    s.store_name
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    salesorders so ON od.order_id = so.order_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    od.product_id = '1c3b0775-1971-468e-8744-8a2c4a5f9b3e'  -- 假设用户选择查询iPhone 13
ORDER BY 
    so.order_date DESC;	729031894
SELECT 
    s.store_name,
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
WHERE p.purchase_price > 4000
AND ss.store_id = 'aa942526-f22a-467c-b31e-665623048753';	2711834209
SELECT 
    s.store_name,
    s.manager_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-09'
GROUP BY 
    s.store_name, s.manager_name
HAVING 
    SUM(so.total_amount) > 10000
ORDER BY 
    total_sales_amount DESC;	1625040088
SELECT 
    s.store_name,
    s.manager_name,
    SUM(so.total_amount) AS total_sales
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-02'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales DESC
LIMIT 1;	3394370453
SELECT s.store_name, s.manager_name
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-09'
GROUP BY s.store_id, s.store_name, s.manager_name
HAVING SUM(ss.sales_amount) > 1000;	1323956071
SELECT 
    e.employee_id,
    e.name AS employee_name,
    p.category_name,
    SUM(so.total_amount) AS total_order_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    e.employee_id, e.name, p.category_name
HAVING 
    SUM(so.total_amount) > 10000
ORDER BY 
    total_order_amount DESC;	3696477446
SELECT s.store_name, SUM(ss.profit) AS total_profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
GROUP BY s.store_name;	4263762934
SELECT 
    s.store_name,
    e.name AS employee_name,
    SUM(ss.sales_amount) AS total_sales_amount,
    p.product_name
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date BETWEEN '2023-05-01' AND '2023-05-31'
    AND p.supplier_name = '索尼官方旗舰店'
GROUP BY 
    s.store_name, e.name, p.product_name
HAVING 
    SUM(ss.sales_amount) > 10000
ORDER BY 
    total_sales_amount DESC;	1452830768
SELECT 
    so.order_id,
    so.order_date,
    so.total_amount,
    od.order_detail_id,
    od.product_id,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS detail_amount
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.total_amount > 5000
ORDER BY 
    so.total_amount DESC;	4210000185
SELECT 
    p.product_name,
    SUM(od.quantity * od.unit_price) AS sales_amount
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.order_date = '2023-05-02'
GROUP BY 
    p.product_name
ORDER BY 
    sales_amount DESC;	2309159488
SELECT 
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date >= '2023-05-01' AND ss.date <= '2023-05-31'
GROUP BY 
    s.store_name
ORDER BY 
    total_sales_quantity DESC;	3856696435
SELECT product_name, sale_price, purchase_price
FROM products;	3385775144
SELECT 
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date BETWEEN '2023-05-01' AND '2023-05-31'
    AND p.category_name = '智能手表'
    AND p.supplier_name = '索尼官方旗舰店'
GROUP BY 
    s.store_name
HAVING 
    SUM(ss.sales_quantity) > 10
ORDER BY 
    total_sales_quantity DESC;	898352649
SELECT 
    s.store_id,
    s.store_name,
    s.manager_name,
    AVG(so.total_amount) AS avg_order_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_id, s.store_name, s.manager_name
HAVING 
    AVG(so.total_amount) > 10000
ORDER BY 
    avg_order_amount DESC;	1057968799
SELECT 
    s.store_name,
    e.name AS employee_name,
    ss.sales_quantity,
    ss.sales_amount,
    ss.profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-02'
    AND p.product_name = 'iPad Air'
ORDER BY 
    ss.profit DESC;	1042797521
SELECT 
    s.store_id,
    s.store_name,
    SUM(od.quantity * (od.unit_price - p.purchase_price)) AS total_profit
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    p.product_name = 'iPhone 13'
    AND so.order_date >= '2023-05-01' 
    AND so.order_date <= '2023-05-31'
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(od.quantity * (od.unit_price - p.purchase_price)) > 0
ORDER BY 
    total_profit DESC;	2349214824
WITH store_sales AS (
    SELECT 
        s.store_id,
        st.store_name,
        SUM(ss.sales_quantity) AS total_quantity,
        SUM(ss.sales_amount) AS total_amount
    FROM 
        salesstatistics ss
    JOIN 
        stores st ON ss.store_id = st.store_id
    JOIN 
        salesorders s ON ss.store_id = s.store_id
    WHERE 
        ss.date >= '2023-05-01' AND ss.date <= '2023-05-31'
    GROUP BY 
        s.store_id, st.store_name
    ORDER BY 
        total_quantity DESC
    LIMIT 1
)
SELECT 
    store_name AS "门店名称",
    total_quantity AS "销售商品数量",
    total_amount AS "总销售金额"
FROM 
    store_sales;	1437353225
SELECT 
    s.store_id,
    s.store_name,
    SUM(so.total_amount) AS total_order_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
WHERE 
    so.order_date = '2023-05-09'
    AND od.product_id IN (
        SELECT product_id 
        FROM products 
        WHERE product_name = 'Apple Watch Series 7'
    )
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    total_order_amount DESC;	2159290753
SELECT quantity, unit_price 
FROM orderdetails;	3028653636
SELECT DISTINCT 
    s.store_name AS store_name,
    e.position AS employee_position
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    p.product_name = 'Nintendo Switch'
    AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
ORDER BY 
    s.store_name, e.position;	699540097
SELECT * 
FROM salesstatistics 
WHERE sales_quantity > 1;	1931659377
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_name = 'Nintendo Switch'
    AND ss.date >= '2023-05-01' 
    AND ss.date <= '2023-05-31'
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(ss.profit) > 0
ORDER BY 
    total_profit DESC;	3746361325
SELECT order_id, total_amount, order_date
FROM salesorders
ORDER BY order_date;	716876897
SELECT 
    s.store_id,
    s.store_name,
    SUM(so.total_amount) AS total_order_amount,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    stores s
LEFT JOIN 
    salesorders so ON s.store_id = so.store_id
LEFT JOIN 
    salesstatistics ss ON s.store_id = ss.store_id
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    s.store_id;	2607128675
SELECT * 
FROM orderdetails 
WHERE quantity = 2;	285217611
SELECT DISTINCT s.store_name, e.name AS employee_name, e.position
FROM salesstatistics ss
JOIN employees e ON ss.employee_id = e.employee_id
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.product_id IN (
    SELECT product_id 
    FROM products 
    WHERE product_name = '戴尔灵越15'
)
AND ss.date = '2023-05-01'
ORDER BY s.store_name, e.name;	780164755
SELECT e.position, s.store_name
FROM employees e
JOIN stores s ON e.store_id = s.store_id;	936656745
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_name = '佳能EOS R6'
    AND ss.date = '2023-05-03'
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(ss.profit) > 0
ORDER BY 
    total_profit DESC;	1245782625
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_name = 'iPhone 13'
    AND ss.date = '2023-05-05'
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(ss.profit) > 0
ORDER BY 
    total_profit DESC;	1283619082
SELECT DISTINCT s.store_id, s.store_name, e.employee_id, e.name AS employee_name
FROM salesstatistics ss
JOIN products p ON ss.product_id = p.product_id
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
WHERE p.product_name = '华为Mate 40 Pro'
  AND ss.date = '2023-05-06'
  AND ss.sales_quantity > 1
ORDER BY s.store_name, e.name;	1656453304
SELECT 
    so.order_id,
    p.product_name,
    od.quantity AS sales_quantity
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
ORDER BY 
    so.order_id, p.product_name;	366199293
SELECT e.name AS employee_name, e.position, s.phone AS store_phone
FROM employees e
JOIN stores s ON e.store_id = s.store_id;	3334478107
SELECT 
    s.store_name,
    e.name AS employee_name,
    ss.sales_quantity
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-05'
    AND p.product_name = '戴尔灵越15'
    AND ss.sales_quantity > 1
ORDER BY 
    s.store_name, e.name;	4270219527
SELECT 
    so.order_id,
    so.order_date,
    so.total_amount,
    p.product_id,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS product_total_amount
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.total_amount > 5000
ORDER BY 
    so.order_id, p.product_id;	1514093143
SELECT 
    e.employee_id,
    e.name AS employee_name,
    so.order_id,
    so.total_amount
FROM 
    employees e
JOIN 
    salesorders so ON e.employee_id = so.employee_id
ORDER BY 
    e.employee_id, so.order_date;	2669644548
SELECT * 
FROM salesstatistics 
WHERE profit > 3000
ORDER BY date;	805828737
SELECT DISTINCT s.store_name
FROM stores s
JOIN employees e ON s.store_id = e.store_id
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-01'
AND p.product_name = 'Apple Watch Series 7'
GROUP BY s.store_name, so.order_id
HAVING SUM(od.quantity * od.unit_price) > 7000;	3997676800
SELECT product_name, remaining_quantity, category_name
FROM products;	4161491201
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-07'
AND p.category_name = '相机'
AND so.total_amount > 15000;	1127435173
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_name = 'iPhone 13'
    AND ss.date = '2023-05-03'
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(ss.profit) > 0
ORDER BY 
    total_profit DESC;	2902593996
SELECT 
    s.store_name,
    s.manager_name,
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
    e.employee_id,
    e.name AS employee_name,
    SUM(ss.sales_quantity) AS total_quantity,
    SUM(ss.sales_amount) AS total_amount
FROM 
    salesstatistics ss
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.store_id = '95eead28-167c-4b82-8c1d-b7e537f2968f'
    AND p.product_name = 'Nintendo Switch'
    AND ss.date = '2023-05-03'
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    total_amount DESC;	4098005311
SELECT DISTINCT s.store_id, s.store_name
FROM salesstatistics ss
JOIN products p ON ss.product_id = p.product_id
JOIN stores s ON ss.store_id = s.store_id
WHERE p.product_name = '戴森V11'
  AND ss.date = '2023-05-05'
  AND ss.profit > 500;	923028298
SELECT 
    s.store_name,
    s.manager_name,
    SUM(ss.sales_amount) AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date = '2023-05-09'
GROUP BY 
    s.store_name, s.manager_name
HAVING 
    SUM(ss.sales_amount) > 2000
ORDER BY 
    total_sales_amount DESC;	1361891626
SELECT s.store_name, s.manager_name
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
WHERE so.order_date = '2023-05-01'
GROUP BY s.store_name, s.manager_name
HAVING SUM(so.total_amount) > 10000;	1630147030
SELECT DISTINCT 
    s.store_id,
    s.store_name,
    s.manager_name AS store_manager
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-09'
    AND p.product_id IN (
        SELECT product_id 
        FROM products 
        WHERE product_name = 'iPhone 13'
    )
ORDER BY 
    s.store_name;	3263175989
SELECT 
    p.product_name,
    SUM(od.quantity * od.unit_price) AS sales_amount,
    p.remaining_quantity
FROM 
    products p
LEFT JOIN 
    orderdetails od ON p.product_id = od.product_id
WHERE 
    p.product_id = '[具体商品ID]'
GROUP BY 
    p.product_name, p.remaining_quantity;	378330460
SELECT store_name, address, phone 
FROM stores;	4052285642
SELECT 
    s.store_name,
    e.name AS employee_name,
    so.total_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-02'
    AND so.total_amount > 2000
ORDER BY 
    so.total_amount DESC;	1549729846
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.profit) AS total_profit
FROM 
    stores s
JOIN 
    salesstatistics ss ON s.store_id = ss.store_id
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    s.store_id;	3935894550
SELECT 
    s.store_name,
    s.manager_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date = '2023-05-07'
GROUP BY 
    s.store_name, s.manager_name
HAVING 
    SUM(ss.profit) > 1000
ORDER BY 
    total_profit DESC;	3331362186
SELECT 
    s.store_name,
    s.manager_name,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date = '2023-05-08'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales_quantity DESC
LIMIT 1;	1128623969
SELECT s.store_name, SUM(ss.profit) AS total_profit
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
WHERE ss.date = '2023-05-09'
GROUP BY s.store_name
ORDER BY total_profit DESC
LIMIT 1;	2501471268
SELECT 
    s.store_id,
    st.store_name,
    e.employee_id,
    e.name AS employee_name,
    SUM(od.quantity * od.unit_price) AS total_order_amount
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores st ON so.store_id = st.store_id
WHERE 
    p.product_name LIKE '%佳能EOS R6%'
    AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_id, st.store_name, e.employee_id, e.name
HAVING 
    SUM(od.quantity * od.unit_price) > 5000
ORDER BY 
    total_order_amount DESC;	1462073315
WHERE p.product_id IN (
    'f27e56c6-8257-4fca-b535-76ce4cead7a9',
    '99663122-3f3c-40e6-b215-a94af8412e41',
    '7664a663-1bd3-4412-98a9-7c560c934a01'
    -- 其他从第一个查询中获得的product_id
);	1581647710
SELECT category_name, sale_price FROM products;	801232665
WITH high_sales_stores AS (
    SELECT s.store_id, s.store_name, SUM(so.total_amount) AS total_sales
    FROM salesorders so
    JOIN stores s ON so.store_id = s.store_id
    WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
    GROUP BY s.store_id, s.store_name
    HAVING SUM(so.total_amount) > 10000
)

SELECT 
    hss.store_id,
    hss.store_name,
    hss.total_sales,
    COUNT(e.employee_id) AS sales_manager_count
FROM high_sales_stores hss
JOIN employees e ON hss.store_id = e.store_id
WHERE e.position = '销售经理'
GROUP BY hss.store_id, hss.store_name, hss.total_sales
ORDER BY hss.total_sales DESC;	456965504
SELECT 
    p.product_id,
    p.product_name,
    p.remaining_quantity,
    COALESCE(SUM(od.quantity), 0) AS sales_quantity
FROM 
    products p
LEFT JOIN 
    orderdetails od ON p.product_id = od.product_id
GROUP BY 
    p.product_id, p.product_name, p.remaining_quantity
ORDER BY 
    p.product_id;	3382493010
SELECT 
    so.order_id,
    so.order_date,
    so.total_amount,
    od.order_detail_id,
    od.product_id,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS detail_amount
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
ORDER BY 
    so.order_date DESC, so.order_id;	571189478
SELECT DISTINCT s.store_name, e.name AS employee_name, ss.sales_quantity
FROM salesstatistics ss
JOIN products p ON ss.product_id = p.product_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN stores s ON ss.store_id = s.store_id
WHERE p.product_name = '华为Mate 40 Pro'
  AND ss.date = '2023-05-06'
  AND ss.sales_quantity > 1
ORDER BY s.store_name, e.name;	3197967117
SELECT s.store_name, e.name AS employee_name, e.position
FROM stores s
JOIN employees e ON s.store_id = e.store_id
ORDER BY s.store_name, e.name;	426781097
SELECT 
    e.employee_id,
    e.name AS employee_name,
    SUM(od.quantity * od.unit_price) AS total_sales_amount
FROM 
    employees e
JOIN 
    salesorders so ON e.employee_id = so.employee_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    s.store_name = '创客空间店'
    AND p.product_name = '华为Mate 40 Pro'
    AND so.order_date = '2023-05-01'
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    total_sales_amount DESC;	3095201302
SELECT DISTINCT s.store_name, e.name AS employee_name, e.position
FROM salesorders so
JOIN orderdetails od ON so.order_id = od.order_id
JOIN employees e ON so.employee_id = e.employee_id
JOIN stores s ON so.store_id = s.store_id
WHERE od.product_id IN (
    SELECT product_id FROM products WHERE product_name LIKE '%戴森V11%'
)
AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
ORDER BY s.store_name, e.name;	3814813462
SELECT 
    od.order_detail_id,
    od.order_id,
    od.product_id,
    od.quantity,
    od.unit_price,
    p.product_name,
    p.category_name,
    p.purchase_price,
    p.sale_price,
    p.remaining_quantity,
    p.supplier_name,
    p.description
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id;	609043667
SELECT DISTINCT e.employee_id, e.name
FROM employees e
JOIN salesstatistics ss ON e.employee_id = ss.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE ss.date = '2023-05-06'
  AND ss.sales_quantity > 1
  AND p.supplier_name = '戴尔官方旗舰店';	1259543351
SELECT product_name, sale_price FROM products;	3115466033
SELECT s.store_name, s.manager_name, s.phone
FROM stores s;	1445435683
SELECT 
    so.total_amount,
    s.store_name
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.employee_id = 'd7a2363e-d8fb-498a-a892-4249d6f17b0d'
    AND so.order_date = '2023-05-07';	1024575513
SELECT 
    s.store_id,
    s.store_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    od.product_id = '4e4e9946-d36e-42fe-bc12-a0fff7357155'
    AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(so.total_amount) > 10000
ORDER BY 
    total_sales_amount DESC;	1356118157
SELECT 
    s.store_id,
    s.store_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date >= '2023-05-01' 
    AND so.order_date <= '2023-05-31'
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    total_sales_amount DESC;	2779355161
SELECT s.store_id, s.store_name, s.manager_name
FROM stores s;	3800488480
SELECT 
    p.product_id,
    p.product_name,
    p.sale_price AS sales_unit_price,
    p.remaining_quantity
FROM 
    products p;	52927163
SELECT 
    s.store_id,
    s.store_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
WHERE 
    so.order_date = '2023-05-01'
    AND od.product_id IN (
        SELECT product_id 
        FROM products 
        WHERE product_name = 'iPhone 13'
    )
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(so.total_amount) > 0
ORDER BY 
    total_sales_amount DESC;	4140737645
SELECT * FROM products WHERE product_name LIKE '%索尼%' OR product_name LIKE '%耳机%';	3812947992
SELECT 
    st.store_id, 
    st.store_name, 
    st.manager_name, 
    SUM(ss.sales_quantity) AS total_sales
FROM 
    salesstatistics ss
JOIN 
    stores st ON ss.store_id = st.store_id
WHERE 
    ss.date = '2023-05-09'
GROUP BY 
    st.store_id, st.store_name, st.manager_name
ORDER BY 
    total_sales DESC
LIMIT 1;	2237439168
SELECT SUM(profit) AS total_profit FROM salesstatistics;	3083869006
SELECT s.order_id, s.order_date, s.total_amount, st.store_name
FROM salesorders s
JOIN stores st ON s.store_id = st.store_id
WHERE s.employee_id = '24afdebe-fb63-4a7d-b6a4-19f810b8cc4e';	106112262
SELECT 
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
WHERE 
    e.name = '黄萍'
    AND ss.date >= '2023-05-01' 
    AND ss.date <= '2023-05-31'
GROUP BY 
    s.store_name
ORDER BY 
    total_sales_quantity DESC
LIMIT 1;	886303610
SELECT 
    s.store_id,
    s.store_name,
    e.employee_id,
    e.name AS employee_name,
    SUM(ss.sales_amount) AS total_sales_amount,
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
        WHERE product_name = 'Nintendo Switch'
    )
    AND ss.date = '2023-05-08'
GROUP BY 
    s.store_id, s.store_name, e.employee_id, e.name
ORDER BY 
    total_profit DESC;	1529918379
SELECT 
    s.store_id,
    st.store_name,
    e.employee_id,
    e.name AS employee_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores st ON so.store_id = st.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    p.product_name = '索尼WH-1000XM4耳机'
    AND so.order_date = '2023-05-05'
GROUP BY 
    s.store_id, st.store_name, e.employee_id, e.name
ORDER BY 
    total_sales_amount DESC;	3470071233
SELECT DISTINCT e.employee_id, e.name, e.position
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.store_id = '79f1a79c-d16b-48b4-88a4-97cae64507ab'
  AND so.order_date = '2023-05-05'
  AND p.supplier_name = '小米官方旗舰店';	616988720
SELECT 
    s.store_name,
    s.manager_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
WHERE 
    ss.date = '2023-05-07'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_profit DESC
LIMIT 1;	4131869213
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_name = '索尼WH-1000XM4'
    AND ss.date = '2023-05-09'
GROUP BY 
    s.store_id, s.store_name
HAVING 
    SUM(ss.profit) > 0
ORDER BY 
    total_profit DESC;	2632379040
SELECT 
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    p.sale_price
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_id = '1c3b0775-1971-468e-8744-8a2c4a5f9b3e'  -- iPhone 13的产品ID
GROUP BY 
    s.store_name, p.sale_price
ORDER BY 
    total_sales_quantity DESC;	1347772939
SELECT 
    so.total_amount,
    s.store_name
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-03';	2314844420
SELECT * 
FROM orderdetails 
WHERE quantity > 1;	1029843679
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
WHERE 
    so.order_date = '2023-05-05'
    AND od.product_id IN (
        SELECT product_id 
        FROM products 
        WHERE product_name = 'iPhone 13'
    )
ORDER BY 
    so.total_amount DESC;	973958071
SELECT 
    s.order_id,
    s.order_date,
    s.total_amount,
    st.store_name
FROM 
    salesorders s
JOIN 
    stores st ON s.store_id = st.store_id
WHERE 
    s.order_date = '2023-05-05';	3235376159
SELECT p.product_name, od.order_id
FROM orderdetails od
JOIN products p ON od.product_id = p.product_id
WHERE od.quantity > 1;	590339570
SELECT *
FROM salesorders
WHERE order_date BETWEEN '2023-05-01' AND '2023-05-31'
ORDER BY order_date;	947155024
SELECT 
    e.employee_id,
    e.name,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    salesstatistics ss
JOIN 
    employees e ON ss.employee_id = e.employee_id
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    total_sales_quantity DESC;	143868964
SELECT product_name, category_name, remaining_quantity 
FROM products
ORDER BY category_name, product_name;	801054820
SELECT 
    e.name AS employee_name,
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity
FROM 
    employees e
JOIN 
    salesstatistics ss ON e.employee_id = ss.employee_id
JOIN 
    stores s ON e.store_id = s.store_id
GROUP BY 
    e.name, s.store_name
ORDER BY 
    total_sales_quantity DESC;	956049949
SELECT order_id, product_id 
FROM orderdetails;	1812261268
SELECT 
    s.date,
    st.store_name,
    e.name AS employee_name,
    p.product_name,
    p.category_name,
    ss.sales_quantity,
    ss.sales_amount,
    ss.profit
FROM 
    salesstatistics ss
JOIN 
    stores st ON ss.store_id = st.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-09'  -- 使用查询1中获取的最新日期作为示例
ORDER BY 
    st.store_name, 
    e.name, 
    p.product_name;	573573963
SELECT 
    e.employee_id,
    e.name AS employee_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.sales_amount) AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.date = '2023-05-01'
    AND s.store_name = '科技园店'
    AND p.product_name = 'iPhone 13'
GROUP BY 
    e.employee_id, e.name;	2726627092
SELECT DISTINCT e.employee_id, e.name, e.position
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-09'
  AND p.product_name = 'Apple Watch Series 7'
  AND p.supplier_name = '任天堂官方旗舰店';	3682087832
SELECT 
    s.store_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-06'
GROUP BY 
    s.store_name;	994704464
SELECT 
    so.order_id,
    so.order_date,
    s.store_name,
    e.name AS employee_name,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS item_total,
    so.total_amount AS order_total
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.order_date BETWEEN '2023-05-07' AND '2023-05-09'
ORDER BY 
    so.order_date DESC, 
    so.order_id,
    p.product_name;	2258930244
SELECT 
    e.employee_id,
    e.name AS employee_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    employees e
JOIN 
    salesorders so ON e.employee_id = so.employee_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    s.store_name = '智慧街店'
    AND p.product_name = '佳能EOS R6相机'
    AND so.order_date = '2023-05-07'
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    total_sales_amount DESC;	251367692
SELECT 
    s.store_id,
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.sales_amount) AS total_sales_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    s.store_id;	4178948313
SELECT 
    s.store_id,
    st.store_name,
    e.employee_id,
    e.name AS employee_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    stores st ON so.store_id = st.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.order_date = '2023-05-05'
    AND p.product_name = '佳能EOS R6相机'
GROUP BY 
    s.store_id, st.store_name, e.employee_id, e.name;	635779591
SELECT * FROM products WHERE sale_price > 15000;	2326522926
SELECT DISTINCT 
    s.store_id,
    s.store_name,
    e.employee_id,
    e.name AS employee_name
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    p.product_name = '索尼WH-1000XM4'
    AND ss.date = '2023-05-08'
    AND ss.sales_quantity > 1
ORDER BY 
    s.store_name, e.name;	845825777
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
    AND p.supplier_name = '戴森官方旗舰店'
ORDER BY 
    ss.sales_amount DESC;	1519890808
SELECT 
    s.order_id,
    s.order_date,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS total_amount,
    st.store_name,
    e.name AS employee_name
FROM 
    salesorders s
JOIN 
    orderdetails od ON s.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    stores st ON s.store_id = st.store_id
JOIN 
    employees e ON s.employee_id = e.employee_id
WHERE 
    p.product_id = '35710343-90e8-47c1-9546-5abcff309bbd'  -- 戴森V11的产品ID
ORDER BY 
    s.order_date DESC;	624803127
SELECT s.store_name, SUM(so.total_amount) AS total_sales_amount
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
GROUP BY s.store_id, s.store_name
ORDER BY total_sales_amount DESC;	4067103855
SELECT 
    so.order_id,
    so.order_date,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS total_price
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.order_date BETWEEN '[开始日期]' AND '[结束日期]'
ORDER BY 
    so.order_date, so.order_id;	2670659765
SELECT 
    so.order_id,
    so.order_date,
    e.name AS employee_name,
    od.order_detail_id,
    od.product_id,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS item_total
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
ORDER BY 
    so.order_date DESC, so.order_id;	4067388605
SELECT product_name, supplier_name 
FROM products;	383590974
SELECT product_name, sale_price, supplier_name 
FROM products;	4056403376
SELECT 
    od.order_detail_id,
    od.order_id,
    od.product_id,
    p.product_name,
    od.unit_price,
    od.quantity,
    (od.unit_price * od.quantity) AS total_price
FROM 
    orderdetails od
JOIN 
    products p ON od.product_id = p.product_id;	3670992366
SELECT s.store_name, s.phone
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
WHERE EXTRACT(YEAR FROM so.order_date) = 2023
  AND EXTRACT(MONTH FROM so.order_date) = 5
GROUP BY s.store_id, s.store_name, s.phone
HAVING SUM(so.total_amount) > 3000;	2335581270
SELECT s.store_name, e.name AS manager_name
FROM stores s
JOIN employees e ON s.store_id = e.store_id AND e.position = '店长';	2535524828
SELECT e.name AS employee_name, s.phone AS store_phone
FROM employees e
JOIN stores s ON e.store_id = s.store_id;	120259515
SELECT 
    e.employee_id,
    e.name AS employee_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.profit) AS total_profit
FROM 
    salesstatistics ss
JOIN 
    employees e ON ss.employee_id = e.employee_id
JOIN 
    products p ON ss.product_id = p.product_id
WHERE 
    ss.store_id = '228a6c5d-6f5a-4a76-b0b2-6f3df976d799'
    AND p.product_name = 'iPad Air'
    AND ss.date = '2023-05-09'
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    total_sales_quantity DESC;	1670319692
SELECT e.employee_id, e.name
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN stores s ON so.store_id = s.store_id
WHERE s.store_name = '未来城店'
  AND so.order_date = '2023-05-07'
  AND so.total_amount > 15000
GROUP BY e.employee_id, e.name;	4086419825
SELECT 
    product_id,
    product_name,
    sale_price,
    purchase_price,
    (sale_price - purchase_price) AS price_difference
FROM 
    products;	3256730396
SELECT 
    s.store_id,
    s.store_name,
    s.manager_name,
    SUM(so.total_amount) AS total_sales
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_id, s.store_name, s.manager_name
HAVING 
    SUM(so.total_amount) > 10000
ORDER BY 
    total_sales DESC;	2107889479
SELECT 
    s.store_name,
    SUM(ss.sales_quantity) AS total_sales_quantity,
    SUM(ss.profit) AS total_profit
FROM 
    stores s
LEFT JOIN 
    salesstatistics ss ON s.store_id = ss.store_id
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    s.store_name;	595252998
SELECT * 
FROM salesorders 
WHERE store_id = '64921abb-1d54-4e03-a15e-ea42f058f31c';	2271451016
SELECT DISTINCT s.store_id, s.store_name
FROM salesorders so
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN stores s ON so.store_id = s.store_id
WHERE so.order_date = '2023-05-06'
AND p.product_name = '小米电视4A'
AND so.total_amount > 10000;	3431877623
SELECT DISTINCT s.store_id, s.store_name, e.employee_id, e.name AS employee_name
FROM salesstatistics ss
JOIN stores s ON ss.store_id = s.store_id
JOIN employees e ON ss.employee_id = e.employee_id
JOIN products p ON ss.product_id = p.product_id
WHERE p.product_name = 'Nintendo Switch'
  AND ss.date BETWEEN '2023-05-01' AND '2023-05-31'
  AND ss.profit > 1000
ORDER BY s.store_id, e.employee_id;	1818716672
SELECT 
    s.store_id,
    s.store_name,
    e.employee_id,
    e.name AS employee_name,
    SUM(ss.sales_quantity) AS total_quantity,
    SUM(ss.sales_amount) AS total_amount
FROM 
    salesstatistics ss
JOIN 
    stores s ON ss.store_id = s.store_id
JOIN 
    employees e ON ss.employee_id = e.employee_id
WHERE 
    ss.product_id = 'f5e347cb-f674-4e33-834c-4d0760682240'
    AND ss.date = '2023-05-09'
GROUP BY 
    s.store_id, s.store_name, e.employee_id, e.name
ORDER BY 
    s.store_name, e.name;	3062953566
SELECT s.order_id, s.store_id, st.store_name, s.employee_id, e.name AS employee_name, 
       s.order_date, s.total_amount
FROM salesorders s
JOIN stores st ON s.store_id = st.store_id
JOIN employees e ON s.employee_id = e.employee_id
WHERE s.store_id = '95eead28-167c-4b82-8c1d-b7e537f2968f'  -- 数字大道店的store_id
ORDER BY s.order_date DESC;	3908942610
SELECT 
    s.store_name,
    s.manager_name,
    SUM(so.total_amount) AS total_sales
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date = '2023-05-03'
GROUP BY 
    s.store_name, s.manager_name
ORDER BY 
    total_sales DESC
LIMIT 1;	208218356
SELECT s.store_name, s.manager_name
FROM stores s
JOIN (
    SELECT store_id, SUM(sales_quantity) as total_sales
    FROM salesstatistics
    WHERE date = '2023-05-03'
    GROUP BY store_id
    ORDER BY total_sales DESC
    LIMIT 1
) ss ON s.store_id = ss.store_id;	4174482566
SELECT 
    s.store_name,
    e.name AS employee_name,
    so.order_id,
    so.total_amount
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
    AND od.product_id IN (
        SELECT product_id 
        FROM products 
        WHERE product_name = 'iPad Air'
    )
ORDER BY 
    so.total_amount DESC;	1762340720
SELECT 
    s.store_id,
    s.store_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    stores s
LEFT JOIN 
    salesorders so ON s.store_id = so.store_id
GROUP BY 
    s.store_id, s.store_name
ORDER BY 
    total_sales_amount DESC;	1734342716
SELECT 
    e.position,
    COUNT(so.order_id) AS order_count
FROM 
    employees e
LEFT JOIN 
    salesorders so ON e.employee_id = so.employee_id
GROUP BY 
    e.position
ORDER BY 
    order_count DESC;	3698654694
SELECT s.statistic_id, s.store_id, st.store_name, s.product_id, p.product_name, 
       s.employee_id, e.name AS employee_name, s.date, 
       s.sales_quantity, s.sales_amount, s.profit
FROM salesstatistics s
JOIN stores st ON s.store_id = st.store_id
JOIN products p ON s.product_id = p.product_id
JOIN employees e ON s.employee_id = e.employee_id
WHERE s.store_id = '79f1a79c-d16b-48b4-88a4-97cae64507ab'  -- 这里使用智能生活馆的store_id作为示例
ORDER BY s.date DESC;	3114650274
SELECT 
    s.store_name,
    s.manager_name,
    SUM(so.total_amount) AS total_sales_amount
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
WHERE 
    so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, s.manager_name
HAVING 
    SUM(so.total_amount) > 10000
ORDER BY 
    total_sales_amount DESC;	2085424302
SELECT DISTINCT s.store_id, s.store_name
FROM stores s
JOIN salesorders so ON s.store_id = so.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-02'
AND p.supplier_name = '华为官方旗舰店'
GROUP BY s.store_id, s.store_name, so.order_id
HAVING SUM(od.quantity * od.unit_price) > 10000;	662177839
WITH top_product AS (
    SELECT 
        ss.product_id,
        p.product_name,
        SUM(ss.sales_quantity) AS total_sales_quantity
    FROM 
        salesstatistics ss
    JOIN 
        products p ON ss.product_id = p.product_id
    WHERE 
        ss.date BETWEEN '[开始日期]' AND '[结束日期]'
    GROUP BY 
        ss.product_id, p.product_name
    ORDER BY 
        total_sales_quantity DESC
    LIMIT 1
)

SELECT 
    so.order_id,
    so.order_date,
    so.total_amount,
    s.store_name,
    e.name AS employee_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS item_total,
    tp.product_name
FROM 
    salesorders so
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    top_product tp ON od.product_id = tp.product_id
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    employees e ON so.employee_id = e.employee_id
WHERE 
    so.order_date BETWEEN '[开始日期]' AND '[结束日期]'
ORDER BY 
    so.order_date DESC;	3976972213
SELECT 
    so.order_id,
    so.order_date,
    so.total_amount,
    s.store_name,
    p.product_name,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS item_total
FROM 
    salesorders so
JOIN 
    stores s ON so.store_id = s.store_id
JOIN 
    orderdetails od ON so.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
WHERE 
    so.employee_id = '24afdebe-fb63-4a7d-b6a4-19f810b8cc4e'  -- 胡海燕的employee_id
ORDER BY 
    so.order_date DESC;	783788015
SELECT 
    s.store_name,
    s.manager_name,
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
SELECT DISTINCT s.store_name, e.position
FROM salesorders so
JOIN employees e ON so.employee_id = e.employee_id
JOIN stores s ON so.store_id = s.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE so.order_date = '2023-05-01'
AND p.product_name = '华为Mate 40 Pro';	1834111948
SELECT 
    e.employee_id,
    e.name AS employee_name,
    s.store_name,
    st.manager_name
FROM 
    employees e
JOIN 
    salesstatistics ss ON e.employee_id = ss.employee_id
JOIN 
    stores st ON e.store_id = st.store_id
JOIN 
    stores s ON e.store_id = s.store_id
WHERE 
    ss.date = '2023-05-06'
    AND ss.sales_amount > 10000
GROUP BY 
    e.employee_id, e.name, s.store_name, st.manager_name;	1718600359
SELECT 
    s.store_name AS "门店名称",
    e.name AS "员工姓名",
    SUM(so.total_amount) AS "订单总金额"
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
    p.product_name = '戴尔灵越15笔记本电脑'
    AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'
GROUP BY 
    s.store_name, e.name
HAVING 
    SUM(so.total_amount) > 5000
ORDER BY 
    "订单总金额" DESC;	2900121322
SELECT product_id, product_name, remaining_quantity, sale_price 
FROM products;	1605466649
SELECT s.store_name, COUNT(e.employee_id) AS employee_count
FROM stores s
LEFT JOIN employees e ON s.store_id = e.store_id
GROUP BY s.store_id, s.store_name
ORDER BY s.store_name;	330758085
SELECT DISTINCT e.employee_id, e.name, e.position
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN stores s ON so.store_id = s.store_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE s.store_name = '科技中心店'
  AND p.product_name = '戴森V11'
  AND so.order_date = '2023-05-05'
  AND od.quantity > 1;	1887568974
SELECT 
    so.order_id,
    so.order_date,
    so.total_amount,
    e.name AS employee_name
FROM 
    salesorders so
JOIN 
    employees e ON so.employee_id = e.employee_id
WHERE 
    so.store_id = '7a44c6b1-ad5c-4a6f-ab71-8020a18b6685'
ORDER BY 
    so.order_date DESC;	1544829110
SELECT ra.assessment_id, ra.risk_level, ra.impact_score, 
       re.event_id, re.event_type, re.event_description, re.occurrence_time, re.severity
FROM risk_assessments ra
JOIN risk_events re ON ra.event_id = re.event_id
WHERE ra.risk_level = '高' AND ra.impact_score > 8;	1389319035
SELECT * 
FROM risk_events 
WHERE event_type = '合规风险';	955757206
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status AS event_status,
    a.alert_id,
    a.alert_type,
    a.alert_time,
    a.status AS alert_status,
    al.audit_result,
    al.audit_comments,
    al.audit_time
FROM 
    risk_events re
JOIN 
    alerts a ON re.event_id = a.event_id
LEFT JOIN 
    audit_logs al ON a.alert_id = al.alert_id
WHERE 
    a.alert_type = '欺诈嫌疑'
ORDER BY 
    re.occurrence_time DESC;	1687223871
SELECT 
    r.report_type,
    AVG(e.severity) AS average_severity
FROM 
    risk_reports r
JOIN 
    risk_events e ON r.event_id = e.event_id
WHERE 
    r.approval_status = 'approved'
GROUP BY 
    r.report_type;	948809000
SELECT 
    c.risk_level,
    COUNT(c.customer_id) AS customer_count,
    AVG(c.credit_score) AS average_credit_score
FROM 
    customers c
GROUP BY 
    c.risk_level
ORDER BY 
    c.risk_level;	2131857844
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    ri.indicator_description,
    ri.measurement_unit,
    ri.threshold_value,
    rml.log_id,
    rml.monitoring_date,
    rml.actual_value,
    rml.is_exceeding_threshold,
    rml.notes
FROM 
    risk_indicators ri
LEFT JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
WHERE 
    EXTRACT(MONTH FROM rml.monitoring_date) = 10 
    AND EXTRACT(YEAR FROM rml.monitoring_date) = 2023
ORDER BY 
    ri.indicator_id, rml.monitoring_date;	1810509227
SELECT 
    r.report_id,
    r.report_type,
    r.report_date,
    r.author,
    r.event_id,
    e.event_type,
    e.event_description
FROM 
    risk_reports r
JOIN 
    risk_events e ON r.event_id = e.event_id
WHERE 
    r.approval_status = 'approved';	2704266530
SELECT 
    c.risk_level,
    t.transaction_type,
    CASE 
        WHEN t.amount < 1000 THEN '0-999'
        WHEN t.amount >= 1000 AND t.amount < 5000 THEN '1000-4999'
        WHEN t.amount >= 5000 AND t.amount < 10000 THEN '5000-9999'
        ELSE '10000+'
    END AS amount_range,
    COUNT(*) AS transaction_count,
    AVG(t.risk_score) AS avg_risk_score
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.risk_level,
    t.transaction_type,
    amount_range
ORDER BY 
    c.risk_level,
    t.transaction_type,
    amount_range;	3816194798
SELECT al.audit_id, al.audit_type, al.auditor, al.audit_time, al.audit_result, al.audit_comments
FROM audit_logs al
JOIN risk_events re ON al.event_id = re.event_id
WHERE re.event_id = '[特定风险事件的event_id]';	3476903471
SELECT 
    r.report_id,
    r.report_type,
    r.report_date,
    r.report_content,
    e.event_id,
    e.event_type,
    e.event_description,
    e.occurrence_time,
    e.severity,
    e.status AS event_status,
    a.assessment_id,
    a.risk_level,
    a.impact_score,
    a.probability_score,
    a.mitigation_plan
FROM 
    risk_reports r
JOIN 
    risk_events e ON r.event_id = e.event_id
LEFT JOIN 
    risk_assessments a ON e.event_id = a.event_id
WHERE 
    r.author = '周婷'
ORDER BY 
    r.report_date DESC;	451357687
SELECT report_id, report_type, report_date, author, approval_status
FROM risk_reports
WHERE report_date >= '2023-01-01'
ORDER BY report_date DESC;	880512967
SELECT 
    re.event_id,
    re.event_description,
    ra.risk_level,
    ra.impact_score,
    ra.probability_score,
    ra.mitigation_plan
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    re.event_description LIKE '%系统%';	4205370122
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    ri.threshold_value,
    current_log.actual_value AS current_value,
    past_log.actual_value AS value_30_days_ago,
    CASE 
        WHEN past_log.actual_value = 0 THEN NULL
        ELSE ROUND(((current_log.actual_value - past_log.actual_value) / past_log.actual_value) * 100, 2)
    END AS percentage_change
FROM 
    risk_indicators ri
LEFT JOIN 
    risk_monitoring_logs current_log ON ri.indicator_id = current_log.indicator_id
    AND current_log.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = ri.indicator_id)
LEFT JOIN 
    risk_monitoring_logs past_log ON ri.indicator_id = past_log.indicator_id
    AND past_log.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs 
                                    WHERE indicator_id = ri.indicator_id 
                                    AND monitoring_date <= (current_log.monitoring_date - INTERVAL '30 days'))
ORDER BY 
    ri.indicator_name;	2721513399
SELECT re.event_id, re.event_type, re.event_description, ra.mitigation_plan
FROM risk_events re
JOIN risk_assessments ra ON re.event_id = ra.event_id
WHERE ra.risk_level = '高风险' AND ra.assessor = '曾强';	1697295436
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.transaction_type = '投资' AND t.risk_score > 60;	2228217319
SELECT event_id, created_at, status 
FROM risk_events;	1939667217
SELECT 
    c.customer_id,
    c.customer_name,
    c.credit_score,
    t.transaction_id,
    t.risk_score
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.credit_score < 600
ORDER BY 
    c.credit_score, t.risk_score DESC;	2175309220
SELECT t.amount, c.customer_name
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
WHERE t.status = 'success'
  AND t.transaction_date >= '2023-12-01' 
  AND t.transaction_date < '2024-01-01';	1016775966
SELECT alert_type, alert_content FROM alerts;	629791557
SELECT 
    r.report_id,
    r.report_type,
    r.report_date,
    r.report_content,
    r.author,
    r.approval_status,
    r.approved_by,
    c.customer_name AS approver_name,
    c.customer_type AS approver_type
FROM 
    risk_reports r
LEFT JOIN 
    customers c ON r.approved_by = c.customer_id;	4191869630
SELECT 
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'success' THEN 1 ELSE 0 END) AS successful_transactions,
    ROUND(SUM(CASE WHEN status = 'success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate,
    AVG(risk_score) AS average_risk_score
FROM 
    transactions
GROUP BY 
    transaction_type
ORDER BY 
    transaction_type;	3240782233
SELECT 
    a.alert_id,
    a.alert_type,
    a.alert_content,
    a.alert_level,
    a.alert_time,
    a.status,
    r.rule_id,
    r.rule_name,
    r.rule_description,
    r.rule_type
FROM 
    alerts a
JOIN 
    rule_configurations r ON a.rule_id = r.rule_id
ORDER BY 
    a.alert_time DESC;	1390189932
SELECT 
    c.customer_id,
    c.customer_name,
    t.transaction_id,
    t.transaction_date,
    t.status AS latest_transaction_status
FROM 
    customers c
LEFT JOIN LATERAL (
    SELECT 
        transaction_id,
        transaction_date,
        status
    FROM 
        transactions
    WHERE 
        customer_id = c.customer_id
    ORDER BY 
        transaction_date DESC
    LIMIT 1
) t ON true
ORDER BY 
    c.customer_id;	2842460105
SELECT 
    ri.indicator_name,
    AVG(rml.actual_value) AS average_value,
    STDDEV(rml.actual_value) AS standard_deviation,
    CASE 
        WHEN AVG(rml.actual_value) = 0 THEN NULL 
        ELSE STDDEV(rml.actual_value) / AVG(rml.actual_value) 
    END AS coefficient_of_variation
FROM 
    risk_indicators ri
JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
GROUP BY 
    ri.indicator_name;	3963285376
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
JOIN audit_logs a ON t.transaction_id = a.transaction_id
WHERE 
    t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
    AND t.risk_score >= 70  -- 假设高风险交易的风险分数阈值为70
    AND t.amount > 500000
    AND a.audit_result = 'FAILED'
    AND a.audit_time >= CURRENT_DATE - INTERVAL '1 year';	2546181421
SELECT 
    COUNT(*) AS total_records,
    AVG(impact_score) AS average_impact_score
FROM 
    risk_assessments
WHERE 
    mitigation_plan IS NULL OR mitigation_plan = '';	2755620243
SELECT alert_content, status
FROM alerts;	3751427783
WITH high_risk_transactions AS (
    SELECT 
        t.customer_id,
        COUNT(*) AS high_risk_count
    FROM 
        transactions t
    WHERE 
        t.risk_score > 70  -- Assuming risk_score > 70 is considered high risk
        AND t.transaction_date >= CURRENT_DATE - INTERVAL '90 days'
    GROUP BY 
        t.customer_id
),

unprocessed_alerts AS (
    SELECT 
        c.customer_id,
        COUNT(a.alert_id) AS unprocessed_alert_count
    FROM 
        customers c
    LEFT JOIN 
        transactions t ON c.customer_id = t.customer_id
    LEFT JOIN 
        alerts a ON t.event_id = a.event_id
    WHERE 
        a.status = 'OPEN'  -- Assuming 'OPEN' status means unprocessed
    GROUP BY 
        c.customer_id
),

customer_credit_scores AS (
    SELECT 
        customer_id,
        credit_score
    FROM 
        customers
)

SELECT 
    c.customer_id,
    c.customer_name,
    COALESCE(hrt.high_risk_count, 0) * 2 + 
    COALESCE(ua.unprocessed_alert_count, 0) * 3 + 
    CASE WHEN cc.credit_score = 0 THEN 0 ELSE (1.0 / cc.credit_score) * 1000 END AS risk_index
FROM 
    customers c
LEFT JOIN 
    high_risk_transactions hrt ON c.customer_id = hrt.customer_id
LEFT JOIN 
    unprocessed_alerts ua ON c.customer_id = ua.customer_id
LEFT JOIN 
    customer_credit_scores cc ON c.customer_id = cc.customer_id
ORDER BY 
    risk_index DESC
LIMIT 10;	2897506811
SELECT 
    re.event_type,
    COUNT(*) AS occurrence_count,
    AVG(re.severity) AS average_severity
FROM 
    risk_events re
WHERE 
    EXTRACT(YEAR FROM re.occurrence_time) = 2023
GROUP BY 
    re.event_type
ORDER BY 
    occurrence_count DESC;	1765860698
SELECT 
    rr.report_id,
    rr.report_content,
    rr.report_type,
    rr.report_date,
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.report_content LIKE '%合规风险%';	2186954842
SELECT indicator_name, update_frequency, data_source
FROM risk_indicators;	1001861352
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    re.reporter,
    re.created_at,
    rr.report_id,
    rr.report_type,
    rr.report_date,
    rr.report_content,
    rr.author,
    rr.approval_status,
    rr.approved_by
FROM 
    risk_events re
LEFT JOIN (
    SELECT 
        report_id,
        report_type,
        report_date,
        report_content,
        author,
        approval_status,
        approved_by,
        event_id,
        ROW_NUMBER() OVER (PARTITION BY event_id ORDER BY report_date DESC) as rn
    FROM 
        risk_reports
) rr ON re.event_id = rr.event_id AND rr.rn = 1
WHERE 
    re.status != 'RESOLVED'
ORDER BY 
    re.occurrence_time DESC;	3688441488
SELECT 
    rc.rule_type,
    COUNT(a.alert_id) AS trigger_count,
    AVG(COUNT(a.alert_id)) OVER (PARTITION BY rc.rule_type) AS avg_trigger_count,
    MAX(rc.updated_at) AS last_update_time
FROM 
    rule_configurations rc
LEFT JOIN 
    alerts a ON rc.rule_id = a.rule_id
GROUP BY 
    rc.rule_type
ORDER BY 
    avg_trigger_count DESC;	2337622346
SELECT event_type, COUNT(*) AS event_count
FROM risk_events
GROUP BY event_type
ORDER BY event_count DESC;	1820971007
SELECT DISTINCT c.customer_id, c.customer_name, c.credit_score
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE EXTRACT(YEAR FROM t.transaction_date) = 2023
AND c.credit_score < 700;	3328333298
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    re.reporter,
    re.created_at,
    rr.report_id,
    rr.report_type,
    rr.report_date,
    rr.report_content,
    rr.author,
    rr.approval_status,
    rr.approved_by
FROM 
    risk_events re
LEFT JOIN 
    risk_reports rr ON re.event_id = rr.event_id
ORDER BY 
    re.event_id;	547790744
SELECT COUNT(*) AS rejected_reports_count
FROM risk_reports
WHERE approval_status = 'rejected'
AND report_date BETWEEN '2023-01-01' AND '2023-12-31';	3644288071
SELECT ra.assessment_id, ra.event_id, ra.assessor, ra.assessment_date, 
       ra.risk_level, ra.impact_score, ra.probability_score, ra.mitigation_plan
FROM risk_assessments ra;	3802320452
SELECT ri.indicator_id, ri.indicator_name, rml.monitoring_date, rml.actual_value, rml.is_exceeding_threshold, rml.notes
FROM risk_indicators ri
LEFT JOIN (
    SELECT indicator_id, MAX(monitoring_date) as latest_date
    FROM risk_monitoring_logs
    GROUP BY indicator_id
) latest ON ri.indicator_id = latest.indicator_id
LEFT JOIN risk_monitoring_logs rml ON rml.indicator_id = latest.indicator_id AND rml.monitoring_date = latest.latest_date
ORDER BY ri.indicator_name;	3489018825
SELECT 
    rc.rule_id,
    rc.rule_name,
    COUNT(a.alert_id) AS alert_count
FROM 
    rule_configurations rc
LEFT JOIN 
    alerts a ON rc.rule_id = a.rule_id
GROUP BY 
    rc.rule_id, rc.rule_name
ORDER BY 
    alert_count DESC;	2505821643
SELECT t.transaction_id, t.customer_id, t.transaction_type, t.amount, 
       t.transaction_date, t.status, t.risk_score, t.event_id,
       c.customer_name, c.customer_type, c.credit_score, c.risk_level,
       re.event_type, re.event_description, re.occurrence_time, re.severity
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN risk_events re ON t.event_id = re.event_id
WHERE re.event_type = '信用风险'
AND t.status = '成功';	3072597279
SELECT risk_level, COUNT(*) AS customer_count
FROM customers
GROUP BY risk_level
ORDER BY risk_level;	260033616
WITH high_risk_customers AS (
    -- 找出2019年之前注册且风险等级为'高'的客户
    SELECT 
        c.customer_id,
        c.customer_name
    FROM 
        customers c
    WHERE 
        c.registration_date < '2019-01-01' 
        AND c.risk_level = '高'
),
customer_transactions AS (
    -- 获取这些客户的交易金额
    SELECT 
        h.customer_id,
        h.customer_name,
        t.amount
    FROM 
        high_risk_customers h
    JOIN 
        transactions t ON h.customer_id = t.customer_id
),
ranked_transactions AS (
    -- 为交易金额排序并计算中位数
    SELECT 
        customer_id,
        customer_name,
        amount,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount) AS row_num,
        COUNT(*) OVER (PARTITION BY customer_id) AS total_count
    FROM 
        customer_transactions
)
-- 计算每个客户的交易金额中位数
SELECT 
    customer_id,
    customer_name,
    AVG(amount) AS median_transaction_amount
FROM 
    ranked_transactions
WHERE 
    row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2))
GROUP BY 
    customer_id, customer_name;	2369245761
SELECT 
    rc.rule_id,
    rc.rule_name,
    re.event_description
FROM 
    alerts a
JOIN 
    rule_configurations rc ON a.rule_id = rc.rule_id
JOIN 
    risk_events re ON a.event_id = re.event_id
WHERE 
    a.alert_level = 'high';	1787317276
SELECT event_id, created_at, status
FROM risk_events;	1447865488
WITH monthly_event_counts AS (
  SELECT 
    event_type,
    DATE_TRUNC('month', occurrence_time) AS month,
    COUNT(*) AS event_count
  FROM 
    risk_events
  GROUP BY 
    event_type, 
    DATE_TRUNC('month', occurrence_time)
),
monthly_with_previous AS (
  SELECT 
    event_type,
    month,
    event_count,
    LAG(event_count) OVER (PARTITION BY event_type ORDER BY month) AS prev_month_count
  FROM 
    monthly_event_counts
)
SELECT 
  event_type,
  TO_CHAR(month, 'YYYY-MM') AS month,
  event_count,
  CASE 
    WHEN prev_month_count IS NULL OR prev_month_count = 0 THEN NULL
    ELSE ROUND((event_count - prev_month_count) * 100.0 / prev_month_count, 2)
  END AS month_over_month_growth_rate
FROM 
  monthly_with_previous
ORDER BY 
  event_type, 
  month;	3560291801
SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year,
    EXTRACT(MONTH FROM transaction_date) AS month,
    COUNT(*) AS transaction_count,
    AVG(amount) AS average_amount
FROM 
    transactions
GROUP BY 
    EXTRACT(YEAR FROM transaction_date),
    EXTRACT(MONTH FROM transaction_date)
ORDER BY 
    year, month;	2152701139
SELECT 
    rr.report_id,
    rr.report_type,
    rr.approved_by,
    re.event_description,
    re.severity
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.approval_status = 'approved';	558233205
SELECT 
    c.customer_id,
    c.customer_name,
    c.risk_level,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status AS transaction_status
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
ORDER BY 
    c.customer_id, t.transaction_date DESC;	3381293646
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.risk_score,
    c.customer_id,
    c.customer_name,
    c.risk_level
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    c.risk_level = 'high'
ORDER BY 
    t.transaction_date DESC;	3077667667
SELECT * 
FROM risk_reports 
WHERE author = '孙宇' AND approval_status != 'approved';	2339616488
SELECT a.alert_content, re.event_description
FROM alerts a
JOIN risk_events re ON a.event_id = re.event_id
WHERE a.status != 'processed' OR a.status IS NULL;	1797007792
SELECT risk_level, COUNT(*) as customer_count
FROM customers
WHERE risk_level IN ('中', '高')
GROUP BY risk_level
ORDER BY risk_level;	298505495
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(t.transaction_id) AS transaction_count,
    AVG(t.risk_score) AS average_risk_score
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.customer_id, c.customer_name
ORDER BY 
    c.customer_id;	612300483
SELECT 
    DATE_TRUNC('month', registration_date) AS month,
    COUNT(*) AS high_risk_customer_count
FROM 
    customers
WHERE 
    risk_level = 'high'
GROUP BY 
    DATE_TRUNC('month', registration_date)
ORDER BY 
    month;	3872938276
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    rml.monitoring_date,
    rml.actual_value,
    rml.is_exceeding_threshold,
    a.alert_id,
    a.alert_type,
    a.alert_level,
    a.alert_time,
    al.audit_id,
    al.audit_result,
    al.audit_comments,
    al.audit_time
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
    ri.risk_level = 'high'
    AND rml.monitoring_date = (
        SELECT MAX(monitoring_date) 
        FROM risk_monitoring_logs 
        WHERE indicator_id = ri.indicator_id
    )
ORDER BY 
    ri.indicator_id, rml.monitoring_date DESC;	4293195588
SELECT 
    c.risk_level,
    COUNT(c.customer_id) AS customer_count,
    AVG(c.credit_score) AS average_credit_score
FROM 
    customers c
GROUP BY 
    c.risk_level
ORDER BY 
    c.risk_level;	3735769324
SELECT 
    a.alert_type,
    AVG(EXTRACT(EPOCH FROM (a.alert_time - e.occurrence_time))) / 3600 AS avg_processing_hours,
    MAX(EXTRACT(EPOCH FROM (a.alert_time - e.occurrence_time))) / 3600 AS max_processing_hours
FROM 
    alerts a
JOIN 
    risk_events e ON a.event_id = e.event_id
WHERE 
    a.status = 'RESOLVED'  -- 假设"已解决"的状态值为'RESOLVED'
GROUP BY 
    a.alert_type
ORDER BY 
    max_processing_hours DESC;	3555900229
SELECT 
    c.customer_name,
    t.amount,
    t.transaction_date
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.transaction_date >= '2023-11-01' 
    AND t.transaction_date < '2023-12-01'
    AND t.amount > 100000
ORDER BY 
    t.transaction_date;	390806390
SELECT indicator_name, SUM(threshold_value) AS total_threshold
FROM risk_indicators
WHERE indicator_name LIKE '%财务%'
GROUP BY indicator_name;	2736578842
SELECT customer_name, credit_score
FROM customers;	453782697
SELECT 
    c.customer_id,
    c.customer_name,
    latest_transactions.transaction_id,
    latest_transactions.transaction_type,
    latest_transactions.amount,
    latest_transactions.transaction_date,
    latest_transactions.risk_score
FROM 
    customers c
JOIN (
    SELECT 
        t.customer_id,
        t.transaction_id,
        t.transaction_type,
        t.amount,
        t.transaction_date,
        t.risk_score,
        ROW_NUMBER() OVER (PARTITION BY t.customer_id ORDER BY t.transaction_date DESC) as rn
    FROM 
        transactions t
) latest_transactions ON c.customer_id = latest_transactions.customer_id AND latest_transactions.rn = 1
ORDER BY 
    c.customer_id;	605680231
SELECT *
FROM risk_monitoring_logs
WHERE is_exceeding_threshold = true;	591035595
SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date, t.status, t.risk_score, 
       c.customer_id, c.customer_name, c.risk_level,
       AVG(t.risk_score) OVER () as avg_risk_score
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
WHERE c.risk_level = 'high'
ORDER BY t.transaction_date DESC;	154773295
SELECT 
    c.customer_id,
    c.customer_name,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.risk_score
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
ORDER BY 
    c.customer_id, t.transaction_date DESC;	2894945358
SELECT 
    report_type,
    COUNT(*) AS rejected_report_count
FROM 
    risk_reports
WHERE 
    approval_status = '已拒绝'
GROUP BY 
    report_type
ORDER BY 
    rejected_report_count DESC;	3936841885
SELECT customer_id, customer_name, credit_score, risk_level
FROM customers
WHERE risk_level = '高' AND credit_score < 600;	2451684746
SELECT 
    c.risk_level,
    AVG(t.amount) AS average_transaction_amount,
    COUNT(t.transaction_id) AS transaction_count
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    c.risk_level
ORDER BY 
    c.risk_level;	1650691143
SELECT r.report_id, r.report_type, r.report_date, r.report_content, r.author, r.approval_status, r.approved_by
FROM risk_reports r
JOIN risk_events e ON r.event_id = e.event_id
WHERE e.event_type = '流动性风险';	3897186376
SELECT 
    COUNT(DISTINCT c.customer_id) AS customer_count,
    SUM(t.amount) AS total_transaction_amount
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.credit_score BETWEEN 600 AND 800;	1076275288
SELECT r.report_content
FROM risk_reports r
WHERE r.approved_by = '王思远'
  AND r.report_date BETWEEN '2023-03-01' AND '2023-03-31'
  AND r.approval_status = 'approved';	1120727301
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    rr.report_id,
    rr.report_type,
    rr.report_date,
    rr.report_content,
    rr.author,
    rr.approval_status
FROM 
    risk_events re
LEFT JOIN 
    risk_reports rr ON re.event_id = rr.event_id
WHERE 
    re.event_type = 'Compliance Risk'
ORDER BY 
    re.occurrence_time DESC;	1080125465
SELECT 
    t.transaction_id,
    t.customer_id,
    c.customer_name,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.risk_score
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    t.transaction_date >= '2023-06-01' 
    AND t.transaction_date < '2023-07-01'
ORDER BY 
    t.transaction_date;	136539419
SELECT DISTINCT re.event_id, re.event_type, re.event_description, re.occurrence_time, re.severity, re.status, re.reporter, re.created_at
FROM risk_events re
JOIN audit_logs al ON re.event_id = al.event_id
WHERE re.severity = 3;	3750047672
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    ri.threshold_value,
    rml.monitoring_date,
    rml.actual_value,
    rml.is_exceeding_threshold,
    rml.notes
FROM 
    risk_indicators ri
JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
WHERE 
    rml.is_exceeding_threshold = true
ORDER BY 
    ri.indicator_name, 
    rml.monitoring_date DESC;	3909298542
SELECT 
    c.customer_id,
    c.customer_name,
    c.risk_level,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status AS transaction_status,
    t.risk_score
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
ORDER BY 
    c.customer_id, t.transaction_date DESC;	2762771801
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    a.alert_id,
    a.alert_type,
    a.alert_content,
    a.alert_level,
    a.alert_time,
    a.status AS alert_status
FROM 
    risk_events re
LEFT JOIN 
    alerts a ON re.event_id = a.event_id
WHERE 
    a.alert_level = '高'
ORDER BY 
    re.occurrence_time DESC;	2830564670
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    a.alert_id,
    a.alert_type,
    a.alert_content,
    a.alert_level,
    a.alert_time,
    a.status AS alert_status
FROM 
    risk_events re
LEFT JOIN 
    alerts a ON re.event_id = a.event_id
ORDER BY 
    a.alert_time ASC;	942591775
SELECT 
    c.risk_level,
    AVG(t.amount) AS average_transaction_amount,
    COUNT(t.transaction_id) AS transaction_count
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.transaction_date >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY 
    c.risk_level
ORDER BY 
    c.risk_level;	3295587616
SELECT customer_id, customer_name, credit_score, risk_level
FROM customers
WHERE risk_level = '高' AND credit_score < 700;	3932804573
SELECT 
    c.customer_id,
    c.customer_name,
    c.credit_score,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status
FROM 
    customers c
LEFT JOIN (
    SELECT 
        transaction_id,
        customer_id,
        transaction_type,
        amount,
        transaction_date,
        status,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_date DESC) as rn
    FROM 
        transactions
    WHERE 
        status = '失败'
) t ON c.customer_id = t.customer_id AND t.rn = 1
ORDER BY 
    c.customer_id;	862533692
SELECT 
    ra.assessment_id,
    ra.event_id,
    ra.risk_level,
    ra.impact_score,
    ra.probability_score,
    c.customer_id,
    c.customer_name,
    c.credit_score
FROM 
    risk_assessments ra
JOIN 
    risk_events re ON ra.event_id = re.event_id
JOIN 
    transactions t ON re.event_id = t.event_id
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    ra.risk_level = 'high'
    AND c.credit_score > 700;	2759801136
SELECT customer_id, customer_name, customer_type, credit_score, risk_level, registration_date, last_update_date
FROM customers
WHERE customer_type = '企业'
ORDER BY credit_score DESC
LIMIT 10;	1448319074
WITH monthly_new_rules AS (
    -- 统计每个月新增的规则数量
    SELECT 
        DATE_TRUNC('month', created_at) AS month,
        COUNT(*) AS new_rules_count
    FROM 
        rule_configurations
    GROUP BY 
        DATE_TRUNC('month', created_at)
),
monthly_active_rules AS (
    -- 计算每个月活跃规则的数量
    SELECT 
        DATE_TRUNC('month', calendar.month) AS month,
        COUNT(rc.rule_id) AS active_rules_count
    FROM 
        (SELECT generate_series(
            (SELECT MIN(created_at) FROM rule_configurations),
            (SELECT MAX(GREATEST(created_at, updated_at)) FROM rule_configurations),
            '1 month'::interval
        ) AS month) AS calendar
    LEFT JOIN 
        rule_configurations rc ON 
            rc.created_at <= calendar.month AND 
            (rc.updated_at >= calendar.month OR rc.updated_at IS NULL) AND
            rc.is_active = true
    GROUP BY 
        DATE_TRUNC('month', calendar.month)
)
-- 合并结果，计算累计平均活跃规则数
SELECT 
    TO_CHAR(mnr.month, 'YYYY-MM') AS month,
    mnr.new_rules_count,
    mar.active_rules_count,
    ROUND(AVG(mar.active_rules_count) OVER (
        ORDER BY mnr.month 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS avg_active_rules
FROM 
    monthly_new_rules mnr
JOIN 
    monthly_active_rules mar ON mnr.month = mar.month
ORDER BY 
    mnr.month;	2148910450
SELECT author, approval_status
FROM risk_reports
WHERE approval_status = 'approved';	3303778848
SELECT 
    c.customer_id,
    c.customer_name,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.status,
    t.transaction_date
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
ORDER BY 
    c.customer_id, 
    t.transaction_date DESC;	2919479377
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    ra.assessment_id,
    ra.risk_level,
    ra.impact_score,
    ra.probability_score,
    ra.mitigation_plan
FROM 
    risk_events re
LEFT JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
ORDER BY 
    re.occurrence_time DESC;	3408098582
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    ri.threshold_value,
    AVG(rml.actual_value) AS average_actual_value,
    CASE 
        WHEN AVG(rml.actual_value) > ri.threshold_value THEN 'Exceeds Threshold'
        ELSE 'Within Threshold' 
    END AS threshold_comparison
FROM 
    risk_indicators ri
LEFT JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
GROUP BY 
    ri.indicator_id, ri.indicator_name, ri.threshold_value
ORDER BY 
    ri.indicator_name;	3536942222
SELECT 
    rr.report_id,
    rr.report_type,
    rr.report_date,
    rr.report_content,
    rr.author,
    rr.approval_status,
    rr.approved_by,
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    re.reporter,
    re.created_at
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.approval_status = 'approved';	3025435441
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
JOIN alerts a ON t.event_id = a.event_id
WHERE t.risk_score >= 80  -- 假设高风险交易的risk_score阈值为80
  AND a.alert_level = 'HIGH'  -- 假设高级别预警的值为'HIGH'
  AND DATE(t.transaction_date) = DATE(a.alert_time);	3761432717
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.risk_score,
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.credit_score,
    c.risk_level
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    t.risk_score > 70  -- 假设高风险交易的risk_score阈值是70
ORDER BY 
    t.risk_score DESC;	3404778014
SELECT 
    re.event_id,
    re.event_description,
    ra.assessment_date,
    ra.risk_level
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    ra.risk_level = '高';	3200534548
SELECT c.customer_id, c.customer_name, c.risk_level, t.transaction_id, t.transaction_date, t.status
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE c.risk_level = 'high'
AND t.status = 'failed'
AND t.transaction_date = (
    SELECT MAX(transaction_date)
    FROM transactions
    WHERE customer_id = c.customer_id
)
ORDER BY t.transaction_date DESC;	698660188
SELECT 
    re.event_id,
    re.event_type,
    COUNT(t.transaction_id) AS transaction_count
FROM 
    risk_events re
LEFT JOIN 
    transactions t ON re.event_id = t.event_id
GROUP BY 
    re.event_id, re.event_type
ORDER BY 
    transaction_count DESC;	756643276
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.risk_score,
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.credit_score,
    c.risk_level,
    c.registration_date
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    c.risk_level = '高风险'
    AND t.amount > 500000
    AND t.transaction_date >= '2023-01-01' 
    AND t.transaction_date < '2023-04-01'
ORDER BY 
    t.transaction_date DESC;	1961596891
SELECT 
    re.event_id,
    re.event_description,
    re.severity,
    ra.risk_level,
    ra.mitigation_plan
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    re.severity IN (4, 5)
    AND EXTRACT(YEAR FROM re.occurrence_time) = 2023
ORDER BY 
    re.severity DESC;	1488802626
SELECT * 
FROM risk_monitoring_logs 
WHERE is_exceeding_threshold = false;	3027811751
SELECT 
    rr.report_id,
    rr.report_type,
    rr.report_date,
    rr.author,
    rr.approval_status,
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status AS event_status,
    al.audit_id,
    al.audit_time,
    al.auditor,
    al.audit_result,
    al.audit_comments
FROM 
    risk_reports rr
LEFT JOIN 
    risk_events re ON rr.event_id = re.event_id
LEFT JOIN (
    SELECT 
        alert_id,
        MAX(audit_time) AS latest_audit_time
    FROM 
        audit_logs
    GROUP BY 
        alert_id
) latest_audit ON rr.report_id = latest_audit.alert_id
LEFT JOIN 
    audit_logs al ON latest_audit.alert_id = al.alert_id 
                  AND latest_audit.latest_audit_time = al.audit_time
WHERE 
    rr.approval_status = '待审批'
ORDER BY 
    rr.report_date DESC;	1296190191
SELECT customer_id, customer_name, credit_score, risk_level, registration_date
FROM customers
WHERE EXTRACT(YEAR FROM registration_date) = 2021
  AND risk_level = '高'
  AND credit_score < 550;	2631012035
WITH latest_transactions AS (
    SELECT 
        t.customer_id,
        t.transaction_id,
        t.transaction_type,
        t.amount,
        t.transaction_date,
        t.status,
        t.risk_score,
        t.event_id,
        ROW_NUMBER() OVER (PARTITION BY t.customer_id ORDER BY t.transaction_date DESC) AS rn
    FROM transactions t
)
SELECT 
    c.customer_id,
    c.customer_name,
    c.customer_type,
    lt.transaction_id,
    lt.transaction_type,
    lt.amount,
    lt.transaction_date,
    lt.status,
    lt.risk_score,
    CASE 
        WHEN a.alert_id IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS has_triggered_alert,
    a.alert_id,
    a.alert_type,
    a.alert_level,
    a.alert_time,
    a.status AS alert_status
FROM customers c
JOIN latest_transactions lt ON c.customer_id = lt.customer_id AND lt.rn = 1
LEFT JOIN alerts a ON lt.event_id = a.event_id
ORDER BY c.customer_id;	2342271424
SELECT 
    event_type AS risk_type,
    COUNT(*) AS event_count
FROM 
    risk_events
GROUP BY 
    event_type
ORDER BY 
    event_count DESC;	2292865545
SELECT 
    c.customer_name,
    rc.rule_name,
    COUNT(a.alert_id) AS trigger_count
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
JOIN 
    alerts a ON t.event_id = a.event_id
JOIN 
    rule_configurations rc ON a.rule_id = rc.rule_id
WHERE 
    c.risk_level = '高'
GROUP BY 
    c.customer_name, rc.rule_name
ORDER BY 
    trigger_count DESC;	3057920994
SELECT 
    re.event_type,
    DATE_TRUNC('month', re.occurrence_time) AS month,
    COUNT(*) AS event_count,
    AVG(re.severity) AS avg_severity,
    SUM(CASE WHEN re.status = 'Resolved' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS resolution_rate_percentage
FROM 
    risk_events re
GROUP BY 
    re.event_type, 
    DATE_TRUNC('month', re.occurrence_time)
ORDER BY 
    re.event_type, 
    month;	1563461822
SELECT 
    rml.log_id,
    ri.indicator_name,
    ri.threshold_value,
    rml.actual_value,
    CASE 
        WHEN rml.actual_value > ri.threshold_value THEN 'Exceeded'
        WHEN rml.actual_value = ri.threshold_value THEN 'Equal'
        ELSE 'Below'
    END AS comparison_result,
    rml.monitoring_date,
    rml.notes
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id
ORDER BY 
    rml.monitoring_date DESC;	2699040253
SELECT 
    c.risk_level,
    t.transaction_type,
    AVG(t.amount) AS average_transaction_amount
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.risk_level, t.transaction_type
ORDER BY 
    c.risk_level, t.transaction_type;	2609391365
SELECT COUNT(*) AS active_rule_count
FROM rule_configurations
WHERE is_active = true;	1646275357
SELECT customer_id, customer_name, risk_level, credit_score
FROM customers;	3640375109
SELECT 
    COUNT(*) AS indicator_count,
    AVG(CASE 
        WHEN update_frequency = 'daily' THEN 1
        WHEN update_frequency = 'weekly' THEN 7
        WHEN update_frequency = 'monthly' THEN 30
        WHEN update_frequency = 'quarterly' THEN 90
        WHEN update_frequency = 'yearly' THEN 365
        ELSE NULL
    END) AS avg_update_days
FROM 
    risk_indicators
WHERE 
    threshold_value > 100;	1137138067
SELECT customer_name, registration_date FROM customers;	674388735
SELECT 
    ri.indicator_name,
    rml.monitoring_date,
    rml.actual_value,
    ri.threshold_value,
    rml.is_exceeding_threshold,
    rml.notes
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id
ORDER BY 
    ri.indicator_name, 
    rml.monitoring_date DESC;	2598937105
SELECT 
    ri.indicator_name,
    ri.data_source,
    AVG(rml.actual_value) AS average_value,
    STDDEV(rml.actual_value) AS standard_deviation
FROM 
    risk_indicators ri
JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
GROUP BY 
    ri.indicator_name, ri.data_source
ORDER BY 
    ri.indicator_name, ri.data_source;	62865185
SELECT audit_id, related_id, audit_type, auditor, audit_time, audit_result, audit_comments, event_id, transaction_id, alert_id
FROM audit_logs
WHERE audit_result = '拒绝';	185839438
SELECT alert_type, alert_content
FROM alerts;	3165460471
SELECT 
    a.alert_id,
    a.alert_type,
    a.alert_level,
    a.alert_time,
    a.status,
    e.event_description,
    e.event_type,
    e.severity,
    al.audit_time AS last_audit_time,
    al.audit_result,
    al.audit_comments
FROM 
    alerts a
JOIN 
    risk_events e ON a.event_id = e.event_id
LEFT JOIN (
    SELECT 
        alert_id,
        audit_time,
        audit_result,
        audit_comments,
        ROW_NUMBER() OVER (PARTITION BY alert_id ORDER BY audit_time DESC) AS rn
    FROM 
        audit_logs
) al ON a.alert_id = al.alert_id AND al.rn = 1
WHERE 
    a.status = '未处理'
ORDER BY 
    a.alert_time DESC;	3849483796
SELECT 
    AVG(EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - alert_time))/3600) AS avg_hours_unresolved,
    COUNT(*) AS unresolved_alerts_count
FROM 
    alerts
WHERE 
    status != 'processed' OR status IS NULL;	1990473038
SELECT 
    c.customer_id,
    c.customer_name,
    (COUNT(DISTINCT ra.assessment_id) * COALESCE(AVG(ra.impact_score + ra.probability_score), 0) + 
     COUNT(DISTINCT a.alert_id) * 2) AS risk_index
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
LEFT JOIN 
    risk_events re ON t.event_id = re.event_id
LEFT JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
LEFT JOIN 
    alerts a ON re.event_id = a.event_id
GROUP BY 
    c.customer_id, c.customer_name
ORDER BY 
    risk_index DESC;	3119334868
SELECT 
    re.event_type,
    COUNT(*) AS event_count
FROM 
    risk_events re
WHERE 
    re.status = '未处理'
GROUP BY 
    re.event_type
ORDER BY 
    event_count DESC;	2458967882
SELECT 
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.credit_score,
    c.risk_level,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.risk_score
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.risk_level = '低' 
    AND c.credit_score > 700
ORDER BY 
    c.customer_id, 
    t.transaction_date;	4081376750
SELECT 
    a.alert_id,
    a.alert_type,
    a.alert_content,
    a.alert_level,
    a.alert_time,
    a.status,
    e.event_id,
    e.event_type,
    e.event_description,
    e.occurrence_time,
    e.severity,
    e.status AS event_status
FROM 
    alerts a
JOIN 
    risk_events e ON a.event_id = e.event_id
WHERE 
    a.alert_level = 'high' 
    AND a.status = 'unprocessed'
ORDER BY 
    a.alert_time DESC;	2952805928
SELECT a.alert_id, a.alert_type, a.alert_content, a.alert_level, a.alert_time, a.status, a.assigned_to, r.rule_name, r.rule_description
FROM alerts a
JOIN rule_configurations r ON a.rule_id = r.rule_id
WHERE r.rule_type = '合规违规'
ORDER BY a.alert_time DESC;	790231894
SELECT 
    c.customer_id,
    c.customer_name,
    c.risk_level,
    SUM(t.amount) AS total_transaction_amount
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.risk_score >= 8  -- 假设高风险交易的risk_score阈值为8
GROUP BY 
    c.customer_id, c.customer_name, c.risk_level
ORDER BY 
    total_transaction_amount DESC;	76184048
SELECT report_content
FROM risk_reports
WHERE report_type = '月度风险报告' AND approval_status = '已拒绝';	291950371
SELECT event_type, COUNT(*) AS event_count
FROM risk_events
GROUP BY event_type
ORDER BY event_count DESC;	2809252635
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE t.transaction_type = '转账'
  AND t.amount > 200000
  AND t.transaction_date >= '2023-05-04 00:00:00'
  AND t.transaction_date < '2023-05-05 00:00:00';	184311181
SELECT 
    a.alert_id,
    a.alert_type,
    a.alert_level,
    a.assigned_to,
    a.alert_time,
    e.event_description,
    e.event_type,
    e.severity
FROM 
    alerts a
JOIN 
    risk_events e ON a.event_id = e.event_id
WHERE 
    a.status != '已处理' 
    AND a.alert_level = '高级'
ORDER BY 
    a.alert_time DESC;	1539184065
SELECT r.report_id, r.report_type, r.report_date, r.report_content, r.author, r.approval_status
FROM risk_reports r
WHERE r.report_date BETWEEN '2023-04-01' AND '2023-04-30'
AND r.approved_by = '高志远';	3408938184
SELECT 
    transaction_type,
    SUM(CASE WHEN status = 'success' THEN 1 ELSE 0 END) AS success_count,
    SUM(CASE WHEN status = 'failed' THEN 1 ELSE 0 END) AS failed_count
FROM 
    transactions
GROUP BY 
    transaction_type
ORDER BY 
    transaction_type;	547284006
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    ra.risk_level,
    ra.impact_score,
    ra.probability_score,
    ra.mitigation_plan,
    ra.assessment_date
FROM 
    risk_events re
LEFT JOIN (
    SELECT 
        ra1.event_id,
        ra1.risk_level,
        ra1.impact_score,
        ra1.probability_score,
        ra1.mitigation_plan,
        ra1.assessment_date
    FROM 
        risk_assessments ra1
    INNER JOIN (
        SELECT 
            event_id,
            MAX(assessment_date) as latest_date
        FROM 
            risk_assessments
        GROUP BY 
            event_id
    ) ra2 ON ra1.event_id = ra2.event_id AND ra1.assessment_date = ra2.latest_date
) ra ON re.event_id = ra.event_id
ORDER BY 
    re.occurrence_time DESC;	2791172353
SELECT 
    c.customer_name,
    COUNT(DISTINCT ra.assessment_id) AS risk_assessment_count,
    COUNT(DISTINCT t.transaction_id) AS large_transaction_count
FROM 
    customers c
LEFT JOIN 
    risk_assessments ra ON c.customer_id = (
        SELECT customer_id 
        FROM transactions 
        WHERE event_id = ra.event_id 
        LIMIT 1
    )
    AND ra.risk_level = 'high'
    AND ra.assessment_date >= CURRENT_DATE - INTERVAL '1 year'
LEFT JOIN 
    transactions t ON t.customer_id = c.customer_id
    AND t.amount > 500000
    AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    c.customer_id, c.customer_name
HAVING 
    COUNT(DISTINCT ra.assessment_id) > 0
    AND COUNT(DISTINCT t.transaction_id) > 0
ORDER BY 
    risk_assessment_count DESC, 
    large_transaction_count DESC;	616009086
SELECT t.* 
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
WHERE c.customer_name = '恒基能源有限公司';	2755424699
SELECT event_id, MAX(severity) AS highest_severity
FROM risk_events
GROUP BY event_id;	3357225905
SELECT 
    c.risk_level,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    AVG(t.amount) AS average_transaction_amount
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.risk_level
ORDER BY 
    c.risk_level;	2507883319
SELECT a.*, al.audit_result
FROM alerts a
JOIN audit_logs al ON a.alert_id = al.alert_id
WHERE al.auditor = '张强';	2171757699
SELECT 
    rml.monitoring_date,
    rml.actual_value,
    rml.is_exceeding_threshold,
    ri.indicator_name,
    ri.indicator_description,
    ri.measurement_unit,
    ri.threshold_value
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id
ORDER BY 
    rml.monitoring_date DESC;	1791933892
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    COUNT(rml.log_id) AS exceed_count,
    AVG(rml.actual_value - ri.threshold_value) AS avg_exceed_amount
FROM 
    risk_indicators ri
JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
WHERE 
    rml.is_exceeding_threshold = true
    AND rml.monitoring_date >= '2023-01-01' 
    AND rml.monitoring_date < '2024-01-01'
GROUP BY 
    ri.indicator_id, ri.indicator_name
ORDER BY 
    exceed_count DESC;	4281611752
SELECT 
    a.alert_id,
    a.alert_type,
    a.alert_content,
    a.alert_level,
    a.alert_time,
    a.status,
    a.assigned_to,
    r.rule_name,
    e.event_type,
    e.event_description
FROM 
    alerts a
JOIN 
    rule_configurations r ON a.rule_id = r.rule_id
LEFT JOIN 
    risk_events e ON a.event_id = e.event_id
WHERE 
    a.alert_time >= '2023-01-01' 
    AND a.alert_time < '2024-01-01'
ORDER BY 
    a.alert_time DESC;	2403947927
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    rml.monitoring_date,
    rml.actual_value
FROM 
    risk_indicators ri
LEFT JOIN (
    SELECT 
        indicator_id,
        MAX(monitoring_date) as latest_date
    FROM 
        risk_monitoring_logs
    GROUP BY 
        indicator_id
) latest ON ri.indicator_id = latest.indicator_id
LEFT JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id AND latest.latest_date = rml.monitoring_date
ORDER BY 
    ri.indicator_id;	3007794799
WITH threshold_exceedances AS (
    SELECT 
        ri.indicator_id,
        ri.indicator_name,
        COUNT(*) AS exceedance_count,
        COUNT(*) * 100.0 / (SELECT COUNT(*) 
                           FROM risk_monitoring_logs rml 
                           WHERE rml.indicator_id = ri.indicator_id 
                           AND rml.monitoring_date >= NOW() - INTERVAL '1 year') AS exceedance_percentage
    FROM 
        risk_indicators ri
    JOIN 
        risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
    WHERE 
        rml.is_exceeding_threshold = TRUE
        AND rml.monitoring_date >= NOW() - INTERVAL '1 year'
    GROUP BY 
        ri.indicator_id, ri.indicator_name
)
SELECT 
    indicator_id,
    indicator_name,
    exceedance_count,
    ROUND(exceedance_percentage, 2) AS exceedance_percentage
FROM 
    threshold_exceedances
ORDER BY 
    exceedance_count DESC
LIMIT 10;	3478580962
SELECT risk_level, COUNT(*) AS customer_count
FROM customers
GROUP BY risk_level
ORDER BY customer_count DESC;	2835641813
SELECT 
    c.customer_id,
    c.customer_name,
    t.transaction_id,
    t.risk_score,
    t.status AS transaction_status
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
ORDER BY 
    c.customer_id, t.transaction_date;	3556405805
SELECT 
    ra.event_id,
    ra.risk_level,
    t.transaction_id,
    t.risk_score
FROM 
    risk_assessments ra
JOIN 
    transactions t ON ra.event_id = t.event_id
WHERE 
    ra.risk_level = '高风险'
    AND t.risk_score < 50;	1912282533
SELECT 
    transaction_type,
    COUNT(*) AS transaction_count
FROM 
    transactions
WHERE 
    status = 'success'
GROUP BY 
    transaction_type
ORDER BY 
    transaction_count DESC
LIMIT 1;	966675168
SELECT t.transaction_id, t.customer_id, t.transaction_type, t.amount, 
       t.transaction_date, t.status, t.risk_score,
       re.event_id, re.event_type, re.event_description, re.status as event_status
FROM transactions t
JOIN risk_events re ON t.event_id = re.event_id
WHERE t.status = 'FAILED' AND re.status = 'RESOLVED';	1657330121
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status AS transaction_status,
    t.risk_score,
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.credit_score,
    c.risk_level AS customer_risk_level
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    t.status = '处理中';	2427884877
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.risk_score,
    e.event_id,
    e.event_type,
    e.event_description,
    e.occurrence_time,
    e.severity,
    e.status AS event_status,
    e.reporter,
    e.created_at
FROM 
    transactions t
JOIN 
    risk_events e ON t.event_id = e.event_id
WHERE 
    t.amount > 1000
ORDER BY 
    t.transaction_date DESC;	2050953540
SELECT 
    t.transaction_id,
    t.customer_id,
    c.customer_name,
    t.amount,
    t.transaction_date,
    t.risk_score,
    e.event_id,
    e.event_type,
    e.event_description,
    e.occurrence_time,
    e.severity,
    e.status
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
LEFT JOIN 
    risk_events e ON t.event_id = e.event_id
WHERE 
    t.amount > 100000
    AND c.risk_level = '高'
    AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY 
    t.transaction_date DESC;	2088100618
SELECT * 
FROM risk_assessments 
WHERE mitigation_plan IS NOT NULL AND mitigation_plan != '';	4242999593
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.risk_score,
    c.customer_id,
    c.customer_name,
    c.risk_level
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    c.risk_level = '高'
ORDER BY 
    t.transaction_date DESC;	4243946175
SELECT 
    rml.actual_value,
    ri.indicator_name,
    ri.threshold_value
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id
WHERE 
    rml.actual_value < ri.threshold_value
LIMIT 100;	1679294343
SELECT 
    rr.report_id,
    rr.report_type,
    rr.report_date,
    rr.approval_status,
    re.event_type,
    re.status AS event_status
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.approval_status = 'REJECTED';	1824329950
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE EXTRACT(YEAR FROM c.registration_date) = 2021
  AND c.credit_score > 700
  AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
  AND t.transaction_date <= CURRENT_DATE;	888703769
SELECT 
    a.alert_id,
    a.alert_type,
    a.alert_content,
    a.alert_level,
    a.alert_time,
    a.status AS alert_status,
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status AS event_status,
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status AS transaction_status,
    t.risk_score
FROM 
    alerts a
JOIN 
    risk_events re ON a.event_id = re.event_id
LEFT JOIN 
    transactions t ON re.event_id = t.event_id
WHERE 
    a.assigned_to = '陈强'
ORDER BY 
    a.alert_time DESC;	411280576
SELECT * 
FROM risk_reports 
WHERE report_content LIKE '%合规%';	452369014
SELECT 
    DATE_TRUNC('month', re.occurrence_time) AS month,
    COUNT(DISTINCT re.event_id) AS event_count,
    AVG(re.severity) AS avg_severity,
    COUNT(DISTINCT a.alert_id) AS alert_count
FROM 
    risk_events re
LEFT JOIN 
    alerts a ON re.event_id = a.event_id
GROUP BY 
    DATE_TRUNC('month', re.occurrence_time)
ORDER BY 
    month;	865900816
SELECT indicator_name, threshold_value 
FROM risk_indicators;	92424187
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    rml.monitoring_date,
    rml.actual_value,
    ri.threshold_value,
    rml.is_exceeding_threshold,
    rml.notes
FROM 
    risk_indicators ri
LEFT JOIN (
    SELECT 
        indicator_id,
        MAX(monitoring_date) as latest_date
    FROM 
        risk_monitoring_logs
    GROUP BY 
        indicator_id
) latest ON ri.indicator_id = latest.indicator_id
LEFT JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id AND latest.latest_date = rml.monitoring_date
ORDER BY 
    ri.indicator_name;	2998508313
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.risk_score,
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.credit_score,
    c.risk_level,
    c.registration_date
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
WHERE 
    t.amount > 100000
ORDER BY 
    t.amount DESC;	1024168357
SELECT * 
FROM risk_reports 
WHERE approval_status = '已批准';	2422412797
SELECT 
    transaction_type,
    AVG(risk_score) AS average_risk_score
FROM 
    transactions
GROUP BY 
    transaction_type;	3918852865
WITH event_status_times AS (
    SELECT 
        re.event_type,
        re.status,
        COUNT(*) AS event_count,
        AVG(
            CASE 
                WHEN re.status = 'UNPROCESSED' THEN 
                    EXTRACT(EPOCH FROM (COALESCE(a.alert_time, re.created_at) - re.created_at))
                WHEN re.status = 'IN_PROGRESS' THEN 
                    EXTRACT(EPOCH FROM (COALESCE(ra.assessment_date, CURRENT_TIMESTAMP) - re.created_at))
                WHEN re.status = 'RESOLVED' THEN 
                    EXTRACT(EPOCH FROM (COALESCE(ra.assessment_date, re.created_at) - re.created_at))
            END
        )/3600 AS avg_duration_hours
    FROM 
        risk_events re
    LEFT JOIN 
        alerts a ON re.event_id = a.event_id
    LEFT JOIN 
        risk_assessments ra ON re.event_id = ra.event_id
    GROUP BY 
        re.event_type, re.status
),
overall_processing_time AS (
    SELECT 
        event_type,
        AVG(
            CASE 
                WHEN status = 'RESOLVED' THEN 
                    EXTRACT(EPOCH FROM (COALESCE(ra.assessment_date, created_at) - created_at))
            END
        )/3600 AS avg_total_processing_hours
    FROM 
        risk_events re
    LEFT JOIN 
        risk_assessments ra ON re.event_id = ra.event_id
    WHERE 
        status = 'RESOLVED'
    GROUP BY 
        event_type
)

SELECT 
    est.event_type,
    est.status,
    est.event_count,
    est.avg_duration_hours AS avg_stage_duration_hours,
    opt.avg_total_processing_hours
FROM 
    event_status_times est
LEFT JOIN 
    overall_processing_time opt ON est.event_type = opt.event_type
ORDER BY 
    est.event_type, 
    CASE est.status
        WHEN 'UNPROCESSED' THEN 1
        WHEN 'IN_PROGRESS' THEN 2
        WHEN 'RESOLVED' THEN 3
        ELSE 4
    END;	2671276850
SELECT 
    a.alert_type,
    COUNT(*) AS alert_count,
    AVG(EXTRACT(EPOCH FROM (al.audit_time - a.alert_time))/60) AS avg_processing_time_minutes
FROM 
    alerts a
JOIN 
    audit_logs al ON a.alert_id = al.alert_id
WHERE 
    al.audit_result IS NOT NULL
GROUP BY 
    a.alert_type
ORDER BY 
    alert_count DESC;	3873676880
SELECT 
    re.event_type,
    AVG(EXTRACT(EPOCH FROM (a.alert_time - re.created_at))/3600) AS avg_processing_time_hours
FROM 
    risk_events re
JOIN 
    alerts a ON re.event_id = a.event_id
WHERE 
    re.status = '已解决'
GROUP BY 
    re.event_type
ORDER BY 
    avg_processing_time_hours DESC;	3957865555
SELECT 
    a.alert_id,
    a.rule_id,
    a.alert_type,
    a.alert_content,
    a.alert_level,
    a.alert_time,
    a.status AS alert_status,
    a.assigned_to,
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status AS event_status,
    re.reporter,
    re.created_at
FROM 
    alerts a
JOIN 
    risk_events re ON a.event_id = re.event_id
WHERE 
    a.rule_id IS NOT NULL
ORDER BY 
    a.alert_time DESC;	4127521896
SELECT 
    c.customer_name,
    COUNT(DISTINCT t.transaction_id) AS high_risk_transaction_count,
    COUNT(DISTINCT a.alert_id) AS high_level_alert_count
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
JOIN 
    alerts a ON t.event_id = a.event_id
WHERE 
    t.risk_score > 80
    AND EXTRACT(YEAR FROM t.transaction_date) = 2023
    AND a.alert_level = '高级'
GROUP BY 
    c.customer_name
HAVING 
    COUNT(DISTINCT t.transaction_id) > 0
    AND COUNT(DISTINCT a.alert_id) > 0;	4089186720
SELECT 
    re.event_id,
    re.event_type,
    re.severity,
    ra.risk_level,
    ra.impact_score,
    ra.probability_score
FROM 
    risk_events re
LEFT JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
ORDER BY 
    re.severity DESC;	907497664
SELECT t.*
FROM transactions t
JOIN risk_events re ON t.event_id = re.event_id
WHERE re.event_id = '[特定风险事件ID]';	4046233588
SELECT customer_type, COUNT(*) as customer_count
FROM customers
GROUP BY customer_type;	950586637
SELECT 
    ra.assessment_id,
    ra.assessor,
    ra.assessment_date,
    ra.risk_level,
    ra.impact_score,
    ra.probability_score,
    ra.mitigation_plan,
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    re.reporter,
    re.created_at
FROM 
    risk_assessments ra
JOIN 
    risk_events re ON ra.event_id = re.event_id;	1374953478
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE c.risk_level = 'high'
AND NOT EXISTS (
    SELECT 1
    FROM transactions t
    WHERE t.customer_id = c.customer_id
    AND t.transaction_date >= CURRENT_DATE - INTERVAL '30 days'
);	3381418272
SELECT 
    c.customer_name,
    c.risk_level,
    t.transaction_date AS last_transaction_date,
    t.amount,
    t.risk_score
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    c.risk_level = 'High'
    AND t.transaction_date = (
        SELECT MAX(transaction_date)
        FROM transactions
        WHERE customer_id = c.customer_id
    )
ORDER BY 
    t.transaction_date DESC;	2179442925
SELECT 
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = '成功' THEN 1 ELSE 0 END) AS successful_transactions,
    ROUND(SUM(CASE WHEN status = '成功' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate_percentage
FROM 
    transactions
GROUP BY 
    transaction_type
ORDER BY 
    transaction_type;	1859945760
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    ra.risk_level,
    ra.mitigation_plan,
    ra.assessor AS responsible_person
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    ra.risk_level = '高';	2798341435
SELECT customer_id, customer_name, credit_score, risk_level
FROM customers
WHERE risk_level = '高' AND credit_score < 700;	2480313897
SELECT *
FROM customers
WHERE risk_level = '高' AND credit_score < 600;	4249746696
SELECT 
    c.customer_id,
    c.customer_name,
    c.risk_level,
    SUM(t.amount) AS total_transaction_amount
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.status = 'success'
GROUP BY 
    c.customer_id, c.customer_name, c.risk_level
ORDER BY 
    c.customer_id;	3634061359
SELECT 
    rr.report_id,
    rr.report_type,
    rr.report_date,
    rr.report_content,
    rr.author,
    rr.approval_status,
    rr.approved_by,
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status AS event_status,
    re.reporter,
    re.created_at AS event_created_at
FROM 
    risk_reports rr
JOIN 
    risk_events re ON rr.event_id = re.event_id
WHERE 
    rr.approval_status = 'approved';	1094205818
SELECT author, COUNT(*) as report_count
FROM risk_reports
GROUP BY author
ORDER BY report_count DESC
LIMIT 1;	4008892599
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    re.reporter,
    re.created_at
FROM 
    risk_events re
WHERE 
    re.status != 'processed' OR re.status IS NULL
ORDER BY 
    re.occurrence_time DESC;	1522060162
SELECT customer_id, customer_name, last_update_date
FROM customers
WHERE registration_date > '2021-12-31'
ORDER BY last_update_date DESC;	2054103027
SELECT 
    r.report_id,
    r.report_type,
    r.report_date,
    r.report_content,
    r.author,
    r.approval_status,
    e.event_id,
    e.event_type,
    e.event_description,
    e.occurrence_time,
    e.severity,
    e.status,
    e.reporter,
    e.created_at
FROM 
    risk_reports r
JOIN 
    risk_events e ON r.event_id = e.event_id
WHERE 
    r.approved_by = '高志远';	3283769605
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    ri.threshold_value,
    rml.actual_value,
    rml.monitoring_date AS last_update_time
FROM 
    risk_indicators ri
LEFT JOIN 
    risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id
WHERE 
    rml.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = ri.indicator_id)
ORDER BY 
    ri.indicator_name;	747719750
SELECT 
    rml.log_id,
    rml.indicator_id,
    rml.monitoring_date,
    rml.actual_value,
    rml.is_exceeding_threshold,
    rml.notes,
    ri.indicator_name,
    ri.indicator_description,
    ri.measurement_unit,
    ri.threshold_value,
    ri.data_source,
    ri.update_frequency
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id;	334580003
SELECT 
    AVG(impact_score) AS avg_impact_score,
    AVG(probability_score) AS avg_probability_score
FROM 
    risk_assessments;	388467912
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    ra.assessment_id,
    ra.assessor,
    ra.assessment_date,
    ra.risk_level,
    ra.impact_score,
    ra.probability_score,
    ra.mitigation_plan
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    ra.assessor IS NOT NULL;	3589660339
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(t.amount) AS total_refund_amount
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.transaction_type = '退款'
GROUP BY 
    c.customer_id, c.customer_name
ORDER BY 
    total_refund_amount DESC;	1785182803
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    ri.indicator_description,
    ri.measurement_unit,
    ri.threshold_value,
    rml.monitoring_date AS latest_monitoring_date,
    rml.actual_value,
    rml.is_exceeding_threshold,
    rml.notes
FROM 
    risk_indicators ri
LEFT JOIN (
    SELECT 
        indicator_id,
        monitoring_date,
        actual_value,
        is_exceeding_threshold,
        notes,
        ROW_NUMBER() OVER (PARTITION BY indicator_id ORDER BY monitoring_date DESC) AS rn
    FROM 
        risk_monitoring_logs
) rml ON ri.indicator_id = rml.indicator_id AND rml.rn = 1
ORDER BY 
    ri.indicator_name;	3949045999
SELECT 
    re.event_type AS risk_type,
    AVG(EXTRACT(EPOCH FROM (re.created_at - ra.assessment_date))/3600) AS avg_mitigation_hours
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    re.created_at > ra.assessment_date
GROUP BY 
    re.event_type
ORDER BY 
    avg_mitigation_hours DESC;	1365503712
SELECT 
    event_type AS risk_type,
    COUNT(*) AS event_count
FROM 
    risk_events
GROUP BY 
    event_type
ORDER BY 
    event_count DESC;	454781039
SELECT 
    ra.assessment_id,
    ra.risk_level,
    ra.impact_score,
    ra.probability_score,
    ra.mitigation_plan,
    ra.assessor,
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status
FROM 
    risk_assessments ra
JOIN 
    risk_events re ON ra.event_id = re.event_id
ORDER BY 
    ra.assessment_date DESC;	312146930
SELECT 
    rml.log_id,
    rml.indicator_id,
    ri.indicator_name,
    rml.monitoring_date,
    ri.threshold_value,
    rml.actual_value,
    rml.is_exceeding_threshold,
    rml.notes
FROM 
    risk_monitoring_logs rml
JOIN 
    risk_indicators ri ON rml.indicator_id = ri.indicator_id
WHERE 
    rml.is_exceeding_threshold = true;

SELECT 
    COUNT(*) AS total_exceeded_records
FROM 
    risk_monitoring_logs
WHERE 
    is_exceeding_threshold = true;	3050678212
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    ra.risk_level AS assessment_risk_level,
    ra.impact_score,
    ra.probability_score,
    ra.mitigation_plan
FROM 
    risk_events re
LEFT JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
ORDER BY 
    re.event_id;	2500244814
SELECT 
    r.report_id,
    r.report_type,
    r.report_date,
    r.report_content,
    r.author,
    r.approval_status,
    r.approved_by,
    r.event_id
FROM 
    risk_reports r
WHERE 
    r.approval_status = 'approved';	2753692877
SELECT c.customer_id, c.customer_name, c.credit_score, c.risk_level
FROM customers c
WHERE c.risk_level = '高' 
AND c.credit_score > (SELECT AVG(credit_score) FROM customers);	2701292510
SELECT alert_content, assigned_to
FROM alerts;	3788454929
SELECT 
    re.event_description,
    re.severity,
    re.created_at,
    al.alert_time AS resolution_time,
    (al.alert_time - re.created_at) AS resolution_duration
FROM 
    risk_events re
JOIN 
    alerts al ON re.event_id = al.event_id
WHERE 
    re.status = 'Resolved'
    AND al.status = 'Closed'
ORDER BY 
    resolution_duration DESC
LIMIT 10;	1494274200
SELECT rc.rule_id, rc.rule_name, rc.rule_description, rc.rule_type, 
       ri.indicator_id, ri.indicator_name, ri.indicator_description
FROM rule_configurations rc
JOIN risk_indicators ri ON rc.indicator_id = ri.indicator_id
WHERE rc.is_active = true;	2741655674
SELECT risk_level, COUNT(*) AS customer_count
FROM customers
GROUP BY risk_level
ORDER BY customer_count DESC;	4006191467
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    re.reporter,
    re.created_at
FROM 
    risk_events re
WHERE 
    re.status != 'processed' OR re.status IS NULL;	1366443289
SELECT event_id, event_type, created_at
FROM risk_events
WHERE severity >= 3
ORDER BY created_at DESC;	2713864982
SELECT 
    r.mitigation_plan,
    r.assessor
FROM 
    risk_assessments r;	4176420377
SELECT 
    a.alert_id,
    a.alert_type,
    a.alert_level,
    a.alert_time,
    re.event_description,
    al.audit_comments AS latest_audit_comment,
    al.audit_time AS latest_audit_time
FROM 
    alerts a
JOIN 
    risk_events re ON a.event_id = re.event_id
LEFT JOIN (
    SELECT 
        alert_id,
        audit_comments,
        audit_time,
        ROW_NUMBER() OVER (PARTITION BY alert_id ORDER BY audit_time DESC) as rn
    FROM 
        audit_logs
) al ON a.alert_id = al.alert_id AND al.rn = 1
WHERE 
    a.status != 'RESOLVED' 
    AND a.alert_level = 'HIGH'
ORDER BY 
    a.alert_time DESC;	2609744326
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    re.occurrence_time,
    re.severity,
    re.status,
    ra.risk_level,
    ra.mitigation_plan
FROM 
    risk_events re
JOIN 
    risk_assessments ra ON re.event_id = ra.event_id
WHERE 
    ra.risk_level = '高';	1472140605
SELECT DISTINCT c.customer_id, c.customer_name, c.risk_level
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE c.risk_level = '高'
  AND t.amount > 100000
  AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	4016844576
SELECT * 
FROM risk_assessments 
WHERE impact_score > 8 AND risk_level = '高';	1206095116
SELECT 
    re.event_id,
    re.event_type,
    re.event_description,
    rr.report_type,
    rr.report_content
FROM 
    risk_events re
LEFT JOIN 
    risk_reports rr ON re.event_id = rr.event_id;	747204718
SELECT 
    fi.institution_name,
    rr.report_type,
    rr.approval_status,
    npl.npl_ratio
FROM 
    financial_institution_info fi
JOIN 
    regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE 
    rr.report_type = '季度报告'
    AND rr.approval_status = '需修改'
    AND npl.npl_ratio > 2
    AND rr.report_date BETWEEN '2023-07-01' AND '2023-09-30'
    AND npl.report_date BETWEEN '2023-07-01' AND '2023-09-30';	380031248
SELECT r.report_id, r.institution_id, f.institution_name, r.report_date, r.report_type, 
       r.submission_date, r.approval_status, r.comments
FROM regulatory_reports r
JOIN financial_institution_info f ON r.institution_id = f.institution_id
WHERE r.submission_date = '2023-11-01';	796615861
SELECT 
    fi.institution_name,
    car.total_car,
    npl.npl_ratio
FROM 
    financial_institution_info fi
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE 
    car.report_date = '2023-06-30'
    AND npl.report_date = '2023-06-30'
    AND car.total_car < 12
    AND npl.npl_ratio > 2;	226307394
SELECT 
    fi.institution_name,
    (re.market_risk_exposure / re.total_risk_exposure) * 100 AS market_risk_ratio
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
ORDER BY 
    market_risk_ratio DESC
LIMIT 1;	2186232166
SELECT DISTINCT fii.institution_name, fii.registered_capital
FROM financial_institution_info fii
JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id
WHERE rr.report_type = '季度报告'
  AND rr.approval_status = '需修改'
  AND rr.report_date BETWEEN '2023-07-01' AND '2023-09-30'
  AND fii.registered_capital > 50000000
ORDER BY fii.registered_capital DESC;	3832687129
SELECT 
    fi.institution_name,
    (car.risk_weighted_assets / bs.total_assets) AS risk_weighted_asset_density
FROM 
    financial_institution_info fi
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id
JOIN 
    balance_sheet bs ON fi.institution_id = bs.institution_id 
    AND car.report_date = bs.report_date
ORDER BY 
    risk_weighted_asset_density DESC
LIMIT 1;	3593789396
SELECT 
    liquidity_coverage_ratio,
    net_stable_funding_ratio,
    report_date,
    institution_id
FROM 
    liquidity_ratio
ORDER BY 
    report_date DESC, 
    institution_id
LIMIT 100;	3734281326
SELECT DISTINCT fi.institution_name
FROM compliance_records cr
JOIN financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE cr.record_date >= '2023-12-01' 
  AND cr.record_date <= '2023-12-31'
  AND cr.status != 'Resolved'
  AND (cr.resolution_date IS NULL OR cr.resolution_date > CURRENT_DATE);	2976622725
SELECT 
    fi.institution_name,
    SUM(bs.loans_and_advances) AS total_loans,
    SUM(bs.deposits) AS total_deposits
FROM 
    balance_sheet bs
JOIN 
    financial_institution_info fi ON bs.institution_id = fi.institution_id
WHERE 
    EXTRACT(YEAR FROM bs.report_date) = 2024
GROUP BY 
    fi.institution_name
ORDER BY 
    fi.institution_name;	3196242817
SELECT * 
FROM balance_sheet 
WHERE report_date = '2039-06-08';	1889616376
SELECT COUNT(DISTINCT n.institution_id) AS high_npl_institutions_count
FROM non_performing_loans n
WHERE n.npl_ratio > 3;	453935379
SELECT 
    i.institution_name,
    s.net_interest_income,
    s.non_interest_income
FROM 
    income_statement s
JOIN 
    financial_institution_info i ON s.institution_id = i.institution_id
WHERE 
    s.report_date = '2023-03-01'
ORDER BY 
    i.institution_name;	44191459
SELECT 
    institution_id,
    report_date,
    npl_amount,
    total_loans,
    (npl_amount / total_loans) * 100 AS npl_percentage
FROM 
    non_performing_loans
ORDER BY 
    report_date DESC, institution_id;	584013962
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_type = '季度报告'
  AND rr.approval_status = '需修改'
  AND EXTRACT(YEAR FROM rr.report_date) = 2023
  AND EXTRACT(YEAR FROM npl.report_date) = 2023
  AND npl.npl_ratio > 1;	2733428482
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE rr.report_date = '2023-10-01'
  AND rr.report_type = '半年度报告'
  AND rr.approval_status = '待审核';	951459633
SELECT 
    institution_name, 
    registered_capital
FROM 
    financial_institution_info
WHERE 
    institution_type != 'Bank'
ORDER BY 
    registered_capital DESC
LIMIT 5;	1829456676
WITH top_500_institutions AS (
    SELECT 
        b.institution_id,
        fi.institution_name,
        b.total_assets,
        RANK() OVER (ORDER BY b.total_assets DESC) AS asset_rank
    FROM 
        balance_sheet b
    JOIN 
        financial_institution_info fi ON b.institution_id = fi.institution_id
    WHERE 
        b.report_date = (SELECT MAX(report_date) FROM balance_sheet)
    ORDER BY 
        b.total_assets DESC
    LIMIT 500
)

SELECT 
    COUNT(*) AS compliant_institutions_count
FROM 
    top_500_institutions t
JOIN 
    non_performing_loans npl ON t.institution_id = npl.institution_id
WHERE 
    npl.npl_ratio < 1 
    AND npl.provision_coverage_ratio > 200
    AND npl.report_date = (SELECT MAX(report_date) FROM non_performing_loans);	1953695337
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE car.report_date = '2023-12-01'
  AND car.core_tier_1_ratio < 10
  AND rr.report_date = '2023-12-01'
  AND rr.approval_status = '待审核';	1414930652
	364214965
SELECT 
    r.report_id,
    r.institution_id,
    f.institution_name,
    r.report_date,
    r.report_type,
    r.submission_date,
    r.approval_status,
    r.comments
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    r.report_date = '2023-07-01'
ORDER BY 
    r.institution_id, r.report_id;	419882166
	3742684421
SELECT cr.*, fi.institution_name
FROM compliance_records cr
JOIN financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE cr.status = '已解决'
AND cr.record_date >= '2023-01-01' 
AND cr.record_date <= '2023-12-31'
ORDER BY cr.record_date DESC;	2448874069
SELECT report_type, COUNT(*) as submission_count
FROM regulatory_reports
WHERE report_date BETWEEN '2023-07-01' AND '2023-09-30'
GROUP BY report_type
ORDER BY submission_count DESC
LIMIT 1;	3679648301
SELECT 
    tier_1_ratio,
    COUNT(*) AS institution_count
FROM 
    capital_adequacy_ratio
GROUP BY 
    tier_1_ratio
ORDER BY 
    tier_1_ratio;	293590145
SELECT 
    fi.institution_name,
    lr.report_date
FROM 
    liquidity_ratio lr
JOIN 
    financial_institution_info fi ON lr.institution_id = fi.institution_id
WHERE 
    lr.liquidity_coverage_ratio > 100
ORDER BY 
    lr.report_date DESC;	685587392
WITH 
-- 获取过去两年中每家金融机构的资产负债率数据
leverage_ratio_data AS (
    SELECT 
        b.institution_id,
        fi.institution_name,
        b.report_date,
        b.total_liabilities / NULLIF(b.total_assets, 0) AS leverage_ratio
    FROM 
        balance_sheet b
    JOIN 
        financial_institution_info fi ON b.institution_id = fi.institution_id
    WHERE 
        b.report_date >= CURRENT_DATE - INTERVAL '2 years'
),

-- 计算每家金融机构资产负债率的波动情况(标准差)
leverage_volatility AS (
    SELECT 
        institution_id,
        institution_name,
        STDDEV(leverage_ratio) AS leverage_volatility,
        COUNT(*) AS num_reports
    FROM 
        leverage_ratio_data
    GROUP BY 
        institution_id, institution_name
    HAVING 
        COUNT(*) > 1  -- 确保有足够的数据点计算波动
),

-- 获取流动性覆盖率数据
lcr_data AS (
    SELECT 
        l.institution_id,
        fi.institution_name,
        l.report_date,
        l.liquidity_coverage_ratio
    FROM 
        liquidity_ratio l
    JOIN 
        financial_institution_info fi ON l.institution_id = fi.institution_id
    WHERE 
        l.report_date >= CURRENT_DATE - INTERVAL '2 years'
)

-- 主查询:找出资产负债率波动最大的5家机构及其LCR趋势
SELECT 
    lv.institution_id,
    lv.institution_name,
    lv.leverage_volatility,
    lv.num_reports,
    JSON_AGG(
        JSON_BUILD_OBJECT(
            'report_date', lcr.report_date,
            'liquidity_coverage_ratio', lcr.liquidity_coverage_ratio
        ) ORDER BY lcr.report_date
    ) AS lcr_trend
FROM 
    leverage_volatility lv
JOIN 
    lcr_data lcr ON lv.institution_id = lcr.institution_id
GROUP BY 
    lv.institution_id, lv.institution_name, lv.leverage_volatility, lv.num_reports
ORDER BY 
    lv.leverage_volatility DESC
LIMIT 5;	727742801
SELECT 
    cr.record_id,
    cr.institution_id,
    fi.institution_name,
    cr.record_date,
    cr.compliance_type,
    cr.description,
    cr.severity,
    cr.status,
    cr.resolution_date
FROM 
    compliance_records cr
JOIN 
    financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE 
    cr.record_date BETWEEN '2023-03-01' AND '2023-03-31'
ORDER BY 
    cr.record_date, cr.institution_id;	3429671168
SELECT 
    fi.institution_name,
    cr.record_date,
    cr.compliance_type,
    cr.description,
    cr.severity,
    cr.status,
    cr.resolution_date
FROM 
    compliance_records cr
JOIN 
    financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE 
    cr.record_date >= '2024-01-01' 
    AND cr.record_date <= '2024-12-31'
ORDER BY 
    cr.record_date, fi.institution_name;	3200376501
SELECT DISTINCT report_type
FROM regulatory_reports
WHERE report_date = '2023-10-01';	1891907399
SELECT cr.*, fi.institution_name
FROM compliance_records cr
JOIN financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE cr.severity = '中'
AND cr.record_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY cr.record_date;	11596427
SELECT 
    cr.record_id,
    cr.institution_id,
    fi.institution_name,
    cr.record_date,
    cr.compliance_type,
    cr.description,
    cr.severity,
    cr.status,
    cr.resolution_date
FROM 
    compliance_records cr
JOIN 
    financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE 
    cr.record_date = '2023-10-01'
ORDER BY 
    cr.institution_id, cr.record_id;	3129849565
WITH industry_averages AS (
    SELECT 
        AVG(liquidity_coverage_ratio) AS avg_lcr,
        AVG(net_stable_funding_ratio) AS avg_nsfr,
        AVG(loan_to_deposit_ratio) AS avg_ldr
    FROM liquidity_ratio
),
superior_institutions AS (
    SELECT 
        lr.institution_id,
        fi.institution_name,
        lr.liquidity_coverage_ratio,
        lr.net_stable_funding_ratio,
        lr.loan_to_deposit_ratio
    FROM liquidity_ratio lr
    JOIN financial_institution_info fi ON lr.institution_id = fi.institution_id
    CROSS JOIN industry_averages ia
    WHERE lr.liquidity_coverage_ratio > ia.avg_lcr
      AND lr.net_stable_funding_ratio > ia.avg_nsfr
      AND lr.loan_to_deposit_ratio < ia.avg_ldr  -- 贷存比是越小越好，所以用小于
)

SELECT 
    institution_id,
    institution_name,
    liquidity_coverage_ratio,
    net_stable_funding_ratio,
    loan_to_deposit_ratio
FROM superior_institutions
ORDER BY institution_name;	3154891263
SELECT 
    fi.institution_name,
    rr.report_type,
    rr.submission_date
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date BETWEEN '2023-07-01' AND '2023-09-30'
    AND rr.approval_status = '需修改'
ORDER BY 
    rr.submission_date DESC;	1874414819
WITH 
-- 计算行业资本充足率的25百分位值
industry_car_percentile AS (
    SELECT 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_car) AS car_25th_percentile
    FROM capital_adequacy_ratio
),
-- 计算行业平均不良贷款率
industry_avg_npl AS (
    SELECT 
        AVG(npl_ratio) AS avg_npl_ratio
    FROM non_performing_loans
),
-- 获取资本充足率处于后25%的机构
low_car_institutions AS (
    SELECT 
        car.institution_id,
        fi.institution_name,
        car.total_car,
        npl.npl_ratio
    FROM capital_adequacy_ratio car
    JOIN financial_institution_info fi ON car.institution_id = fi.institution_id
    JOIN non_performing_loans npl ON car.institution_id = npl.institution_id 
        AND car.report_date = npl.report_date
    CROSS JOIN industry_car_percentile
    WHERE car.total_car <= industry_car_percentile.car_25th_percentile
)
-- 筛选出不良贷款率低于行业平均水平的机构
SELECT 
    institution_id,
    institution_name,
    total_car,
    npl_ratio
FROM low_car_institutions
CROSS JOIN industry_avg_npl
WHERE npl_ratio < industry_avg_npl.avg_npl_ratio
ORDER BY npl_ratio ASC;	495816064
SELECT institution_name, institution_type, registered_capital
FROM financial_institution_info;	4161304037
SELECT institution_name, establishment_date, legal_representative
FROM financial_institution_info;	1631317162
SELECT 
    fi.institution_name,
    cr.record_date,
    cr.compliance_type,
    cr.description,
    cr.severity,
    cr.status,
    cr.resolution_date
FROM 
    compliance_records cr
JOIN 
    financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE 
    cr.status = '已解决'
ORDER BY 
    fi.institution_name, cr.record_date;	2784626903
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_date BETWEEN '2023-07-01' AND '2023-07-31'
  AND rr.approval_status = '需修改'
  AND npl.report_date BETWEEN '2023-07-01' AND '2023-07-31'
  AND npl.npl_ratio > 1;	1450759690
SELECT 
    f.institution_name,
    b.loans_and_advances,
    b.deposits,
    (b.loans_and_advances / b.deposits) AS loan_to_deposit_ratio,
    ABS((b.loans_and_advances / b.deposits) - 1) AS ratio_deviation
FROM 
    balance_sheet b
JOIN 
    financial_institution_info f ON b.institution_id = f.institution_id
WHERE 
    b.deposits > 0  -- 避免除以零错误
ORDER BY 
    ratio_deviation ASC
LIMIT 1;	862814083
SELECT fi.institution_id, fi.institution_name, fi.institution_type, fi.license_number
FROM financial_institution_info fi
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE npl.total_loans > 100000000000;	2681992996
SELECT cash_and_equivalents
FROM balance_sheet
WHERE report_date = '2026-04-27';	3797835240
SELECT fi.institution_name, car.core_tier_1_ratio
FROM financial_institution_info fi
JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id
WHERE car.core_tier_1_ratio < 9
ORDER BY car.core_tier_1_ratio ASC;	788537141
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_type = '季度报告'
  AND rr.approval_status = '已拒绝'
  AND EXTRACT(YEAR FROM rr.report_date) = 2023
  AND EXTRACT(YEAR FROM npl.report_date) = 2023
  AND npl.npl_ratio > 2;	2511418954
WITH 
-- 计算风险加权资产占总资产比例最高的10家机构
top_risk_weighted_institutions AS (
    SELECT 
        bs.institution_id,
        fi.institution_name,
        car.risk_weighted_assets / bs.total_assets AS risk_weighted_assets_ratio,
        re.market_risk_exposure,
        PERCENT_RANK() OVER (ORDER BY re.market_risk_exposure) AS market_risk_percentile
    FROM 
        balance_sheet bs
    JOIN 
        capital_adequacy_ratio car ON bs.institution_id = car.institution_id 
                                   AND bs.report_date = car.report_date
    JOIN 
        risk_exposure re ON bs.institution_id = re.institution_id 
                         AND bs.report_date = re.report_date
    JOIN 
        financial_institution_info fi ON bs.institution_id = fi.institution_id
    WHERE 
        bs.total_assets > 0
    ORDER BY 
        risk_weighted_assets_ratio DESC
    LIMIT 10
)

-- 统计其中市场风险暴露在前25%的机构数量
SELECT 
    COUNT(*) AS high_market_risk_count
FROM 
    top_risk_weighted_institutions
WHERE 
    market_risk_percentile >= 0.75;	133973236
-- 无法生成有效的SQL查询，因为数据库结构中缺少关于金融机构分支机构数量的信息
-- 提供的表结构中既没有单独的分支机构表，也没有在金融机构信息表中包含分支机构数量的字段
-- 需要补充分支机构数据才能回答这个问题
SELECT NULL AS result WHERE 1=0;	580723534
SELECT 
    fi.institution_name,
    re.market_risk_exposure,
    re.total_risk_exposure,
    (re.market_risk_exposure / re.total_risk_exposure * 100) AS market_risk_percentage,
    car.core_tier_1_ratio
FROM 
    financial_institution_info fi
JOIN 
    risk_exposure re ON fi.institution_id = re.institution_id
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id
WHERE 
    (re.market_risk_exposure / re.total_risk_exposure * 100) > 20
    AND car.core_tier_1_ratio < 8.5
    AND re.report_date = car.report_date  -- 确保是同期的数据
ORDER BY 
    market_risk_percentage DESC;	627590872
SELECT 
    fi.institution_name,
    car.core_tier_1_ratio,
    car.tier_1_ratio,
    car.total_car
FROM 
    capital_adequacy_ratio car
JOIN 
    financial_institution_info fi ON car.institution_id = fi.institution_id
WHERE 
    car.report_date = '2023-12-01'
    AND car.core_tier_1_ratio < 10
    AND car.total_car < 12;	3208012990
SELECT COUNT(*) AS high_severity_compliance_issues_2023
FROM compliance_records
WHERE severity = '高'
  AND EXTRACT(YEAR FROM record_date) = 2023;	377707744
SELECT 
    fi.institution_name,
    (bs.cash_and_equivalents / bs.total_assets) * 100 AS cash_to_assets_ratio
FROM 
    balance_sheet bs
JOIN 
    financial_institution_info fi ON bs.institution_id = fi.institution_id
ORDER BY 
    cash_to_assets_ratio DESC
LIMIT 1;	2467976254
SELECT 
    fi.institution_name,
    re.market_risk_exposure,
    re.total_risk_exposure,
    (re.market_risk_exposure / re.total_risk_exposure * 100) AS market_risk_percentage
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    (re.market_risk_exposure / re.total_risk_exposure) > 0.4
ORDER BY 
    market_risk_percentage DESC;	416448494
SELECT 
    fi.institution_id,
    fi.institution_name,
    COUNT(rr.report_id) AS total_reports,
    COUNT(DISTINCT rr.report_type) AS distinct_report_types,
    SUM(CASE WHEN rr.approval_status = 'Approved' THEN 1 ELSE 0 END) AS approved_reports,
    ROUND(COUNT(DISTINCT rr.report_type) * 1.0 / COUNT(rr.report_id), 2) AS report_diversity_score
FROM 
    financial_institution_info fi
LEFT JOIN 
    regulatory_reports rr ON fi.institution_id = rr.institution_id
    AND EXTRACT(YEAR FROM rr.report_date) = 2023
GROUP BY 
    fi.institution_id, fi.institution_name
HAVING 
    COUNT(rr.report_id) > 0
ORDER BY 
    total_reports DESC,
    report_diversity_score DESC,
    approved_reports DESC
LIMIT 10;	1582694445
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE EXTRACT(YEAR FROM car.report_date) = 2023
  AND car.core_tier_1_ratio < 8
  AND EXTRACT(YEAR FROM rr.report_date) = 2023
  AND rr.approval_status = '已批准';	3631241992
SELECT 
    fi.institution_name,
    re.operational_risk_exposure,
    re.credit_risk_exposure
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    re.report_date >= '2024-01-01' 
    AND re.report_date <= '2024-01-31'
ORDER BY 
    fi.institution_name;	3632342709
SELECT record_id, institution_id, compliance_type, description, severity, status, resolution_date
FROM compliance_records
WHERE record_date = '2023-04-02';	2274602916
SELECT 
    n.institution_id,
    f.institution_name,
    n.report_date,
    n.npl_ratio,
    LAG(n.npl_ratio) OVER (PARTITION BY n.institution_id ORDER BY n.report_date) AS prev_npl_ratio,
    n.npl_ratio - LAG(n.npl_ratio) OVER (PARTITION BY n.institution_id ORDER BY n.report_date) AS npl_ratio_change
FROM 
    non_performing_loans n
JOIN 
    financial_institution_info f ON n.institution_id = f.institution_id
ORDER BY 
    n.institution_id, 
    n.report_date;	3547022021
SELECT 
    fi.institution_name,
    npl.report_date,
    npl.provision_coverage_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
WHERE 
    npl.provision_coverage_ratio > 150
ORDER BY 
    npl.provision_coverage_ratio DESC;	4106988075
SELECT rpt.transaction_id, rpt.institution_id, fi.institution_name, 
       rpt.transaction_date, rpt.related_party, rpt.transaction_type, 
       rpt.transaction_amount, rpt.approval_status
FROM related_party_transactions rpt
JOIN financial_institution_info fi ON rpt.institution_id = fi.institution_id
WHERE rpt.transaction_date = '2023-12-22'
ORDER BY rpt.transaction_id;	1714782457
SELECT fi.institution_name
FROM financial_institution_info fi
JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE lr.liquidity_coverage_ratio > 110
AND npl.npl_ratio < 1.5;	663454855
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_type = '季度报告'
  AND rr.approval_status = '需修改'
  AND EXTRACT(YEAR FROM rr.report_date) = 2023
  AND npl.npl_ratio > 2
  AND EXTRACT(YEAR FROM npl.report_date) = 2023;	1930062711
SELECT 
    fi.institution_name,
    AVG(is.net_profit / (is.net_interest_income + is.non_interest_income)) AS avg_profit_margin
FROM 
    income_statement is
JOIN 
    financial_institution_info fi ON is.institution_id = fi.institution_id
WHERE 
    is.report_date >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY 
    fi.institution_id, fi.institution_name
ORDER BY 
    avg_profit_margin DESC
LIMIT 5;	166707732
SELECT 
    fi.institution_type,
    AVG(npl.npl_ratio) AS avg_npl_ratio
FROM 
    financial_institution_info fi
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE 
    EXTRACT(YEAR FROM npl.report_date) = 2023
GROUP BY 
    fi.institution_type
ORDER BY 
    avg_npl_ratio DESC;	833967887
WITH latest_risk_exposure AS (
    SELECT 
        institution_id,
        report_date,
        market_risk_exposure,
        LAG(market_risk_exposure) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_market_risk_exposure,
        LAG(report_date) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_report_date
    FROM risk_exposure
    WHERE report_date IN (
        SELECT DISTINCT report_date 
        FROM risk_exposure 
        ORDER BY report_date DESC 
        LIMIT 2
    )
),

risk_growth AS (
    SELECT 
        institution_id,
        (market_risk_exposure - prev_market_risk_exposure) / prev_market_risk_exposure * 100 AS market_risk_growth_percent
    FROM latest_risk_exposure
    WHERE prev_market_risk_exposure IS NOT NULL
    AND prev_market_risk_exposure != 0
),

latest_car AS (
    SELECT 
        institution_id,
        report_date,
        total_car,
        LAG(total_car) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_total_car,
        LAG(report_date) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_report_date
    FROM capital_adequacy_ratio
    WHERE report_date IN (
        SELECT DISTINCT report_date 
        FROM capital_adequacy_ratio
        ORDER BY report_date DESC 
        LIMIT 2
    )
),

car_change AS (
    SELECT 
        institution_id,
        (total_car - prev_total_car) AS car_change_percentage_points
    FROM latest_car
    WHERE prev_total_car IS NOT NULL
)

SELECT COUNT(DISTINCT fii.institution_id) AS institution_count
FROM financial_institution_info fii
JOIN risk_growth rg ON fii.institution_id = rg.institution_id
JOIN car_change cc ON fii.institution_id = cc.institution_id
WHERE rg.market_risk_growth_percent > 50
AND cc.car_change_percentage_points < 1;	4204116228
SELECT 
    fi.institution_name,
    bs.report_date,
    bs.total_assets,
    bs.total_liabilities
FROM 
    balance_sheet bs
JOIN 
    financial_institution_info fi ON bs.institution_id = fi.institution_id
ORDER BY 
    fi.institution_name, bs.report_date;	771560804
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id
WHERE rr.report_date BETWEEN '2023-07-01' AND '2023-07-31'
  AND rr.approval_status = '需修改'
  AND rpt.transaction_date BETWEEN '2023-07-01' AND '2023-07-31'
  AND rpt.transaction_amount > 5000000;	1414769749
SELECT AVG(car.total_car) AS average_capital_adequacy_ratio
FROM financial_institution_info fi
JOIN balance_sheet bs ON fi.institution_id = bs.institution_id
JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id
WHERE bs.total_assets > 1000000000000;	2946947084
SELECT * 
FROM risk_exposure 
WHERE report_date = '2023-10-01';	68375114
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE rpt.transaction_date = '2023-06-01'
  AND rpt.transaction_amount > 5000000
  AND rr.approval_status = '已批准'
  AND rr.report_date <= '2023-06-01'
  AND (rr.report_date = (
      SELECT MAX(report_date) 
      FROM regulatory_reports 
      WHERE institution_id = fi.institution_id 
        AND report_date <= '2023-06-01'
  ));	1086344523
SELECT 
    bs.institution_id,
    fi.institution_name,
    bs.report_date,
    bs.total_assets,
    car.total_car,
    (bs.total_assets / NULLIF(car.total_car, 0)) AS assets_to_car_ratio
FROM 
    balance_sheet bs
JOIN 
    capital_adequacy_ratio car ON bs.institution_id = car.institution_id AND bs.report_date = car.report_date
JOIN 
    financial_institution_info fi ON bs.institution_id = fi.institution_id
ORDER BY 
    bs.total_assets DESC, car.total_car DESC
LIMIT 100;	1266365033
SELECT 
    fi.institution_name,
    COUNT(CASE WHEN rpt.approval_status != 'Approved' THEN 1 END) AS rejected_count,
    COUNT(*) AS total_count,
    (COUNT(CASE WHEN rpt.approval_status != 'Approved' THEN 1 END) * 100.0 / COUNT(*)) AS rejection_percentage
FROM 
    financial_institution_info fi
JOIN 
    related_party_transactions rpt ON fi.institution_id = rpt.institution_id
WHERE 
    EXTRACT(YEAR FROM rpt.transaction_date) = 2023
GROUP BY 
    fi.institution_name
HAVING 
    (COUNT(CASE WHEN rpt.approval_status != 'Approved' THEN 1 END) * 100.0 / COUNT(*)) > 20
ORDER BY 
    rejection_percentage DESC;	152560977
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_date = '2023-07-01'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '需修改'
  AND npl.report_date = '2023-07-01'
  AND npl.npl_ratio > 2;	3829846580
SELECT 
    fi.institution_name,
    rr.report_date,
    rr.approval_status,
    cr.record_date,
    cr.compliance_type,
    cr.severity,
    cr.status
FROM 
    financial_institution_info fi
LEFT JOIN 
    regulatory_reports rr ON fi.institution_id = rr.institution_id
    AND rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
LEFT JOIN 
    compliance_records cr ON fi.institution_id = cr.institution_id
    AND cr.record_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY 
    fi.institution_name,
    rr.report_date,
    cr.record_date;	3809349460
SELECT DISTINCT fii.institution_name
FROM financial_institution_info fii
JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id
WHERE rr.report_date = '2023-10-01'
  AND rr.report_type = '半年度报告'
  AND npl.report_date = '2023-10-01'
  AND npl.npl_ratio > 2;	3887529815
SELECT 
    fi.institution_name,
    lr.liquidity_coverage_ratio,
    lr.net_stable_funding_ratio
FROM 
    financial_institution_info fi
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id
WHERE 
    lr.report_date = '2023-05-01'
ORDER BY 
    fi.institution_name;	1095324516
SELECT 
    fi.institution_name,
    SUM(is.net_interest_income) AS total_non_interest_income
FROM 
    income_statement is
JOIN 
    financial_institution_info fi ON is.institution_id = fi.institution_id
WHERE 
    is.report_date = '2023-03-01'
GROUP BY 
    fi.institution_name;	2608079409
SELECT 
    fi.institution_name,
    re.report_date,
    re.credit_risk_exposure,
    re.market_risk_exposure,
    re.operational_risk_exposure,
    re.total_risk_exposure
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    re.report_date = '2023-02-01'
ORDER BY 
    fi.institution_name;	1384996686
SELECT COUNT(*) 
FROM related_party_transactions
WHERE transaction_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND transaction_amount > 500000000
  AND transaction_type = '资产转移';	2903384914
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id
WHERE rr.report_date = '2023-08-01'
  AND rr.approval_status = '需修改'
  AND rpt.transaction_amount > 5000000
  AND rpt.transaction_date <= '2023-08-01';	1640671061
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN income_statement is ON fi.institution_id = is.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '已拒绝'
  AND is.report_date BETWEEN '2023-01-01' AND '2023-03-31'
  AND is.net_profit > 10000000;	3904574419
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE rr.report_date = '2023-07-01'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '需要修改';	493525183
SELECT 
    fi.institution_name,
    cr.record_date,
    cr.compliance_type,
    cr.description,
    cr.severity,
    cr.status,
    cr.resolution_date
FROM 
    compliance_records cr
JOIN 
    financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE 
    cr.compliance_type = '内控管理'
ORDER BY 
    fi.institution_name, cr.record_date;	3146074594
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_type = '半年度报告'
  AND rr.approval_status = '待审核'
  AND EXTRACT(YEAR FROM rr.report_date) = 2023
  AND EXTRACT(MONTH FROM rr.report_date) = 10
  AND npl.npl_ratio > 1
  AND EXTRACT(YEAR FROM npl.report_date) = 2023
  AND EXTRACT(MONTH FROM npl.report_date) = 10;	2337714646
SELECT 
    fi.institution_type,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl.npl_ratio) AS median_npl_ratio
FROM 
    financial_institution_info fi
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
GROUP BY 
    fi.institution_type
ORDER BY 
    median_npl_ratio DESC;	2791588181
SELECT *
FROM capital_adequacy_ratio
WHERE core_tier_1_ratio < 8;	833263523
SELECT DISTINCT fii.institution_name
FROM financial_institution_info fii
JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id
WHERE rr.report_type = '半年度报告'
  AND rr.approval_status = '待审核'
  AND EXTRACT(YEAR FROM rr.report_date) = 2023
  AND fii.registered_capital > 50000000;	3179741002
SELECT 
    fi.institution_name,
    rpt.transaction_amount,
    rpt.approval_status
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fi ON rpt.institution_id = fi.institution_id
WHERE 
    rpt.transaction_date = '2023-06-01'
    AND rpt.transaction_amount > 5000000
    AND rpt.approval_status = '待审批';	2065261887
WITH industry_averages AS (
    SELECT 
        AVG(lr.loan_to_deposit_ratio) AS avg_loan_to_deposit,
        AVG(lr.liquidity_coverage_ratio) AS avg_liquidity_coverage
    FROM liquidity_ratio lr
),
institution_metrics AS (
    SELECT 
        fii.institution_id,
        fii.institution_name,
        lr.loan_to_deposit_ratio,
        lr.liquidity_coverage_ratio
    FROM financial_institution_info fii
    JOIN liquidity_ratio lr ON fii.institution_id = lr.institution_id
    WHERE lr.report_date = (SELECT MAX(report_date) FROM liquidity_ratio WHERE institution_id = fii.institution_id)
)
SELECT 
    im.institution_id,
    im.institution_name,
    im.loan_to_deposit_ratio,
    ia.avg_loan_to_deposit AS industry_avg_loan_to_deposit,
    im.liquidity_coverage_ratio,
    ia.avg_liquidity_coverage AS industry_avg_liquidity_coverage
FROM institution_metrics im
CROSS JOIN industry_averages ia
WHERE im.loan_to_deposit_ratio > ia.avg_loan_to_deposit
  AND im.liquidity_coverage_ratio < ia.avg_liquidity_coverage
ORDER BY im.loan_to_deposit_ratio DESC;	2360476437
SELECT fi.institution_name, i.net_interest_income
FROM income_statement i
JOIN financial_institution_info fi ON i.institution_id = fi.institution_id
WHERE i.report_date = '2023-04-01'
AND i.net_interest_income > 1000000000;	1635102268
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '需修改'
  AND npl.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND npl.npl_ratio > 1;	890576370
SELECT 
    fi.institution_name,
    re.total_risk_exposure,
    car.core_tier_1_ratio
FROM 
    financial_institution_info fi
JOIN 
    risk_exposure re ON fi.institution_id = re.institution_id
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id
WHERE 
    re.report_date = '2023-10-01'
    AND car.report_date = '2023-10-01'
    AND re.total_risk_exposure > 300000000000  -- 3000亿元，假设单位为元
    AND car.core_tier_1_ratio < 8
ORDER BY 
    re.total_risk_exposure DESC;	1878253672
WITH current_risk AS (
    SELECT 
        institution_id,
        credit_risk_exposure,
        market_risk_exposure,
        market_risk_exposure / NULLIF(credit_risk_exposure, 0) AS current_ratio
    FROM risk_exposure
    WHERE report_date >= CURRENT_DATE - INTERVAL '1 year'
      AND report_date = (SELECT MAX(report_date) FROM risk_exposure WHERE institution_id = risk_exposure.institution_id)
),
past_risk AS (
    SELECT 
        institution_id,
        credit_risk_exposure,
        market_risk_exposure,
        market_risk_exposure / NULLIF(credit_risk_exposure, 0) AS past_ratio
    FROM risk_exposure
    WHERE report_date >= CURRENT_DATE - INTERVAL '2 years'
      AND report_date < CURRENT_DATE - INTERVAL '1 year'
      AND report_date = (SELECT MAX(report_date) FROM risk_exposure 
                         WHERE institution_id = risk_exposure.institution_id 
                         AND report_date < CURRENT_DATE - INTERVAL '1 year')
),
ratio_changes AS (
    SELECT 
        c.institution_id,
        c.current_ratio,
        p.past_ratio,
        ABS(c.current_ratio - p.past_ratio) / NULLIF(p.past_ratio, 0) AS change_percentage
    FROM current_risk c
    JOIN past_risk p ON c.institution_id = p.institution_id
    WHERE p.past_ratio IS NOT NULL AND c.current_ratio IS NOT NULL
)
SELECT COUNT(DISTINCT institution_id) AS significant_change_count
FROM ratio_changes
WHERE change_percentage > 0.3; -- 假设30%的变化为显著变化;	860852233
SELECT 
    fi.institution_name,
    bs.loans_and_advances,
    bs.deposits
FROM 
    balance_sheet bs
JOIN 
    financial_institution_info fi ON bs.institution_id = fi.institution_id
WHERE 
    bs.loans_and_advances > bs.deposits
ORDER BY 
    bs.loans_and_advances DESC;	3387337626
SELECT 
    fi.institution_name,
    rr.report_date,
    rr.approval_status
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '已拒绝'
ORDER BY 
    fi.institution_name,
    rr.report_date;	1310122613
SELECT fi.institution_name
FROM financial_institution_info fi
JOIN income_statement i ON fi.institution_id = i.institution_id
WHERE i.report_date = '2023-04-01'
AND i.non_interest_income > 200000000;	663309404
SELECT 
    fi.institution_name,
    COUNT(rpt.transaction_id) AS transaction_count
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fi ON rpt.institution_id = fi.institution_id
WHERE 
    rpt.transaction_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY 
    fi.institution_name
ORDER BY 
    transaction_count DESC
LIMIT 1;	3052564664
SELECT 
    fi.institution_name,
    (re.credit_risk_exposure / re.total_risk_exposure * 100) AS credit_risk_ratio
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
ORDER BY 
    credit_risk_ratio DESC
LIMIT 1;	3564915606
SELECT DISTINCT fi.institution_id, fi.institution_name
FROM financial_institution_info fi
JOIN risk_exposure re ON fi.institution_id = re.institution_id
WHERE EXTRACT(YEAR FROM re.report_date) = 2023;	197691923
SELECT fi.institution_name, car.risk_weighted_assets
FROM capital_adequacy_ratio car
JOIN financial_institution_info fi ON car.institution_id = fi.institution_id
WHERE car.report_date BETWEEN '2023-11-01' AND '2023-11-30'
AND car.risk_weighted_assets > 120000000000
ORDER BY car.risk_weighted_assets DESC;	4129983532
SELECT 
    severity, 
    AVG(EXTRACT(DAY FROM (resolution_date - record_date))) AS avg_resolution_time_days,
    COUNT(*) AS issue_count
FROM 
    compliance_records
WHERE 
    resolution_date IS NOT NULL
    AND record_date IS NOT NULL
GROUP BY 
    severity
ORDER BY 
    avg_resolution_time_days DESC;	2233736633
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
    non_performing_loans npl ON fi.institution_id = npl.institution_id 
    AND bs.report_date = npl.report_date
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id 
    AND bs.report_date = car.report_date
WHERE 
    fi.institution_id IN (
        SELECT fi2.institution_id
        FROM financial_institution_info fi2
        JOIN balance_sheet bs2 ON fi2.institution_id = bs2.institution_id
        ORDER BY bs2.total_assets DESC
        LIMIT 1000
    );	2186326450
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_date = '2023-07-01'
  AND rr.report_type = '季度报告'
  AND npl.report_date = '2023-07-01'
  AND npl.npl_ratio > 1.5;	2638456489
SELECT DISTINCT fii.institution_name
FROM financial_institution_info fii
JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id
WHERE rr.report_date = '2024-01-01'
  AND rr.report_type = '年度报告'
  AND rr.approval_status = '已批准'
  AND npl.report_date = '2024-01-01'
  AND npl.npl_ratio > 1;	3113756288
SELECT 
    lr.loan_to_deposit_ratio, 
    bs.loans_and_advances, 
    bs.deposits, 
    lr.liquidity_coverage_ratio, 
    lr.net_stable_funding_ratio,
    bs.total_assets,
    bs.total_liabilities,
    bs.total_equity
FROM 
    liquidity_ratio lr
JOIN 
    balance_sheet bs ON lr.institution_id = bs.institution_id 
    AND lr.report_date = bs.report_date
ORDER BY 
    lr.loan_to_deposit_ratio DESC;	1220868379
SELECT 
    fi.institution_name,
    npl.npl_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
WHERE 
    npl.report_date BETWEEN '2023-12-01' AND '2023-12-31'
    AND npl.npl_ratio > 1.5
ORDER BY 
    npl.npl_ratio DESC;	576576905
ERROR: LLM 请求失败	4037291156
SELECT * 
FROM regulatory_reports 
WHERE report_type = '半年度报告';	163054391
SELECT 
    cr.institution_id,
    fi.institution_name,
    cr.record_id,
    cr.compliance_type,
    cr.description,
    cr.severity,
    cr.status,
    cr.record_date,
    cr.resolution_date,
    (cr.resolution_date - cr.record_date) AS resolution_duration
FROM 
    compliance_records cr
JOIN 
    financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE 
    cr.resolution_date IS NOT NULL
ORDER BY 
    resolution_duration DESC
LIMIT 5;	3390154129
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '已拒绝'
  AND npl.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND npl.npl_ratio > 2;	1510688156
SELECT 
    fii.institution_name,
    rr.report_id,
    rr.report_date,
    rr.comments
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fii ON rr.institution_id = fii.institution_id
WHERE 
    rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '已拒绝'
ORDER BY 
    rr.report_date;	776982448
SELECT 
    fi.institution_name,
    lr.loan_to_deposit_ratio
FROM 
    liquidity_ratio lr
JOIN 
    financial_institution_info fi ON lr.institution_id = fi.institution_id
WHERE 
    lr.loan_to_deposit_ratio BETWEEN 60 AND 80
ORDER BY 
    lr.loan_to_deposit_ratio;	3735593182
SELECT 
    fi.institution_name,
    car.core_tier_1_ratio,
    car.total_car,
    (car.core_tier_1_ratio - car.total_car) AS difference
FROM 
    capital_adequacy_ratio car
JOIN 
    financial_institution_info fi ON car.institution_id = fi.institution_id
ORDER BY 
    ABS(car.core_tier_1_ratio - car.total_car) ASC
LIMIT 10;	1403047777
SELECT 
    fi.institution_name,
    bs.total_liabilities,
    fi.registered_capital
FROM 
    financial_institution_info fi
JOIN 
    balance_sheet bs ON fi.institution_id = bs.institution_id
WHERE 
    EXTRACT(YEAR FROM bs.report_date) = 2024
ORDER BY 
    fi.institution_name;	2008864858
SELECT 
    r.institution_id,
    fi.institution_name,
    r.report_date,
    r.credit_risk_exposure,
    n.npl_ratio
FROM 
    risk_exposure r
JOIN 
    non_performing_loans n ON r.institution_id = n.institution_id 
    AND r.report_date = n.report_date
JOIN 
    financial_institution_info fi ON r.institution_id = fi.institution_id
ORDER BY 
    r.institution_id, r.report_date;	4061107202
ERROR: LLM 请求失败	1821132508
SELECT 
    n.institution_id,
    fi.institution_name,
    n.npl_ratio
FROM 
    non_performing_loans n
JOIN 
    financial_institution_info fi ON n.institution_id = fi.institution_id
WHERE 
    n.report_date = '2023-06-01';	1128459706
SELECT fi.institution_name, re.market_risk_exposure
FROM risk_exposure re
JOIN financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE re.report_date = '2023-05-01'
AND re.market_risk_exposure > 20000000000;	4259113020
SELECT 
    fi.institution_name,
    rr.report_date,
    rr.approval_status
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date >= '2024-01-01' AND rr.report_date <= '2024-12-31'
    AND rr.report_type = '年度报告'
    AND rr.approval_status = '已批准'
ORDER BY 
    rr.report_date;	3886257211
SELECT 
    c.report_date,
    c.core_tier_1_ratio,
    c.tier_1_ratio,
    c.total_car,
    c.risk_weighted_assets,
    f.institution_name,
    f.institution_type
FROM 
    capital_adequacy_ratio c
JOIN 
    financial_institution_info f ON c.institution_id = f.institution_id
WHERE 
    c.report_date = '2023-11-01'
ORDER BY 
    f.institution_name;	1168290373
SELECT 
    lr.institution_id,
    fi.institution_name,
    lr.report_date,
    lr.net_stable_funding_ratio,
    car.core_tier_1_ratio
FROM 
    liquidity_ratio lr
JOIN 
    capital_adequacy_ratio car ON lr.institution_id = car.institution_id 
    AND lr.report_date = car.report_date
JOIN
    financial_institution_info fi ON lr.institution_id = fi.institution_id
ORDER BY 
    lr.institution_id, 
    lr.report_date;	2077067574
SELECT 
    fi.institution_name,
    rr.report_date
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND rr.report_type = '年度报告'
    AND rr.approval_status = '已批准'
ORDER BY 
    rr.report_date;	2225198432
SELECT * 
FROM capital_adequacy_ratio 
WHERE report_date = '2023-11-01';	1600202324
SELECT 
    car_id,
    institution_id,
    report_date,
    core_tier_1_ratio,
    tier_1_ratio,
    total_car,
    risk_weighted_assets
FROM 
    capital_adequacy_ratio
WHERE 
    institution_id = 2162
ORDER BY 
    report_date DESC;	1999653381
SELECT 
    fi.institution_name,
    SUM(npl.total_loans) AS total_loans,
    SUM(npl.npl_amount) AS npl_amount
FROM 
    financial_institution_info fi
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE 
    EXTRACT(YEAR FROM npl.report_date) = 2023
GROUP BY 
    fi.institution_name
ORDER BY 
    fi.institution_name;	4241341417
SELECT 
    re.institution_id,
    fi.institution_name,
    re.report_date,
    re.market_risk_exposure / NULLIF(re.total_risk_exposure, 0) AS market_risk_exposure_ratio,
    is.non_interest_income / NULLIF((is.net_interest_income + is.non_interest_income), 0) AS non_interest_income_ratio
FROM 
    risk_exposure re
JOIN 
    income_statement is ON re.institution_id = is.institution_id AND re.report_date = is.report_date
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    re.total_risk_exposure > 0 
    AND (is.net_interest_income + is.non_interest_income) > 0
ORDER BY 
    re.institution_id, re.report_date;	885949604
SELECT 
    fi.institution_name,
    npl.provision_coverage_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
ORDER BY 
    npl.provision_coverage_ratio DESC
LIMIT 1;	2230661366
SELECT 
    fi.institution_name,
    lr.report_date AS liquidity_report_date,
    lr.liquidity_coverage_ratio,
    lr.net_stable_funding_ratio,
    lr.loan_to_deposit_ratio,
    car.report_date AS capital_report_date,
    car.core_tier_1_ratio,
    car.tier_1_ratio,
    car.total_car,
    car.risk_weighted_assets
FROM 
    financial_institution_info fi
LEFT JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id 
    AND EXTRACT(YEAR FROM lr.report_date) = 2023
LEFT JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id 
    AND EXTRACT(YEAR FROM car.report_date) = 2023
WHERE 
    lr.report_date IS NOT NULL 
    OR car.report_date IS NOT NULL
ORDER BY 
    fi.institution_name,
    lr.report_date,
    car.report_date;	2148224764
SELECT 
    fi.institution_name,
    i.operating_expenses
FROM 
    income_statement i
JOIN 
    financial_institution_info fi ON i.institution_id = fi.institution_id
WHERE 
    i.report_date = '2023-04-01'
ORDER BY 
    i.operating_expenses DESC
LIMIT 100;	1163520286
SELECT 
    f.institution_id,
    f.institution_name,
    SUM(i.non_interest_income) AS total_non_interest_income,
    SUM(i.net_profit) AS total_net_profit
FROM 
    financial_institution_info f
JOIN 
    income_statement i ON f.institution_id = i.institution_id
WHERE 
    EXTRACT(YEAR FROM i.report_date) = 2023
GROUP BY 
    f.institution_id, f.institution_name
ORDER BY 
    f.institution_id;	3770945123
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_type = '季度报告'
  AND rr.approval_status = '已拒绝'
  AND EXTRACT(YEAR FROM rr.report_date) = 2023
  AND EXTRACT(YEAR FROM npl.report_date) = 2023
  AND npl.npl_ratio > 2;	3353540268
SELECT 
    fi.institution_name,
    car.core_tier_1_ratio
FROM 
    capital_adequacy_ratio car
JOIN 
    financial_institution_info fi ON car.institution_id = fi.institution_id
WHERE 
    car.report_date = '2023-12-31'
    AND car.core_tier_1_ratio < 9
ORDER BY 
    car.core_tier_1_ratio ASC;	2078748822
SELECT fi.institution_name, lr.liquidity_coverage_ratio
FROM financial_institution_info fi
JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id
WHERE lr.report_date BETWEEN '2023-11-01' AND '2023-11-30'
AND lr.liquidity_coverage_ratio < 110;	953035312
ERROR: LLM 请求失败	2823110481
SELECT institution_name, legal_representative, contact_number
FROM financial_institution_info;	1671662541
SELECT 
    fii.institution_id,
    fii.institution_name,
    COUNT(DISTINCT rpt.related_party) AS num_counterparties
FROM 
    financial_institution_info fii
JOIN 
    related_party_transactions rpt ON fii.institution_id = rpt.institution_id
WHERE 
    EXTRACT(YEAR FROM rpt.transaction_date) = 2023
GROUP BY 
    fii.institution_id, fii.institution_name
ORDER BY 
    num_counterparties DESC
LIMIT 1;	2071522801
SELECT 
    CASE 
        WHEN address LIKE '%上海%' THEN '上海'
        WHEN address LIKE '%深圳%' THEN '深圳'
        WHEN address LIKE '%广州%' THEN '广州'
        WHEN address LIKE '%北京%' THEN '北京'
        ELSE '其他'
    END AS region,
    AVG(l.liquidity_coverage_ratio) AS avg_liquidity_coverage_ratio
FROM 
    financial_institution_info f
JOIN 
    liquidity_ratio l ON f.institution_id = l.institution_id
GROUP BY 
    region
ORDER BY 
    avg_liquidity_coverage_ratio DESC
LIMIT 1;	205800859
SELECT 
    EXTRACT(QUARTER FROM r.report_date) AS quarter,
    AVG(LENGTH(r.comments)) AS avg_comment_length
FROM 
    regulatory_reports r
WHERE 
    EXTRACT(YEAR FROM r.report_date) = 2023
GROUP BY 
    EXTRACT(QUARTER FROM r.report_date)
ORDER BY 
    quarter;	3274370781
SELECT 
    fii.institution_name,
    npl.provision_coverage_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fii ON npl.institution_id = fii.institution_id
ORDER BY 
    npl.provision_coverage_ratio DESC
LIMIT 1;	1230704489
SELECT institution_name, legal_representative, contact_number
FROM financial_institution_info;	1986352436
SELECT 
    fi.institution_name,
    rr.report_date,
    rr.submission_date
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '需修改'
ORDER BY 
    rr.report_date;	171565062
SELECT 
    fi.institution_name,
    car.total_car AS capital_adequacy_ratio,
    npl.npl_ratio AS non_performing_loan_ratio
FROM 
    financial_institution_info fi
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE 
    car.total_car > 12
    AND npl.npl_ratio < 2
    AND car.report_date = npl.report_date
ORDER BY 
    fi.institution_name;	1038814840
SELECT 
    fi.institution_name,
    lr.net_stable_funding_ratio,
    lr.loan_to_deposit_ratio
FROM 
    financial_institution_info fi
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id
WHERE 
    lr.net_stable_funding_ratio > (SELECT AVG(net_stable_funding_ratio) FROM liquidity_ratio)
    AND lr.loan_to_deposit_ratio < (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio)
ORDER BY 
    lr.net_stable_funding_ratio DESC,
    lr.loan_to_deposit_ratio ASC
LIMIT 10;	1181628181
SELECT fi.institution_name, re.credit_risk_exposure
FROM risk_exposure re
JOIN financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE EXTRACT(YEAR FROM re.report_date) = 2023
AND re.credit_risk_exposure > 50000000000
ORDER BY re.credit_risk_exposure DESC;	3568939453
SELECT 
    fi.institution_id,
    fi.institution_name,
    npl.report_date,
    npl.npl_ratio
FROM 
    financial_institution_info fi
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE 
    npl.npl_ratio > 2
ORDER BY 
    npl.npl_ratio DESC;	716682341
SELECT * 
FROM capital_adequacy_ratio 
WHERE report_date = '2023-05-01';	2344870041
SELECT 
    fi.institution_name,
    cr.severity,
    COUNT(*) AS count
FROM 
    compliance_records cr
JOIN 
    financial_institution_info fi ON cr.institution_id = fi.institution_id
WHERE 
    EXTRACT(YEAR FROM cr.record_date) = 2023
GROUP BY 
    fi.institution_name, cr.severity
ORDER BY 
    fi.institution_name, cr.severity;	79705771
SELECT 
    fi.institution_name,
    rr.report_date,
    rr.comments
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '已拒绝'
ORDER BY 
    rr.report_date;	3897795864
SELECT 
    fi.institution_name,
    rpt.related_party,
    rpt.transaction_type,
    rpt.transaction_amount,
    rpt.transaction_date,
    rpt.approval_status
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fi ON rpt.institution_id = fi.institution_id
ORDER BY 
    fi.institution_name, 
    rpt.transaction_date DESC;	3910780788
SELECT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id
WHERE rr.report_date = '2023-10-01'
  AND rr.report_type = '半年度报告'
  AND rpt.transaction_date = '2023-10-01'
GROUP BY fi.institution_id, fi.institution_name
HAVING SUM(rpt.transaction_amount) > 10000000;	463284912
SELECT 
    fii.institution_name,
    rr.report_id,
    rr.report_date,
    rr.comments
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fii ON rr.institution_id = fii.institution_id
WHERE 
    rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '已拒绝'
ORDER BY 
    rr.report_date;	3023341474
SELECT 
    fi.institution_name,
    rr.report_type,
    rr.approval_status,
    rr.submission_date
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '已拒绝'
ORDER BY 
    rr.submission_date;	100349185
	1713055268
SELECT 
    r.report_id,
    f.institution_name,
    r.report_type,
    r.report_date,
    r.submission_date,
    r.approval_status,
    r.comments
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
WHERE 
    EXTRACT(YEAR FROM r.report_date) = 2024
ORDER BY 
    r.report_date DESC;	1241000114
SELECT 
    fi.institution_type,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lr.liquidity_coverage_ratio) AS median_liquidity_coverage_ratio
FROM 
    financial_institution_info fi
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id
GROUP BY 
    fi.institution_type;	2918395057
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '已拒绝'
  AND car.report_date = '2023-06-01'
  AND car.core_tier_1_ratio < 8;	3292170043
WITH top10_institutions AS (
    SELECT 
        car.institution_id,
        fi.institution_name,
        car.total_car
    FROM 
        capital_adequacy_ratio car
    JOIN 
        financial_institution_info fi ON car.institution_id = fi.institution_id
    WHERE 
        car.report_date BETWEEN '2023-07-01' AND '2023-09-30'
    ORDER BY 
        car.total_car DESC
    LIMIT 10
)

SELECT 
    AVG(npl.npl_ratio) AS average_npl_ratio
FROM 
    non_performing_loans npl
JOIN 
    top10_institutions top10 ON npl.institution_id = top10.institution_id
WHERE 
    npl.report_date BETWEEN '2023-07-01' AND '2023-09-30';	759134662
SELECT 
    fi.institution_name,
    COUNT(cr.record_id) AS unresolved_compliance_count
FROM 
    financial_institution_info fi
JOIN 
    compliance_records cr ON fi.institution_id = cr.institution_id
WHERE 
    cr.status != 'Resolved' OR cr.status IS NULL
GROUP BY 
    fi.institution_id, fi.institution_name
ORDER BY 
    unresolved_compliance_count DESC
LIMIT 1;	4264132838
SELECT 
    rpt.transaction_id,
    rpt.institution_id,
    fi.institution_name,
    rpt.transaction_date,
    rpt.related_party,
    rpt.transaction_type,
    rpt.transaction_amount,
    rpt.approval_status
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fi ON rpt.institution_id = fi.institution_id
WHERE 
    rpt.transaction_date >= '2023-01-01' 
    AND rpt.transaction_date <= '2023-12-31'
    AND rpt.transaction_amount > 5000000
ORDER BY 
    rpt.transaction_amount DESC;	2605714275
SELECT 
    fi.institution_name,
    re.market_risk_exposure,
    re.total_risk_exposure,
    (re.market_risk_exposure / re.total_risk_exposure * 100) AS market_risk_percentage
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    re.total_risk_exposure > 0 
    AND (re.market_risk_exposure / re.total_risk_exposure) > 0.25
ORDER BY 
    market_risk_percentage DESC;	1937284507
SELECT 
    fi.institution_name,
    rpt.transaction_amount,
    rpt.transaction_type
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fi ON rpt.institution_id = fi.institution_id
WHERE 
    rpt.transaction_date BETWEEN '2023-08-01' AND '2023-08-31'
    AND rpt.transaction_amount > 5000000
    AND rpt.approval_status = '待审批'
ORDER BY 
    rpt.transaction_amount DESC;	2934397812
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN income_statement is ON fi.institution_id = is.institution_id
WHERE rr.report_type = '季度报告'
  AND rr.approval_status = '需修改'
  AND EXTRACT(YEAR FROM rr.report_date) = 2023
  AND EXTRACT(YEAR FROM is.report_date) = 2023
  AND EXTRACT(QUARTER FROM is.report_date) = 1
  AND is.net_profit > 50000000;	508885744
WITH latest_npl AS (
    SELECT 
        institution_id,
        npl_ratio,
        provision_coverage_ratio,
        report_date,
        ROW_NUMBER() OVER (PARTITION BY institution_id ORDER BY report_date DESC) AS rn
    FROM non_performing_loans
),
latest_car AS (
    SELECT 
        institution_id,
        total_car,
        report_date,
        ROW_NUMBER() OVER (PARTITION BY institution_id ORDER BY report_date DESC) AS rn
    FROM capital_adequacy_ratio
),
industry_medians AS (
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl.npl_ratio) AS median_npl_ratio,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl.provision_coverage_ratio) AS median_provision_coverage,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY car.total_car) AS median_total_car
    FROM latest_npl npl
    JOIN latest_car car ON npl.institution_id = car.institution_id
    WHERE npl.rn = 1 AND car.rn = 1
),
institution_data AS (
    SELECT 
        i.institution_id,
        i.institution_name,
        npl.npl_ratio,
        npl.provision_coverage_ratio,
        car.total_car
    FROM financial_institution_info i
    JOIN latest_npl npl ON i.institution_id = npl.institution_id AND npl.rn = 1
    JOIN latest_car car ON i.institution_id = car.institution_id AND car.rn = 1
)
SELECT 
    id.institution_id,
    id.institution_name,
    id.npl_ratio,
    id.provision_coverage_ratio,
    id.total_car,
    im.median_npl_ratio,
    im.median_provision_coverage,
    im.median_total_car
FROM institution_data id
CROSS JOIN industry_medians im
WHERE id.npl_ratio > im.median_npl_ratio
  AND id.provision_coverage_ratio > im.median_provision_coverage
  AND id.total_car > im.median_total_car
ORDER BY id.institution_name;	1632272828
SELECT related_party, MAX(transaction_amount) AS max_transaction_amount
FROM related_party_transactions
GROUP BY related_party
ORDER BY max_transaction_amount DESC
LIMIT 1;	1799492050
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE rr.report_date = '2023-10-01'
AND rr.approval_status = '待审批';	2216482912
SELECT 
    fi.institution_name,
    re.total_risk_exposure
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    re.report_date BETWEEN '2023-05-01' AND '2023-05-31'
    AND re.total_risk_exposure > 15000000000
ORDER BY 
    re.total_risk_exposure DESC;	1256154419
SELECT DISTINCT fii.institution_name, fii.registered_capital
FROM financial_institution_info fii
JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '需修改'
  AND fii.registered_capital > 50000000;	4262674456
SELECT 
    fi.institution_name,
    re.market_risk_exposure,
    re.credit_risk_exposure
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    EXTRACT(YEAR FROM re.report_date) = 2023 
    AND EXTRACT(MONTH FROM re.report_date) = 11
ORDER BY 
    fi.institution_name;	710647517
SELECT 
    fi.institution_name,
    re.report_date,
    re.credit_risk_exposure,
    re.total_risk_exposure
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    re.report_date = '2023-09-01'
ORDER BY 
    fi.institution_name;	58767252
SELECT 
    fi.institution_name,
    rpt.transaction_amount,
    rpt.approval_status,
    rpt.transaction_date
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fi ON rpt.institution_id = fi.institution_id
WHERE 
    rpt.transaction_date BETWEEN '2023-05-01' AND '2023-05-31'
    AND rpt.transaction_amount > 5000000
    AND rpt.approval_status = '已批准'
ORDER BY 
    rpt.transaction_amount DESC;	637645661
SELECT fi.institution_name, car.report_date, car.risk_weighted_assets
FROM capital_adequacy_ratio car
JOIN financial_institution_info fi ON car.institution_id = fi.institution_id
WHERE car.risk_weighted_assets > 800000000000
ORDER BY car.risk_weighted_assets DESC;	3688064451
SELECT COUNT(DISTINCT fi.institution_id) AS count_institutions
FROM financial_institution_info fi
JOIN balance_sheet bs ON fi.institution_id = bs.institution_id
WHERE fi.registered_capital < 1000000000  -- 10亿元转换为数值
AND bs.total_assets > 100000000000  -- 1000亿元转换为数值;	3547661219
SELECT 
    fi.institution_name,
    car.total_car AS capital_adequacy_ratio,
    npl.npl_ratio AS non_performing_loan_ratio
FROM 
    financial_institution_info fi
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE 
    car.report_date BETWEEN '2023-07-01' AND '2023-09-30'
    AND npl.report_date BETWEEN '2023-07-01' AND '2023-09-30'
    AND car.total_car < 12
    AND npl.npl_ratio > 2;	162610329
SELECT 
    r.report_date,
    r.approval_status,
    f.institution_name
FROM 
    regulatory_reports r
JOIN 
    financial_institution_info f ON r.institution_id = f.institution_id
ORDER BY 
    r.report_date DESC;	1552788455
SELECT 
    fi.institution_name,
    bs.total_assets
FROM 
    balance_sheet bs
JOIN 
    financial_institution_info fi ON bs.institution_id = fi.institution_id
WHERE 
    EXTRACT(YEAR FROM bs.report_date) = 2024
ORDER BY 
    bs.total_assets DESC
LIMIT 1;	116844122
SELECT 
    compliance_type,
    AVG(EXTRACT(DAY FROM (resolution_date - record_date))) AS avg_resolution_days
FROM 
    compliance_records
WHERE 
    severity = 'Severe' 
    AND record_date >= '2023-01-01' 
    AND record_date <= '2023-12-31'
    AND resolution_date IS NOT NULL
GROUP BY 
    compliance_type
ORDER BY 
    avg_resolution_days DESC
LIMIT 1;	4240691021
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id
WHERE rr.report_date = '2023-10-01'
  AND rr.report_type = '半年度报告'
  AND rpt.transaction_amount > 5000000;	1677817776
SELECT AVG(non_interest_income) AS average_non_interest_income
FROM income_statement
WHERE report_date = '2023-01-01';	1301409349
SELECT 
    npl.institution_id,
    fi.institution_name,
    npl.report_date,
    npl.npl_amount,
    npl.npl_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
WHERE 
    npl.report_date BETWEEN '2023-06-01' AND '2023-06-30'
ORDER BY 
    npl.institution_id, npl.report_date;	948022455
SELECT 
    fi.institution_name,
    npl.report_date,
    npl.provision_coverage_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
WHERE 
    npl.provision_coverage_ratio < 200
ORDER BY 
    npl.provision_coverage_ratio ASC;	3714986713
WITH top10_institutions AS (
    SELECT 
        i.institution_id,
        i.institution_name,
        SUM(s.net_profit) AS total_net_profit
    FROM 
        income_statement s
    JOIN 
        financial_institution_info i ON s.institution_id = i.institution_id
    WHERE 
        s.report_date BETWEEN '2023-10-01' AND '2023-12-31'
    GROUP BY 
        i.institution_id, i.institution_name
    ORDER BY 
        total_net_profit DESC
    LIMIT 10
)

SELECT 
    AVG(c.total_car) AS average_capital_adequacy_ratio
FROM 
    capital_adequacy_ratio c
JOIN 
    top10_institutions t ON c.institution_id = t.institution_id
WHERE 
    c.report_date BETWEEN '2023-10-01' AND '2023-12-31';	3771907244
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN compliance_records cr ON fi.institution_id = cr.institution_id
WHERE cr.description LIKE '%客户投诉%' OR cr.description LIKE '%customer complaint%';	1867865451
SELECT 
    f.institution_name,
    i.net_interest_income,
    i.non_interest_income
FROM 
    income_statement i
JOIN 
    financial_institution_info f ON i.institution_id = f.institution_id
WHERE 
    i.report_date BETWEEN '2023-07-01' AND '2023-07-31'
ORDER BY 
    f.institution_name;	246993905
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND rr.report_type = '季度报告'
  AND rr.approval_status = '已拒绝'
  AND npl.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND npl.npl_ratio > 1;	1509764635
SELECT 
    npl.npl_amount,
    npl.provision_coverage_ratio,
    fi.institution_name
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
WHERE 
    npl.report_date = '2023-03-01';	3372111545
WITH latest_data AS (
    SELECT 
        fi.institution_id,
        fi.institution_name,
        fi.institution_type,
        bs.total_assets,
        car.total_car AS capital_adequacy_ratio,
        lr.liquidity_coverage_ratio,
        npl.npl_ratio AS non_performing_loan_ratio,
        CASE WHEN car.total_car >= 10.5 THEN '达标' ELSE '不达标' END AS car_compliance,
        CASE WHEN lr.liquidity_coverage_ratio >= 100 THEN '达标' ELSE '不达标' END AS lcr_compliance,
        CASE WHEN npl.npl_ratio <= 5 THEN '达标' ELSE '不达标' END AS npl_compliance
    FROM financial_institution_info fi
    LEFT JOIN (
        SELECT institution_id, MAX(report_date) AS latest_date
        FROM balance_sheet
        GROUP BY institution_id
    ) bs_latest ON fi.institution_id = bs_latest.institution_id
    LEFT JOIN balance_sheet bs ON bs.institution_id = bs_latest.institution_id AND bs.report_date = bs_latest.latest_date
    LEFT JOIN (
        SELECT institution_id, MAX(report_date) AS latest_date
        FROM capital_adequacy_ratio
        GROUP BY institution_id
    ) car_latest ON fi.institution_id = car_latest.institution_id
    LEFT JOIN capital_adequacy_ratio car ON car.institution_id = car_latest.institution_id AND car.report_date = car_latest.latest_date
    LEFT JOIN (
        SELECT institution_id, MAX(report_date) AS latest_date
        FROM liquidity_ratio
        GROUP BY institution_id
    ) lr_latest ON fi.institution_id = lr_latest.institution_id
    LEFT JOIN liquidity_ratio lr ON lr.institution_id = lr_latest.institution_id AND lr.report_date = lr_latest.latest_date
    LEFT JOIN (
        SELECT institution_id, MAX(report_date) AS latest_date
        FROM non_performing_loans
        GROUP BY institution_id
    ) npl_latest ON fi.institution_id = npl_latest.institution_id
    LEFT JOIN non_performing_loans npl ON npl.institution_id = npl_latest.institution_id AND npl.report_date = npl_latest.latest_date
)

SELECT 
    CASE 
        WHEN total_assets < 1000000000 THEN '小型机构(<10亿)'
        WHEN total_assets BETWEEN 1000000000 AND 10000000000 THEN '中型机构(10亿-100亿)'
        WHEN total_assets > 10000000000 THEN '大型机构(>100亿)'
        ELSE '未分类'
    END AS institution_size_category,
    COUNT(*) AS institution_count,
    ROUND(AVG(total_assets), 2) AS avg_total_assets,
    ROUND(AVG(capital_adequacy_ratio), 2) AS avg_car,
    ROUND(AVG(liquidity_coverage_ratio), 2) AS avg_lcr,
    ROUND(AVG(non_performing_loan_ratio), 2) AS avg_npl_ratio,
    ROUND(SUM(CASE WHEN car_compliance = '达标' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS car_compliance_rate,
    ROUND(SUM(CASE WHEN lcr_compliance = '达标' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS lcr_compliance_rate,
    ROUND(SUM(CASE WHEN npl_compliance = '达标' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS npl_compliance_rate
FROM latest_data
WHERE total_assets IS NOT NULL
GROUP BY institution_size_category
ORDER BY 
    CASE institution_size_category
        WHEN '小型机构(<10亿)' THEN 1
        WHEN '中型机构(10亿-100亿)' THEN 2
        WHEN '大型机构(>100亿)' THEN 3
        ELSE 4
    END;	1509942542
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND rr.report_type = 'Quarterly'
  AND rr.approval_status = 'Rejected';	2196231862
WITH loan_growth AS (
    SELECT 
        n1.institution_id,
        n1.report_date AS year1,
        n2.report_date AS year2,
        n3.report_date AS year3,
        n1.total_loans AS loans_year1,
        n2.total_loans AS loans_year2,
        n3.total_loans AS loans_year3,
        (n2.total_loans - n1.total_loans) / n1.total_loans * 100 AS growth_year1_to_year2,
        (n3.total_loans - n2.total_loans) / n2.total_loans * 100 AS growth_year2_to_year3
    FROM 
        non_performing_loans n1
        JOIN non_performing_loans n2 ON n1.institution_id = n2.institution_id 
            AND n2.report_date = (n1.report_date + INTERVAL '1 year')
        JOIN non_performing_loans n3 ON n2.institution_id = n3.institution_id 
            AND n3.report_date = (n2.report_date + INTERVAL '1 year')
),

car_trend AS (
    SELECT 
        c1.institution_id,
        c1.report_date AS year1,
        c2.report_date AS year2,
        c3.report_date AS year3,
        c1.total_car AS car_year1,
        c2.total_car AS car_year2,
        c3.total_car AS car_year3
    FROM 
        capital_adequacy_ratio c1
        JOIN capital_adequacy_ratio c2 ON c1.institution_id = c2.institution_id 
            AND c2.report_date = (c1.report_date + INTERVAL '1 year')
        JOIN capital_adequacy_ratio c3 ON c2.institution_id = c3.institution_id 
            AND c3.report_date = (c2.report_date + INTERVAL '1 year')
)

SELECT COUNT(DISTINCT f.institution_id) AS qualifying_institutions_count
FROM 
    financial_institution_info f
    JOIN loan_growth lg ON f.institution_id = lg.institution_id
    JOIN car_trend ct ON f.institution_id = ct.institution_id
WHERE 
    lg.growth_year1_to_year2 > 20 
    AND lg.growth_year2_to_year3 > 20
    AND ct.car_year1 > ct.car_year2 
    AND ct.car_year2 > ct.car_year3;	2728172184
SELECT 
    fi.institution_name,
    rr.report_type,
    rr.approval_status,
    rr.report_date
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_type = '季度报告'
    AND rr.approval_status = '需修改'
    AND rr.report_date BETWEEN '2023-07-01' AND '2023-09-30'
ORDER BY 
    fi.institution_name;	3768872221
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_date = '2023-07-01'
  AND rr.report_type = '季度报告'
  AND npl.report_date = '2023-07-01'
  AND npl.npl_ratio > 1;	2784905980
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id
WHERE rpt.transaction_date BETWEEN '2023-10-01' AND '2023-10-31'
ORDER BY fi.institution_name;	678545000
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id
WHERE rr.report_date = '2023-07-01'
  AND rr.report_type = '季度报告'
  AND npl.report_date = '2023-07-01'
  AND npl.npl_ratio > 2;	3037348782
	1162073522
SELECT 
    fi.institution_name,
    lr.liquidity_coverage_ratio,
    rr.approval_status
FROM 
    financial_institution_info fi
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id
JOIN 
    regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE 
    EXTRACT(YEAR FROM lr.report_date) = 2023
    AND EXTRACT(YEAR FROM rr.report_date) = 2023
    AND rr.report_type = 'Liquidity Coverage Ratio Report';	1324283532
SELECT 
    fii.institution_name,
    rr.report_date,
    rr.approval_status
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fii ON rr.institution_id = fii.institution_id
WHERE 
    rr.report_date > '2023-07-01'
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '需修改'
ORDER BY 
    rr.report_date DESC;	3789302325
SELECT COUNT(*) AS rejected_reports_count
FROM regulatory_reports
WHERE report_date BETWEEN '2023-04-01' AND '2023-06-30'
AND approval_status = 'Rejected';	3524683857
SELECT 
    re.institution_id,
    fi.institution_name,
    re.report_date,
    re.credit_risk_exposure,
    re.market_risk_exposure,
    re.operational_risk_exposure,
    re.total_risk_exposure
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    re.report_date = '2023-10-01'
ORDER BY 
    re.institution_id;	1676740080
WITH loan_data AS (
    SELECT 
        fii.institution_name,
        bs.institution_id,
        bs.report_date,
        bs.loans_and_advances,
        LAG(bs.loans_and_advances) OVER (PARTITION BY bs.institution_id ORDER BY bs.report_date) AS previous_loans
    FROM 
        balance_sheet bs
    JOIN 
        financial_institution_info fii ON bs.institution_id = fii.institution_id
    WHERE 
        bs.loans_and_advances IS NOT NULL
),
growth_rates AS (
    SELECT 
        institution_name,
        institution_id,
        report_date,
        loans_and_advances,
        previous_loans,
        CASE 
            WHEN previous_loans = 0 THEN NULL
            ELSE (loans_and_advances - previous_loans) / previous_loans * 100
        END AS growth_rate
    FROM 
        loan_data
    WHERE 
        previous_loans IS NOT NULL
)
SELECT 
    institution_name,
    growth_rate AS loan_growth_rate_percentage
FROM 
    growth_rates
ORDER BY 
    growth_rate DESC
LIMIT 1;	3743576610
SELECT 
    fi.institution_name,
    (re.market_risk_exposure / (bs.total_equity + bs.total_liabilities)) * 100 AS market_risk_capital_ratio
FROM 
    financial_institution_info fi
JOIN 
    risk_exposure re ON fi.institution_id = re.institution_id
JOIN 
    balance_sheet bs ON fi.institution_id = bs.institution_id
WHERE 
    EXTRACT(YEAR FROM re.report_date) = 2023
    AND EXTRACT(YEAR FROM bs.report_date) = 2023
    AND (re.market_risk_exposure / (bs.total_equity + bs.total_liabilities)) * 100 > 15
ORDER BY 
    market_risk_capital_ratio DESC;	763017611
SELECT 
    fi.institution_name,
    rr.report_type,
    rr.submission_date
FROM 
    regulatory_reports rr
JOIN 
    financial_institution_info fi ON rr.institution_id = fi.institution_id
WHERE 
    rr.report_date >= '2023-01-01' 
    AND rr.report_date <= '2023-12-31'
    AND rr.approval_status = '需修改'
ORDER BY 
    rr.submission_date DESC;	227811783
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
LEFT JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id
    AND EXTRACT(YEAR FROM rpt.transaction_date) = 2023
    AND rpt.transaction_amount > 10000000
WHERE EXTRACT(YEAR FROM rr.report_date) = 2023
    AND rr.report_type = '季度报告'
    AND rr.approval_status = '需修改'
ORDER BY fi.institution_name;	636265180
SELECT 
    fi.institution_type,
    AVG(lr.liquidity_coverage_ratio) AS avg_liquidity_coverage_ratio,
    MIN(lr.liquidity_coverage_ratio) AS min_liquidity_coverage_ratio,
    MAX(lr.liquidity_coverage_ratio) AS max_liquidity_coverage_ratio,
    COUNT(*) AS record_count
FROM 
    financial_institution_info fi
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id
GROUP BY 
    fi.institution_type
ORDER BY 
    avg_liquidity_coverage_ratio DESC;	3904345596
SELECT 
    fi.institution_name,
    rpt.transaction_date,
    rpt.related_party,
    rpt.transaction_type,
    rpt.transaction_amount,
    rpt.approval_status
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fi ON rpt.institution_id = fi.institution_id
WHERE 
    rpt.transaction_date BETWEEN '2023-10-01' AND '2023-10-31'
    AND rpt.transaction_amount > 10000000
ORDER BY 
    rpt.transaction_amount DESC;	2375076145
SELECT 
    fi.institution_name,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN rpt.approval_status = '未通过' THEN 1 ELSE 0 END) AS rejected_transactions,
    ROUND(SUM(CASE WHEN rpt.approval_status = '未通过' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS rejection_rate
FROM 
    related_party_transactions rpt
JOIN 
    financial_institution_info fi ON rpt.institution_id = fi.institution_id
WHERE 
    rpt.transaction_date >= '2023-01-01'
GROUP BY 
    fi.institution_id, fi.institution_name
HAVING 
    COUNT(*) > 0
ORDER BY 
    rejection_rate DESC
LIMIT 1;	1557709908
SELECT 
    fi.institution_name,
    re.operational_risk_exposure / re.total_risk_exposure * 100 AS operational_risk_ratio
FROM 
    risk_exposure re
JOIN 
    financial_institution_info fi ON re.institution_id = fi.institution_id
WHERE 
    EXTRACT(YEAR FROM re.report_date) = 2023
ORDER BY 
    operational_risk_ratio DESC
LIMIT 1;	963481309
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31'
AND rr.comments IS NOT NULL
AND rr.comments != '';	3447512985
SELECT 
    fi.institution_name,
    npl.report_date,
    npl.total_loans,
    npl.npl_amount,
    npl.npl_ratio,
    npl.provision_coverage_ratio
FROM 
    non_performing_loans npl
JOIN 
    financial_institution_info fi ON npl.institution_id = fi.institution_id
WHERE 
    npl.report_date = '2023-03-01';	3623964040
SELECT institution_name, legal_representative
FROM financial_institution_info
WHERE legal_representative LIKE '王%';	478636896
SELECT DISTINCT fi.institution_name
FROM financial_institution_info fi
JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id
JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id
WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-03-31'
  AND rr.report_type LIKE '%资本充足率%'
  AND car.report_date BETWEEN '2023-01-01' AND '2023-03-31'
  AND car.total_car > 10;	1733036868
