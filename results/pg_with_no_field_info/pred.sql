SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-13' AND (a.check_out - a.check_in) > INTERVAL '15 hours';	2499788398
SELECT e.* FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-11' AND a.check_in > '09:00:00';	2790038483
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H03961' AND date BETWEEN '2024-01-01' AND '2024-12-31' AND check_in > '09:00:00';	1518250136
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in < '08:30:00' AND p.rating = 'A+' AND p.evaluation_date = (SELECT MAX(evaluation_date) FROM performance_evaluations WHERE employee_id = a.employee_id);	2290175818
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-05';	1543926007
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-21' ORDER BY d.name;	3053690473
SELECT ROUND(100.0 * COUNT(CASE WHEN pe.status = '离职' AND (pe.end_date - pe.start_date) < interval '3 months' THEN 1 END) / COUNT(*), 2) FROM employees e LEFT JOIN probation_employees pe ON e.employee_id = pe.employee_id;	1446084728
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-08' AND a.check_in > '09:00:00';	2505330870
SELECT e.name, e.hire_date FROM employees e JOIN probation_employees p ON e.employee_id = p.employee_id;	77372189
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00' AND e.remaining_annual_leave < 5;	1298859483
SELECT e.name, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN (SELECT employee_id, rating FROM performance_evaluations WHERE (employee_id, evaluation_date) IN (SELECT employee_id, MAX(evaluation_date) FROM performance_evaluations GROUP BY employee_id)) p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-10-05';	569704912
SELECT e.employee_id, e.name, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-09-26';	399196427
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H05598' AND date BETWEEN '2024-01-01' AND '2024-12-31' AND check_out < '18:00:00';	2805240810
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-28' AND ar.check_in > '09:00:00';	3848816814
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '运营部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	2544920386
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00:00';	2048034491
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-21' AND a.check_in > '09:00:00';	1501079200
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-12-11' AND pe.rating = 'C';	1654155358
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00';	1952426931
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '创新奖' AND p.rating = 'A+';	3946055885
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-09' AND a.check_in > '08:30:00';	2952516110
SELECT COUNT(DISTINCT e.employee_id) FROM employees e JOIN probation_employees pe ON e.employee_id = pe.employee_id JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工奖' AND pe.start_date <= '2023-12-31' AND pe.end_date >= '2023-01-01';	3989733729
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2021 AND a.year = 2022;	241703514
SELECT employee_id FROM attendance_records GROUP BY employee_id, date HAVING COUNT(*) > 1;	4110426671
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:30:00' AND e.remaining_annual_leave < 10;	1958968748
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-19' AND a.check_in > '09:00:00';	1261641813
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-26' AND a.check_in > '09:00:00' AND p.rating = 'C';	1404049949
SELECT e.employee_id, e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2021 AND a.year = 2021 AND p.rating = 'B';	860878506
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-03' AND d.name = '销售部' AND a.check_in > '09:00:00';	1830063336
SELECT a.employee_id FROM awards a JOIN probation_employees p ON a.employee_id = p.employee_id WHERE a.year = 2020 AND a.award_name = '优秀员工' AND p.status = '试用期' AND CURRENT_DATE BETWEEN p.start_date AND p.end_date;	1384865982
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.year = 2023 AND p.rating = 'A+';	3542777151
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN probation_employees p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND p.status = '试用期';	1253418500
SELECT employee_id, name, (15 - remaining_annual_leave) AS used_annual_leave FROM employees;	1306743539
SELECT e.employee_id, e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '技术突破奖' AND (ar.check_out - ar.check_in) > '10:00:00' GROUP BY e.employee_id, e.name;	1998735563
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-20' AND (a.check_out - a.check_in) > interval '8 hours';	3735871221
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-25' AND a.check_in < '09:00:00';	392713451
SELECT e.name FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE pe.rating = 'A+' GROUP BY e.name ORDER BY AVG(ar.check_out - ar.check_in) DESC LIMIT 1;	3464604281
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-04' AND a.check_in > '09:00:00';	1444696553
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-18' AND a.check_in > '09:00:00' AND p.rating = 'D';	2023290915
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-25' AND a.check_in > '08:30:00' AND p.rating = 'B+';	3746804657
SELECT * FROM interviews WHERE interview_date >= '2024-01-01' AND interview_date <= '2024-12-31' ORDER BY interview_count;	72949237
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '08:30:00' AND p.rating = 'A+';	1155706622
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-27' AND a.check_in > '09:00:00' AND e.remaining_annual_leave < 10;	638989138
SELECT e.name, p.evaluation_date FROM employees e LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id;	2390401103
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-07' AND a.check_in > '09:00:00' AND a.check_out < '17:00:00';	78855873
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-05';	3197959623
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN interviews i ON e.employee_id = i.employee_id GROUP BY d.name ORDER BY AVG(i.interview_count) DESC LIMIT 1;	3699728041
SELECT e.* FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-27' AND p.rating = 'A+';	3065616199
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '最佳团队奖' AND ar.date = '2024-10-09' AND ar.check_in > '09:00:00';	1681003052
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-10-14' AND a.check_in > '09:00:00';	4050465535
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_out > '13:00:00' AND p.rating = 'B+';	4249036992
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-08' AND ar.check_in > '09:00:00';	592982415
SELECT e.name, d.name, a.award_name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2022;	3584914350
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND a.check_in > '09:00:00' AND p.rating = 'D';	1423306349
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-13' AND a.check_in < '09:30:00';	2203283189
SELECT e.* FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-22';	3865699446
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND p.rating = 'A+';	1909210649
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-05' AND a.check_in > '08:30:00' AND d.manager_id = 'H05487';	2144085984
SELECT e.* FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-02' AND (a.check_out - a.check_in) > interval '9 hours';	283013543
SELECT d.name, e.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-03-31' AND pe.rating = 'D';	214548501
SELECT name, car_plate FROM employees WHERE employee_type = '正式';	3902051234
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-19' AND a.check_in > '09:00:00';	4268232257
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '客户满意度奖' AND ar.date = '2024-10-12' AND ar.check_in > '09:00:00';	2777106158
SELECT e.employee_id FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-11' AND ar.check_in > '09:00:00' AND d.manager_id = 'H00842';	932008813
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2023 AND a.award_name = '领导力奖';	3805690652
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND ar.date = '2024-10-09' AND ar.check_in > '09:00:00';	795140600
SELECT e.name AS intern_name, m.name AS manager_name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE e.employee_type = '实习生' AND a.date = '2024-10-02' AND a.check_in BETWEEN '09:00:00' AND '10:00:00';	3086085668
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id GROUP BY d.name ORDER BY AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.birth_date)) DESC LIMIT 1;	2411560883
SELECT DISTINCT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-16' AND p.rating = 'C';	3743308464
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-08' AND a.check_in > '09:00:00';	439444083
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-09-20' AND a.check_in > '09:00:00';	3252922075
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > interval '8 hours';	1549624018
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-14' AND p.rating = 'A+';	261206730
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-09-27' AND a.check_in > '09:00:00';	1406124018
SELECT d.name, COUNT(e.employee_id) FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.name;	1273187788
SELECT e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.rating = 'A+' ORDER BY e.hire_date DESC LIMIT 1;	161130038
SELECT e.employee_id, e.name, e.department_id, ABS(EXTRACT(EPOCH FROM (a.check_out - a.check_in)) - d.avg_duration) AS duration_diff FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN (SELECT e.department_id, AVG(EXTRACT(EPOCH FROM (a.check_out - a.check_in))) AS avg_duration FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id GROUP BY e.department_id) d ON e.department_id = d.department_id ORDER BY duration_diff DESC LIMIT 1;	2367131410
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > interval '10 hours';	736904101
SELECT e.name, d.name, p.rating FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-12';	87083721
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND d.name = '销售部' AND a.check_in > '09:00:00';	1391282019
SELECT e.name, d.name, a_r.check_in, a.award_name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a_r ON e.employee_id = a_r.employee_id JOIN awards a ON e.employee_id = a.employee_id WHERE a_r.date = '2024-09-26' AND a_r.check_in > '09:00:00' AND a.year = 2024 AND a.award_name IS NOT NULL;	1614124608
SELECT a.employee_id FROM attendance_records a INNER JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-05' AND a.check_in > '09:00:00' AND p.rating = 'A+';	119065582
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-07' AND a.check_in > '09:00:00';	305429407
SELECT e.name, d.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND e.employee_type = '实习生' AND a.check_in < '09:00:00';	1434754295
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工奖' AND p.rating = 'A+';	1416753262
SELECT d.name, COUNT(DISTINCT e.employee_id) FROM departments d JOIN employees e ON d.department_id = e.department_id LEFT JOIN awards a ON e.employee_id = a.employee_id LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE (e.hire_date >= CURRENT_DATE - INTERVAL '5 years' OR a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5) AND (e.position IN ('总监','经理') OR e.employee_id IN (SELECT manager_id FROM departments)) GROUP BY d.name;	1966520829
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '新人奖' AND ar.date = '2024-10-08';	3742208647
SELECT e.employee_id, e.name 
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-10-02' 
AND ar.check_in > '09:00:00' 
AND pe.rating = 'A+';	681058956
SELECT e.name AS 员工姓名, d.name AS 部门名称 FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2024 AND a.award_name = '新人奖';	3929652777
SELECT AVG(CURRENT_DATE - e.hire_date) AS avg_time_to_management 
FROM employees e 
JOIN departments d ON e.employee_id = d.manager_id;	2290314264
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-06' AND (a.check_out - a.check_in) > interval '10 hours';	2118323252
SELECT DISTINCT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '技术突破奖' AND p.rating = 'A+';	1087843451
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND a.check_in > '09:00:00' AND p.rating = 'D';	386106206
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '项目管理奖' AND ar.date = '2024-10-03';	855220810
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND e.hire_date > '2017-12-31';	3375057924
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-16' AND (a.check_out - a.check_in) > interval '8 hours';	4174232427
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND p.evaluation_date = '2023-06-04' AND p.rating = 'D';	734321783
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	1241353029
SELECT e.employee_id FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-21' AND ar.check_in > '09:00:00' AND pe.rating = 'B';	3667177289
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-24' AND ar.check_in > '09:00:00' AND pe.rating = 'C';	4273970415
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > interval '9 hours';	323611946
SELECT e.* FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-06' AND a.check_in > '09:00:00';	2940103155
SELECT e.name AS employee_name, m.name AS manager_name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE pe.rating = 'A+' AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023;	434694019
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:00:00' AND p.rating = 'A';	1289703363
SELECT check_in, check_out FROM attendance_records WHERE date = '2024-10-01' AND employee_id IN (SELECT employee_id FROM awards WHERE year = 2023 AND award_name = '销售冠军');	1722398575
SELECT DISTINCT ON (d.name) d.name AS department_name, e.name AS employee_name FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.rating = 'A+' AND pe.evaluation_date = (SELECT MIN(pe2.evaluation_date) FROM performance_evaluations pe2 WHERE pe2.employee_id = e.employee_id AND pe2.rating = 'A+') ORDER BY d.name, pe.evaluation_date - e.hire_date;	804493985
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00';	1306450278
SELECT employee_id FROM awards WHERE year = 2024 AND award_name = '优秀员工' INTERSECT SELECT employee_id FROM performance_evaluations WHERE rating = 'A+';	1414070332
SELECT e.name, d.name, p.rating FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-10-29';	3925025909
SELECT employees.name FROM employees JOIN attendance_records ON employees.employee_id = attendance_records.employee_id WHERE employees.university = '清华大学' AND attendance_records.date = '2024-09-17' AND (attendance_records.check_out - attendance_records.check_in) > '09:00:00';	1398775192
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2022-06-16' AND pe.rating = 'C';	2656339281
SELECT employee_id FROM awards WHERE year = 2022 AND award_name = '优秀员工' INTERSECT SELECT employee_id FROM performance_evaluations WHERE evaluation_date = '2022-10-30' AND rating = 'A+';	3627252999
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-15' AND a.check_in > '09:00:00' AND p.rating = 'B';	2285040147
SELECT e.name, e.position FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE d.name = '销售部';	3934214389
SELECT e.employee_id, e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-23' AND a.check_in > '09:00:00' AND p.rating = 'D' AND p.evaluation_date = (SELECT MAX(evaluation_date) FROM performance_evaluations WHERE employee_id = e.employee_id);	1649684433
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '客户服务部' AND p.rating = 'D' AND p.evaluation_date = '2024-10-14' AND e.hire_date <= '2024-10-14' AND (e.start_work_date <= '2024-10-14' OR e.start_work_date IS NULL);	1300169145
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND e.hire_date >= '2019-01-01';	3467712746
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00:00' AND pe.rating = 'A+';	225648923
SELECT DISTINCT e.name FROM employees e INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id INNER JOIN awards a ON e.employee_id = a.employee_id WHERE p.rating = '一般';	3415487094
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in BETWEEN '08:00:00' AND '09:00:00' AND p.rating = 'B';	1027352926
SELECT e.* FROM employees e JOIN (SELECT employee_id, MAX(evaluation_date) AS last_eval_date FROM performance_evaluations GROUP BY employee_id) last_evals ON e.employee_id = last_evals.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id AND last_evals.last_eval_date = pe.evaluation_date WHERE pe.evaluation_date < '2024-01-01' AND pe.rating = 'B';	3444450310
SELECT e.employee_id FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-19' AND ar.check_in > '09:00:00' AND pe.rating = 'B+';	73955891
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-24' AND (ar.check_out - ar.check_in) > INTERVAL '12 hours';	2221450098
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-29' AND a.check_in < '09:00:00';	2070780775
SELECT employees.* FROM employees JOIN attendance_records ON employees.employee_id = attendance_records.employee_id JOIN performance_evaluations ON employees.employee_id = performance_evaluations.employee_id WHERE attendance_records.date = '2024-10-11' AND attendance_records.check_in > '09:00:00' AND performance_evaluations.rating = 'A';	1554709262
AMBIGUOUS_QUERY	706296760
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '厦门大学' AND a.date = '2024-09-23' AND a.check_in > '09:00:00';	392591213
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND a.check_in > '09:00:00' AND p.rating = 'D';	3172283899
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-11' AND a.check_in > '08:30:00';	988606028
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '09:00:00' AND p.rating = 'D';	2714488838
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2024 AND a.year = 2024 AND a.award_name = '新人奖' AND p.rating = 'A';	4248175692
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-26' AND a.check_in BETWEEN '08:00:00' AND '09:00:00' AND p.rating = 'B+';	302928867
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '创新奖' AND ar.date = '2024-09-25';	886106357
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00:00' AND p.rating = 'D';	4026541630
SELECT d.name, AVG(e.remaining_annual_leave) FROM departments d JOIN employees e ON d.department_id = e.department_id WHERE d.manager_id = 'H03372' GROUP BY d.name;	1802079912
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND p.rating = 'A+';	865528666
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND ar.date = '2024-10-03' AND ar.check_in > '09:00:00';	4061141103
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '财务部' AND p.rating = 'A+' AND e.hire_date <= '2024-09-15' AND (e.start_work_date IS NULL OR e.start_work_date <= '2024-09-15') AND p.evaluation_date <= '2024-09-15';	2313524982
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-21' AND a.check_in > '09:00:00';	1992247421
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-25' AND (a.check_out - a.check_in) > interval '8 hours';	165828985
SELECT p.rating FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2022 AND a.award_name = '技术突破奖' AND p.evaluation_date > '2022-07-13';	2853735999
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-11' AND a.check_in > '09:00:00';	2393343950
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	541232515
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2023-08-06' AND p.rating = 'C';	2805706885
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-01' AND (ar.check_out - ar.check_in) > interval '12 hours';	642307462
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-09' AND a.check_in > '09:00:00' AND p.rating = 'A+';	1883744787
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-09-24' AND a.check_in > '09:00:00';	2974332534
SELECT e.employee_id, e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-02' AND a.check_in > '09:00:00';	3471772100
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-11' AND a.check_out > '21:00:00' AND p.rating = 'B+';	2086845631
SELECT e.name, d.name, e.hire_date FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.rating = 'B' AND p.evaluation_date BETWEEN '2022-01-01' AND '2022-12-31' ORDER BY e.hire_date;	4264799007
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND d.name = '客户服务部';	3620357144
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00:00' AND pe.rating = 'B';	1491216239
SELECT e.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id WHERE ar.date = '2024-10-02' ORDER BY ar.check_in ASC LIMIT 1;	3076427726
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-10-10' AND p.rating = 'B+';	3105805885
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-04' AND a.check_in > '09:00:00';	619146222
SELECT e.* FROM employees e INNER JOIN attendance_records a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND p.rating = 'A+';	701268008
SELECT d.name FROM probation_employees pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.status = '延长' GROUP BY e.employee_id, d.name ORDER BY COUNT(*) DESC LIMIT 3;	1106812044
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-04' AND a.check_in > '09:00:00';	150140045
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2023 AND a.award_name = '优秀员工';	3067705249
SELECT COUNT(DISTINCT a.employee_id) FROM awards a JOIN probation_employees p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '客户满意度奖' AND p.start_date <= '2023-12-31' AND p.end_date >= '2023-01-01';	370099566
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00:00' AND p.rating = 'C';	3404150466
SELECT e.name, a.award_name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id;	2389000379
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-13' AND a.check_in < '08:30:00';	3131729527
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-17' AND (a.check_out - a.check_in) > interval '9 hours';	525985276
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-26' AND e.remaining_annual_leave > 10;	331075127
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-09' AND a.check_in > '09:00:00';	1437451129
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-10' AND a.check_in > '09:00:00';	4184935107
SELECT e.name, COUNT(a.id) AS award_count FROM employees e JOIN awards a ON e.employee_id = a.employee_id GROUP BY e.name ORDER BY award_count DESC LIMIT 10;	2884744128
SELECT e.name, d.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-25' AND a.check_in > '09:00:00';	23024706
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '客户服务部' AND p.rating = 'A+' AND p.evaluation_date <= '2024-09-28';	1389756999
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-07' AND a.check_in > '09:00:00';	2946411490
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-14';	4118104089
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2021 AND ar.date > '2021-01-01';	2690408936
SELECT AVG(remaining_annual_leave) FROM employees WHERE employee_id IN (SELECT employee_id FROM awards WHERE year=2024 AND award_name='领导力奖') AND hire_date > '2017-12-31';	312466402
SELECT e.employee_id, e.name FROM employees e 
LEFT JOIN awards a ON e.employee_id = a.employee_id 
LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id 
WHERE e.university NOT IN ('清华大学','北京大学','复旦大学','上海交通大学','浙江大学') 
AND e.position NOT LIKE '%总监%' AND e.position NOT LIKE '%总裁%' 
AND (a.award_name LIKE '%创新%' OR a.award_name LIKE '%突破%' OR p.rating = '优秀');	2444022671
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-12-07' AND pe.rating = 'B';	4277707010
SELECT e.name, d.name AS department_name, a.award_name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN awards a ON e.employee_id = a.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.year = 2023;	4268522360
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-25' AND a.check_in > '09:00:00';	4254579364
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-20' AND a.check_in > '09:00:00';	2369381920
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-29' AND (a.check_out - a.check_in) > interval '10 hours';	4086198634
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-04' AND a.check_in > '08:30:00' AND p.rating = 'A+';	2201325936
SELECT e.employee_id, e.name, COUNT(CASE WHEN a.check_in > '09:00:00' THEN 1 END) AS late_days FROM employees e LEFT JOIN attendance_records a ON e.employee_id = a.employee_id GROUP BY e.employee_id, e.name;	3450923921
SELECT e.employee_id, e.name FROM employees e INNER JOIN attendance_records a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-15' AND p.rating = 'A+';	3735318054
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '最佳团队奖' AND ar.date = '2024-09-19';	1103295358
SELECT employees.* FROM employees JOIN departments ON employees.department_id = departments.department_id JOIN attendance_records ON employees.employee_id = attendance_records.employee_id WHERE departments.name = '客户服务部' AND attendance_records.date = '2024-09-21';	1771528644
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-09-23' AND a.check_in < '09:30:00';	1983289607
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-10-09' AND a.check_in > '09:00:00' AND e.employee_type = '实习生';	3578772260
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '项目管理奖' AND ar.date = '2024-09-23';	417939953
SELECT e.employee_id FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE e.hire_date BETWEEN '2022-01-01' AND '2022-12-31' AND a.year = 2023 AND p.rating = 'A+';	1624107441
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-13';	1951693602
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-09-18' AND a.check_in > '09:00:00';	82225620
SELECT '导师计划' AS factor, COUNT(*) AS count FROM performance_evaluations WHERE rating = '优秀' UNION SELECT '培训课程' AS factor, COUNT(*) FROM interviews WHERE interview_count > 3 UNION SELECT '轮岗经历' AS factor, COUNT(*) FROM employees WHERE department_id IN (SELECT department_id FROM departments GROUP BY department_id HAVING COUNT(*) > 1) ORDER BY count DESC LIMIT 1;	3464614512
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-20' AND a.check_in > '08:00:00';	3644746054
SELECT d.name AS department_name, e.name AS employee_name FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE (e.department_id, e.birth_date) IN (SELECT department_id, MIN(birth_date) FROM employees GROUP BY department_id);	2589067480
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-30' AND d.name = '人力资源部' AND a.check_in > '09:00:00';	525741152
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-09-18' AND a.check_in > '09:00:00';	1233829446
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:30:00' AND p.rating = 'A+';	1073149875
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND a.check_in > '09:00:00' AND p.rating = 'B';	2974599681
SELECT DISTINCT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-22' AND p.rating = 'D';	4292447380
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-03' AND p.rating = 'A+';	1372088201
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-07' AND a.check_in > '09:00:00';	1829638261
SELECT e.employee_id, e.name, ar.date, ar.check_in, ar.check_out, pe.rating FROM employees e LEFT JOIN attendance_records ar ON e.employee_id = ar.employee_id LEFT JOIN performance_evaluations pe ON e.employee_id = pe.employee_id;	4051639960
SELECT DISTINCT a.employee_id FROM attendance_records a INNER JOIN awards b ON a.employee_id = b.employee_id WHERE a.date = '2024-10-05' AND a.check_in > '09:00:00' AND b.year = 2021;	3807676634
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-25' AND a.check_in > '08:30:00';	22049871
SELECT 
    q.employee_id,
    e.name,
    q.year,
    q.quarter,
    CASE WHEN a.avg_lateness <= INTERVAL '0' THEN '是' ELSE '否' END AS is_punctual
FROM (
    SELECT 
        a.employee_id,
        EXTRACT(YEAR FROM a.year || '-01-01'::date) AS year,
        EXTRACT(QUARTER FROM a.year || '-01-01'::date) AS quarter,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM a.year || '-01-01'::date), EXTRACT(QUARTER FROM a.year || '-01-01'::date) ORDER BY COUNT(*) DESC) AS rank
    FROM 
        awards a
    WHERE 
        a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 3
    GROUP BY 
        a.employee_id, a.year
) q
JOIN employees e ON q.employee_id = e.employee_id
LEFT JOIN (
    SELECT 
        ar.employee_id,
        AVG(ar.check_in - '09:00:00'::time) AS avg_lateness
    FROM 
        attendance_records ar
    GROUP BY 
        ar.employee_id
) a ON q.employee_id = a.employee_id
WHERE 
    q.rank = 1;	2830500866
SELECT DISTINCT e.employee_id, e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND p.rating = 'A+';	753042700
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '质量改进奖' AND ar.date = '2024-10-04' AND ar.check_in > '09:00:00';	3115674665
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	3347041396
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-02' AND a.check_in > '09:00:00';	2106049978
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工' AND p.rating = 'A+';	2418301693
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2023-05-31' AND p.rating = 'A+';	3616397443
SELECT e.name FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN (SELECT employee_id FROM performance_evaluations WHERE rating = 'A+' GROUP BY employee_id HAVING MAX(evaluation_date)) pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-10-02' AND ar.check_in > '09:00:00';	4109172134
SELECT attendance_records.* FROM attendance_records JOIN awards ON attendance_records.employee_id = awards.employee_id WHERE awards.year = 2021 AND awards.award_name = '销售冠军' AND attendance_records.date = '2024-09-18';	2161202831
SELECT e.name, d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-05-27' AND p.rating = 'A+';	883813840
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-16' AND ar.check_in > '09:00:00';	537717055
SELECT e.name, d.name FROM employees e JOIN departments d ON e.department_id = d.department_id;	2763876996
SELECT name FROM employees WHERE hire_date = (SELECT MIN(hire_date) FROM employees) ORDER BY position ASC LIMIT 1;	2600861795
SELECT e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE e.department_id = 'D00007' AND p.rating = 'A' AND p.evaluation_date BETWEEN '2024-01-01' AND '2024-12-31';	2781387557
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '创新奖' AND ar.date = '2024-10-12' AND ar.check_in > '09:00';	2256872853
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-23' AND a.check_in > '09:00:00';	3830013539
SELECT COUNT(DISTINCT a.employee_id) FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND p.rating = 'A+';	2490180425
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-23' AND a.check_in > '08:00:00' AND a.check_out < '18:00:00';	2983573490
SELECT DISTINCT d.name FROM employees e JOIN interviews i ON e.employee_id = i.employee_id JOIN awards a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE i.interview_date = '2023-10-09' AND a.award_name = '优秀员工奖';	2710720384
SELECT a.employee_id FROM attendance_records a INNER JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND a.check_in < '09:00:00' AND p.rating = 'B+';	737077017
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in > '09:00:00' AND p.rating = 'A+';	1491113326
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2021 AND a.award_name = '质量改进奖' AND p.rating = 'B+';	498106360
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-29' AND a.check_in > '08:30:00';	640452635
SELECT e.name AS employee_name, m.name AS manager_name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE ar.date = '2024-09-16' AND ar.check_in > '08:30:00';	208690009
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-10-01' AND a.check_in > '09:00:00' AND e.position = '顾问';	392941851
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-23' AND a.check_in > '09:00:00';	2938732459
SELECT a.year, e.name, p.rating FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.award_name = '技术创新奖' AND a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5 ORDER BY a.year;	1117540294
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-06' AND a.check_in > '09:00:00';	1014591026
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-04' AND ar.check_in > '09:00:00';	1623914717
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-04';	2050714128
SELECT a.employee_id, a.award_name, p.rating, p.evaluation_date FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	3216421294
SELECT e.name, d.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '09:30:00';	1913384420
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-19';	914649823
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	4047308852
SELECT d.name FROM employees e JOIN departments d ON e.department_id = d.department_id GROUP BY d.name ORDER BY AVG(e.remaining_annual_leave) DESC LIMIT 1;	389946505
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-27' AND a.check_in < '10:00:00' AND p.rating = 'A+';	2789183181
SELECT interview_date, interview_count FROM interviews WHERE interview_date >= '2024-01-01' AND interview_date <= '2024-12-31';	2066321300
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00:00';	517679865
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '研发部' AND p.rating = 'B+' AND e.hire_date <= '2024-09-29' AND (e.start_work_date IS NULL OR e.start_work_date <= '2024-09-29');	168044233
SELECT a.* FROM attendance_records a JOIN awards b ON a.employee_id = b.employee_id WHERE b.year = 2022 AND b.award_name = '销售冠军' AND a.date = '2024-10-10';	3832137822
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '客户满意度奖' AND e.hire_date > '2020-06-19';	2937344989
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00' AND p.rating = 'A+';	666608778
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2022-06-20' AND p.rating = 'C';	895348774
SELECT DISTINCT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND a.award_name = '客户满意度奖' AND p.rating = 'C';	140831793
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '项目管理奖' GROUP BY e.name HAVING AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10;	3458227345
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-03-09' AND pe.rating = 'D';	1848769486
AMBIGUOUS_QUERY	2500228389
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-08';	2138121838
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-09-26' AND a.check_in > '09:00:00';	2171081157
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:00:00' AND p.rating = 'A+';	1610499668
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-09-20' AND a.check_in > '09:00:00';	2819549023
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-10-13' AND ar.check_in > '09:00:00' AND pe.rating = 'A+';	898575802
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND p.rating IN ('A', 'B');	3845606236
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-09-17' AND (a.check_out - a.check_in) > interval '9 hours';	3651268255
SELECT e.name AS employee_name, m.name AS manager_name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE ar.date = '2024-09-18' AND ar.check_in > '09:00:00';	2107787587
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '技术突破奖' AND ar.date = '2024-09-23' AND ar.check_in > '09:00:00';	3117376201
SELECT employees.* FROM employees JOIN departments ON employees.department_id = departments.department_id JOIN attendance_records ON employees.employee_id = attendance_records.employee_id WHERE departments.name = '运营部' AND attendance_records.date = '2024-09-26';	480860919
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2020 AND a.award_name = '优秀员工' AND EXTRACT(YEAR FROM p.evaluation_date) = 2023 AND p.rating = 'C';	460298626
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-03' AND a.check_in > '09:00:00' AND p.rating = 'C';	2730014142
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	3912663730
SELECT d.name FROM (
    SELECT 
        e.department_id,
        EXTRACT(YEAR FROM i.interview_date) AS year,
        COUNT(DISTINCT i.employee_id) FILTER (WHERE e.hire_date IS NOT NULL)::float / 
        COUNT(DISTINCT i.employee_id) AS pass_rate
    FROM interviews i
    LEFT JOIN employees e ON i.employee_id = e.employee_id
    WHERE EXTRACT(YEAR FROM i.interview_date) BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) - 5 AND EXTRACT(YEAR FROM CURRENT_DATE)
    GROUP BY e.department_id, EXTRACT(YEAR FROM i.interview_date)
    ORDER BY pass_rate DESC
    LIMIT 1
) t
JOIN departments d ON t.department_id = d.department_id;	2709449383
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-12';	773661226
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND ar.date = '2024-10-01' AND ar.check_in > '09:00:00';	2010808566
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND ar.date = '2024-09-22' AND ar.check_in > '09:00:00';	201608997
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-10' AND a.check_in > '09:00:00';	305187601
SELECT e.name, d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-04-20' AND p.rating = 'D';	1158176204
SELECT (COUNT(DISTINCT a.employee_id)::float / COUNT(DISTINCT e.employee_id) * 100) AS percentage FROM employees e LEFT JOIN (SELECT DISTINCT employee_id FROM awards WHERE year >= EXTRACT(YEAR FROM CURRENT_DATE) - 1) a ON e.employee_id = a.employee_id LEFT JOIN (SELECT DISTINCT employee_id FROM performance_evaluations WHERE evaluation_date >= CURRENT_DATE - INTERVAL '2 years' AND rating IN ('优秀', '良好')) p ON e.employee_id = p.employee_id WHERE a.employee_id IS NOT NULL AND p.employee_id IS NOT NULL;	3838245936
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.year = 2023 AND a.award_name = '优秀员工奖' AND p.rating = 'A+';	2323193672
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-21' AND a.check_in > '09:00:00';	662747906
SELECT employee_id, SUM(check_out - check_in) AS total_working_time FROM attendance_records GROUP BY employee_id;	1678101946
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-15' AND a.check_in > '09:00:00';	523515982
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '创新奖' AND ar.date = '2024-10-05' AND ar.check_in > '09:00:00';	2715149255
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2024 AND p.rating = 'C';	3069073544
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND a.award_name = '领导力奖' AND p.rating = 'C';	2258483174
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-19' AND a.check_in > '09:00:00';	389046410
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '项目管理奖' AND ar.date = '2024-09-23';	2068076752
SELECT e.name, d.name, p.rating FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20';	406606744
SELECT e.name AS employee_name, m.name AS manager_name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE ar.date = '2024-09-26' AND ar.check_in > '09:30:00';	260151387
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	4070449827
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-01' AND (a.check_out - a.check_in) > interval '10 hours';	2852580257
SELECT p.rating FROM performance_evaluations p JOIN awards a ON p.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工' AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	1727169008
SELECT d.cust_no, d.acct_bal, l.loan_balance, lt.loan_type_name FROM deposit_account_info d JOIN loan_detail_info l ON d.cust_no = l.cust_id JOIN loan_type lt ON l.loan_type = lt.loan_type_code WHERE d.data_dt = '2024-07-19' AND l.dw_date = '2024-07-19' AND d.acct_bal > 100000 AND l.loan_balance > 500000;	1877699859
SELECT DISTINCT cust_no FROM financial_products WHERE data_dt = '2024-07-02' AND currency = '美元' AND wealth_bal > 5000000;	2884293015
SELECT rs_type_name, rs_type_id FROM five_level_classification WHERE data_dt = '2024-07-22' AND rs_type = '不良';	958998120
SELECT c.customer_name, o.occupation_name, lr.description FROM customer c JOIN occupation o ON c.occupation_id = o.id JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id ORDER BY lr.repayment_amount DESC;	1597552663
SELECT c.customer_name, c.id_number, c.phone_number, c.email, c.address FROM customer c JOIN occupation o ON c.occupation_id = o.id WHERE o.occupation_name = '护士' ORDER BY c.customer_name;	2952757264
SELECT COUNT(DISTINCT d.cust_no) FROM deposit_account_info d JOIN loan_detail_info l ON d.cust_no = l.cust_id JOIN bank_orgnization b ON d.org_no = b.bank_id WHERE d.data_dt = '2024-07-19' AND d.cust_type = '1' AND b.bank_name = '沈阳分行' AND l.dw_date = '2024-07-19';	469159086
SELECT c.curr_code, c.curr_full_name, b.bank_name, b.bank_level FROM currency c, bank_orgnization b WHERE c.data_dt = '2023-06-30' AND b.data_dt = '2023-06-30' AND c.curr_class != '人民币';	731693068
SELECT deposit_id, deposit_name FROM deposit_type WHERE data_dt = '2024-07-22';	1236011704
SELECT cust_nm, residential_address, card_no, card_type_nm, current_bal FROM debit_card_information WHERE open_date = '2024-07-15' AND current_bal > 2000;	280502890
SELECT customer_id, credit_score FROM loan_credit WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	236766680
SELECT c.customer_name, c.gender, SUM(lr.repayment_amount) FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id GROUP BY c.gender, c.customer_name;	1413730783
SELECT c.* FROM loan_application la JOIN customer c ON la.customer_id = c.id ORDER BY la.loan_amount DESC LIMIT 1;	2991390114
SELECT COUNT(DISTINCT f.cust_no) FROM financial_products f JOIN debit_card_information d ON f.cust_no = d.cust_no WHERE f.wealth_bal > 1000000 AND d.card_state = '正常';	2514430924
SELECT cust_no, cust_name FROM deposit_account_info WHERE org_nm = '沈阳余淮支行' AND acct_type_code = '活期存款' AND bank_date = '2024-07-19' AND act_mon_avg_bal > 50000;	4288779306
SELECT c.customer_name, l.loan_amount FROM loan_application l JOIN customer c ON l.customer_id = c.id WHERE l.loan_amount > 30000 AND l.status = 'PENDING';	3310831117
SELECT d.acct_type_code, COUNT(DISTINCT d.cust_no) FROM deposit_account_info d WHERE d.cust_no IN (SELECT cust_id FROM loan_detail_info GROUP BY cust_id ORDER BY SUM(loan_amount) DESC LIMIT 20) GROUP BY d.acct_type_code;	2450245528
SELECT curr_code, curr_full_name FROM currency WHERE curr_class = '外币' ORDER BY curr_code ASC;	821687353
SELECT c.id, c.customer_name, l.loan_amount FROM customer c JOIN loan_application l ON c.id = l.customer_id ORDER BY l.loan_amount DESC;	3139230407
SELECT cast_type, SUM(wealth_t_m_avg_bal_a) FROM financial_products WHERE data_dt BETWEEN '2024-07-01' AND '2024-07-31' GROUP BY cast_type;	3089791258
SELECT * FROM loan_detail_info WHERE loandate_s::date > '2024-04-01';	52505136
SELECT c.id, c.customer_name 
FROM customer c
JOIN loan_application l ON c.id = l.customer_id
WHERE l.loan_amount > 1.5 * (
    SELECT AVG(la.loan_amount)
    FROM loan_application la
    JOIN customer cu ON la.customer_id = cu.id
    WHERE 
        (EXTRACT(YEAR FROM AGE(CURRENT_DATE, cu.birth_date)) BETWEEN 0 AND 20 AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 0 AND 20) OR
        (EXTRACT(YEAR FROM AGE(CURRENT_DATE, cu.birth_date)) BETWEEN 21 AND 40 AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 21 AND 40) OR
        (EXTRACT(YEAR FROM AGE(CURRENT_DATE, cu.birth_date)) BETWEEN 41 AND 60 AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 41 AND 60) OR
        (EXTRACT(YEAR FROM AGE(CURRENT_DATE, cu.birth_date)) > 60 AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) > 60)
);	3773590841
SELECT birth_date, gender FROM customer;	2822188040
SELECT DISTINCT c.id FROM loan_detail_info l JOIN bank_orgnization b ON l.loan_orgno = b.bank_id JOIN customer c ON l.cust_id = c.id_number WHERE l.dw_date = '2024-07-19' AND b.bank_name = '沈阳分行' AND l.loan_balance > 500000;	1440558878
SELECT l.*, c.curr_full_name, f.rs_type_name FROM loan_detail_info l JOIN currency c ON l.currency_type = c.curr_code JOIN five_level_classification f ON l.judgelevel = f.rs_type_id WHERE l.loan_balance > 1000000;	1736005638
SELECT loan_detail_info.cust_id, loan_detail_info.loan_balance, currency.curr_full_name FROM loan_detail_info JOIN currency ON loan_detail_info.currency_type = currency.curr_code WHERE loan_detail_info.loan_balance > 1000000 ORDER BY loan_detail_info.loan_balance DESC;	2851656495
SELECT customer_id FROM user_behavior WHERE behavior_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY customer_id ORDER BY COUNT(DISTINCT behavior_type) DESC LIMIT 5;	875490154
SELECT SUM(stm_overdu), COUNT(DISTINCT xaccount) FROM credit_card_data WHERE corporation = 'Corp3' AND cycle_nbr = '2024-07-03';	4277933960
SELECT * FROM loan_detail_info WHERE cust_id = '1004';	3853460934
SELECT c.*, t.* FROM customer c LEFT JOIN transfer t ON c.id = t.source_customer_id OR c.id = t.target_customer_id;	3090102533
SELECT c.id, c.customer_name, ub.behavior_type, ub.behavior_date, lr.repayment_amount, lr.repayment_date FROM customer c LEFT JOIN user_behavior ub ON c.id = ub.customer_id LEFT JOIN loan_application la ON c.id = la.customer_id LEFT JOIN loan_repayment lr ON la.id = lr.loan_application_id;	1353951750
SELECT dai.cust_name, dai.acct_bal, dt.deposit_type_name FROM deposit_account_info dai JOIN deposit_type dt ON dai.acct_type_code = dt.deposit_type_id WHERE dai.data_dt = '2024-07-21' AND dai.acct_bal > 50000;	2088616407
SELECT c.id, c.customer_name, c.province, 
       SUM(l.loan_amount) AS customer_total,
       SUM(l.loan_amount) / SUM(SUM(l.loan_amount)) OVER (PARTITION BY c.province) * 100 AS percentage
FROM customer c JOIN loan_application l ON c.id = l.customer_id
GROUP BY c.id, c.customer_name, c.province;	130934854
SELECT DISTINCT ON (c.province) c.province, o.occupation_name FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN occupation o ON c.occupation_id = o.id WHERE la.status = '通过' GROUP BY c.province, o.occupation_name ORDER BY c.province, COUNT(*) FILTER (WHERE la.status = '通过')::float / COUNT(*) DESC;	3921482862
SELECT (SUM(top10.acct_bal) / SUM(total.total_balance)) AS ratio FROM (SELECT org_no, acct_bal FROM deposit_account_info WHERE org_no IN (SELECT bank_id FROM bank_orgnization WHERE bank_level = '分行') ORDER BY acct_bal DESC LIMIT 10) AS top10 JOIN (SELECT org_no, SUM(acct_bal) AS total_balance FROM deposit_account_info WHERE org_no IN (SELECT bank_id FROM bank_orgnization WHERE bank_level = '分行') GROUP BY org_no) AS total ON top10.org_no = total.org_no;	2823798793
SELECT cust_nm, tel_no FROM debit_card_information WHERE cust_nm LIKE '%Lee%';	1257769422
SELECT c.id, c.customer_name, ub.behavior_type, ub.behavior_date, lr.repayment_amount, lr.repayment_date FROM customer c LEFT JOIN user_behavior ub ON c.id = ub.customer_id LEFT JOIN loan_repayment lr ON c.id = (SELECT customer_id FROM loan_application WHERE id = lr.loan_application_id);	3060090955
SELECT DISTINCT c.id FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id JOIN loan_repayment lr ON lc.customer_id = lr.loan_application_id WHERE lc.credit_score > 0.75 AND lr.repayment_date = '2021-11-10';	1862922606
SELECT * FROM loan_repayment WHERE repayment_amount > 900;	2509103407
SELECT cust_no, cust_nm, card_no, residential_address FROM debit_card_information WHERE data_dt = '2024-07-09' AND card_state = '正常' AND residential_address = '987 Willow Street';	695694478
SELECT c.id, c.customer_name, l.loan_type, l.loan_amount, l.loan_balance FROM customer c JOIN loan_detail_info l ON c.id::text = l.cust_id;	834672780
SELECT lt.loan_type_name, COUNT(DISTINCT d.cust_id) AS user_count FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN customer c ON la.customer_id = c.id JOIN debit_card_information d ON c.id_number = d.cust_id GROUP BY lt.loan_type_name;	4144067238
SELECT loan_type_name, COUNT(DISTINCT customer_id) FROM loan_application JOIN loan_type ON loan_application.loan_type_id = loan_type.id GROUP BY loan_type_name;	2026869176
SELECT credit_score, description FROM loan_credit WHERE credit_date = '2011-04-13';	276439287
SELECT SUM(wealth_bal) AS total_wealth_balance, SUM(wealth_bal_f) AS total_guaranteed_wealth_balance FROM financial_products WHERE org_nm = '沈阳余淮支行' AND cust_type = '2' AND data_dt = '2024-07-14';	3759367452
SELECT customer_id, credit_score FROM loan_credit WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	854057318
SELECT source_customer_id, target_customer_id, transfer_amount, transfer_date FROM transfer;	4026685166
SELECT loan_type_name FROM loan_type WHERE loan_type_code = 'MORTGAGE';	3768964878
SELECT cust_nm, card_no FROM debit_card_information WHERE data_dt = '2024-07-05' AND card_state = '正常';	2031979235
SELECT fp.bank_nm, COUNT(*) AS product_count, dai.cust_type FROM financial_products fp JOIN deposit_account_info dai ON fp.cust_no = dai.cust_no GROUP BY fp.bank_nm, dai.cust_type;	1154484795
SELECT deposit_name, deposit_type_id FROM deposit_type ORDER BY deposit_name;	1534988899
SELECT c.customer_name, ls.loan_status_name, la.loan_amount FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN loan_status ls ON la.status = ls.loan_status_code;	3094943511
SELECT c.* FROM customer c INNER JOIN loan_credit lc ON c.id = lc.customer_id WHERE lc.credit_score = 0.77;	3794501166
SELECT lt.description, lr.* FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN loan_repayment lr ON la.id = lr.loan_application_id;	1460602722
SELECT rs_type_id, rs_type_name FROM five_level_classification;	3806586802
SELECT card_no, closing_date FROM debit_card_information WHERE closing_date > '2024-07-05';	4276410819
SELECT card_type_nm, card_state FROM debit_card_information WHERE card_type_nm IS NOT NULL;	3975346738
SELECT cust_id, SUM(loan_balance) FROM loan_detail_info WHERE dw_date = '2024-07-19' AND loan_balance > 100000 GROUP BY cust_id;	828477757
SELECT d.org_no, CORR(d.acct_bal, l.loan_balance) AS correlation_coefficient FROM deposit_account_info d JOIN loan_detail_info l ON d.org_no = l.loan_orgno GROUP BY d.org_no;	2234207790
SELECT 
    COALESCE(t.month, l.month) AS month,
    COALESCE(t.transfer_total, 0) AS transfer_total,
    COALESCE(l.loan_total, 0) AS loan_total
FROM 
    (SELECT TO_CHAR(transfer_date, 'YYYY-MM') AS month, SUM(transfer_amount) AS transfer_total FROM transfer GROUP BY month) t
FULL JOIN 
    (SELECT TO_CHAR(apply_date, 'YYYY-MM') AS month, SUM(loan_amount) AS loan_total FROM loan_application GROUP BY month) l
ON t.month = l.month
ORDER BY month;	1812141267
SELECT customer_name, phone_number FROM customer WHERE province = '上海市';	1984914783
SELECT credit_score, credit_date FROM loan_credit WHERE customer_id = 533302;	1612151566
SELECT * FROM transfer ORDER BY transfer_amount DESC;	1955324709
SELECT customer_id, COUNT(DISTINCT behavior_type) FROM user_behavior GROUP BY customer_id;	3342688355
SELECT COUNT(DISTINCT d.cust_no) FROM deposit_account_info d JOIN credit_card_data c ON d.cust_no = c.custr_nbr JOIN bank_orgnization b ON d.org_no = b.bank_id WHERE d.data_dt = '2024-07-22' AND d.acct_bal > 100000 AND c.stm_overdu > 5000 AND b.bank_name LIKE '%沈阳%';	3958858753
SELECT card_no, cust_nm FROM debit_card_information WHERE org_nm LIKE '%北京分行%';	4286151760
SELECT COUNT(DISTINCT customer_id) FROM (
    SELECT customer_id, DATE_TRUNC('month', apply_date) AS month,
           DATE_TRUNC('month', apply_date) - (ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY DATE_TRUNC('month', apply_date)) * INTERVAL '1 month') AS grp
    FROM loan_application
    GROUP BY customer_id, DATE_TRUNC('month', apply_date)
) t GROUP BY customer_id, grp HAVING COUNT(*) >= 3;	3229999001
SELECT cust_no, bank_nm FROM financial_products ORDER BY cust_no;	4182504410
SELECT occupation_code, occupation_name FROM occupation ORDER BY occupation_name;	917603455
SELECT COUNT(DISTINCT f.cust_no) FROM financial_products f JOIN debit_card_information d ON f.cust_no = d.cust_no WHERE f.wealth_bal > d.current_bal * 10;	3406337356
SELECT loan_orgno, loan_balance FROM loan_detail_info WHERE loan_amount > 70000;	1335793922
SELECT lt.loan_type_name, ub.behavior_type FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN customer c ON la.customer_id = c.id JOIN user_behavior ub ON c.id = ub.customer_id;	1151279551
SELECT bank_level, COUNT(*) FROM bank_orgnization GROUP BY bank_level;	954153971
SELECT current_bal, fixed_bal FROM debit_card_information WHERE data_dt = '2024-07-15' AND org_nm = '北京东单支行' AND cust_nm = 'Olivia Lee';	45765016
SELECT c.customer_name, lc.description FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id WHERE lc.credit_date = '2017-10-31' AND lc.credit_score > 0.85 ORDER BY lc.credit_score DESC;	3502920391
SELECT loan_amount FROM loan_application la JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_name = '汽车贷款';	1646074274
SELECT loan_type.loan_type_name, AVG(loan_repayment.repayment_amount), COUNT(loan_repayment.id) FROM loan_repayment JOIN loan_application ON loan_repayment.loan_application_id = loan_application.id JOIN loan_type ON loan_application.loan_type_id = loan_type.id GROUP BY loan_type.loan_type_name;	672526664
SELECT acc_name1, bank, category, day_opened FROM credit_card_data WHERE corporation = 'Corp3' ORDER BY day_opened DESC;	2466786763
SELECT customer_name, address FROM customer;	4227028668
SELECT b.bank_name, 
       SUM(l.loan_amount)/NULLIF(SUM(d.current_bal), 0) AS loan_to_debit_ratio 
FROM bank_orgnization b 
LEFT JOIN loan_detail_info l ON b.bank_id = l.loan_orgno AND EXTRACT(YEAR FROM l.dw_date) = 2023 
LEFT JOIN debit_card_information d ON b.bank_id = d.bank_no AND EXTRACT(YEAR FROM d.data_dt) = 2023 
GROUP BY b.bank_name;	2693621587
SELECT * FROM loan_repayment ORDER BY ABS(repayment_amount - (SELECT AVG(repayment_amount) FROM loan_repayment)) LIMIT 1;	4145982837
SELECT DISTINCT lc.customer_id FROM loan_credit lc JOIN financial_products fp ON lc.customer_id::text = fp.cust_no WHERE lc.credit_score > 0.8 AND lc.credit_date <= '2024-07-31' AND fp.data_dt >= '2024-07-01' AND fp.data_dt <= '2024-07-31';	1544259726
SELECT DATE_TRUNC('month', apply_date) AS month, COUNT(*) FILTER (WHERE status = 'APPROVED')::numeric / COUNT(*) AS approval_rate FROM loan_application GROUP BY month ORDER BY month;	1355078743
SELECT 
    b.bank_name,
    COUNT(DISTINCT u.customer_id) AS new_customer_count,
    AVG(l.loan_amount) AS avg_loan_amount
FROM 
    user_behavior u
JOIN 
    customer c ON u.customer_id = c.id
JOIN 
    loan_application l ON c.id = l.customer_id
JOIN 
    bank_orgnization b ON l.loan_type_id::text = b.bank_id
WHERE 
    u.behavior_type = '新开户'
    AND u.behavior_date BETWEEN '2024-01-01' AND '2024-03-31'
    AND l.apply_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY 
    b.bank_name;	1126971637
SELECT b.bank_name, AVG(l.loan_term) AS avg_loan_term, AVG(l.loan_amount) AS avg_loan_amount FROM loan_application l JOIN bank_orgnization b ON l.customer_id = b.bank_id GROUP BY b.bank_name;	3096647573
SELECT credit_score, credit_date FROM loan_credit;	1447870202
SELECT cust_id, loan_balance FROM loan_detail_info WHERE loandate_e < '2026';	3139357622
SELECT id, apply_date FROM loan_application;	2354889533
SELECT customer_id, loan_amount FROM loan_application la JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_name = '住房贷款' AND la.status = 'APPROVED' ORDER BY loan_amount DESC;	526851116
SELECT b1.bank_name, b2.bank_name FROM deposit_account_info d JOIN bank_orgnization b1 ON d.org_no = b1.bank_id JOIN bank_orgnization b2 ON b1.bank_parent = b2.bank_id GROUP BY b1.bank_name, b2.bank_name ORDER BY SUM(d.acct_bal) DESC LIMIT 5;	1791411839
SELECT * FROM loan_repayment WHERE description = '严琳';	2162165264
SELECT rs_type_name, COUNT(*) FROM five_level_classification GROUP BY rs_type_name;	76588831
SELECT rs_type_name, COUNT(*) FROM five_level_classification GROUP BY rs_type_name;	3941609286
SELECT b.bank_name, f.cust_no, f.wealth_bal FROM bank_orgnization b JOIN financial_products f ON b.bank_id = f.bank_no OR b.bank_id = f.org_no;	2101507672
SELECT loan_type_name, description FROM loan_type ORDER BY loan_type_code;	1923349382
SELECT bank_name, bank_parent FROM bank_orgnization WHERE bank_level = '2';	1121179521
SELECT province, customer_name, loan_amount FROM (SELECT c.province, c.customer_name, l.loan_amount, ROW_NUMBER() OVER(PARTITION BY c.province ORDER BY l.loan_amount DESC) AS rn FROM customer c JOIN loan_application l ON c.id = l.customer_id) t WHERE rn <= 3;	2484251331
SELECT * FROM transfer WHERE source_customer_id = 376252;	2203191109
SELECT c.customer_name, c.gender, o.occupation_name FROM customer c JOIN occupation o ON c.occupation_id = o.id;	2236467382
SELECT COUNT(DISTINCT f.cust_no) AS customer_count, SUM(f.wealth_bal_f) AS total_non_guaranteed_balance FROM financial_products f JOIN deposit_account_info d ON f.cust_no = d.cust_no WHERE d.org_nm = '沈阳余淮支行' AND EXTRACT(YEAR FROM f.data_dt) = 2024 AND EXTRACT(MONTH FROM f.data_dt) = 7 AND f.wealth_bal_f > 0;	2201430567
SELECT customer_id FROM loan_credit WHERE credit_score > 0.8;	1372106457
SELECT s.customer_name AS source_name, t.customer_name AS target_name, transfer.transfer_amount FROM transfer JOIN customer s ON transfer.source_customer_id = s.id JOIN customer t ON transfer.target_customer_id = t.id WHERE transfer.transfer_amount > 5000;	3513022788
SELECT customer_name FROM customer JOIN loan_application ON customer.id = loan_application.customer_id WHERE EXTRACT(YEAR FROM apply_date) = 2019 AND status = 'APPROVED';	2898422903
SELECT d.card_type, d.card_type_nm, COUNT(DISTINCT d.cust_no) AS customer_count, AVG(f.wealth_bal) AS avg_wealth_balance FROM debit_card_information d LEFT JOIN financial_products f ON d.cust_no = f.cust_no GROUP BY d.card_type, d.card_type_nm;	3077268751
SELECT c.customer_name, l.loan_amount FROM loan_application l JOIN customer c ON l.customer_id = c.id ORDER BY l.apply_date ASC;	1301921764
SELECT SUM(acct_bal) AS 账户余额总和, SUM(act_year_avg_bal) AS 实际年日均余额总和 FROM deposit_account_info WHERE data_dt = '2024-07-19' AND cust_type = 'P';	3969277636
SELECT c.customer_name, o.occupation_name FROM customer c JOIN loan_repayment lr ON c.id = lr.customer_id JOIN occupation o ON c.occupation_id = o.id WHERE lr.repayment_amount < 500;	3878396052
SELECT cust_name, acct_bal FROM deposit_account_info WHERE data_dt = '2023-07-19';	2773495410
SELECT c.*, d.acct_bal, l.* FROM customer c JOIN (SELECT cust_no, acct_bal FROM deposit_account_info ORDER BY acct_bal DESC LIMIT 1) d ON c.id_number = d.cust_no JOIN (SELECT * FROM loan_application WHERE customer_id = (SELECT c.id FROM customer c JOIN deposit_account_info d ON c.id_number = d.cust_no ORDER BY d.acct_bal DESC LIMIT 1) ORDER BY apply_date DESC LIMIT 1) l ON c.id = l.customer_id;	309023757
SELECT occupation_id, COUNT(*) FROM customer GROUP BY occupation_id;	978163931
SELECT customer.customer_name, transfer.transfer_amount FROM transfer JOIN customer ON transfer.source_customer_id = customer.id WHERE transfer.transfer_date = '2016-06-11' AND transfer.transfer_amount > 5000 ORDER BY transfer.transfer_amount DESC;	641452553
SELECT l.cust_id, l.loan_balance, l.loan_type, c.curr_full_name FROM loan_detail_info l JOIN currency c ON l.currency_type = c.curr_code WHERE l.loandate_s::date > '2024-07-01' AND l.loan_balance > 1000000 ORDER BY l.loan_balance DESC;	1351088256
SELECT * FROM user_behavior WHERE behavior_date = '2018-06-26';	583833982
SELECT * FROM loan_repayment WHERE EXTRACT(DOW FROM repayment_date) IN (0, 6);	2116101795
SELECT d.acct_type_code, l.loan_type, COUNT(DISTINCT d.cust_no) AS customer_count FROM deposit_account_info d JOIN loan_detail_info l ON d.cust_no = l.cust_id GROUP BY d.acct_type_code, l.loan_type ORDER BY customer_count DESC;	985889089
SELECT c.customer_name, lr.repayment_amount FROM loan_repayment lr JOIN loan_application la ON lr.loan_application_id = la.id JOIN customer c ON la.customer_id = c.id WHERE lr.repayment_date = '2021-11-10' AND lr.repayment_amount > 20 ORDER BY lr.repayment_amount DESC;	2925851112
SELECT loan_type_name, AVG(credit_score) FROM loan_credit lc JOIN loan_application la ON lc.customer_id = la.customer_id JOIN loan_type lt ON la.loan_type_id = lt.id GROUP BY loan_type_name;	714042771
SELECT loan_type_code, loan_type_name FROM loan_type WHERE loan_type_code IS NOT NULL;	3725846926
SELECT ls.loan_status_name, COUNT(la.id) FROM loan_status ls LEFT JOIN loan_application la ON ls.loan_status_code = la.status GROUP BY ls.loan_status_name;	128551642
SELECT customer_id, description FROM loan_credit;	1070169294
SELECT c.customer_name, c.id_number, c.phone_number, d.card_no, d.current_bal FROM customer c JOIN debit_card_information d ON c.id_number = d.cust_id WHERE d.open_date = '2024-07-15' AND d.org_nm = '北京东单支行';	3530929289
SELECT cust_type, SUM(loan_amount) FROM deposit_account_info d JOIN loan_detail_info l ON d.cert_code = l.cust_id GROUP BY cust_type ORDER BY cust_type;	2475731730
SELECT iou_no FROM loan_detail_info ORDER BY (loan_balance/loan_amount) DESC LIMIT 10;	2108379659
SELECT customer_id, SUM(loan_amount) FROM loan_application la JOIN loan_type lt ON la.loan_type_id = lt.id WHERE EXTRACT(YEAR FROM apply_date) = 2019 AND lt.loan_type_name = '住房贷款' AND la.status = 'REJECTED' GROUP BY customer_id;	3717149823
SELECT * FROM bank_orgnization;	1463400602
SELECT l.*, c.curr_full_name, f.rs_type_name FROM loan_detail_info l JOIN currency c ON l.currency_type = c.curr_code JOIN five_level_classification f ON l.judgelevel = f.rs_type_id WHERE l.dw_date = '2024-07-22' AND l.loan_balance > 10000;	3647903773
SELECT card_state, open_date FROM debit_card_information WHERE card_state = '正常';	190467620
SELECT c.customer_name, t.transfer_amount, t.transfer_date FROM transfer t JOIN customer c ON t.source_customer_id = c.id WHERE t.transfer_date = '2023-06-30' ORDER BY t.transfer_amount DESC;	1357323463
SELECT bank_level, bank_name FROM bank_orgnization WHERE data_dt = '2023-06-30';	1614074594
SELECT cust_no, SUM(wealth_bal) FROM financial_products WHERE data_dt = '2024-07-02' AND cast_type = '非保本' GROUP BY cust_no ORDER BY SUM(wealth_bal) DESC;	1411048057
SELECT SUM(loan_amount) FROM loan_application WHERE EXTRACT(YEAR FROM apply_date) = 2019 AND status = 'REJECTED';	2743985170
SELECT org_nm, SUM(acct_bal) FROM deposit_account_info WHERE data_dt = '2024-07-21' AND cust_type = '2' AND org_no IN (SELECT bank_id FROM bank_orgnization WHERE bank_parent = '杭州分行') GROUP BY org_nm;	1124781975
SELECT c.id, COALESCE(SUM(lr.repayment_amount), 0) AS total_repayment, COUNT(DISTINCT ub.id) AS behavior_count, CASE WHEN COUNT(lr.id) = 0 THEN 0 ELSE COALESCE(SUM(lr.repayment_amount), 0)/COUNT(lr.id) END AS avg_repayment FROM customer c LEFT JOIN loan_application la ON c.id = la.customer_id LEFT JOIN loan_repayment lr ON la.id = lr.loan_application_id LEFT JOIN user_behavior ub ON c.id = ub.customer_id GROUP BY c.id;	1877601035
SELECT bank_name, bank_level, data_dt FROM bank_orgnization;	3704765747
WITH top_depositors AS (
    SELECT cust_no, acct_bal 
    FROM deposit_account_info 
    WHERE acct_bal >= (SELECT percentile_cont(0.9) WITHIN GROUP (ORDER BY acct_bal) FROM deposit_account_info)
)
SELECT c.customer_name, d.acct_bal, o.occupation_name 
FROM top_depositors d
JOIN customer c ON d.cust_no = c.id_number
JOIN occupation o ON c.occupation_id = o.id
WHERE NOT EXISTS (SELECT 1 FROM loan_application l WHERE l.customer_id = c.id);	1929928822
SELECT c.province, COUNT(CASE WHEN la.status = '已批准' THEN 1 END)::float / COUNT(*) AS success_rate FROM loan_application la JOIN customer c ON la.customer_id = c.id GROUP BY c.province;	693366950
SELECT cust_no, cust_name, acct_bal FROM deposit_account_info WHERE data_dt >= '2023-07-01' AND data_dt < '2023-08-01';	2017141047
SELECT DISTINCT d.org_nm FROM deposit_account_info d JOIN bank_orgnization b ON d.org_no = b.bank_id WHERE d.data_dt = '2023-06-30' AND d.acct_bal > 100000 AND d.cur_type = '美元';	2208770845
SELECT dai.cust_name, dai.acct_type_code, dai.acct_bal, c.curr_full_name FROM deposit_account_info dai JOIN currency c ON dai.cur_type = c.curr_code WHERE dai.data_dt = '2024-07-19' AND dai.acct_bal > 100000;	2411764640
SELECT cust_nm, card_no FROM debit_card_information WHERE card_state = '正常' AND open_date > '2024-07-01' ORDER BY open_date DESC;	2948516213
SELECT deposit_name, deposit_type_id FROM deposit_type ORDER BY deposit_name;	2373067027
WITH top_customers AS (SELECT source_customer_id FROM transfer GROUP BY source_customer_id ORDER BY COUNT(*) DESC LIMIT 10), ranked_amounts AS (SELECT source_customer_id, transfer_amount, ROW_NUMBER() OVER (PARTITION BY source_customer_id ORDER BY COUNT(*) DESC) AS rn FROM transfer WHERE source_customer_id IN (SELECT source_customer_id FROM top_customers) GROUP BY source_customer_id, transfer_amount) SELECT source_customer_id, transfer_amount FROM ranked_amounts WHERE rn = 1;	758507051
SELECT COUNT(DISTINCT c.id) AS customer_count, COALESCE(SUM(l.loan_balance), 0) AS total_loan_balance FROM customer c JOIN credit_card_data cc ON c.id_number = cc.custr_nbr JOIN loan_detail_info l ON c.id_number = l.cust_id WHERE c.province = '上海市' AND cc.acct_sts = '正常';	3655735172
SELECT l.*, f.rs_type_name, t.loan_type_name FROM loan_detail_info l JOIN five_level_classification f ON l.judgelevel = f.rs_type_id JOIN loan_type t ON l.loan_type = t.loan_type_code WHERE l.dw_date = '2024-07-22' AND l.loan_balance > 15000;	2721235050
SELECT COUNT(DISTINCT a.cust_id) 
FROM loan_detail_info a 
JOIN loan_detail_info b ON a.cust_id = b.cust_id 
WHERE a.loan_type = '房贷' AND b.loan_type = '车贷' AND a.loan_amount > b.loan_amount;	4255369233
SELECT c.customer_name, SUM(d.current_bal) AS total_balance FROM debit_card_information d JOIN bank_orgnization b ON d.bank_no = b.bank_id JOIN customer c ON d.cust_no = c.id_number WHERE b.bank_name = '杭州上城区支行' AND d.data_dt = '2024-07-19' GROUP BY c.customer_name ORDER BY total_balance DESC;	2277646392
SELECT vouch_type, AVG(loan_amount) AS avg_loan_amount, percentile_cont(0.5) WITHIN GROUP (ORDER BY loan_amount) AS median_loan_amount, percentile_cont(0.75) WITHIN GROUP (ORDER BY loan_amount) - percentile_cont(0.25) WITHIN GROUP (ORDER BY loan_amount) AS iqr_loan_amount FROM loan_detail_info GROUP BY vouch_type;	3239376234
SELECT SUM(t.transfer_amount) FROM transfer t WHERE t.transfer_date = '2020-11-03' AND EXISTS (SELECT 1 FROM loan_credit lc WHERE lc.customer_id = t.source_customer_id AND lc.credit_score > 0.8) AND EXISTS (SELECT 1 FROM loan_credit lc WHERE lc.customer_id = t.target_customer_id AND lc.credit_score > 0.8);	3541568339
SELECT COUNT(*) FROM loan_application la JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id WHERE la.loan_amount > 50000 AND o.occupation_name = '护士';	1123257910
SELECT la.*, c.* FROM loan_application la JOIN customer c ON la.customer_id = c.id WHERE la.apply_date BETWEEN '2024-07-01' AND '2024-07-31';	820431444
SELECT 
    TO_CHAR(apply_date, 'YYYY-MM') AS month,
    COUNT(*) FILTER (WHERE status = '通过') * 100.0 / COUNT(*) AS approval_rate
FROM loan_application
GROUP BY TO_CHAR(apply_date, 'YYYY-MM')
ORDER BY month;	2667178372
SELECT org_nm, SUM(wealth_bal) FROM financial_products WHERE data_dt = '2024-07-02' AND cust_type = '2' GROUP BY org_nm;	130622905
SELECT c.*, l.status FROM customer c LEFT JOIN loan_application l ON c.id = l.customer_id;	4174863363
SELECT loan_type_name, COUNT(DISTINCT customer_id) AS customer_count, SUM(loan_amount) AS total_amount FROM loan_application JOIN loan_type ON loan_application.loan_type_id = loan_type.id GROUP BY loan_type_name;	3814340700
SELECT CASE WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 0 AND 20 THEN '0-20' WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 21 AND 40 THEN '21-40' WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 41 AND 60 THEN '41-60' ELSE '61+' END AS age_group, COUNT(CASE WHEN la.status = '通过' THEN 1 END)::FLOAT/COUNT(*) AS approval_rate FROM loan_application la JOIN customer c ON la.customer_id = c.id GROUP BY age_group;	3039598050
SELECT repayment_amount, repayment_date FROM loan_repayment WHERE loan_application_id = 323803;	684098334
SELECT c.id, lc.credit_score FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id JOIN bank_orgnization bo ON c.province = bo.bank_name WHERE bo.bank_name = '杭州上城区支行' AND lc.credit_date = '2023-06-30' ORDER BY lc.credit_score DESC LIMIT 1;	2020704797
SELECT * FROM loan_repayment WHERE repayment_date < '2020-02-25';	3613008055
SELECT t.* FROM transfer t JOIN customer c ON t.source_customer_id = c.id OR t.target_customer_id = c.id WHERE c.customer_name = '关飞';	1250415044
SELECT c.customer_name, c.id_number, ls.loan_status_name FROM customer c LEFT JOIN loan_application la ON c.id = la.customer_id LEFT JOIN loan_status ls ON la.status = ls.loan_status_code;	1513848555
SELECT * FROM user_behavior WHERE behavior_type LIKE '%ILL%';	921285205
SELECT * FROM transfer ORDER BY transfer_amount ASC;	1784808376
SELECT * FROM user_behavior WHERE description IS NOT NULL;	1450251644
SELECT d.current_bal FROM debit_card_information d JOIN customer c ON d.cust_id = c.id_number WHERE c.customer_name = 'James Taylor' AND d.org_nm = '杭州上城区支行' AND d.data_dt = '2024-07-09';	2152314580
SELECT loan_type_name FROM loan_type WHERE description LIKE '%Loan%';	4164431702
SELECT c.curr_num, cu.curr_full_name, COUNT(*) AS account_count FROM credit_card_data c JOIN currency cu ON c.curr_num = cu.curr_code GROUP BY c.curr_num, cu.curr_full_name;	1368623184
SELECT AVG(wealth_t_m_avg_bal_a) FROM financial_products;	399556639
SELECT loan_type_name, description FROM loan_type WHERE id IN (SELECT loan_type_id FROM loan_application WHERE status = 'APPROVED');	4055303490
SELECT c.customer_name, EXTRACT(YEAR FROM age(c.birth_date)) AS age, l.loan_amount FROM customer c JOIN loan_application l ON c.id = l.customer_id WHERE EXTRACT(YEAR FROM l.apply_date) = 2023 ORDER BY age DESC LIMIT 5;	4242939153
SELECT COUNT(DISTINCT c.id) FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id JOIN bank_orgnization bo ON c.province = bo.bank_name WHERE bo.bank_name = '杭州上城区支行' AND lc.credit_score > 0.75 AND lc.credit_date = '2023-06-30';	2373959946
SELECT rs_type_name, COUNT(*) FROM five_level_classification WHERE data_dt = '2024-07-22' GROUP BY rs_type_name;	3345826641
SELECT f.rs_type_name, COUNT(ub.id) FROM five_level_classification f JOIN loan_detail_info l ON f.rs_type_id = l.judgelevel JOIN customer c ON l.cust_id = c.id_number JOIN user_behavior ub ON c.id = ub.customer_id GROUP BY f.rs_type_name;	4002524997
SELECT * FROM transfer ORDER BY transfer_date;	3440883843
SELECT d.card_type, d.card_type_nm, d.card_state FROM debit_card_information d JOIN bank_orgnization b ON d.org_no = b.bank_id JOIN customer c ON d.cust_id = c.id_number WHERE b.bank_name = '杭州上城区支行' AND c.customer_name = 'James Taylor' AND d.data_dt >= '2024-07-01' AND d.data_dt < '2024-08-01';	2903014629
SELECT SUM(wealth_bal) FROM financial_products WHERE data_dt = '2024-07-02'::timestamp AND currency = 'USD';	3876498515
SELECT c.id, COUNT(ub.id) AS behavior_count, 
(SELECT lc.credit_score FROM loan_credit lc WHERE lc.customer_id = c.id ORDER BY lc.credit_date DESC LIMIT 1) AS latest_credit_score 
FROM customer c LEFT JOIN user_behavior ub ON c.id = ub.customer_id 
GROUP BY c.id ORDER BY c.id;	4258165101
SELECT c1.customer_name AS source_customer, c2.customer_name AS target_customer, t.transfer_amount FROM transfer t JOIN customer c1 ON t.source_customer_id = c1.id JOIN customer c2 ON t.target_customer_id = c2.id WHERE t.transfer_date = '2023-06-30' AND t.transfer_amount > 1000;	1167360749
SELECT * FROM customer WHERE customer_name = '饶丽';	1853157405
SELECT card_no, cust_nm FROM debit_card_information WHERE data_dt = '2024-07-14' AND card_state = '正常';	856149789
SELECT c.customer_name, f.rs_type_name, cu.curr_full_name, l.loan_balance FROM loan_detail_info l JOIN five_level_classification f ON l.judgelevel = f.rs_type_id JOIN currency cu ON l.currency_type = cu.curr_code JOIN customer c ON l.cust_id = c.id_number WHERE l.loan_balance > 500000 AND l.dw_date = '2024-07-19' ORDER BY l.loan_balance DESC;	12643482
SELECT COUNT(DISTINCT d.cust_no) FROM deposit_account_info d JOIN customer c ON d.cert_code = c.id_number WHERE d.data_dt = '2024-07-19' AND d.org_nm LIKE '%沈阳%' AND d.acct_bal > 100000 AND c.gender = '男';	3675937964
SELECT * FROM loan_type WHERE loan_type_name = '汽车贷款';	517341637
SELECT c.customer_name, l.loan_amount FROM customer c JOIN loan_application l ON c.id = l.customer_id WHERE l.loan_amount > 10000;	317385728
SELECT 
    c.id,
    c.customer_name,
    (COALESCE(SUM(d.acct_bal), 0) / NULLIF(COUNT(DISTINCT d.cust_no), 0) + 
     COALESCE(lc.credit_score, 0) + 
     COALESCE(SUM(lr.repayment_amount), 0) / NULLIF(COUNT(DISTINCT lr.id), 0)) / 3 AS composite_score
FROM 
    customer c
LEFT JOIN 
    deposit_account_info d ON c.id::text = d.cust_no
LEFT JOIN 
    loan_credit lc ON c.id = lc.customer_id
LEFT JOIN 
    loan_application la ON c.id = la.customer_id
LEFT JOIN 
    loan_repayment lr ON la.id = lr.loan_application_id
GROUP BY 
    c.id, c.customer_name, lc.credit_score
ORDER BY 
    composite_score DESC
LIMIT 20;	162793313
SELECT occupation_code, description FROM occupation WHERE occupation_name = '护士';	1226891061
SELECT ub.customer_id, ub.behavior_type, ub.behavior_date, ub.description, lc.credit_score, lc.credit_date 
FROM user_behavior ub 
JOIN loan_credit lc ON ub.customer_id = lc.customer_id 
WHERE ub.behavior_date BETWEEN '2021-08-01' AND '2021-08-31';	3649901835
SELECT loan_type_name AS type_name, description FROM loan_type
UNION ALL
SELECT loan_status_name AS type_name, description FROM loan_status;	2345937214
SELECT org_nm, SUM(wealth_bal) FROM financial_products fp JOIN deposit_account_info dai ON fp.cust_no = dai.cust_no WHERE fp.data_dt = '2024-07-02' AND dai.cust_type = '2' GROUP BY org_nm;	726948157
SELECT DISTINCT c.id FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_name = '住房贷款' AND la.apply_date BETWEEN '2019-01-01' AND '2019-12-31' AND la.status = 'REJECTED';	428507464
SELECT cust_no, wealth_bal FROM financial_products WHERE data_dt = '2024-07-19' AND wealth_bal > 100000 ORDER BY wealth_bal DESC;	1610322845
SELECT customer_name, email FROM customer;	377073913
SELECT customer_id, date_trunc('quarter', apply_date) AS quarter, COUNT(CASE WHEN status = 'approved' THEN 1 END)::float/COUNT(*) AS success_rate FROM loan_application GROUP BY customer_id, quarter ORDER BY customer_id, quarter;	1405120881
SELECT cust_name, acct_bal FROM deposit_account_info WHERE data_dt = '2024-07-19'::timestamp AND cur_type = 'USD' ORDER BY acct_bal DESC;	965817749
SELECT customer_name, id_number, phone_number, email FROM customer WHERE birth_date > '1980-01-01';	311014935
SELECT o.occupation_name FROM loan_application la JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id ORDER BY la.loan_amount DESC LIMIT 5;	946337978
SELECT cust_type, loan_balance FROM loan_detail_info;	2702285633
SELECT 
    SUM(d.acct_bal) AS total_current_balance,
    SUM(d.fixed_bal) AS total_fixed_balance
FROM 
    debit_card_information dc
JOIN 
    deposit_account_info d ON dc.cust_no = d.cust_no
WHERE 
    dc.org_nm LIKE '%杭州上城区支行%' 
    AND dc.data_dt = '2023-06-30' 
    AND d.data_dt = '2023-06-30';	1617148541
AMBIGUOUS_QUERY	1580416554
SELECT * FROM customer WHERE id_number = 'c839d762-6392-4005-8386-ed4e2c50997a';	1114816707
SELECT credit_score, description FROM loan_credit WHERE credit_date = '2003-06-22';	808510096
SELECT cust_no, cust_name FROM deposit_account_info JOIN bank_orgnization ON deposit_account_info.org_no = bank_orgnization.bank_id WHERE bank_orgnization.bank_name = '杭州分行' AND deposit_account_info.data_dt = '2024-07-21' AND deposit_account_info.acct_bal > 50000;	3305168434
SELECT l.cust_id, l.loan_balance, d.acct_bal FROM loan_detail_info l JOIN deposit_account_info d ON l.cust_id = d.cust_no WHERE l.loan_balance > 10000;	3107729998
SELECT rs_type_name, COUNT(DISTINCT cust_id) AS user_count, SUM(loan_balance) AS total_loan_balance FROM loan_detail_info l JOIN five_level_classification f ON l.judgelevel = f.rs_type_id GROUP BY rs_type_name;	3912588693
SELECT deposit_name FROM deposit_type WHERE data_dt = '2024-07-22';	158646132
SELECT * FROM transfer WHERE transfer_amount > 500;	3617397322
SELECT c.customer_name, c.id_number, lc.credit_score FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id WHERE c.province = '河北省' AND lc.credit_score > 0.8 ORDER BY lc.credit_score DESC;	397932156
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 20 AND 30 THEN '20-30岁'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 31 AND 40 THEN '31-40岁'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, c.birth_date)) BETWEEN 41 AND 50 THEN '41-50岁'
        ELSE '51岁以上'
    END AS age_group,
    lt.loan_type_name,
    ROUND(100.0 * SUM(CASE WHEN la.status = '批准' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate
FROM customer c
JOIN loan_application la ON c.id = la.customer_id
JOIN loan_type lt ON la.loan_type_id = lt.id
GROUP BY age_group, lt.loan_type_name
ORDER BY age_group, lt.loan_type_name;	269454572
SELECT ls.loan_status_name, o.occupation_name FROM loan_status ls JOIN loan_application la ON ls.loan_status_code = la.status JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id WHERE o.occupation_code = 'NURSE' AND la.status = 'APPROVED';	3026164558
SELECT occupation.occupation_name, COUNT(customer.id), AVG(loan_application.loan_amount) FROM customer JOIN occupation ON customer.occupation_id = occupation.id JOIN loan_application ON loan_application.customer_id = customer.id GROUP BY occupation.occupation_name HAVING COUNT(customer.id) > 100;	308222457
SELECT cust_no FROM financial_products fp JOIN bank_orgnization bo ON fp.org_no = bo.bank_id JOIN currency c ON fp.currency = c.curr_code WHERE fp.data_dt = '2024-07-14' AND bo.bank_name = '沈阳余淮支行' AND c.curr_full_name = '新加坡元' AND fp.wealth_bal_f > 0;	2469695932
SELECT id_number, phone_number FROM customer;	425374562
SELECT cust_nm, open_date FROM debit_card_information WHERE open_date >= '2024-07-05';	2892564169
SELECT COUNT(DISTINCT fp.cust_no) FROM financial_products fp JOIN (SELECT cust_no FROM financial_products WHERE wealth_bal >= (SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY wealth_bal) FROM financial_products)) top_cust ON fp.cust_no = top_cust.cust_no JOIN user_behavior ub ON ub.customer_id::text = fp.cust_no WHERE ub.behavior_type = '登录' AND ub.behavior_date >= CURRENT_DATE - INTERVAL '30 days';	1640385150
SELECT lc.customer_id, lc.credit_score FROM loan_credit lc JOIN user_behavior ub ON lc.customer_id = ub.customer_id WHERE lc.credit_date = '2023-12-10';	3377906541
SELECT bank_id, bank_name FROM bank_orgnization;	365779440
SELECT lr.*, la.* FROM loan_repayment lr JOIN loan_application la ON lr.loan_application_id = la.id WHERE lr.repayment_date = '2024-01-20';	798971312
SELECT c.curr_code, c.curr_full_name, COUNT(t.id) AS transfer_count FROM currency c LEFT JOIN transfer t ON t.transfer_date < '2023-06-30' WHERE c.curr_class = '外币' AND c.data_dt = '2023-06-30' GROUP BY c.curr_code, c.curr_full_name;	1756912532
SELECT repayment_amount FROM loan_repayment WHERE repayment_date = '2021-11-10' AND loan_application_id = 742969;	3898093211
SELECT dt.deposit_type_name, AVG(ldi.loan_amount) AS avg_loan_amount, STDDEV(ldi.loan_amount) AS stddev_loan_amount FROM loan_detail_info ldi JOIN deposit_account_info dai ON ldi.cust_id = dai.cust_no JOIN deposit_type dt ON dai.acct_type_code = dt.deposit_type_id GROUP BY dt.deposit_type_name;	2131176144
SELECT c.customer_name, o.occupation_name, lr.repayment_date FROM customer c JOIN occupation o ON c.occupation_id = o.id JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id;	784123269
SELECT lt.loan_type_name, 
       AVG(la.loan_amount) AS avg_loan_amount, 
       AVG(dai.acct_bal) AS avg_deposit_balance
FROM loan_application la
JOIN loan_type lt ON la.loan_type_id = lt.id
JOIN customer c ON la.customer_id = c.id
JOIN deposit_account_info dai ON c.id_number = dai.cert_code
GROUP BY lt.loan_type_name;	1431165151
SELECT COUNT(DISTINCT la.customer_id) FROM loan_application la INNER JOIN user_behavior ub ON la.customer_id=ub.customer_id WHERE la.apply_date='2019-01-10' AND la.status='REJECTED' AND ub.behavior_date='2017-10-24' AND ub.behavior_type='LOGIN';	2469033655
SELECT customer.customer_name, loan_application.loan_amount FROM customer JOIN loan_application ON customer.id = loan_application.customer_id JOIN loan_credit ON customer.id = loan_credit.customer_id WHERE EXTRACT(YEAR FROM loan_application.apply_date) = 2019 AND loan_credit.credit_score > 0.8 ORDER BY loan_application.loan_amount DESC;	398304766
SELECT * FROM loan_detail_info WHERE loan_balance > 500000 ORDER BY loan_balance DESC;	3521704142
SELECT customer_id, credit_score FROM loan_credit WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	1896500682
SELECT customer_name, birth_date FROM customer WHERE birth_date > '1990-01-01';	1933728727
SELECT customer_id, MAX(credit_score) - MIN(credit_score) AS score_increase 
FROM loan_credit 
WHERE credit_date >= CURRENT_DATE - INTERVAL '1 year' 
GROUP BY customer_id 
ORDER BY score_increase DESC 
LIMIT 5;	3124021686
SELECT behavior_type, COUNT(DISTINCT customer_id) FROM user_behavior GROUP BY behavior_type;	3585096464
SELECT 
    a.acct_type_code,
    COUNT(DISTINCT CASE WHEN b.cust_no IS NOT NULL THEN a.cust_no END) * 100.0 / COUNT(DISTINCT a.cust_no) AS retention_rate
FROM 
    (SELECT DISTINCT acct_type_code, cust_no FROM deposit_account_info WHERE data_dt <= CURRENT_DATE - INTERVAL '1 year') a
LEFT JOIN 
    (SELECT DISTINCT acct_type_code, cust_no FROM deposit_account_info WHERE data_dt > CURRENT_DATE - INTERVAL '1 year') b 
ON a.acct_type_code = b.acct_type_code AND a.cust_no = b.cust_no
GROUP BY a.acct_type_code;	677634919
SELECT SUM(t.transfer_amount) FROM transfer t JOIN customer c ON t.source_customer_id = c.id JOIN bank_orgnization b ON c.province = '沈阳' AND b.bank_name = '沈阳分行' WHERE t.transfer_date = '2024-07-19';	3094639947
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.profit) DESC LIMIT 1;	1003634069
SELECT profit, sales_quantity FROM salesstatistics;	3101430966
AMBIGUOUS_QUERY	2117960535
SELECT employees.* FROM employees JOIN salesorders ON employees.employee_id = salesorders.employee_id JOIN stores ON salesorders.store_id = stores.store_id WHERE salesorders.order_date = '2023-05-05' AND stores.store_name = '数码广场' AND salesorders.total_amount > 7000;	941218200
SELECT * FROM salesstatistics ORDER BY profit DESC LIMIT 1;	1332840948
SELECT s.store_name, e.name, ss.sales_amount, p.product_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND ss.sales_amount > 10000 AND p.supplier_name = '苹果官方旗舰店' ORDER BY ss.sales_amount DESC;	3240310596
SELECT DISTINCT p.product_name, p.supplier_name FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN stores s ON so.store_id = s.store_id WHERE s.store_name = '电子城旗舰店';	717197329
SELECT s.store_name, e.position FROM products p JOIN orderdetails od ON p.product_id=od.product_id JOIN salesorders so ON od.order_id=so.order_id JOIN employees e ON so.employee_id=e.employee_id JOIN stores s ON so.store_id=s.store_id WHERE p.product_name='iPad Air' AND so.order_date='2023-05-09';	1628648561
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	2064785597
SELECT e.name, s.total_amount FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id WHERE s.order_date = '2023-05-07' AND s.total_amount > 10000;	3560785170
SELECT s.store_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND date_trunc('month', ss.date) = '2023-05-01' GROUP BY s.store_name HAVING SUM(ss.profit) > 5000;	251536917
SELECT DISTINCT e.employee_id, e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'Nintendo Switch' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 5000;	634768311
SELECT p.product_name, s.profit FROM products p JOIN salesstatistics s ON p.product_id = s.product_id ORDER BY s.sales_amount DESC LIMIT 1;	725261436
SELECT od.order_detail_id, od.order_id, p.product_name, so.total_amount FROM orderdetails od JOIN products p ON od.product_id = p.product_id JOIN salesorders so ON od.order_id = so.order_id;	1323416994
SELECT e.name, s.store_name FROM employees e JOIN stores s ON e.store_id = s.store_id;	513278066
SELECT s.manager_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id WHERE so.order_date = '2023-05-08' GROUP BY s.manager_name;	3418908967
SELECT s.order_id, e.name FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id WHERE s.total_amount > 7000;	1868084525
SELECT s.store_name, e.name, ss.sales_amount, p.product_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND ss.sales_amount > 10000 AND p.supplier_name = '苹果官方旗舰店';	3487107783
AMBIGUOUS_QUERY	556239338
SELECT * FROM salesorders WHERE order_id = 'b8b62bfe-a35d-4ff5-9bc9-654b5f67fed2';	2327152729
SELECT e.employee_id, SUM(s.total_amount) FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id GROUP BY e.employee_id;	3589036319
SELECT product_id, sale_price, purchase_price FROM products;	3750652945
SELECT e.name, s.manager_name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY e.name, s.manager_name HAVING SUM(so.total_amount) > 10000;	148577634
AMBIGUOUS_QUERY	693418076
SELECT s.store_name, e.name, ss.profit FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-07' AND p.product_name = 'Apple Watch Series 7';	1476013456
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id WHERE so.order_date = '2023-05-05' AND so.total_amount > 10000 AND EXISTS (SELECT 1 FROM orderdetails od JOIN products p ON od.product_id = p.product_id WHERE od.order_id = so.order_id AND p.sale_price > 5000);	3645006631
SELECT o.order_id, p.product_name, o.quantity FROM orderdetails o JOIN products p ON o.product_id = p.product_id;	1046575296
SELECT * FROM salesorders WHERE store_id = '0887d06a-27a8-46b4-98d6-514702e698da';	1550748576
SELECT DISTINCT s.employee_id FROM salesstatistics s JOIN salesorders o ON s.order_id = o.order_id JOIN orderdetails d ON o.order_id = d.order_id WHERE s.date BETWEEN '2023-05-01' AND '2023-05-31' AND s.sales_quantity > d.quantity;	2462853793
SELECT s.store_name, SUM(so.total_amount) FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-01' GROUP BY s.store_name;	1349452785
SELECT p.product_id, SUM(od.quantity) AS sales_quantity, so.order_date FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id GROUP BY p.product_id, so.order_date;	3541158395
SELECT s.store_name, s.manager_name FROM stores s WHERE s.store_id = (SELECT so.store_id FROM salesorders so WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY so.store_id ORDER BY SUM(so.total_amount) DESC LIMIT 1);	3496741770
AMBIGUOUS_QUERY	2485376576
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-07' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2624059207
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND so.order_date = '2023-05-01' AND so.total_amount > 8000;	509381804
SELECT purchase_price, sale_price FROM products;	535494901
SELECT unit_price, quantity FROM orderdetails;	3918531592
SELECT e.name, s.store_name FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN products p ON ss.product_id = p.product_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = 'Apple Watch Series 7' AND ss.date = '2023-05-06';	4213276457
SELECT store_name, SUM(sales_amount) FROM salesstatistics JOIN stores USING(store_id) GROUP BY store_name ORDER BY SUM(sales_quantity) DESC LIMIT 1;	1019928378
SELECT DISTINCT e.name, p.category_name FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE s.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND s.total_amount > 10000;	1374387165
SELECT e.employee_id, e.name, s.store_name, SUM(so.total_amount) FROM employees e JOIN stores s ON e.store_id = s.store_id JOIN salesorders so ON e.employee_id = so.employee_id GROUP BY e.employee_id, e.name, s.store_name;	765173051
SELECT s.store_name, SUM(so.total_amount) AS total_sales, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_id;	1497182476
SELECT p.product_name, od.quantity, od.unit_price, o.order_date FROM orderdetails od JOIN salesorders o ON od.order_id = o.order_id JOIN products p ON od.product_id = p.product_id WHERE o.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND od.quantity > 5;	1106161896
SELECT p.product_name, SUM(s.sales_quantity) AS total_sales, p.sale_price FROM products p JOIN salesstatistics s ON p.product_id = s.product_id GROUP BY p.product_name, p.sale_price;	1170519624
SELECT s.store_name, s.manager_name, ss.profit FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-01' AND p.product_name = '佳能EOS R6';	834717526
SELECT store_name, address, phone FROM stores;	2895234210
SELECT s.order_id, p.product_name FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id JOIN products p ON o.product_id = p.product_id WHERE s.total_amount < 5000;	710749857
SELECT s.store_name, e.name, SUM(ss.sales_quantity) AS total_quantity, SUM(ss.profit) AS total_profit FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, e.name ORDER BY total_quantity DESC LIMIT 1;	1055484680
SELECT s.store_name, SUM(ss.profit) AS total_profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '小米电视4A' AND ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' GROUP BY s.store_name;	1417436330
SELECT e.name, SUM(s.profit) FROM employees e JOIN salesstatistics s ON e.employee_id = s.employee_id JOIN stores st ON s.store_id = st.store_id JOIN products p ON s.product_id = p.product_id WHERE s.date = '2023-05-06' AND st.store_name = '智慧街店' AND p.product_name = '小米电视4A' GROUP BY e.name;	3793589229
SELECT store_name, phone FROM stores;	1607637139
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.profit) > 1000;	3962541566
SELECT p.category_name, SUM(od.quantity) FROM orderdetails od JOIN products p ON od.product_id = p.product_id GROUP BY p.category_name;	2338461777
SELECT s.store_id, s.store_name, e.employee_id, e.name FROM stores s JOIN employees e ON s.store_id = e.store_id;	1062218506
SELECT order_id FROM salesorders WHERE total_amount > (SELECT AVG(total_amount) FROM salesorders);	1070226284
AMBIGUOUS_QUERY	2289172435
SELECT e.employee_id, e.name, s.order_date, s.total_amount FROM employees e LEFT JOIN salesorders s ON e.employee_id = s.employee_id;	2176343547
SELECT e.employee_id, e.name, SUM(s.total_amount) FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id GROUP BY e.employee_id, e.name;	3778494114
SELECT e.name, SUM(ss.sales_quantity) AS total_sales, SUM(ss.profit) AS total_profit FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id GROUP BY e.name;	230146678
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '佳能EOS R6' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 10000;	1097733010
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	406428809
SELECT s.store_name, SUM(ss.sales_quantity), SUM(ss.sales_amount) FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id GROUP BY s.store_name;	224479304
SELECT s.store_name, s.manager_name FROM stores s JOIN (SELECT store_id FROM salesstatistics WHERE date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY store_id ORDER BY SUM(sales_quantity) DESC LIMIT 1) t ON s.store_id = t.store_id;	549557561
AMBIGUOUS_QUERY	4264530712
SELECT order_detail_id, order_id, product_id, quantity, unit_price FROM orderdetails WHERE product_id = '某商品ID';	3474684191
SELECT s.store_id, st.store_name, s.date, SUM(s.sales_amount) AS total_sales FROM salesstatistics s JOIN stores st ON s.store_id = st.store_id GROUP BY s.store_id, st.store_name, s.date;	3292698794
SELECT p.product_name FROM products p JOIN salesstatistics ss ON p.product_id = ss.product_id JOIN stores s ON ss.store_id = s.store_id WHERE s.store_name = '未来城' AND p.purchase_price > 4000;	3179632170
SELECT s.store_name, s.manager_name FROM stores s JOIN (SELECT store_id, SUM(total_amount) AS total FROM salesorders WHERE order_date = '2023-05-09' GROUP BY store_id HAVING SUM(total_amount) > 10000) so ON s.store_id = so.store_id;	2509582177
SELECT s.store_name, s.manager_name FROM stores s WHERE s.store_id = (SELECT so.store_id FROM salesorders so WHERE so.order_date = '2023-05-02' GROUP BY so.store_id ORDER BY SUM(so.total_amount) DESC LIMIT 1);	1374950508
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-09' AND so.total_amount > 1000 GROUP BY s.store_name, s.manager_name;	2266088702
SELECT DISTINCT e.name, p.category_name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 10000;	2178886607
SELECT store_name, SUM(profit) FROM salesstatistics JOIN stores ON salesstatistics.store_id = stores.store_id GROUP BY store_name;	2714447935
SELECT s.store_name, e.name, ss.sales_amount, p.product_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND ss.sales_amount > 10000 AND p.supplier_name = '索尼官方旗舰店';	1871066617
SELECT s.*, o.* FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id WHERE s.total_amount > 5000;	2023023440
AMBIGUOUS_QUERY	3146544905
SELECT s.sales_quantity, st.store_name FROM salesstatistics s JOIN stores st ON s.store_id = st.store_id WHERE s.date >= '2023-05-01' AND s.date <= '2023-05-31';	283454282
SELECT sale_price, purchase_price FROM products;	2083297023
SELECT s.store_name, ss.sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND p.category_name = '智能手表' AND p.supplier_name = '索尼官方旗舰店' AND ss.sales_quantity > 10;	2394150048
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name HAVING AVG(so.total_amount) > 10000;	519899560
SELECT s.store_name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-02' AND p.product_name = 'iPad Air';	1920836570
AMBIGUOUS_QUERY	3659690943
SELECT s.store_name, SUM(ss.sales_amount) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	1937076000
SELECT s.store_name, SUM(so.total_amount) FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'Apple Watch Series 7' AND so.order_date = '2023-05-09' GROUP BY s.store_name;	2659013528
SELECT quantity, unit_price FROM orderdetails;	1610928077
SELECT DISTINCT s.store_name, e.name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31';	2010016216
SELECT * FROM salesstatistics WHERE sales_quantity > 1;	1911035258
SELECT s.store_name, SUM(ss.profit) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name;	761870148
SELECT total_amount, order_date FROM salesorders;	3087271800
SELECT s.store_id, s.store_name, SUM(so.total_amount) AS total_order_amount, SUM(ss.sales_quantity) AS total_sales_quantity FROM stores s LEFT JOIN salesorders so ON s.store_id = so.store_id LEFT JOIN salesstatistics ss ON s.store_id = ss.store_id GROUP BY s.store_id, s.store_name;	1161484474
SELECT * FROM orderdetails WHERE quantity = 2;	52411810
SELECT DISTINCT s.store_name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '戴尔灵越15' AND ss.date = '2023-05-01';	1664706844
SELECT e.position, s.store_name FROM employees e JOIN stores s ON e.store_id = s.store_id;	3840473394
SELECT s.store_name, SUM(ss.profit) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-03' AND p.product_name = '佳能EOS R6' GROUP BY s.store_name;	2695189368
AMBIGUOUS_QUERY	2733025825
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' AND p.product_name = '华为Mate 40 Pro' AND ss.sales_quantity > 1;	807812239
SELECT s.order_id, p.product_name, o.quantity FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id JOIN products p ON o.product_id = p.product_id;	4273091220
SELECT e.name, e.position, s.phone FROM employees e JOIN stores s ON e.store_id = s.store_id;	4275534962
SELECT s.store_name, e.name, ss.sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE ss.date = '2023-05-05' AND p.product_name = '戴尔灵越15' AND ss.sales_quantity > 1;	1477929232
SELECT s.order_id, s.order_date, s.total_amount, p.product_id, p.product_name, p.category_name FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id JOIN products p ON o.product_id = p.product_id WHERE s.total_amount > 5000;	729968430
SELECT e.employee_id, e.name, s.order_id, s.total_amount FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id;	1040158875
SELECT * FROM salesstatistics WHERE profit > 3000;	1660394186
SELECT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-01' AND so.total_amount > 7000 AND p.product_name = 'Apple Watch Series 7';	3002487561
SELECT remaining_quantity, category_name FROM products;	2715847000
SELECT DISTINCT e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-07' AND p.category_name = '相机' AND so.total_amount > 15000;	1326759420
AMBIGUOUS_QUERY	57033443
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-08' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2455933109
SELECT e.name, ss.sales_quantity, ss.sales_amount FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-03' AND s.store_name = '数字大道店' AND p.product_name = 'Nintendo Switch';	4078619784
SELECT s.store_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-05' AND p.product_name = '戴森V11' AND ss.profit > 500;	2372435041
SELECT s.store_name, s.manager_name FROM stores s WHERE s.store_id IN (SELECT store_id FROM salesorders WHERE order_date = '2023-05-09' GROUP BY store_id HAVING SUM(total_amount) > 2000);	1022758323
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-01' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	2940623149
AMBIGUOUS_QUERY	3177645630
AMBIGUOUS_QUERY	2385992805
SELECT store_name, address, phone FROM stores;	2749807521
SELECT s.store_name, e.name, o.total_amount FROM salesorders o JOIN employees e ON o.employee_id = e.employee_id JOIN stores s ON o.store_id = s.store_id WHERE o.order_date = '2023-05-02' AND o.total_amount > 2000;	888076621
SELECT s.store_name, SUM(ss.sales_quantity) AS total_sales, SUM(ss.profit) AS total_profit FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id GROUP BY s.store_name;	1648589599
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-07' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.profit) > 1000;	2992228883
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	3404171320
SELECT store_name FROM stores JOIN salesstatistics ON stores.store_id = salesstatistics.store_id WHERE date = '2023-05-09' GROUP BY store_name ORDER BY SUM(profit) DESC LIMIT 1;	952156269
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '佳能EOS R6' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 5000;	4068577452
SELECT DISTINCT s.store_name, e.position FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = 'iPad Air' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	1242514407
SELECT category_name, sale_price FROM products;	3705049314
SELECT s.store_name, COUNT(e.employee_id) AS manager_count FROM stores s JOIN employees e ON s.store_id = e.store_id WHERE s.store_id IN (SELECT ss.store_id FROM salesstatistics ss WHERE date_trunc('month', ss.date) = '2023-05-01' GROUP BY ss.store_id HAVING SUM(ss.sales_amount) > 10000) AND e.position = '销售经理' GROUP BY s.store_name;	4213863561
SELECT p.product_id, p.remaining_quantity, SUM(s.sales_quantity) AS sales_quantity FROM products p LEFT JOIN salesstatistics s ON p.product_id = s.product_id GROUP BY p.product_id;	1964767451
SELECT order_date, total_amount FROM salesorders;	2226247599
SELECT DISTINCT s.store_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-06' AND p.product_name = '华为Mate 40 Pro' AND ss.sales_quantity > 1;	2202777878
SELECT s.store_name, e.name, e.position FROM stores s JOIN employees e ON s.store_id = e.store_id;	3419270272
SELECT e.name, SUM(od.quantity * od.unit_price) AS total_amount FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON so.employee_id = e.employee_id WHERE s.store_name = '创客空间店' AND p.product_name = '华为Mate 40 Pro' AND so.order_date = DATE '2023-05-01' GROUP BY e.name;	569246445
SELECT DISTINCT s.store_name, e.name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '戴森V11' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31';	830322285
SELECT * FROM orderdetails JOIN products ON orderdetails.product_id = products.product_id;	2616706012
SELECT e.name FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-06' AND ss.sales_quantity > 1 AND p.supplier_name = '戴尔官方旗舰店';	2466792320
SELECT product_name, sale_price FROM products;	1812987912
SELECT store_name, manager_name, phone FROM stores;	3453098028
SELECT s.store_name, SUM(so.total_amount) FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-07' AND e.name = '范莹' GROUP BY s.store_name;	4200224368
SELECT store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Apple Watch Series 7' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY store_name HAVING SUM(sales_amount) > 10000;	1555442404
SELECT s.store_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name;	3702552802
SELECT store_name, manager_name FROM stores;	2171002807
SELECT product_name, sale_price, remaining_quantity FROM products;	2060589508
AMBIGUOUS_QUERY	356180662
SELECT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-08' AND p.product_name = '索尼WH-1000XM4耳机' AND so.total_amount > 15000;	4289573231
SELECT s.store_name, s.manager_name FROM stores s WHERE s.store_id = (SELECT store_id FROM salesstatistics WHERE date = '2023-05-09' GROUP BY store_id ORDER BY SUM(sales_quantity) DESC LIMIT 1);	218019223
SELECT SUM(profit) FROM salesstatistics;	1638224805
AMBIGUOUS_QUERY	2476507165
SELECT s.store_name, SUM(ss.sales_quantity) FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE e.name = '黄萍' AND ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' GROUP BY s.store_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	1748148291
SELECT s.store_name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' AND p.product_name = 'Nintendo Switch';	2979325122
SELECT s.store_name, so.total_amount FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND so.order_date = '2023-05-05';	2667320856
SELECT DISTINCT e.name FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-05' AND s.store_name = '智能生活馆' AND p.supplier_name = '小米官方旗舰店';	1093613959
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-07' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.profit) DESC LIMIT 1;	2112449268
SELECT s.store_name, e.name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND ss.date = '2023-05-09';	2094309801
AMBIGUOUS_QUERY	3718167842
SELECT s.total_amount, t.store_name FROM salesorders s JOIN stores t ON s.store_id = t.store_id WHERE s.order_date = '2023-05-03';	3764251163
SELECT * FROM orderdetails WHERE quantity > 1;	1497641640
AMBIGUOUS_QUERY	4149606926
SELECT s.*, t.store_name FROM salesorders s JOIN stores t ON s.store_id = t.store_id WHERE s.order_date = '2023-05-05';	4134019112
SELECT p.product_name, od.order_id FROM products p JOIN orderdetails od ON p.product_id = od.product_id WHERE od.quantity > 1;	2245397691
SELECT order_id FROM salesorders WHERE order_date BETWEEN '2023-05-01' AND '2023-05-31';	2674486311
SELECT employee_id, SUM(sales_quantity) FROM salesstatistics GROUP BY employee_id;	2993192059
SELECT category_name, remaining_quantity FROM products;	2808717165
SELECT s.store_name, SUM(ss.sales_quantity) FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id GROUP BY s.store_name, e.employee_id;	3833291686
SELECT order_id, product_id FROM orderdetails;	2280059229
AMBIGUOUS_QUERY	77729748
AMBIGUOUS_QUERY	82660779
SELECT e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-09' AND p.product_name = 'Apple Watch Series 7' AND p.supplier_name = '任天堂官方旗舰店';	787968865
SELECT s.total_amount, t.store_name FROM salesorders s JOIN stores t ON s.store_id = t.store_id WHERE s.order_date = '2023-05-06';	3377021543
AMBIGUOUS_QUERY	813286043
SELECT e.name, SUM(so.total_amount) FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-07' AND s.store_name = '智慧街店' AND p.product_name = '佳能EOS R6相机' GROUP BY e.name;	727992931
SELECT s.store_id, SUM(od.quantity) AS total_quantity, SUM(so.total_amount) AS total_amount FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN stores s ON so.store_id = s.store_id GROUP BY s.store_id;	825037872
SELECT s.store_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-05' AND p.product_name = '佳能EOS R6相机' GROUP BY s.store_name;	4082105822
SELECT * FROM products WHERE sale_price > 15000;	3249720567
SELECT s.store_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = '索尼WH-1000XM4' AND ss.date = '2023-05-08' AND ss.sales_quantity > 1;	2614838216
SELECT s.store_name, e.name, p.product_name, ss.sales_amount FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-01' AND ss.sales_amount > 1000 AND p.supplier_name = '戴森官方旗舰店';	1333469519
AMBIGUOUS_QUERY	2995198030
SELECT s.store_name, SUM(o.total_amount) FROM stores s JOIN salesorders o ON s.store_id = o.store_id GROUP BY s.store_name;	2649378296
AMBIGUOUS_QUERY	746087372
SELECT s.order_id, s.order_date, e.name FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id;	3679313236
SELECT product_name, supplier_name FROM products;	2391253319
SELECT product_name, sale_price, supplier_name FROM products;	1769098425
SELECT o.*, p.product_name, p.sale_price FROM orderdetails o JOIN products p ON o.product_id = p.product_id;	622285765
SELECT s.store_name, s.phone FROM stores s JOIN salesorders so ON s.store_id = so.store_id WHERE EXTRACT(YEAR FROM so.order_date) = 2023 AND EXTRACT(MONTH FROM so.order_date) = 5 GROUP BY s.store_id HAVING SUM(so.total_amount) > 3000;	3990639391
SELECT store_name, manager_name FROM stores;	986209829
SELECT e.name, s.phone FROM employees e JOIN stores s ON e.store_id = s.store_id;	2997501252
SELECT e.name, ss.sales_quantity, ss.profit FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-09' AND s.store_name = '创新路专卖店' AND p.product_name = 'iPad Air';	3439332131
SELECT e.name FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id JOIN stores st ON s.store_id = st.store_id WHERE s.order_date = '2023-05-07' AND st.store_name = '未来城店' AND s.total_amount > 15000;	3283669448
SELECT product_name, sale_price - purchase_price AS price_difference FROM products;	1627244723
SELECT s.store_name, s.manager_name FROM stores s JOIN (SELECT store_id, SUM(total_amount) AS total FROM salesorders WHERE order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY store_id HAVING SUM(total_amount) > 10000) AS so ON s.store_id = so.store_id;	1569820240
SELECT store_id, SUM(profit) AS total_profit, SUM(sales_quantity) AS total_sales FROM salesstatistics GROUP BY store_id;	3499069647
SELECT * FROM salesorders WHERE store_id = '64921abb-1d54-4e03-a15e-ea42f058f31c';	1379442449
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '小米电视4A' AND so.order_date = '2023-05-06' AND so.total_amount > 10000;	2629127246
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND ss.profit > 1000 AND ss.date BETWEEN '2023-05-01' AND '2023-05-31';	3788770697
SELECT s.store_name, ss.sales_quantity, ss.sales_amount FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '索尼WH-1000XM4' AND ss.date = '2023-05-09';	1545362727
AMBIGUOUS_QUERY	2279456937
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-03' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2483765707
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-03' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	2155062621
SELECT s.store_name, so.total_amount FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-01';	1172044345
SELECT store_id, SUM(total_amount) FROM salesorders GROUP BY store_id;	413296723
SELECT e.position, COUNT(o.order_id) FROM employees e LEFT JOIN salesorders o ON e.employee_id = o.employee_id GROUP BY e.position;	1774082301
AMBIGUOUS_QUERY	1485164601
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	1282673925
SELECT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-02' AND p.supplier_name = '华为官方旗舰店' GROUP BY s.store_name HAVING SUM(ss.sales_amount) > 10000;	3234218182
AMBIGUOUS_QUERY	623061772
AMBIGUOUS_QUERY	3776277190
SELECT s.store_name, s.manager_name FROM stores s WHERE s.store_id = (SELECT store_id FROM salesorders WHERE order_date = '2023-05-04' GROUP BY store_id ORDER BY SUM(total_amount) DESC LIMIT 1);	2220998092
SELECT DISTINCT s.store_name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE p.product_name = '华为Mate 40 Pro' AND ss.date = '2023-05-01';	3144588067
SELECT e.name AS employee_name, s.manager_name FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores st ON e.store_id = st.store_id WHERE ss.date = '2023-05-06' AND ss.sales_amount > 10000;	3325155262
SELECT s.store_name, e.name, so.total_amount FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = '戴尔灵越15笔记本电脑' AND so.total_amount > 5000 AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	3438936179
SELECT product_id, remaining_quantity, sale_price FROM products;	214316002
SELECT s.store_name, COUNT(e.employee_id) FROM employees e JOIN stores s ON e.store_id = s.store_id GROUP BY s.store_name;	3304679388
SELECT e.name FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-05' AND s.store_name = '科技中心店' AND p.product_name = '戴森V11' AND ss.sales_quantity > 1;	1528991895
SELECT order_id, total_amount FROM salesorders WHERE store_id = (SELECT store_id FROM stores WHERE store_name = '数码广场店');	127103551
SELECT ra.assessment_id, ra.risk_level, ra.impact_score, re.event_id, re.event_type, re.event_description, re.severity FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id WHERE ra.risk_level = '高' AND ra.impact_score > 8;	1891291054
SELECT event_id FROM risk_events WHERE event_type = '合规风险';	491501449
SELECT risk_events.event_id, audit_logs.audit_result FROM alerts JOIN risk_events ON alerts.event_id = risk_events.event_id JOIN audit_logs ON audit_logs.alert_id = alerts.alert_id WHERE alerts.alert_type = '欺诈嫌疑预警';	3354532402
SELECT report_type, AVG(severity) FROM risk_reports JOIN risk_events ON risk_reports.event_id = risk_events.event_id WHERE approval_status = '已批准' GROUP BY report_type;	1450781019
SELECT risk_level, COUNT(*) AS customer_count, AVG(credit_score) AS avg_credit_score FROM customers GROUP BY risk_level;	3784241191
SELECT * FROM risk_indicators JOIN risk_monitoring_logs ON risk_indicators.indicator_id = risk_monitoring_logs.indicator_id WHERE monitoring_date >= '2023-10-01' AND monitoring_date < '2023-11-01';	2169849694
SELECT report_id, author, event_id FROM risk_reports WHERE approval_status = '已批准';	1821041301
SELECT c.risk_level, t.transaction_type, CASE WHEN t.amount < 1000 THEN '小额' WHEN t.amount < 10000 THEN '中额' ELSE '大额' END AS amount_range, COUNT(*) AS transaction_count, AVG(t.risk_score) AS avg_risk_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level, t.transaction_type, amount_range;	2399924571
AMBIGUOUS_QUERY	2832409698
SELECT rr.report_id, rr.report_type, rr.report_date, re.event_id, re.event_type, re.event_description, ra.assessment_id, ra.risk_level, ra.impact_score, ra.probability_score FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE rr.author = '周婷';	4007902186
SELECT author, approval_status FROM risk_reports WHERE report_date >= '2023-01-01';	3766793908
SELECT re.event_description, ra.risk_level, ra.mitigation_plan FROM risk_events re INNER JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE re.event_description LIKE '%系统%';	379347511
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    curr.actual_value AS current_value,
    prev.actual_value AS value_30_days_ago,
    CASE 
        WHEN prev.actual_value IS NULL THEN NULL 
        ELSE ROUND((curr.actual_value - prev.actual_value) / prev.actual_value * 100, 2) 
    END AS change_percentage
FROM 
    risk_indicators ri
LEFT JOIN LATERAL (
    SELECT actual_value, monitoring_date 
    FROM risk_monitoring_logs 
    WHERE indicator_id = ri.indicator_id 
    ORDER BY monitoring_date DESC 
    LIMIT 1
) curr ON true
LEFT JOIN LATERAL (
    SELECT actual_value 
    FROM risk_monitoring_logs 
    WHERE indicator_id = ri.indicator_id 
    AND monitoring_date <= (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = ri.indicator_id) - INTERVAL '30 days'
    ORDER BY monitoring_date DESC 
    LIMIT 1
) prev ON true;	1838288170
SELECT event_id FROM risk_events JOIN risk_assessments USING(event_id) WHERE risk_level = '高风险' AND assessor = '曾强';	3470826751
SELECT DISTINCT c.customer_id, c.customer_name FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_type = '投资' AND t.risk_score > 60;	1344992090
SELECT created_at, status FROM risk_events;	1091103550
SELECT c.customer_id, t.risk_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score < 600;	1666978001
SELECT t.amount, c.customer_name FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.status = '成功' AND t.transaction_date >= '2023-12-01' AND t.transaction_date < '2024-01-01';	3043489169
SELECT alert_type, alert_content FROM alerts;	228553912
SELECT report_id, approved_by FROM risk_reports;	3145840427
SELECT transaction_type, COUNT(CASE WHEN status = '成功' THEN 1 END)::float/COUNT(*) AS success_rate, AVG(risk_score) AS avg_risk_score FROM transactions GROUP BY transaction_type;	2194753030
SELECT a.alert_id, r.rule_description FROM alerts a JOIN rule_configurations r ON a.rule_id = r.rule_id;	2007490591
SELECT c.customer_id, c.customer_name, t.status FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date = (SELECT MAX(transaction_date) FROM transactions WHERE customer_id = c.customer_id) OR t.transaction_date IS NULL;	1993896438
SELECT indicator_id, AVG(actual_value) AS avg_value, STDDEV(actual_value) AS stddev, STDDEV(actual_value)/NULLIF(AVG(actual_value),0) AS coefficient_of_variation FROM risk_monitoring_logs GROUP BY indicator_id;	2353107053
SELECT DISTINCT t1.customer_id FROM transactions t1 JOIN transactions t2 ON t1.customer_id = t2.customer_id JOIN audit_logs a ON t2.transaction_id = a.transaction_id WHERE t1.risk_score > 80 AND t1.transaction_date > CURRENT_DATE - INTERVAL '1 year' AND t2.amount > 500000 AND a.audit_result = '未通过' AND t2.transaction_date > CURRENT_DATE - INTERVAL '1 year';	1348678368
SELECT AVG(impact_score) FROM risk_assessments WHERE mitigation_plan IS NULL;	3331891334
SELECT alert_content, status FROM alerts;	3770586804
SELECT 
    c.customer_id,
    c.customer_name,
    (COALESCE(high_risk_tx.count, 0) * 2 + 
     COALESCE(unprocessed_alerts.count, 0) * 3 + 
     CASE WHEN c.credit_score = 0 THEN 0 ELSE 1000.0 / c.credit_score END) AS risk_index
FROM 
    customers c
LEFT JOIN (
    SELECT 
        customer_id, 
        COUNT(*) AS count
    FROM 
        transactions
    WHERE 
        transaction_date >= CURRENT_DATE - INTERVAL '90 days'
        AND (risk_score > 80 OR amount > 100000)
    GROUP BY 
        customer_id
) AS high_risk_tx ON c.customer_id = high_risk_tx.customer_id
LEFT JOIN (
    SELECT 
        t.customer_id, 
        COUNT(*) AS count
    FROM 
        alerts a
    JOIN 
        transactions t ON a.event_id = t.event_id
    WHERE 
        a.status = '未处理'
    GROUP BY 
        t.customer_id
) AS unprocessed_alerts ON c.customer_id = unprocessed_alerts.customer_id
ORDER BY 
    risk_index DESC
LIMIT 10;	2420031848
SELECT event_type, COUNT(*) AS occurrence_count, AVG(severity) AS avg_severity FROM risk_events WHERE occurrence_time >= '2023-01-01' AND occurrence_time < '2024-01-01' GROUP BY event_type ORDER BY occurrence_count DESC;	2122948167
SELECT * FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.report_content LIKE '%合规风险%';	1467350797
SELECT update_frequency, data_source FROM risk_indicators;	1619162011
SELECT DISTINCT ON (re.event_id) re.event_id, re.event_type, re.event_description, re.status, rr.report_id, rr.report_type, rr.report_date FROM risk_events re LEFT JOIN risk_reports rr ON re.event_id = rr.event_id WHERE re.status != '已解决' ORDER BY re.event_id, rr.report_date DESC;	3180110269
SELECT rc.rule_type, AVG(alert_count.count) AS avg_trigger_count, MAX(rc.updated_at) AS last_updated_time FROM rule_configurations rc LEFT JOIN (SELECT rule_id, COUNT(*) AS count FROM alerts GROUP BY rule_id) alert_count ON rc.rule_id = alert_count.rule_id GROUP BY rc.rule_type;	491065533
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type ORDER BY COUNT(*) DESC;	210792684
SELECT DISTINCT c.customer_id, c.customer_name FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score < 700 AND t.transaction_date >= '2023-01-01' AND t.transaction_date < '2024-01-01';	528895519
SELECT * FROM risk_events LEFT JOIN risk_reports ON risk_events.event_id = risk_reports.event_id;	3994194373
SELECT COUNT(*) FROM risk_reports WHERE approval_status = '被拒绝' AND report_date BETWEEN '2023-01-01' AND '2023-12-31';	3108618170
SELECT risk_level, mitigation_plan FROM risk_assessments;	2756291249
SELECT * FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY indicator_id ORDER BY monitoring_date DESC) AS rn FROM risk_monitoring_logs) t WHERE rn = 1;	3508177846
SELECT r.rule_id, r.rule_name, COUNT(a.alert_id) AS alert_count FROM rule_configurations r LEFT JOIN alerts a ON r.rule_id = a.rule_id GROUP BY r.rule_id, r.rule_name;	3123122302
SELECT t.* FROM transactions t JOIN risk_events e ON t.event_id = e.event_id WHERE e.event_type = '信用风险' AND t.status = '成功';	3431937746
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	4153763267
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY total_amount) FROM (SELECT SUM(amount) AS total_amount FROM transactions JOIN customers ON transactions.customer_id = customers.customer_id WHERE customers.registration_date < '2019-01-01' AND customers.risk_level = '高' GROUP BY customers.customer_id) AS customer_totals;	2480143604
SELECT rc.rule_name, re.event_description FROM rule_configurations rc JOIN alerts a ON rc.rule_id = a.rule_id JOIN risk_events re ON a.event_id = re.event_id WHERE a.alert_level = '高风险';	1278986057
SELECT created_at, status FROM risk_events;	983609731
SELECT event_type, 
       to_char(occurrence_time, 'YYYY-MM') AS month, 
       COUNT(*) AS event_count,
       (COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY event_type ORDER BY to_char(occurrence_time, 'YYYY-MM'))) * 100.0 / 
       NULLIF(LAG(COUNT(*)) OVER (PARTITION BY event_type ORDER BY to_char(occurrence_time, 'YYYY-MM')), 0) AS growth_rate
FROM risk_events
GROUP BY event_type, to_char(occurrence_time, 'YYYY-MM')
ORDER BY event_type, month;	2727402886
SELECT DATE_TRUNC('month', transaction_date) AS month, AVG(amount) AS avg_amount, COUNT(*) AS transaction_count FROM transactions GROUP BY month;	1304137472
SELECT r.report_id, r.report_type, r.approved_by, e.event_description, e.severity FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approval_status = '已批准';	1801532770
SELECT c.customer_id, c.risk_level, array_agg(DISTINCT t.status) AS transaction_statuses FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.customer_id, c.risk_level;	2532729979
SELECT t.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险';	1467489344
SELECT * FROM risk_reports WHERE author = '孙宇' AND approval_status = '尚未审批';	2860062939
SELECT a.alert_content, r.event_description FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理';	186829469
SELECT risk_level, COUNT(*) FROM customers WHERE risk_level IN ('中','高') GROUP BY risk_level;	1965814026
SELECT customer_id, COUNT(*), AVG(risk_score) FROM transactions GROUP BY customer_id;	1229601142
SELECT DATE_TRUNC('month', registration_date) AS month, COUNT(*) FROM customers WHERE risk_level = '高风险' GROUP BY month ORDER BY month;	134467671
SELECT ri.indicator_name, ri.threshold_value, rml.monitoring_date, rml.actual_value, a.alert_id, a.alert_time, al.audit_result FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id JOIN rule_configurations rc ON ri.indicator_id = rc.indicator_id JOIN alerts a ON rc.rule_id = a.rule_id LEFT JOIN audit_logs al ON a.alert_id = al.alert_id WHERE rml.is_exceeding_threshold = true AND rml.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = ri.indicator_id);	2051579057
SELECT risk_level, COUNT(*), AVG(credit_score) FROM customers GROUP BY risk_level;	1467515231
SELECT alert_type FROM alerts a JOIN audit_logs al ON a.alert_id=al.alert_id WHERE a.status='已解决' GROUP BY alert_type ORDER BY AVG(EXTRACT(EPOCH FROM (al.audit_time - a.alert_time))) DESC LIMIT 1;	928241464
SELECT c.customer_name, t.amount, t.transaction_date FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.transaction_date BETWEEN '2023-11-01' AND '2023-11-30' AND t.amount > 100000;	861248617
SELECT SUM(threshold_value) FROM risk_indicators WHERE indicator_name LIKE '%财务%';	2228247623
SELECT customer_name, credit_score FROM customers;	1010279388
SELECT DISTINCT ON (customer_id) customer_id, risk_score FROM transactions ORDER BY customer_id, transaction_date DESC;	3854618324
SELECT * FROM risk_monitoring_logs WHERE is_exceeding_threshold = true;	4048786296
SELECT transactions.*, AVG(transactions.risk_score) OVER() AS avg_risk_score FROM transactions JOIN customers ON transactions.customer_id = customers.customer_id WHERE customers.risk_level = '高风险';	2208124060
SELECT c.customer_id, c.customer_name, t.transaction_id, t.transaction_type, t.amount, t.transaction_date, t.status, t.risk_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id;	2046381691
SELECT report_type, COUNT(*) FROM risk_reports WHERE status = '已拒绝' GROUP BY report_type;	218145680
SELECT customer_id, customer_name FROM customers WHERE risk_level = '高' AND credit_score < 600;	4118993277
SELECT c.risk_level, AVG(t.amount) AS avg_amount, COUNT(*) AS transaction_count FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY c.risk_level;	4099101626
SELECT * FROM risk_reports WHERE event_id IN (SELECT event_id FROM risk_events WHERE event_type = '流动性风险');	158715771
SELECT COUNT(DISTINCT c.customer_id), COALESCE(SUM(t.amount), 0) FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score BETWEEN 600 AND 800;	1057264197
SELECT report_content FROM risk_reports WHERE approved_by = '王思远' AND report_date >= '2023-03-01' AND report_date <= '2023-03-31';	2894258616
SELECT * FROM risk_events JOIN risk_reports USING (event_id);	1697426124
SELECT * FROM transactions WHERE transaction_date >= '2023-06-01' AND transaction_date < '2023-07-01';	1368489416
SELECT event_id FROM risk_events WHERE severity = 3 AND EXISTS (SELECT 1 FROM audit_logs WHERE audit_logs.event_id = risk_events.event_id);	1079159915
SELECT threshold_value, actual_value FROM risk_indicators JOIN risk_monitoring_logs ON risk_indicators.indicator_id = risk_monitoring_logs.indicator_id WHERE actual_value > threshold_value;	1387862561
SELECT c.customer_id, c.customer_name, c.risk_level, t.status FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id;	1914208134
SELECT * FROM risk_events JOIN alerts ON risk_events.event_id = alerts.event_id WHERE alerts.alert_level = '高';	3189905137
SELECT * FROM risk_events LEFT JOIN alerts ON risk_events.event_id = alerts.event_id ORDER BY alerts.alert_time;	434260556
SELECT risk_level, AVG(amount) AS avg_amount, COUNT(*) AS transaction_count FROM transactions JOIN customers ON transactions.customer_id = customers.customer_id WHERE transaction_date >= CURRENT_DATE - INTERVAL '90 days' GROUP BY risk_level;	3762237075
SELECT customer_id, customer_name FROM customers WHERE risk_level = '高' AND credit_score < 700;	2322626250
SELECT c.customer_id, c.customer_name, c.credit_score, t.transaction_id, t.transaction_type, t.amount, t.transaction_date FROM customers c LEFT JOIN (SELECT DISTINCT ON (customer_id) * FROM transactions WHERE status='失败' ORDER BY customer_id, transaction_date DESC) t ON c.customer_id=t.customer_id;	294935919
SELECT ra.assessment_id, c.customer_id, c.customer_name, c.credit_score, ra.risk_level FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id JOIN transactions t ON re.event_id = t.event_id JOIN customers c ON t.customer_id = c.customer_id WHERE ra.risk_level = '高风险' AND c.credit_score > 700;	1926912221
SELECT customer_id, customer_name, credit_score FROM customers WHERE customer_type = '企业' ORDER BY credit_score DESC LIMIT 10;	3499522069
SELECT date_trunc('month', created_at) AS month, COUNT(*) AS new_rules_count, AVG(SUM(is_active::int) OVER (ORDER BY date_trunc('month', created_at)))::numeric(10,2) AS avg_active_rules FROM rule_configurations GROUP BY month ORDER BY month;	538732127
SELECT author, approval_status FROM risk_reports WHERE approval_status = '已批准';	2736181075
SELECT c.customer_id, c.customer_name, t.amount, t.status FROM customers c JOIN transactions t ON c.customer_id = t.customer_id;	1873450174
SELECT re.*, ra.risk_level, ra.impact_score, ra.probability_score FROM risk_events re LEFT JOIN risk_assessments ra ON re.event_id = ra.event_id;	3031401155
SELECT i.indicator_name, AVG(l.actual_value) AS avg_actual_value, i.threshold_value FROM risk_indicators i JOIN risk_monitoring_logs l ON i.indicator_id = l.indicator_id GROUP BY i.indicator_id;	1926763899
SELECT r.report_id, r.report_type, r.report_date, r.report_content, r.author, e.event_id, e.event_type, e.event_description, e.occurrence_time, e.severity, e.status FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approval_status = '已批准';	2380941668
SELECT DISTINCT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN alerts a ON DATE(t.transaction_date) = DATE(a.alert_time) WHERE t.risk_score > 80 AND a.alert_level = '高';	1133773952
SELECT t.*, c.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.risk_score > 80;	2358748811
SELECT re.event_description, ra.assessment_date FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id WHERE ra.risk_level = '高';	634372359
SELECT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险' AND t.status = '失败' AND t.transaction_date = (SELECT MAX(transaction_date) FROM transactions WHERE customer_id = c.customer_id);	54166415
SELECT event_id, COUNT(*) FROM transactions GROUP BY event_id;	775802297
SELECT t.*, c.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.transaction_date BETWEEN '2023-01-01' AND '2023-03-31' AND c.risk_level = '高风险' AND t.amount > 500000;	3320369998
SELECT re.event_description, re.severity, ra.risk_level, ra.mitigation_plan FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE re.severity IN (4,5) AND re.occurrence_time >= '2023-01-01' AND re.occurrence_time < '2024-01-01';	4254692719
SELECT * FROM risk_monitoring_logs WHERE is_exceeding_threshold = false;	3645112410
SELECT r.report_id, r.report_type, r.author, e.event_type, e.event_description, a.audit_time, a.audit_result 
FROM risk_reports r 
JOIN risk_events e ON r.event_id = e.event_id 
LEFT JOIN (
    SELECT DISTINCT ON (related_id) related_id, audit_time, audit_result 
    FROM audit_logs 
    WHERE audit_type = '风险报告审核' 
    ORDER BY related_id, audit_time DESC
) a ON r.report_id = a.related_id 
WHERE r.approval_status = '待审批';	1798162210
SELECT customer_id FROM customers WHERE EXTRACT(YEAR FROM registration_date) = 2021 AND risk_level = '高' AND credit_score < 550;	2215350256
AMBIGUOUS_QUERY	1774673651
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	3960174076
SELECT c.customer_name, r.rule_name, COUNT(*) AS trigger_count FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN alerts a ON t.event_id = a.event_id JOIN rule_configurations r ON a.rule_id = r.rule_id WHERE c.risk_level = '高' GROUP BY c.customer_name, r.rule_name;	4181335061
SELECT event_type, DATE_TRUNC('month', occurrence_time) AS month, COUNT(*) AS event_count, AVG(severity) AS avg_severity, SUM(CASE WHEN status = '已解决' THEN 1 ELSE 0 END)::float/COUNT(*) AS resolution_rate FROM risk_events GROUP BY event_type, month;	995864049
SELECT rml.log_id, ri.indicator_name, rml.actual_value, ri.threshold_value, rml.is_exceeding_threshold FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id;	430786160
SELECT c.risk_level, t.transaction_type, AVG(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level, t.transaction_type;	2101060146
SELECT COUNT(*) FROM rule_configurations WHERE is_active = true;	1665434378
SELECT risk_level, credit_score FROM customers;	3176119352
SELECT COUNT(*) FROM risk_indicators WHERE threshold_value > 100;	1713409158
SELECT customer_name, registration_date FROM customers;	1230885426
SELECT indicator_id, actual_value, is_exceeding_threshold FROM risk_monitoring_logs;	1766048190
SELECT i.indicator_id, i.data_source, AVG(l.actual_value) AS average_value, STDDEV(l.actual_value) AS standard_deviation FROM risk_indicators i JOIN risk_monitoring_logs l ON i.indicator_id = l.indicator_id GROUP BY i.indicator_id, i.data_source;	2747654158
SELECT * FROM audit_logs WHERE audit_result = '拒绝';	1853147969
SELECT alert_type, alert_content FROM alerts;	2764222826
SELECT a.*, re.event_description, al.* FROM alerts a JOIN risk_events re ON a.event_id = re.event_id LEFT JOIN LATERAL (SELECT * FROM audit_logs WHERE alert_id = a.alert_id ORDER BY audit_time DESC LIMIT 1) al ON true WHERE a.status = '未处理';	1328047815
SELECT AVG(EXTRACT(EPOCH FROM (NOW() - alert_time))) FROM alerts WHERE status = '未处理';	1153256443
SELECT c.customer_id, (COUNT(ra.assessment_id) * AVG(ra.impact_score) + COUNT(a.alert_id) * 2) AS risk_index FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id LEFT JOIN risk_events re ON t.event_id = re.event_id LEFT JOIN risk_assessments ra ON re.event_id = ra.event_id LEFT JOIN alerts a ON re.event_id = a.event_id GROUP BY c.customer_id;	2529991047
SELECT event_type, COUNT(*) FROM risk_events WHERE status = '未处理' GROUP BY event_type;	1891370109
SELECT * FROM transactions WHERE customer_id IN (SELECT customer_id FROM customers WHERE risk_level='低' AND credit_score>700);	3513778977
SELECT a.alert_id, a.alert_content, a.alert_time, r.event_type, r.event_description, r.occurrence_time, r.severity FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理' AND a.alert_level = '高级';	1342627605
SELECT a.alert_id, a.status FROM alerts a JOIN rule_configurations r ON a.rule_id = r.rule_id WHERE r.rule_type = '合规违规';	2457540425
SELECT c.customer_name, c.risk_level, SUM(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.risk_score > 80 GROUP BY c.customer_name, c.risk_level;	3803553571
SELECT report_content FROM risk_reports WHERE report_type = '月度风险报告' AND approval_status = '已拒绝';	3170647440
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	3365749326
SELECT customer_id, customer_name FROM customers WHERE customer_id IN (SELECT customer_id FROM transactions WHERE transaction_date::date = '2023-05-04' AND transaction_type = '转账' AND amount > 200000);	2632721664
SELECT a.assigned_to, r.event_description FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理' AND a.alert_level = '高级别';	2115455156
SELECT report_id FROM risk_reports WHERE report_date BETWEEN '2023-04-01' AND '2023-04-30' AND approved_by = '高志远';	3669635067
SELECT transaction_type, status, COUNT(*) FROM transactions GROUP BY transaction_type, status;	4274653529
SELECT re.*, ra.* FROM risk_events re LEFT JOIN (SELECT DISTINCT ON (event_id) * FROM risk_assessments ORDER BY event_id, assessment_date DESC) ra ON re.event_id = ra.event_id;	522918260
SELECT c.customer_name, COUNT(DISTINCT ra.assessment_id) AS risk_assessment_count, COUNT(DISTINCT t.transaction_id) AS large_transaction_count FROM customers c JOIN risk_assessments ra ON ra.event_id IN (SELECT event_id FROM transactions WHERE customer_id = c.customer_id AND transaction_date >= NOW() - INTERVAL '1 year' AND amount > 500000) JOIN transactions t ON t.customer_id = c.customer_id AND t.transaction_date >= NOW() - INTERVAL '1 year' AND t.amount > 500000 WHERE ra.assessment_date >= NOW() - INTERVAL '1 year' AND ra.risk_level = '高风险' GROUP BY c.customer_id, c.customer_name HAVING COUNT(DISTINCT ra.assessment_id) > 0 AND COUNT(DISTINCT t.transaction_id) > 0;	4200581425
AMBIGUOUS_QUERY	4250954216
SELECT event_id, MAX(severity) FROM risk_events GROUP BY event_id;	3376384926
SELECT c.risk_level, COUNT(c.customer_id), AVG(t.amount) FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level;	1863389546
SELECT a.*, al.audit_result FROM alerts a JOIN audit_logs al ON a.alert_id = al.alert_id WHERE al.auditor = '张强';	1527263926
SELECT actual_value, is_exceeding_threshold FROM risk_monitoring_logs JOIN risk_indicators USING (indicator_id);	959044977
SELECT r.indicator_id, COUNT(*) AS exceed_count, AVG(l.actual_value - r.threshold_value) AS avg_exceed_value FROM risk_monitoring_logs l JOIN risk_indicators r ON l.indicator_id = r.indicator_id WHERE l.monitoring_date BETWEEN '2023-01-01' AND '2023-12-31' AND l.is_exceeding_threshold = true GROUP BY r.indicator_id;	3965887957
SELECT alert_content, status FROM alerts WHERE alert_time >= '2023-01-01' AND alert_time < '2024-01-01';	1868278026
SELECT DISTINCT ON (indicator_id) indicator_id, actual_value FROM risk_monitoring_logs ORDER BY indicator_id, monitoring_date DESC;	739540706
SELECT i.indicator_name, COUNT(*) AS exceed_count, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM risk_monitoring_logs WHERE indicator_id = i.indicator_id AND monitoring_date >= NOW() - INTERVAL '1 year'), 2) AS exceed_percentage FROM risk_monitoring_logs l JOIN risk_indicators i ON l.indicator_id = i.indicator_id WHERE l.is_exceeding_threshold = true AND l.monitoring_date >= NOW() - INTERVAL '1 year' GROUP BY i.indicator_id, i.indicator_name ORDER BY exceed_count DESC LIMIT 10;	2175305749
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	2458944386
SELECT c.customer_id, t.risk_score, t.status FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id;	2707842138
SELECT * FROM risk_assessments ra JOIN transactions t ON ra.event_id = t.event_id WHERE ra.risk_level = '高风险' AND t.risk_score < 50;	1192678488
SELECT transaction_type FROM transactions WHERE status = '成功' GROUP BY transaction_type ORDER BY count(*) DESC LIMIT 1;	1326015635
SELECT * FROM transactions t JOIN risk_events r ON t.event_id = r.event_id WHERE t.status = '失败' AND r.status = '已解决';	3710680886
SELECT t.*, c.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.status = '处理中';	581328064
SELECT t.transaction_id, r.event_id FROM transactions t JOIN risk_events r ON t.event_id = r.event_id WHERE t.amount > 1000;	3472554935
SELECT t.transaction_id, t.amount, e.event_id, e.event_type, e.event_description, e.severity FROM transactions t JOIN customers c ON t.customer_id = c.customer_id JOIN risk_events e ON t.event_id = e.event_id WHERE t.amount > 100000 AND c.risk_level = '高' AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	72136253
SELECT * FROM risk_assessments WHERE mitigation_plan IS NOT NULL;	3778743836
SELECT t.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险';	1975692082
SELECT rml.actual_value, ri.indicator_name FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id WHERE rml.actual_value < ri.threshold_value;	263024116
SELECT r.report_id, e.event_type, e.status FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approval_status = '已拒绝';	4272740433
SELECT customer_name FROM customers WHERE registration_date BETWEEN '2021-01-01' AND '2021-12-31' AND credit_score > 700 AND EXISTS (SELECT 1 FROM transactions WHERE transactions.customer_id = customers.customer_id AND transaction_date >= CURRENT_DATE - INTERVAL '1 year');	33599686
SELECT a.*, r.*, t.* FROM alerts a JOIN risk_events r ON a.event_id = r.event_id JOIN transactions t ON a.event_id = t.event_id WHERE a.assigned_to = '陈强';	1531250861
SELECT * FROM risk_reports WHERE report_content LIKE '%合规%';	3898772643
SELECT to_char(risk_events.occurrence_time, 'YYYY-MM') AS month, COUNT(DISTINCT risk_events.event_id) AS event_count, AVG(risk_events.severity) AS avg_severity, COUNT(DISTINCT alerts.alert_id) AS alert_count FROM risk_events LEFT JOIN alerts ON risk_events.event_id = alerts.event_id GROUP BY month ORDER BY month;	3314311299
SELECT indicator_name, threshold_value FROM risk_indicators;	648920878
SELECT ri.indicator_id, ri.indicator_name, rml.actual_value, rml.is_exceeding_threshold FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id JOIN (SELECT indicator_id, MAX(monitoring_date) AS latest_date FROM risk_monitoring_logs GROUP BY indicator_id) latest ON rml.indicator_id = latest.indicator_id AND rml.monitoring_date = latest.latest_date;	2490177094
SELECT t.transaction_id, t.amount, t.transaction_date, c.customer_id, c.customer_name FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.amount > 100000;	4125993810
SELECT * FROM risk_reports WHERE approval_status = '已批准';	1573849130
SELECT transaction_type, AVG(risk_score) FROM transactions GROUP BY transaction_type;	180382260
SELECT event_type, AVG(CASE WHEN status='已解决' THEN EXTRACT(EPOCH FROM (NOW() - created_at))/3600 END) AS avg_resolution_time, AVG(CASE WHEN status='未处理' THEN EXTRACT(EPOCH FROM (NOW() - created_at))/3600 END) AS avg_pending_time, AVG(CASE WHEN status='处理中' THEN EXTRACT(EPOCH FROM (NOW() - created_at))/3600 END) AS avg_processing_time FROM risk_events GROUP BY event_type;	3666899871
SELECT alert_type, COUNT(*) AS alert_count, AVG(EXTRACT(EPOCH FROM (audit_time - alert_time))/60) AS avg_processing_time_minutes FROM alerts JOIN audit_logs ON alerts.alert_id = audit_logs.alert_id GROUP BY alert_type;	3229183107
SELECT e.event_type, AVG(EXTRACT(EPOCH FROM (a.audit_time - e.created_at))/3600) AS avg_processing_hours FROM risk_events e JOIN audit_logs a ON e.event_id = a.event_id WHERE a.audit_result = '解决' GROUP BY e.event_type;	1330206790
SELECT alerts.*, risk_events.status FROM alerts JOIN risk_events ON alerts.event_id = risk_events.event_id WHERE alerts.rule_id IS NOT NULL;	1499863131
SELECT c.customer_name, COUNT(DISTINCT t.transaction_id) AS high_risk_transactions, COUNT(DISTINCT a.alert_id) AS high_level_alerts FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN alerts a ON t.event_id = a.event_id WHERE t.risk_score > 80 AND t.transaction_date BETWEEN '2023-01-01' AND '2023-12-31' AND a.alert_level = '高级' GROUP BY c.customer_id, c.customer_name;	4020556557
SELECT re.severity, ra.risk_level FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id;	2574806195
AMBIGUOUS_QUERY	368566951
SELECT customer_type, COUNT(*) FROM customers GROUP BY customer_type;	1635727552
SELECT ra.*, re.* FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id;	328924275
AMBIGUOUS_QUERY	206421261
SELECT c.customer_name, c.risk_level, t.transaction_date, t.amount, t.risk_score FROM customers c JOIN (SELECT DISTINCT ON (customer_id) * FROM transactions ORDER BY customer_id, transaction_date DESC) t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险';	1632035738
SELECT transaction_type, COUNT(*) FILTER (WHERE status = '成功')::numeric/COUNT(*) AS success_rate, COUNT(*) FROM transactions GROUP BY transaction_type;	3886658963
SELECT re.event_id, re.event_type, re.event_description, ra.mitigation_plan, ra.assessor FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id WHERE ra.risk_level = '高';	2797728174
SELECT customer_id, customer_name FROM customers WHERE risk_level = '高' AND credit_score < 700;	4147622428
SELECT * FROM customers WHERE risk_level = '高' AND credit_score < 600;	2005982395
SELECT c.risk_level, SUM(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.status = '成功' GROUP BY c.risk_level;	2801172444
SELECT * FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approval_status = '已批准';	449712045
SELECT author FROM risk_reports GROUP BY author ORDER BY count(*) DESC LIMIT 1;	3632195172
SELECT event_id, event_type, reporter FROM risk_events WHERE status != '已处理';	673496495
SELECT customer_name, last_update_date FROM customers WHERE registration_date > '2021-01-01';	1638441248
SELECT r.*, e.* FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approved_by = '高志远';	108772594
SELECT ri.indicator_name, ri.threshold_value, rml.actual_value, rml.monitoring_date FROM risk_indicators ri LEFT JOIN (SELECT indicator_id, actual_value, monitoring_date FROM risk_monitoring_logs WHERE (indicator_id, monitoring_date) IN (SELECT indicator_id, MAX(monitoring_date) FROM risk_monitoring_logs GROUP BY indicator_id)) rml ON ri.indicator_id = rml.indicator_id;	4205470451
SELECT * FROM risk_monitoring_logs JOIN risk_indicators ON risk_monitoring_logs.indicator_id = risk_indicators.indicator_id;	3583518096
SELECT AVG(impact_score), AVG(probability_score) FROM risk_assessments;	2055776443
SELECT re.*, ra.* FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE ra.assessor IS NOT NULL;	3949000806
SELECT SUM(amount) FROM transactions WHERE transaction_type = '退款';	2492972672
SELECT ri.*, rml.* FROM risk_indicators ri LEFT JOIN (SELECT DISTINCT ON (indicator_id) * FROM risk_monitoring_logs ORDER BY indicator_id, monitoring_date DESC) rml ON ri.indicator_id = rml.indicator_id;	3484790242
SELECT event_type, AVG(EXTRACT(EPOCH FROM (assessment_date - occurrence_time))/3600) AS avg_mitigation_hours FROM risk_events JOIN risk_assessments ON risk_events.event_id = risk_assessments.event_id WHERE mitigation_plan IS NOT NULL GROUP BY event_type;	1982804371
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	4285492578
SELECT ra.assessment_id, re.event_type, ra.assessor FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id;	3769897631
SELECT * FROM risk_monitoring_logs WHERE is_exceeding_threshold = true UNION ALL SELECT NULL, NULL, NULL, NULL, NULL, NULL, COUNT(*) FROM risk_monitoring_logs WHERE is_exceeding_threshold = true;	529242231
SELECT r.event_id, a.risk_level, a.mitigation_plan FROM risk_events r JOIN risk_assessments a ON r.event_id = a.event_id;	3117545473
SELECT author FROM risk_reports WHERE approval_status = '已批准';	3370993536
SELECT customer_id, customer_name FROM customers WHERE risk_level = '高' AND credit_score > (SELECT AVG(credit_score) FROM customers);	1091114187
SELECT alert_content, assigned_to FROM alerts;	2742425726
SELECT event_description, severity, created_at, occurrence_time FROM risk_events WHERE status = '已解决' ORDER BY (occurrence_time - created_at) DESC LIMIT 10;	2894923077
SELECT * FROM rule_configurations rc JOIN risk_indicators ri ON rc.indicator_id = ri.indicator_id WHERE rc.is_active = true;	1904439079
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	1764574936
SELECT event_id, reporter FROM risk_events WHERE status = '未处理';	517879622
SELECT event_id, created_at FROM risk_events WHERE severity >= 3;	2298203203
SELECT mitigation_plan, assessor FROM risk_assessments;	3327856710
SELECT a.alert_id, r.event_description, l.audit_comments FROM alerts a LEFT JOIN risk_events r ON a.event_id = r.event_id LEFT JOIN (SELECT DISTINCT ON (alert_id) alert_id, audit_comments FROM audit_logs WHERE alert_id IS NOT NULL ORDER BY alert_id, audit_time DESC) l ON a.alert_id = l.alert_id WHERE a.status != '已解决' AND a.alert_level = '高';	3186015417
SELECT event_id, mitigation_plan FROM risk_assessments WHERE risk_level = '高';	278998762
SELECT DISTINCT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险' AND t.amount > 100000 AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	3967091987
SELECT * FROM risk_assessments WHERE impact_score > 8 AND risk_level = '高';	4092376057
SELECT re.event_description, rr.report_type, rr.report_content FROM risk_events re LEFT JOIN risk_reports rr ON re.event_id = rr.event_id;	4193608347
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 2 AND rr.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND npl.report_date BETWEEN '2023-07-01' AND '2023-09-30';	1848858966
SELECT * FROM regulatory_reports WHERE report_date = '2023-11-01';	4213891451
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE car.report_date BETWEEN '2023-06-01' AND '2023-06-30' AND npl.report_date BETWEEN '2023-06-01' AND '2023-06-30' AND car.total_car < 12 AND npl.npl_ratio > 2;	1479692348
SELECT institution_name FROM financial_institution_info JOIN risk_exposure USING(institution_id) ORDER BY market_risk_exposure/total_risk_exposure DESC LIMIT 1;	1995041708
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND rr.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND fi.registered_capital > 50000000;	963624927
SELECT fi.institution_name, (car.risk_weighted_assets/bs.total_assets) AS risk_weighted_asset_density FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN balance_sheet bs ON fi.institution_id = bs.institution_id AND car.report_date = bs.report_date ORDER BY risk_weighted_asset_density DESC LIMIT 1;	1658477082
SELECT liquidity_coverage_ratio, net_stable_funding_ratio FROM liquidity_ratio;	4132703668
SELECT institution_name FROM financial_institution_info JOIN compliance_records USING(institution_id) WHERE record_date BETWEEN '2023-12-01' AND '2023-12-31' AND status != '已解决';	3320395647
SELECT institution_id, SUM(loans_and_advances) AS total_loans, SUM(deposits) AS total_deposits FROM balance_sheet WHERE EXTRACT(YEAR FROM report_date) = 2024 GROUP BY institution_id;	1564305915
SELECT * FROM balance_sheet WHERE report_date = '2039-06-08';	4026702014
SELECT COUNT(DISTINCT institution_id) FROM non_performing_loans WHERE npl_ratio > 3;	512893913
SELECT net_interest_income, non_interest_income FROM income_statement WHERE report_date = '2023-03-01';	387964381
SELECT npl_amount/total_loans FROM non_performing_loans;	392823504
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND n.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND n.npl_ratio > 1;	2013521148
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM regulatory_reports WHERE report_date = '2023-10-01' AND report_type = '半年度报告' AND approval_status = '待审核');	1920599339
SELECT institution_name FROM financial_institution_info WHERE institution_type = '非银行' ORDER BY registered_capital DESC LIMIT 5;	2173229598
SELECT COUNT(*) FROM (SELECT fi.institution_id FROM financial_institution_info fi JOIN balance_sheet bs ON fi.institution_id=bs.institution_id JOIN non_performing_loans npl ON fi.institution_id=npl.institution_id WHERE npl.npl_ratio<1 AND npl.provision_coverage_ratio>200 GROUP BY fi.institution_id ORDER BY MAX(bs.total_assets) DESC LIMIT 500) AS top_500;	1986299311
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE car.report_date = '2023-12-01' AND rr.report_date = '2023-12-01' AND car.core_tier_1_ratio < 10 AND rr.approval_status = '待审核';	1934474274
SELECT fi.institution_name FROM financial_institution_info fi JOIN (
    SELECT i.institution_id, 
           (SUM(CASE WHEN i.report_date >= CURRENT_DATE - INTERVAL '1 year' THEN i.net_interest_income + i.non_interest_income ELSE 0 END) - 
            SUM(CASE WHEN i.report_date >= CURRENT_DATE - INTERVAL '2 years' AND i.report_date < CURRENT_DATE - INTERVAL '1 year' THEN i.net_interest_income + i.non_interest_income ELSE 0 END)) / 
           NULLIF(SUM(CASE WHEN i.report_date >= CURRENT_DATE - INTERVAL '2 years' AND i.report_date < CURRENT_DATE - INTERVAL '1 year' THEN i.net_interest_income + i.non_interest_income ELSE 0 END), 0) AS revenue_growth,
           (SUM(CASE WHEN i.report_date >= CURRENT_DATE - INTERVAL '1 year' THEN i.net_profit ELSE 0 END) - 
            SUM(CASE WHEN i.report_date >= CURRENT_DATE - INTERVAL '2 years' AND i.report_date < CURRENT_DATE - INTERVAL '1 year' THEN i.net_profit ELSE 0 END)) / 
           NULLIF(SUM(CASE WHEN i.report_date >= CURRENT_DATE - INTERVAL '2 years' AND i.report_date < CURRENT_DATE - INTERVAL '1 year' THEN i.net_profit ELSE 0 END), 0) AS profit_growth
    FROM income_statement i
    WHERE i.report_date >= CURRENT_DATE - INTERVAL '2 years'
    GROUP BY i.institution_id
    ORDER BY revenue_growth DESC, profit_growth ASC
    LIMIT 1
) growth ON fi.institution_id = growth.institution_id;	3102250159
SELECT report_date, approval_status FROM regulatory_reports WHERE report_date = '2023-07-01';	3066710012
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id GROUP BY fi.institution_id, fi.institution_name HAVING AVG(car.core_tier_1_ratio) > (SELECT AVG(core_tier_1_ratio) FROM capital_adequacy_ratio) AND AVG(car.tier_1_ratio) > (SELECT AVG(tier_1_ratio) FROM capital_adequacy_ratio) AND AVG(car.total_car) > (SELECT AVG(total_car) FROM capital_adequacy_ratio);	3079904075
SELECT * FROM compliance_records WHERE EXTRACT(YEAR FROM record_date) = 2023 AND status = '已解决';	2257683611
SELECT report_type FROM regulatory_reports WHERE report_date BETWEEN '2023-07-01' AND '2023-09-30' GROUP BY report_type ORDER BY COUNT(*) DESC LIMIT 1;	722775591
SELECT tier_1_ratio FROM capital_adequacy_ratio;	692012487
SELECT fi.institution_name, lr.report_date FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id WHERE lr.liquidity_coverage_ratio > 100;	3599351686
SELECT 
    fii.institution_name,
    STDDEV(bs.total_liabilities / bs.total_assets) AS liability_ratio_volatility,
    ARRAY_AGG(lr.liquidity_coverage_ratio ORDER BY lr.report_date) AS lcr_trend
FROM balance_sheet bs
JOIN financial_institution_info fii ON bs.institution_id = fii.institution_id
JOIN liquidity_ratio lr ON bs.institution_id = lr.institution_id AND bs.report_date = lr.report_date
WHERE bs.report_date >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY fii.institution_id, fii.institution_name
ORDER BY liability_ratio_volatility DESC
LIMIT 5;	3317302935
SELECT * FROM compliance_records WHERE EXTRACT(YEAR FROM record_date) = 2023 AND EXTRACT(MONTH FROM record_date) = 3;	3773444090
SELECT compliance_type, severity FROM compliance_records WHERE EXTRACT(YEAR FROM record_date) = 2024;	1568439599
SELECT report_type FROM regulatory_reports WHERE report_date = '2023-10-01';	2339192001
SELECT * FROM compliance_records WHERE severity = '中' AND EXTRACT(YEAR FROM record_date) = 2023;	1629609477
SELECT record_id, compliance_type, description, status FROM compliance_records WHERE record_date = '2023-10-01';	3577134167
SELECT fi.institution_name FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id WHERE lr.liquidity_coverage_ratio > (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio) AND lr.net_stable_funding_ratio > (SELECT AVG(net_stable_funding_ratio) FROM liquidity_ratio) AND lr.loan_to_deposit_ratio > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio);	1942470085
SELECT fi.institution_name, rr.report_type, rr.submission_date FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id WHERE rr.submission_date BETWEEN '2023-07-01' AND '2023-09-30' AND rr.approval_status = '需修改' ORDER BY rr.submission_date DESC;	385930717
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE car.total_car < (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY total_car) FROM capital_adequacy_ratio) AND npl.npl_ratio < (SELECT AVG(npl_ratio) FROM non_performing_loans) AND car.report_date = (SELECT MAX(report_date) FROM capital_adequacy_ratio WHERE institution_id = fi.institution_id) AND npl.report_date = (SELECT MAX(report_date) FROM non_performing_loans WHERE institution_id = fi.institution_id);	528420038
SELECT registered_capital, institution_type FROM financial_institution_info;	2513164587
SELECT establishment_date, legal_representative FROM financial_institution_info;	1975090084
SELECT * FROM compliance_records WHERE status = '已解决';	107672657
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.approval_status = '需修改' AND npl.npl_ratio > 1 AND rr.report_date BETWEEN '2023-07-01' AND '2023-07-31' AND npl.report_date BETWEEN '2023-07-01' AND '2023-07-31';	1483363664
SELECT institution_name FROM financial_institution_info JOIN balance_sheet USING(institution_id) ORDER BY ABS(loans_and_advances/deposits - 1) LIMIT 1;	2929840073
SELECT fi.* FROM financial_institution_info fi INNER JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE npl.total_loans > 100000000000;	1300789994
SELECT cash_and_equivalents FROM balance_sheet WHERE report_date = '2026-04-27';	2165898338
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM capital_adequacy_ratio WHERE core_tier_1_ratio < 9);	3755218299
SELECT DISTINCT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '已拒绝' AND npl.npl_ratio > 2 AND EXTRACT(YEAR FROM rr.report_date) = 2023 AND EXTRACT(YEAR FROM npl.report_date) = 2023;	523740688
SELECT COUNT(*) FROM (SELECT fi.institution_id FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN balance_sheet bs ON fi.institution_id = bs.institution_id AND car.report_date = bs.report_date ORDER BY (car.risk_weighted_assets / bs.total_assets) DESC LIMIT 10) AS top_institutions WHERE EXISTS (SELECT 1 FROM risk_exposure re WHERE re.institution_id = top_institutions.institution_id AND re.market_risk_exposure > 1000000);	3766160186
SELECT NULL AS average_branch_count WHERE false;	3227551380
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id AND re.report_date = car.report_date WHERE re.market_risk_exposure/re.total_risk_exposure > 0.2 AND car.core_tier_1_ratio < 8.5;	2211928222
SELECT f.institution_name, c.core_tier_1_ratio, c.tier_1_ratio, c.total_car FROM financial_institution_info f JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id WHERE c.report_date = '2023-12-01' AND c.core_tier_1_ratio < 10 AND c.total_car < 12;	1570037252
SELECT COUNT(*) FROM compliance_records WHERE severity = '高' AND record_date BETWEEN '2023-01-01' AND '2023-12-31';	1995720794
SELECT institution_name FROM financial_institution_info WHERE institution_id = (SELECT institution_id FROM balance_sheet ORDER BY cash_and_equivalents/total_assets DESC LIMIT 1);	2276785796
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id WHERE re.market_risk_exposure / re.total_risk_exposure > 0.4;	1118569576
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.approval_status = '批准' GROUP BY fi.institution_name ORDER BY COUNT(*) DESC LIMIT 1;	201491443
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE car.core_tier_1_ratio < 8 AND rr.approval_status = '已批准' AND EXTRACT(YEAR FROM car.report_date) = 2023 AND EXTRACT(YEAR FROM rr.report_date) = 2023;	883311234
SELECT fi.institution_name, re.operational_risk_exposure, re.credit_risk_exposure FROM risk_exposure re JOIN financial_institution_info fi ON re.institution_id = fi.institution_id WHERE re.report_date BETWEEN '2024-01-01' AND '2024-01-31';	1131673647
SELECT description, severity FROM compliance_records WHERE record_date = '2023-04-02';	626463466
SELECT report_date, npl_ratio FROM non_performing_loans ORDER BY report_date;	4144375691
SELECT fi.institution_name, npl.provision_coverage_ratio FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE npl.provision_coverage_ratio > 150;	3229296369
SELECT * FROM related_party_transactions WHERE transaction_date = '2023-12-22';	386496319
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN liquidity_ratio l ON f.institution_id = l.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE l.liquidity_coverage_ratio > 110 AND n.npl_ratio < 1.5;	1091949185
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND n.npl_ratio > 2;	2649798001
SELECT f.institution_name FROM financial_institution_info f JOIN income_statement i ON f.institution_id = i.institution_id WHERE i.report_date >= CURRENT_DATE - INTERVAL '2 years' GROUP BY f.institution_name ORDER BY AVG(i.net_profit / (i.net_interest_income + i.non_interest_income)) DESC LIMIT 5;	3441420122
SELECT institution_type, AVG(npl_ratio) FROM financial_institution_info JOIN non_performing_loans ON financial_institution_info.institution_id = non_performing_loans.institution_id WHERE EXTRACT(YEAR FROM report_date) = 2023 GROUP BY institution_type;	3747732181
SELECT COUNT(DISTINCT fi.institution_id) FROM financial_institution_info fi
WHERE EXISTS (
    SELECT 1 FROM (
        SELECT institution_id, 
               market_risk_exposure,
               LAG(market_risk_exposure) OVER (PARTITION BY institution_id ORDER BY report_date) as prev_market_risk
        FROM risk_exposure
    ) re 
    WHERE re.institution_id = fi.institution_id 
    AND re.prev_market_risk IS NOT NULL
    AND (re.market_risk_exposure - re.prev_market_risk)/re.prev_market_risk > 0.5
) AND EXISTS (
    SELECT 1 FROM (
        SELECT institution_id, 
               total_car,
               LAG(total_car) OVER (PARTITION BY institution_id ORDER BY report_date) as prev_car
        FROM capital_adequacy_ratio
    ) car 
    WHERE car.institution_id = fi.institution_id 
    AND car.prev_car IS NOT NULL
    AND (car.total_car - car.prev_car) < 1
);	919872126
SELECT total_assets, total_liabilities FROM balance_sheet;	2908646442
SELECT DISTINCT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE rr.approval_status = '需修改' AND rpt.transaction_amount > 5000000 AND rr.report_date BETWEEN '2023-07-01' AND '2023-07-31' AND rpt.transaction_date BETWEEN '2023-07-01' AND '2023-07-31';	2285587483
SELECT AVG(total_car) FROM capital_adequacy_ratio WHERE institution_id IN (SELECT institution_id FROM balance_sheet WHERE total_assets > 100000000000);	649523026
SELECT * FROM risk_exposure WHERE report_date = '2023-10-01';	3485650704
SELECT fi.institution_name FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rpt.transaction_date = '2023-06-01' AND rpt.transaction_amount > 5000000 AND rr.approval_status = '已批准';	1308426053
SELECT b.institution_id, b.report_date, b.total_assets, c.total_car FROM balance_sheet b JOIN capital_adequacy_ratio c ON b.institution_id = c.institution_id AND b.report_date = c.report_date;	2884378083
SELECT fi.institution_name FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE EXTRACT(YEAR FROM rpt.transaction_date) = 2023 GROUP BY fi.institution_id, fi.institution_name HAVING SUM(CASE WHEN rpt.approval_status != '通过' THEN 1 ELSE 0 END)::float/COUNT(*) > 0.2;	443478039
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.report_date = '2023-07-01' AND npl.npl_ratio > 2;	4005725614
SELECT r.institution_id, r.approval_status, c.description, c.severity, c.status FROM regulatory_reports r JOIN compliance_records c ON r.institution_id = c.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND c.record_date BETWEEN '2023-01-01' AND '2023-12-31';	4256634062
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' AND npl.report_date = '2023-10-01' AND npl.npl_ratio > 2;	2610777117
SELECT fi.institution_name, lr.liquidity_coverage_ratio, lr.net_stable_funding_ratio FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id WHERE lr.report_date BETWEEN '2023-05-01' AND '2023-05-31';	1523818846
SELECT i.institution_name, SUM(s.non_interest_income) FROM financial_institution_info i JOIN income_statement s ON i.institution_id = s.institution_id WHERE s.report_date = '2023-03-01' GROUP BY i.institution_name;	959939959
SELECT institution_id, credit_risk_exposure, market_risk_exposure, operational_risk_exposure, total_risk_exposure FROM risk_exposure WHERE report_date = '2023-02-01';	1728769608
SELECT COUNT(*) FROM related_party_transactions WHERE EXTRACT(YEAR FROM transaction_date) = 2023 AND transaction_amount > 500000000 AND transaction_type = '资产转移';	192754968
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT r.institution_id FROM regulatory_reports r WHERE r.report_date = '2023-08-01' AND r.approval_status = '需修改' INTERSECT SELECT t.institution_id FROM related_party_transactions t WHERE t.transaction_amount > 5000000);	1423558555
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN income_statement is ON fi.institution_id = is.institution_id WHERE EXTRACT(YEAR FROM rr.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝' AND is.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND is.net_profit > 10000000;	1234119757
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM regulatory_reports WHERE report_date = '2023-07-01' AND approval_status = '需要修改' AND report_type = '季度报告');	4123846713
SELECT * FROM compliance_records WHERE compliance_type = '内控管理';	2934745000
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date BETWEEN '2023-10-01' AND '2023-10-31' AND rr.report_type = '半年度报告' AND rr.approval_status = '待审核' AND npl.npl_ratio > 1;	2857258268
SELECT fi.institution_type, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl.npl_ratio) AS median_npl_ratio FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id GROUP BY fi.institution_type;	3135361103
SELECT * FROM capital_adequacy_ratio WHERE core_tier_1_ratio < 8;	2627561757
SELECT institution_name FROM financial_institution_info JOIN regulatory_reports USING(institution_id) WHERE EXTRACT(YEAR FROM report_date) = 2023 AND report_type = '半年度报告' AND approval_status = '待审核' AND registered_capital > 50000000;	1691256900
SELECT fi.institution_name FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE rpt.transaction_date = '2023-06-01' AND rpt.transaction_amount > 5000000 AND rpt.approval_status = '待审批';	3500907449
SELECT fi.institution_name FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id WHERE lr.loan_to_deposit_ratio > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio) AND lr.liquidity_coverage_ratio < (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio);	1148055259
SELECT institution_name FROM financial_institution_info JOIN income_statement USING(institution_id) WHERE report_date = '2023-04-01' AND net_interest_income > 1000000000;	2380032898
SELECT DISTINCT fi.institution_name FROM financial_institution_info fi INNER JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id INNER JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND npl.npl_ratio > 1;	3197865400
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE re.report_date = '2023-10-01' AND car.report_date = '2023-10-01' AND re.total_risk_exposure > 3000 AND car.core_tier_1_ratio < 8;	1039966050
SELECT COUNT(DISTINCT r1.institution_id) FROM risk_exposure r1 JOIN risk_exposure r2 ON r1.institution_id = r2.institution_id AND r1.report_date > r2.report_date WHERE r1.report_date >= CURRENT_DATE - INTERVAL '1 year' AND r2.report_date >= CURRENT_DATE - INTERVAL '2 years' AND ABS((r1.market_risk_exposure/NULLIF(r1.credit_risk_exposure,0)) - (r2.market_risk_exposure/NULLIF(r2.credit_risk_exposure,0))) > 0.1;	198071887
SELECT f.institution_name FROM financial_institution_info f JOIN balance_sheet b ON f.institution_id = b.institution_id WHERE b.loans_and_advances > b.deposits;	1236237152
SELECT f.institution_name, r.report_date, r.approval_status FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '已拒绝';	968909295
SELECT institution_name FROM financial_institution_info JOIN income_statement USING(institution_id) WHERE report_date = '2023-04-01' AND non_interest_income > 200000000;	2730335394
SELECT fi.institution_name FROM related_party_transactions rpt JOIN financial_institution_info fi ON rpt.institution_id = fi.institution_id WHERE rpt.transaction_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY fi.institution_name ORDER BY COUNT(*) DESC LIMIT 1;	3396337586
SELECT fi.institution_name, re.credit_risk_exposure/re.total_risk_exposure FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id ORDER BY re.credit_risk_exposure/re.total_risk_exposure DESC LIMIT 1;	3597519580
SELECT DISTINCT institution_id FROM risk_exposure WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31';	3614967513
SELECT institution_name FROM financial_institution_info JOIN capital_adequacy_ratio USING(institution_id) WHERE report_date BETWEEN '2023-11-01' AND '2023-11-30' AND risk_weighted_assets > 120000000000;	2748780530
SELECT CORR(EXTRACT(DAY FROM (resolution_date - record_date)), CASE severity WHEN '高' THEN 3 WHEN '中' THEN 2 WHEN '低' THEN 1 END) FROM compliance_records WHERE resolution_date IS NOT NULL;	2632158975
SELECT COUNT(DISTINCT institution_id) FROM liquidity_ratio WHERE liquidity_coverage_ratio >= 100 AND net_stable_funding_ratio >= 100;	2902591324
SELECT AVG(npl.npl_ratio) AS avg_npl_ratio, AVG(npl.provision_coverage_ratio) AS avg_provision_coverage_ratio, AVG(car.total_car) AS avg_total_car FROM non_performing_loans npl JOIN capital_adequacy_ratio car ON npl.institution_id = car.institution_id AND npl.report_date = car.report_date WHERE npl.institution_id IN (SELECT institution_id FROM balance_sheet ORDER BY total_assets DESC LIMIT 1000);	1348038828
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND npl.report_date = '2023-07-01' AND npl.npl_ratio > 1.5;	3607596195
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2024-01-01' AND rr.report_type = '年度报告' AND rr.approval_status = '已批准' AND npl.report_date = '2024-01-01' AND npl.npl_ratio > 1;	3633299910
SELECT f.institution_name, l.report_date, l.liquidity_coverage_ratio, l.net_stable_funding_ratio, l.loan_to_deposit_ratio FROM liquidity_ratio l JOIN financial_institution_info f ON l.institution_id = f.institution_id;	1922989461
SELECT fi.institution_name FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE EXTRACT(YEAR FROM npl.report_date) = 2023 AND EXTRACT(MONTH FROM npl.report_date) = 12 AND npl.npl_ratio > 1.5;	2401722243
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT l.institution_id FROM liquidity_ratio l WHERE l.loan_to_deposit_ratio > 75 AND l.liquidity_coverage_ratio < 120);	2405354254
SELECT * FROM regulatory_reports WHERE report_type = '半年度报告';	4266831229
SELECT c.description, f.institution_name, (c.resolution_date - c.record_date) AS resolution_time FROM compliance_records c JOIN financial_institution_info f ON c.institution_id = f.institution_id WHERE c.resolution_date IS NOT NULL ORDER BY resolution_time DESC LIMIT 5;	1742014679
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND EXTRACT(YEAR FROM n.report_date) = 2023 AND n.npl_ratio > 2;	3817977186
SELECT fi.institution_name, rr.report_id, rr.report_date, rr.comments FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE EXTRACT(YEAR FROM rr.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	1802118314
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM liquidity_ratio WHERE loan_to_deposit_ratio BETWEEN 60 AND 80);	2087453732
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id ORDER BY ABS(car.core_tier_1_ratio - car.total_car) ASC LIMIT 1;	3808399451
SELECT b.total_liabilities, f.registered_capital FROM balance_sheet b JOIN financial_institution_info f ON b.institution_id = f.institution_id WHERE b.report_date BETWEEN '2024-01-01' AND '2024-12-31';	2456149460
SELECT CORR(re.credit_risk_exposure, npl.npl_ratio) FROM risk_exposure re JOIN non_performing_loans npl ON re.institution_id = npl.institution_id AND re.report_date = npl.report_date;	3432807420
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id JOIN regulatory_reports r ON f.institution_id = r.institution_id WHERE EXTRACT(YEAR FROM c.report_date) = 2023 AND EXTRACT(YEAR FROM r.report_date) = 2023 AND r.approval_status = '已批准' AND c.total_car > 10;	2831855702
SELECT fi.institution_name, npl.npl_ratio FROM non_performing_loans npl JOIN financial_institution_info fi ON npl.institution_id = fi.institution_id WHERE npl.report_date = '2023-06-01';	937269248
SELECT institution_name FROM financial_institution_info JOIN risk_exposure ON financial_institution_info.institution_id = risk_exposure.institution_id WHERE report_date BETWEEN '2023-05-01' AND '2023-05-31' AND market_risk_exposure > 20000000000;	1582158774
SELECT fi.institution_name, rr.report_date, rr.approval_status FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id WHERE EXTRACT(YEAR FROM rr.report_date) = 2024 AND rr.report_type = '年度报告' AND rr.approval_status = '已批准';	1919719297
SELECT core_tier_1_ratio, tier_1_ratio, total_car, risk_weighted_assets FROM capital_adequacy_ratio WHERE report_date = '2023-11-01';	290598667
SELECT CORR(lr.net_stable_funding_ratio, car.core_tier_1_ratio) FROM liquidity_ratio lr JOIN capital_adequacy_ratio car ON lr.institution_id = car.institution_id AND lr.report_date = car.report_date;	2475489916
SELECT fi.institution_name, rr.report_date FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.report_date BETWEEN '2024-01-01' AND '2024-12-31' AND rr.report_type = '年度报告' AND rr.approval_status = '已批准';	3290412838
SELECT * FROM capital_adequacy_ratio WHERE report_date = '2023-11-01';	3667228314
SELECT core_tier_1_ratio, tier_1_ratio, total_car, risk_weighted_assets FROM capital_adequacy_ratio WHERE institution_id = 2162;	3772456063
SELECT total_loans, npl_amount FROM non_performing_loans WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31';	1771519459
SELECT CORR(re.market_risk_ratio, ie.non_interest_ratio) FROM (SELECT institution_id, report_date, market_risk_exposure/total_risk_exposure AS market_risk_ratio FROM risk_exposure WHERE total_risk_exposure > 0) re JOIN (SELECT institution_id, report_date, non_interest_income/(net_interest_income+non_interest_income) AS non_interest_ratio FROM income_statement WHERE (net_interest_income+non_interest_income) > 0) ie ON re.institution_id = ie.institution_id AND re.report_date = ie.report_date;	3968495722
SELECT i.institution_name FROM financial_institution_info i JOIN income_statement s ON i.institution_id = s.institution_id JOIN non_performing_loans n ON i.institution_id = n.institution_id AND s.report_date = n.report_date ORDER BY s.provision_for_loan_losses/n.npl_amount DESC LIMIT 1;	3848674416
SELECT f.institution_name, l.report_date, l.liquidity_coverage_ratio, l.net_stable_funding_ratio, l.loan_to_deposit_ratio, c.core_tier_1_ratio, c.tier_1_ratio, c.total_car FROM financial_institution_info f JOIN liquidity_ratio l ON f.institution_id = l.institution_id JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id AND l.report_date = c.report_date WHERE l.report_date BETWEEN '2023-01-01' AND '2023-12-31';	3699682626
SELECT i.institution_name FROM income_statement s JOIN financial_institution_info i ON s.institution_id = i.institution_id WHERE s.report_date = '2023-04-01' ORDER BY s.operating_expenses DESC LIMIT 1;	2936322968
SELECT i.institution_name, s.non_interest_income, s.net_profit FROM financial_institution_info i JOIN income_statement s ON i.institution_id = s.institution_id WHERE EXTRACT(YEAR FROM s.report_date) = 2023;	4218229725
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND EXTRACT(YEAR FROM n.report_date) = 2023 AND n.npl_ratio > 2;	2633632934
SELECT institution_name FROM financial_institution_info JOIN capital_adequacy_ratio ON financial_institution_info.institution_id = capital_adequacy_ratio.institution_id WHERE report_date BETWEEN '2023-12-01' AND '2023-12-31' AND core_tier_1_ratio < 9;	2211128720
SELECT institution_name FROM financial_institution_info JOIN liquidity_ratio USING(institution_id) WHERE report_date BETWEEN '2023-11-01' AND '2023-11-30' AND liquidity_coverage_ratio < 110;	3020061302
SELECT re.market_risk_exposure, npl.provision_coverage_ratio FROM risk_exposure re JOIN non_performing_loans npl ON re.institution_id = npl.institution_id WHERE re.report_date = '2023-03-01' AND npl.report_date = '2023-03-01';	3525231563
SELECT legal_representative, contact_number FROM financial_institution_info;	2015435463
SELECT fi.institution_name FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE EXTRACT(YEAR FROM rpt.transaction_date) = 2023 GROUP BY fi.institution_id, fi.institution_name ORDER BY COUNT(DISTINCT rpt.related_party) DESC LIMIT 1;	4069066039
SELECT fi.address, AVG(lr.liquidity_coverage_ratio) FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id GROUP BY fi.address ORDER BY AVG(lr.liquidity_coverage_ratio) DESC;	803154529
SELECT date_trunc('quarter', report_date) AS quarter, avg(char_length(comments)) FROM regulatory_reports WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY quarter ORDER BY quarter;	3721655383
SELECT fi.institution_name, npl.provision_coverage_ratio FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id ORDER BY npl.provision_coverage_ratio DESC LIMIT 1;	1629126831
SELECT legal_representative, contact_number FROM financial_institution_info;	4123438074
SELECT fi.institution_name, rr.report_date, rr.submission_date FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改';	2499994444
SELECT f.institution_name FROM financial_institution_info f JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE c.total_car > 12 AND n.npl_ratio < 2;	2833113074
SELECT fi.institution_name FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id WHERE lr.liquidity_coverage_ratio > 100 AND lr.loan_to_deposit_ratio < 75 LIMIT 10;	3586979855
SELECT institution_name FROM financial_institution_info JOIN risk_exposure USING(institution_id) WHERE EXTRACT(YEAR FROM report_date) = 2023 AND credit_risk_exposure > 50000000000;	3035130167
SELECT institution_name FROM financial_institution_info JOIN non_performing_loans ON financial_institution_info.institution_id = non_performing_loans.institution_id WHERE npl_ratio > 2;	991328095
SELECT * FROM capital_adequacy_ratio WHERE report_date = '2023-05-01';	193769567
SELECT institution_id, severity, COUNT(*) FROM compliance_records WHERE record_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY institution_id, severity;	1904851109
SELECT f.institution_name, r.report_date, r.comments FROM regulatory_reports r JOIN financial_institution_info f ON r.institution_id = f.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '已拒绝';	1910117598
SELECT fi.institution_name, rpt.related_party, rpt.transaction_type, rpt.transaction_amount, rpt.approval_status FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id;	1443528046
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' GROUP BY fi.institution_id, fi.institution_name HAVING SUM(rpt.transaction_amount) > 10000000;	2822939894
SELECT f.institution_name, r.report_id, r.report_date, r.comments FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '已拒绝';	835822696
SELECT fi.institution_name, rr.report_type, rr.approval_status, rr.submission_date FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE EXTRACT(YEAR FROM rr.submission_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	3549330683
SELECT f.address, n.npl_ratio FROM non_performing_loans n JOIN financial_institution_info f ON n.institution_id = f.institution_id;	3331068318
SELECT report_type, approval_status FROM regulatory_reports WHERE report_date BETWEEN '2024-01-01' AND '2024-12-31';	1531917176
SELECT fi.institution_type, percentile_cont(0.5) WITHIN GROUP (ORDER BY lr.liquidity_coverage_ratio) FROM liquidity_ratio lr JOIN financial_institution_info fi ON lr.institution_id = fi.institution_id GROUP BY fi.institution_type;	760513399
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND c.report_date = '2023-06-01' AND c.core_tier_1_ratio < 8;	3284405813
SELECT AVG(npl.npl_ratio) FROM (SELECT institution_id FROM capital_adequacy_ratio WHERE report_date BETWEEN '2023-07-01' AND '2023-09-30' ORDER BY total_car DESC LIMIT 10) AS top10 JOIN non_performing_loans npl ON top10.institution_id = npl.institution_id WHERE npl.report_date BETWEEN '2023-07-01' AND '2023-09-30';	2472810304
SELECT institution_name FROM financial_institution_info WHERE institution_id = (SELECT institution_id FROM compliance_records WHERE status = '未解决' GROUP BY institution_id ORDER BY COUNT(*) DESC LIMIT 1);	2615993388
SELECT * FROM related_party_transactions WHERE transaction_date BETWEEN '2023-01-01' AND '2023-12-31' AND transaction_amount > 5000000;	377772969
SELECT institution_name FROM financial_institution_info JOIN risk_exposure USING(institution_id) WHERE (market_risk_exposure / total_risk_exposure) > 0.25;	1308984725
SELECT f.institution_name, r.transaction_amount, r.transaction_type FROM financial_institution_info f JOIN related_party_transactions r ON f.institution_id = r.institution_id WHERE EXTRACT(YEAR FROM r.transaction_date) = 2023 AND EXTRACT(MONTH FROM r.transaction_date) = 8 AND r.transaction_amount > 5000000 AND r.approval_status = '待审批';	1150041966
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN income_statement i ON f.institution_id = i.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND i.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND i.net_profit > 50000000;	673273910
SELECT institution_id FROM non_performing_loans WHERE npl_ratio > (SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY npl_ratio) FROM non_performing_loans) INTERSECT SELECT institution_id FROM non_performing_loans WHERE provision_coverage_ratio > (SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY provision_coverage_ratio) FROM non_performing_loans) INTERSECT SELECT institution_id FROM capital_adequacy_ratio WHERE total_car > (SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY total_car) FROM capital_adequacy_ratio);	419851650
SELECT related_party FROM related_party_transactions ORDER BY transaction_amount DESC LIMIT 1;	3572294732
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.report_date = '2023-10-01' AND rr.approval_status = '待审批';	4283508902
SELECT institution_name FROM financial_institution_info f JOIN risk_exposure r ON f.institution_id = r.institution_id WHERE r.report_date BETWEEN '2023-05-01' AND '2023-05-31' AND r.total_risk_exposure > 15000000000;	1599927341
SELECT institution_name FROM financial_institution_info JOIN regulatory_reports USING(institution_id) WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31' AND report_type = '季度报告' AND approval_status = '需修改' AND registered_capital > 50000000;	3420383582
SELECT credit_risk_exposure, market_risk_exposure FROM risk_exposure WHERE report_date BETWEEN '2023-11-01' AND '2023-11-30';	499317923
SELECT credit_risk_exposure, total_risk_exposure FROM risk_exposure WHERE report_date = '2023-09-01';	457189594
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM related_party_transactions WHERE transaction_date BETWEEN '2023-05-01' AND '2023-05-31' AND transaction_amount > 5000000 AND approval_status = '已批准');	3369481943
SELECT institution_id FROM capital_adequacy_ratio WHERE risk_weighted_assets > 8000;	1390640393
SELECT COUNT(DISTINCT fi.institution_id) FROM financial_institution_info fi JOIN balance_sheet bs ON fi.institution_id = bs.institution_id WHERE fi.registered_capital < 1000000000 AND bs.total_assets > 100000000000;	1382464489
SELECT f.institution_name FROM financial_institution_info f JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE c.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND n.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND c.total_car < 12 AND n.npl_ratio > 2;	2752170463
SELECT report_date, approval_status FROM regulatory_reports;	3325591137
SELECT institution_name FROM financial_institution_info JOIN balance_sheet USING(institution_id) WHERE EXTRACT(YEAR FROM report_date) = 2024 ORDER BY total_assets DESC LIMIT 1;	1941989460
SELECT compliance_type FROM compliance_records WHERE record_date >= '2023-01-01' AND record_date <= '2023-12-31' AND severity = '严重' GROUP BY compliance_type ORDER BY AVG(resolution_date - record_date) DESC LIMIT 1;	1530061075
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id=rr.institution_id JOIN related_party_transactions rpt ON fi.institution_id=rpt.institution_id WHERE rr.report_date='2023-10-01' AND rr.report_type='半年度报告' AND rpt.transaction_amount>5000000;	3537264682
SELECT AVG(non_interest_income) FROM income_statement WHERE report_date = '2023-01-01';	2919422399
SELECT npl_amount, report_date FROM non_performing_loans WHERE report_date >= '2023-06-01' AND report_date < '2023-07-01';	1291795377
SELECT institution_id FROM non_performing_loans WHERE provision_coverage_ratio < 200;	1487045407
SELECT AVG(car.total_car) FROM (SELECT i.institution_id FROM income_statement i WHERE i.report_date BETWEEN '2023-10-01' AND '2023-12-31' GROUP BY i.institution_id ORDER BY SUM(i.net_profit) DESC LIMIT 10) top10 JOIN capital_adequacy_ratio car ON top10.institution_id = car.institution_id WHERE car.report_date BETWEEN '2023-10-01' AND '2023-12-31';	1882291622
SELECT DISTINCT institution_name FROM financial_institution_info JOIN compliance_records USING(institution_id) WHERE description LIKE '%客户投诉%';	4004951089
SELECT institution_id, net_interest_income, non_interest_income FROM income_statement WHERE report_date BETWEEN '2023-07-01' AND '2023-07-31';	1865006955
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND EXTRACT(YEAR FROM n.report_date) = 2023 AND n.npl_ratio > 1;	3817053665
SELECT npl_amount, provision_coverage_ratio FROM non_performing_loans WHERE report_date = '2023-03-01';	3715884467
SELECT 
    fi.institution_name,
    bs.total_assets,
    car.total_car,
    lr.liquidity_coverage_ratio,
    npl.npl_ratio
FROM 
    financial_institution_info fi
JOIN 
    balance_sheet bs ON fi.institution_id = bs.institution_id
JOIN 
    capital_adequacy_ratio car ON fi.institution_id = car.institution_id AND bs.report_date = car.report_date
JOIN 
    liquidity_ratio lr ON fi.institution_id = lr.institution_id AND bs.report_date = lr.report_date
JOIN 
    non_performing_loans npl ON fi.institution_id = npl.institution_id AND bs.report_date = npl.report_date
ORDER BY 
    bs.total_assets DESC;	294279124
SELECT DISTINCT institution_name FROM financial_institution_info JOIN regulatory_reports USING(institution_id) WHERE EXTRACT(YEAR FROM report_date) = 2023 AND approval_status = '已拒绝';	3265881008
SELECT COUNT(DISTINCT a.institution_id) FROM (
    SELECT institution_id, report_date, loans_and_advances, 
           LAG(loans_and_advances) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_loans,
           LAG(report_date) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_date
    FROM balance_sheet
) a JOIN (
    SELECT institution_id, report_date, total_car,
           LAG(total_car) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_car,
           LAG(report_date) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_car_date
    FROM capital_adequacy_ratio
) b ON a.institution_id = b.institution_id AND a.report_date = b.report_date
WHERE EXTRACT(YEAR FROM a.report_date) - EXTRACT(YEAR FROM a.prev_date) = 1 
  AND EXTRACT(YEAR FROM b.report_date) - EXTRACT(YEAR FROM b.prev_car_date) = 1
  AND (a.loans_and_advances - a.prev_loans)/a.prev_loans > 0.2
  AND (b.total_car - b.prev_car) < 0
  AND EXISTS (
    SELECT 1 FROM (
        SELECT institution_id, report_date, loans_and_advances, 
               LAG(loans_and_advances) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_loans2,
               LAG(report_date) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_date2
        FROM balance_sheet
    ) c 
    WHERE c.institution_id = a.institution_id 
      AND EXTRACT(YEAR FROM c.report_date) = EXTRACT(YEAR FROM a.prev_date)
      AND EXTRACT(YEAR FROM c.prev_date2) = EXTRACT(YEAR FROM a.prev_date) - 1
      AND (c.loans_and_advances - c.prev_loans2)/c.prev_loans2 > 0.2
  )
  AND EXISTS (
    SELECT 1 FROM (
        SELECT institution_id, report_date, total_car,
               LAG(total_car) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_car2,
               LAG(report_date) OVER (PARTITION BY institution_id ORDER BY report_date) AS prev_car_date2
        FROM capital_adequacy_ratio
    ) d 
    WHERE d.institution_id = b.institution_id 
      AND EXTRACT(YEAR FROM d.report_date) = EXTRACT(YEAR FROM b.prev_car_date)
      AND EXTRACT(YEAR FROM d.prev_car_date2) = EXTRACT(YEAR FROM b.prev_car_date) - 1
      AND (d.total_car - d.prev_car2) < 0
  );	562975454
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id WHERE r.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND r.report_type = '季度报告' AND r.approval_status = '需修改';	484628119
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND npl.npl_ratio > 1;	3754045686
SELECT DISTINCT f.institution_name FROM related_party_transactions r JOIN financial_institution_info f ON r.institution_id = f.institution_id WHERE EXTRACT(YEAR FROM r.transaction_date) = 2023 AND EXTRACT(MONTH FROM r.transaction_date) = 10;	2822411822
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT r.institution_id FROM regulatory_reports r JOIN non_performing_loans n ON r.institution_id = n.institution_id WHERE r.report_date = '2023-07-01' AND r.report_type = '季度报告' AND n.npl_ratio > 2);	3908166516
SELECT report_date, total_car, risk_weighted_assets FROM capital_adequacy_ratio ORDER BY report_date;	950743928
SELECT f.institution_name, l.liquidity_coverage_ratio, r.approval_status FROM financial_institution_info f JOIN liquidity_ratio l ON f.institution_id = l.institution_id JOIN regulatory_reports r ON f.institution_id = r.institution_id WHERE EXTRACT(YEAR FROM l.report_date) = 2023 AND EXTRACT(YEAR FROM r.report_date) = 2023 GROUP BY f.institution_name, l.liquidity_coverage_ratio, r.approval_status;	4238047826
SELECT i.institution_name, r.report_date, r.approval_status FROM financial_institution_info i JOIN regulatory_reports r ON i.institution_id = r.institution_id WHERE r.report_date > '2023-07-01' AND r.approval_status = '需修改';	3281109935
SELECT COUNT(*) FROM regulatory_reports WHERE report_date BETWEEN '2023-04-01' AND '2023-06-30' AND approval_status = '被拒绝';	1892746955
SELECT credit_risk_exposure, market_risk_exposure, operational_risk_exposure, total_risk_exposure FROM risk_exposure WHERE report_date = '2023-10-01';	3501885418
SELECT f.institution_name, (MAX(b.loans_and_advances)-MIN(b.loans_and_advances))/MIN(b.loans_and_advances)*100 AS growth_rate FROM balance_sheet b JOIN financial_institution_info f ON b.institution_id=f.institution_id GROUP BY f.institution_name ORDER BY growth_rate DESC LIMIT 1;	1776872424
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id JOIN balance_sheet bs ON fi.institution_id = bs.institution_id WHERE EXTRACT(YEAR FROM re.report_date) = 2023 AND EXTRACT(YEAR FROM bs.report_date) = 2023 AND (re.market_risk_exposure/bs.total_equity)*100 > 15;	3857370065
SELECT fi.institution_name, rr.report_type, rr.submission_date FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id WHERE rr.approval_status = '需修改' AND rr.submission_date BETWEEN '2023-01-01' AND '2023-12-31' ORDER BY rr.submission_date DESC;	1089851841
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN related_party_transactions t ON f.institution_id = t.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND EXTRACT(YEAR FROM t.transaction_date) = 2023 AND t.transaction_amount > 10000000;	1021775394
SELECT i.institution_type, AVG(l.liquidity_coverage_ratio) FROM financial_institution_info i JOIN liquidity_ratio l ON i.institution_id = l.institution_id GROUP BY i.institution_type;	1227391350
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM related_party_transactions WHERE transaction_date BETWEEN '2023-10-01' AND '2023-10-31' AND transaction_amount > 10000000);	993873143
SELECT i.institution_name FROM financial_institution_info i JOIN related_party_transactions t ON i.institution_id = t.institution_id WHERE t.transaction_date >= '2023-01-01' GROUP BY i.institution_name ORDER BY SUM(CASE WHEN t.approval_status = '未通过' THEN 1 ELSE 0 END)::float/COUNT(*) DESC LIMIT 1;	4220740302
SELECT f.institution_name FROM risk_exposure r JOIN financial_institution_info f ON r.institution_id = f.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' ORDER BY r.operational_risk_exposure / r.total_risk_exposure DESC LIMIT 1;	1254398371
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id WHERE r.report_type = '年度报告' AND EXTRACT(YEAR FROM r.report_date) = 2023 AND r.comments IS NOT NULL;	3894797587
SELECT n.total_loans, n.npl_amount, n.npl_ratio, n.provision_coverage_ratio, f.institution_name FROM non_performing_loans n JOIN financial_institution_info f ON n.institution_id = f.institution_id WHERE n.report_date = '2023-03-01';	1466082382
SELECT institution_name FROM financial_institution_info WHERE legal_representative LIKE '王%';	1640932570
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND c.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND r.report_type LIKE '%资本充足率%' AND c.total_car > 10;	659019966
