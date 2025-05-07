SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '客户服务部' AND a.date = '2024-10-13' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) / 3600 > 15;	2499788398
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-11' AND a.check_in > '09:00';	2790038483
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H03961' AND strftime('%Y', date) = '2024' AND check_in > '09:00';	1518250136
SELECT e.employee_id FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-24' AND ar.check_in < '08:30' AND pe.rating = 'A+';	2290175818
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-05';	1543926007
SELECT employees.name, departments.name, attendance_records.check_in, attendance_records.check_out FROM employees JOIN departments ON employees.department_id = departments.department_id JOIN attendance_records ON employees.employee_id = attendance_records.employee_id WHERE attendance_records.date = '2024-09-21' ORDER BY departments.name;	3053690473
SELECT ROUND(COUNT(CASE WHEN status = '离职' AND julianday(end_date) - julianday(start_date) < 90 THEN 1 END) * 1.0 / COUNT(*), 2) AS proportion FROM probation_employees;	1446084728
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-08' AND a.check_in > '09:00';	2505330870
SELECT e.name, e.hire_date FROM employees e JOIN probation_employees p ON e.employee_id = p.employee_id;	77372189
SELECT d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00' AND e.remaining_annual_leave < 5;	1298859483
SELECT e.employee_id, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE YEAR(e.hire_date) = 2023 AND a.date = '2024-10-05';	569704912
SELECT p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE YEAR(e.hire_date) = 2023 AND a.date = '2024-09-26';	399196427
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H05598' AND strftime('%Y', date) = '2024' AND check_out < '18:00';	2805240810
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-28' AND a.check_in > '09:00';	3848816814
SELECT e.employee_id FROM attendance_records a INNER JOIN employees e ON a.employee_id = e.employee_id INNER JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-12' AND a.check_in > '09:00' AND d.name = '运营部';	2544920386
SELECT e.employee_id, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00';	2048034491
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-21' AND a.check_in > '09:00';	1501079200
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-12-11' AND pe.rating = 'C';	1654155358
SELECT e.employee_id, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00';	1952426931
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '创新奖' AND p.rating = 'A+';	3946055885
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-09' AND a.check_in > '08:30:00';	2952516110
SELECT COUNT(DISTINCT p.employee_id) FROM probation_employees p JOIN awards a ON p.employee_id = a.employee_id WHERE YEAR(p.start_date) = 2023 AND YEAR(p.end_date) = 2023 AND a.year = 2023 AND a.award_name = '优秀员工奖';	3989733729
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE YEAR(e.hire_date) = 2021 AND a.year = 2022;	241703514
SELECT employee_id FROM attendance_records GROUP BY employee_id, date HAVING COUNT(*) > 1;	4110426671
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:30' AND e.remaining_annual_leave < 10;	1958968748
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.department_id = '销售部' AND a.date = '2024-09-19' AND a.check_in > '09:00';	1261641813
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-26' AND a.check_in > '09:00' AND p.rating = 'C';	1404049949
SELECT e.employee_id FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE YEAR(e.hire_date) = 2021 AND a.year = 2021 AND p.rating = 'B';	860878506
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-03' AND a.check_in > '09:00';	1830063336
SELECT a.employee_id FROM awards a JOIN probation_employees p ON a.employee_id = p.employee_id WHERE a.year = 2020 AND a.award_name = '优秀员工' AND p.status = '试用期内';	1384865982
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE YEAR(e.hire_date) = 2023 AND a.year = 2023 AND p.rating = 'A+';	3542777151
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN probation_employees p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND p.status = '试用期内';	1253418500
SELECT employee_id, 20 - remaining_annual_leave AS used_annual_leave FROM employees;	1306743539
SELECT e.name FROM employees e JOIN (SELECT a.employee_id FROM awards a WHERE a.year = 2022 AND a.award_name = '技术突破奖') AS awardees ON e.employee_id = awardees.employee_id JOIN (SELECT ar.employee_id FROM attendance_records ar WHERE (strftime('%s', ar.check_out) - strftime('%s', ar.check_in)) / 3600 > 10) AS long_workers ON e.employee_id = long_workers.employee_id;	1998735563
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-20' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 28800 AND d.name = '质量控制部';	3735871221
SELECT e.employee_id FROM employees e INNER JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-25' AND a.check_in < '09:00';	392713451
SELECT e.employee_id FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE pe.rating = 'A+' GROUP BY e.employee_id ORDER BY AVG((strftime('%s', ar.check_out) - strftime('%s', ar.check_in)) / 3600.0) DESC LIMIT 1;	3464604281
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-04' AND a.check_in > '09:00';	1444696553
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-18' AND a.check_in > '09:00' AND p.rating = 'D';	2023290915
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-25' AND a.check_in > '08:30:00' AND p.rating = 'B+';	3746804657
SELECT employee_id, interview_count FROM interviews WHERE YEAR(interview_date) = 2024 ORDER BY interview_count;	72949237
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '08:30:00' AND p.rating = 'A+';	1155706622
SELECT DISTINCT e.department_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-27' AND a.check_in > '09:00' AND e.remaining_annual_leave < 10;	638989138
SELECT e.name, p.evaluation_date FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id;	2390401103
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-07' AND a.check_in > '09:00' AND a.check_out < '17:00';	78855873
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-05';	3197959623
SELECT department_id FROM employees JOIN (SELECT employee_id, AVG(interview_count) AS avg_interviews FROM interviews GROUP BY employee_id) AS emp_interviews ON employees.employee_id = emp_interviews.employee_id GROUP BY department_id ORDER BY AVG(avg_interviews) DESC LIMIT 1;	3699728041
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-27' AND p.rating = 'A+';	3065616199
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '最佳团队奖' AND ar.date = '2024-10-09' AND ar.check_in > '09:00';	1681003052
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-10-14' AND a.check_in > '09:00';	4050465535
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_out > '13:00' AND p.rating = 'B+';	4249036992
SELECT e.employee_id, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-08' AND a.check_in > '09:00';	592982415
SELECT e.name, d.name, a.award_name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2022;	3584914350
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND a.check_in > '09:00' AND p.rating = 'D';	1423306349
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-13' AND a.check_in < '09:30';	2203283189
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-09-22' AND e.department_id = '客户服务部';	3865699446
SELECT DISTINCT a.employee_id FROM awards a INNER JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND p.rating = 'A+';	1909210649
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-05' AND a.check_in > '08:30' AND d.manager_id = 'H05487';	2144085984
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-02' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 32400;	283013543
SELECT departments.name, employees.name FROM performance_evaluations JOIN employees ON performance_evaluations.employee_id = employees.employee_id JOIN departments ON employees.department_id = departments.department_id WHERE performance_evaluations.evaluation_date = '2023-03-31' AND performance_evaluations.rating = 'D';	214548501
SELECT name, car_plate FROM employees WHERE employee_type = '正式';	3902051234
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-19' AND a.check_in > '09:00';	4268232257
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '客户满意度奖' AND ar.date = '2024-10-12' AND ar.check_in > '09:00';	2777106158
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00' AND d.manager_id = 'H00842';	932008813
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2023 AND a.award_name = '领导力奖';	3805690652
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND ar.date = '2024-10-09' AND ar.check_in > '09:00';	795140600
SELECT d.manager_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-02' AND a.check_in BETWEEN '09:00' AND '10:00' AND e.employee_type = '实习生';	3086085668
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id GROUP BY d.name ORDER BY AVG(DATEDIFF(CURRENT_DATE, e.birth_date)) DESC LIMIT 1;	2411560883
SELECT employee_id FROM employees WHERE employee_id IN (SELECT employee_id FROM attendance_records WHERE date = '2024-09-16') AND employee_id IN (SELECT employee_id FROM performance_evaluations WHERE rating = 'C');	3743308464
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-08' AND a.check_in > '09:00';	439444083
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-09-20' AND a.check_in > '09:00';	3252922075
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-05' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 28800;	1549624018
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-14' AND p.rating = 'A+';	261206730
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-27' AND a.check_in > '09:00' AND d.name = '行政部';	1406124018
SELECT d.name, COUNT(e.employee_id) FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.name;	1273187788
SELECT e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.rating = 'A+' ORDER BY e.hire_date DESC LIMIT 1;	161130038
SELECT e.employee_id FROM employees e JOIN (SELECT a.employee_id, ABS((strftime('%s', a.check_out) - strftime('%s', a.check_in)) - AVG(strftime('%s', a.check_out) - strftime('%s', a.check_in)) OVER (PARTITION BY e.department_id)) AS diff FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id) AS diff_table ON e.employee_id = diff_table.employee_id ORDER BY diff DESC LIMIT 1;	2367131410
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '研发部' AND a.date = '2024-10-05' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 36000;	736904101
SELECT e.name, d.name, p.rating FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-12';	87083721
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-11' AND a.check_in > '09:00';	1391282019
SELECT e.name, d.name, a.check_in, aw.award_name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id JOIN awards aw ON e.employee_id = aw.employee_id WHERE a.date = '2024-09-26' AND a.check_in > '09:00' AND aw.year = 2024 AND aw.date = '2024-09-26';	1614124608
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-05' AND a.check_in > '09:00' AND p.rating = 'A+';	119065582
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-10-07' AND a.check_in > '09:00' AND e.department_id = '人力资源部';	305429407
SELECT e.name, d.name, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-11' AND e.employee_type = '实习生' AND a.check_in < '09:00';	1434754295
SELECT a.employee_id FROM awards a INNER JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工奖' AND p.rating = 'A+';	1416753262
SELECT d.name, COUNT(DISTINCT e.employee_id) FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE pe.evaluation_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) AND pe.rating = '高' AND e.position IN ('经理', '高级职位') GROUP BY d.name;	1966520829
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '新人奖' AND ar.date = '2024-10-08';	3742208647
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-02' AND a.check_in > '09:00:00' AND p.rating = 'A+';	681058956
SELECT employees.name, departments.name FROM awards JOIN employees ON awards.employee_id = employees.employee_id JOIN departments ON employees.department_id = departments.department_id WHERE awards.year = 2024 AND awards.award_name = '新人奖';	3929652777
SELECT AVG(JULIANDAY(start_work_date) - JULIANDAY(hire_date)) FROM employees WHERE position = '管理职位';	2290314264
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-06' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 36000;	2118323252
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '技术突破奖' AND p.rating = 'A+';	1087843451
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND a.check_in > '09:00' AND p.rating = 'D';	386106206
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '项目管理奖' AND ar.date = '2024-10-03';	855220810
SELECT a.employee_id FROM awards a JOIN employees e ON a.employee_id = e.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND e.hire_date > '2017-01-01';	3375057924
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-16' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 28800;	4174232427
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND p.evaluation_date = '2023-06-04' AND p.rating = 'D';	734321783
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-10-12' AND a.check_in > '09:00' AND e.department_id = '客户服务部';	1241353029
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-21' AND a.check_in > '09:00' AND p.rating = 'B';	3667177289
SELECT DISTINCT d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00' AND p.rating = 'C';	4273970415
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-05' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 32400 AND d.name = '行政部';	323611946
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-06' AND a.check_in > '09:00';	2940103155
SELECT d.manager_id FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE YEAR(p.evaluation_date) = 2023 AND p.rating = 'A+';	434694019
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:00:00' AND p.rating = 'A';	1289703363
SELECT * FROM attendance_records WHERE date = '2024-10-01' AND employee_id IN (SELECT employee_id FROM awards WHERE year = 2023 AND award_name = '销售冠军');	1722398575
SELECT e.name, d.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN (SELECT pe.employee_id, MIN(pe.evaluation_date) AS first_a_plus_date FROM performance_evaluations pe WHERE pe.rating = 'A+' GROUP BY pe.employee_id) AS first_a_plus ON e.employee_id = first_a_plus.employee_id ORDER BY (first_a_plus.first_a_plus_date - e.hire_date) ASC LIMIT 1;	804493985
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00';	1306450278
SELECT DISTINCT a.employee_id FROM awards a INNER JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND a.award_name = '优秀员工' AND p.rating = 'A+';	1414070332
SELECT e.name, d.name, p.rating FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2023-10-29';	3925025909
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-17' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 32400;	1398775192
SELECT d.name FROM performance_evaluations p INNER JOIN employees e ON p.employee_id = e.employee_id INNER JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2022-06-16' AND p.rating = 'C';	2656339281
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2022 AND a.award_name = '优秀员工' AND p.evaluation_date = '2022-10-30' AND p.rating = 'A+';	3627252999
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-15' AND a.check_in > '09:00' AND p.rating = 'B';	2285040147
SELECT e.name, e.position FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE d.name = '销售部';	3934214389
SELECT employee_id FROM employees WHERE employee_id IN (SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-23' AND a.check_in > '09:00' AND p.rating = 'D');	1649684433
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '客户服务部' AND p.rating = 'D' AND p.evaluation_date = '2024-10-14';	1300169145
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND e.hire_date >= '2019-01-01';	3467712746
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in > '09:00' AND p.rating = 'A+';	225648923
SELECT e.employee_id, e.name FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN awards a ON e.employee_id = a.employee_id WHERE pe.rating = '一般' AND (a.award_name = '最佳团队贡献奖' OR a.award_name = '最佳同事奖');	3415487094
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in BETWEEN '08:00' AND '09:00' AND p.rating = 'B';	1027352926
SELECT employee_id FROM (SELECT employee_id, evaluation_date, rating, ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY evaluation_date DESC) AS rn FROM performance_evaluations) WHERE rn = 1 AND evaluation_date < '2024-01-01' AND rating = 'B';	3444450310
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND a.check_in > '09:00' AND p.rating = 'B+';	73955891
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-24' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 43200;	2221450098
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-29' AND a.check_in < '09:00';	2070780775
SELECT name FROM employees WHERE employee_id IN (SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00' AND p.rating = 'A');	1554709262
AMBIGUOUS_QUERY	706296760
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '厦门大学' AND a.date = '2024-09-23' AND a.check_in > '09:00:00';	392591213
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND a.check_in > '09:00' AND p.rating = 'D';	3172283899
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-11' AND a.check_in > '08:30';	988606028
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '09:00' AND p.rating = 'D';	2714488838
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE YEAR(e.hire_date) = 2024 AND YEAR(a.year) = 2024 AND a.award_name = '新人奖' AND p.rating = 'A';	4248175692
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-26' AND a.check_in BETWEEN '08:00:00' AND '09:00:00' AND p.rating = 'B+';	302928867
SELECT employee_id FROM attendance_records WHERE date = '2024-09-25' AND employee_id IN (SELECT employee_id FROM awards WHERE year = 2023 AND award_name = '创新奖');	886106357
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00' AND p.rating = 'D';	4026541630
SELECT AVG(e.remaining_annual_leave) FROM departments d JOIN employees e ON d.department_id = e.department_id WHERE d.manager_id = 'H03372';	1802079912
SELECT employee_id FROM employees WHERE employee_id IN (SELECT employee_id FROM attendance_records WHERE date = '2024-10-12') AND employee_id IN (SELECT employee_id FROM performance_evaluations WHERE rating = 'A+');	865528666
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND ar.date = '2024-10-03' AND ar.check_in > '09:00';	4061141103
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '财务部' AND p.rating = 'A+' AND p.evaluation_date <= '2024-09-15';	2313524982
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-21' AND a.check_in > '09:00' AND d.name = '质量控制部';	1992247421
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-25' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 28800 AND d.name = '销售部';	165828985
SELECT p.employee_id, p.rating FROM performance_evaluations p JOIN awards a ON p.employee_id = a.employee_id WHERE a.year = 2022 AND a.award_name = '技术突破奖' AND p.evaluation_date > '2022-07-13';	2853735999
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.department_id = '财务部' AND a.date = '2024-10-11' AND a.check_in > '09:00';	2393343950
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-12' AND a.check_in > '09:00';	541232515
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2023-08-06' AND p.rating = 'C';	2805706885
SELECT d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-01' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 43200;	642307462
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-09' AND a.check_in > '09:00' AND p.rating = 'A+';	1883744787
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-09-24' AND a.check_in > '09:00';	2974332534
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-02' AND a.check_in > '09:00';	3471772100
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-11' AND a.check_out > '21:00' AND p.rating = 'B+';	2086845631
SELECT e.name, d.name, e.hire_date FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.rating = 'B' AND p.evaluation_date BETWEEN '2022-01-01' AND '2022-12-31' ORDER BY e.hire_date;	4264799007
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-22' AND d.name = '客户服务部';	3620357144
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00' AND pe.rating = 'B';	1491216239
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-02' ORDER BY a.check_in ASC LIMIT 1;	3076427726
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE YEAR(e.hire_date) = 2023 AND a.date = '2024-10-10' AND p.rating = 'B+';	3105805885
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-04' AND a.check_in > '09:00';	619146222
SELECT employee_id FROM employees WHERE employee_id IN (SELECT employee_id FROM attendance_records WHERE date = '2024-09-17') AND employee_id IN (SELECT employee_id FROM performance_evaluations WHERE rating = 'A+');	701268008
SELECT department_id FROM employees WHERE employee_id IN (SELECT employee_id FROM probation_employees WHERE status = '延长' GROUP BY employee_id ORDER BY COUNT(*) DESC LIMIT 3);	1106812044
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-04' AND a.check_in > '09:00' AND d.name = '财务部';	150140045
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2023 AND a.award_name = '优秀员工';	3067705249
SELECT COUNT(DISTINCT a.employee_id) FROM awards a JOIN probation_employees p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '客户满意度奖' AND p.start_date <= '2023-12-31' AND p.end_date >= '2023-01-01';	370099566
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00:00' AND p.rating = 'C';	3404150466
SELECT employees.name, awards.award_name FROM employees INNER JOIN awards ON employees.employee_id = awards.employee_id;	2389000379
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-13' AND a.check_in < '08:30';	3131729527
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-17' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 32400;	525985276
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e INNER JOIN departments d ON e.department_id = d.department_id INNER JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-26' AND e.remaining_annual_leave > 10;	331075127
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-09' AND a.check_in > '09:00:00';	1437451129
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-10' AND a.check_in > '09:00' AND d.name = '客户服务部';	4184935107
SELECT NULL;	2884744128
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-25' AND a.check_in > '09:00';	23024706
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '客户服务部' AND p.rating = 'A+' AND p.evaluation_date = '2024-09-28';	1389756999
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-07' AND a.check_in > '09:00';	2946411490
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-14';	4118104089
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '优秀员工' AND ar.date > '2021-01-01';	2690408936
SELECT AVG(e.remaining_annual_leave) FROM awards a JOIN employees e ON a.employee_id = e.employee_id WHERE a.year = 2024 AND a.award_name = '领导力奖' AND e.hire_date > '2017-01-01';	312466402
SELECT e.name FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE pe.rating = '优秀' AND e.university IS NOT NULL AND e.major IS NOT NULL AND e.position IS NOT NULL;	2444022671
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-12-07' AND pe.rating = 'B';	4277707010
SELECT e.name, d.name, a.award_name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE YEAR(e.hire_date) = 2023 AND a.year = 2023;	4268522360
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-25' AND a.check_in > '09:00' AND d.name = '销售部';	4254579364
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-20' AND a.check_in > '09:00';	2369381920
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-29' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 36000;	4086198634
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-04' AND a.check_in > '08:30' AND p.rating = 'A+';	2201325936
SELECT employee_id, COUNT(*) AS late_days FROM attendance_records WHERE check_in > '09:00' GROUP BY employee_id;	3450923921
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-15' AND p.rating = 'A+';	3735318054
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '最佳团队奖' AND ar.date = '2024-09-19';	1103295358
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-21';	1771528644
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-09-23' AND a.check_in < '09:30';	1983289607
SELECT attendance_records.* FROM attendance_records JOIN employees ON attendance_records.employee_id = employees.employee_id WHERE attendance_records.date = '2024-10-09' AND attendance_records.check_in > '09:00' AND employees.employee_type = '实习生';	3578772260
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '项目管理奖' AND ar.date = '2024-09-23';	417939953
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE YEAR(e.hire_date) = 2022 AND a.year = 2023 AND p.rating = 'A+';	1624107441
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-13' AND d.name = '人力资源部';	1951693602
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-09-18' AND a.check_in > '09:00';	82225620
SELECT NULL;	3464614512
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-20' AND a.check_in > '08:00:00' AND d.name = '销售部';	3644746054
SELECT department_id, name FROM employees WHERE (department_id, birth_date) IN (SELECT department_id, MIN(birth_date) FROM employees GROUP BY department_id);	2589067480
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-09-30' AND a.check_in > '09:00';	525741152
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-09-18' AND a.check_in > '09:00';	1233829446
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:30' AND p.rating = 'A+';	1073149875
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND a.check_in > '09:00' AND p.rating = 'B';	2974599681
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-22' AND p.rating = 'D';	4292447380
SELECT employee_id FROM employees WHERE employee_id IN (SELECT employee_id FROM attendance_records WHERE date = '2024-10-03') AND employee_id IN (SELECT employee_id FROM performance_evaluations WHERE rating = 'A+');	1372088201
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-07' AND a.check_in > '09:00' AND d.name = '客户服务部';	1829638261
SELECT a.employee_id, a.date, a.check_in, a.check_out, p.rating FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id;	4051639960
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN awards b ON a.employee_id = b.employee_id WHERE a.date = '2024-10-05' AND a.check_in > '09:00' AND b.year = 2021;	3807676634
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-25' AND a.check_in > '08:30:00';	22049871
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year >= YEAR(CURDATE()) - 3 GROUP BY a.year, QUARTER(a.date) HAVING COUNT(a.award_name) = (SELECT MAX(award_count) FROM (SELECT COUNT(award_name) AS award_count FROM awards WHERE year >= YEAR(CURDATE()) - 3 GROUP BY year, QUARTER(date)) AS subquery) AND TIMESTAMPDIFF(MINUTE, ar.check_in, ar.check_out) = (SELECT MIN(TIMESTAMPDIFF(MINUTE, check_in, check_out)) FROM attendance_records WHERE employee_id = a.employee_id);	2830500866
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND p.rating = 'A+';	753042700
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '质量改进奖' AND ar.date = '2024-10-04' AND ar.check_in > '09:00:00';	3115674665
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-03' AND a.check_in > '09:00';	3347041396
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-02' AND a.check_in > '09:00';	2106049978
SELECT a.employee_id FROM awards a INNER JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工' AND p.rating = 'A+';	2418301693
SELECT d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-05-31' AND p.rating = 'A+';	3616397443
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-02' AND a.check_in > '09:00' AND p.rating = 'A+';	4109172134
SELECT * FROM attendance_records WHERE date = '2024-09-18' AND employee_id IN (SELECT employee_id FROM awards WHERE year = 2021 AND award_name = '销售冠军');	2161202831
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-05-27' AND pe.rating = 'A+';	883813840
SELECT d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-16' AND a.check_in > '09:00';	537717055
SELECT e.name, d.name FROM employees e JOIN departments d ON e.department_id = d.department_id;	2763876996
SELECT name FROM employees ORDER BY hire_date ASC, position ASC LIMIT 1;	2600861795
SELECT e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE e.department_id = 'D00007' AND YEAR(p.evaluation_date) = 2024 AND p.rating = 'A';	2781387557
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '创新奖' AND ar.date = '2024-10-12' AND ar.check_in > '09:00';	2256872853
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-23' AND a.check_in > '09:00';	3830013539
SELECT COUNT(DISTINCT a.employee_id) FROM awards a INNER JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND p.rating = 'A+';	2490180425
SELECT DISTINCT d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-23' AND a.check_in > '08:00' AND a.check_out < '18:00';	2983573490
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工奖' AND a.date = '2023-10-09';	2710720384
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND a.check_in < '09:00' AND p.rating = 'B+';	737077017
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in > '09:00' AND p.rating = 'A+';	1491113326
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2021 AND a.award_name = '质量改进奖' AND p.rating = 'B+';	498106360
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-29' AND a.check_in > '08:30:00' AND d.name = '客户服务部';	640452635
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-16' AND a.check_in > '08:30:00';	208690009
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-10-01' AND a.check_in > '09:00' AND e.position = '顾问';	392941851
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.department_id = '客户服务部' AND a.date = '2024-09-23' AND a.check_in > '09:00';	2938732459
SELECT year, employee_id FROM awards WHERE award_name = '技术创新奖' AND year >= YEAR(CURDATE()) - 5;	1117540294
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-06' AND a.check_in > '09:00';	1014591026
SELECT e.employee_id, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-04' AND a.check_in > '09:00';	1623914717
SELECT employees.name, departments.name FROM attendance_records JOIN employees ON attendance_records.employee_id = employees.employee_id JOIN departments ON employees.department_id = departments.department_id WHERE attendance_records.date = '2024-10-04';	2050714128
SELECT a.employee_id, a.award_name, p.rating, p.evaluation_date FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND YEAR(p.evaluation_date) = 2023;	3216421294
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-10' AND a.check_in > '09:30';	1913384420
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-19';	914649823
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-03' AND a.check_in > '09:00';	4047308852
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id GROUP BY d.name ORDER BY AVG(e.remaining_annual_leave) DESC LIMIT 1;	389946505
SELECT e.name FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-27' AND ar.check_in < '10:00' AND pe.rating = 'A+';	2789183181
SELECT interview_date, interview_count FROM interviews WHERE YEAR(interview_date) = 2024;	2066321300
SELECT d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-20' AND a.check_in > '09:00:00';	517679865
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '研发部' AND p.rating = 'B+' AND p.evaluation_date = '2024-09-29';	168044233
SELECT check_in, check_out FROM attendance_records WHERE date = '2024-10-10' AND employee_id IN (SELECT employee_id FROM awards WHERE year = 2022 AND award_name = '销售冠军');	3832137822
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '客户满意度奖' AND e.hire_date > '2020-06-19';	2937344989
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00' AND p.rating = 'A+';	666608778
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2022-06-20' AND p.rating = 'C';	895348774
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND a.award_name = '客户满意度奖' AND p.rating = 'C';	140831793
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '项目管理奖' GROUP BY a.employee_id HAVING AVG((strftime('%s', ar.check_out) - strftime('%s', ar.check_in)) / 3600.0) > 10;	3458227345
SELECT d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-03-09' AND p.rating = 'D';	1848769486
AMBIGUOUS_QUERY	2500228389
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-08';	2138121838
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-26' AND a.check_in > '09:00' AND d.name = '人力资源部';	2171081157
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:00' AND p.rating = 'A+';	1610499668
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-09-20' AND a.check_in > '09:00:00';	2819549023
SELECT DISTINCT d.name FROM attendance_records ar JOIN performance_evaluations pe ON ar.employee_id = pe.employee_id JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-13' AND ar.check_in > '09:00' AND pe.rating = 'A+';	898575802
SELECT DISTINCT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND p.rating IN ('A', 'B');	3845606236
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-09-17' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 32400;	3651268255
SELECT d.manager_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-18' AND a.check_in > '09:00';	2107787587
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '技术突破奖' AND ar.date = '2024-09-23' AND ar.check_in > '09:00';	3117376201
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '运营部' AND a.date = '2024-09-26';	480860919
SELECT DISTINCT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2020 AND a.award_name = '优秀员工' AND YEAR(p.evaluation_date) = 2023 AND p.rating = 'C';	460298626
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-03' AND a.check_in > '09:00' AND p.rating = 'C';	2730014142
SELECT e.employee_id FROM employees e INNER JOIN departments d ON e.department_id = d.department_id INNER JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-12' AND a.check_in > '09:00';	3912663730
SELECT department_id FROM (SELECT d.department_id, YEAR(i.interview_date) AS year, COUNT(DISTINCT e.employee_id) * 1.0 / COUNT(DISTINCT i.employee_id) AS pass_rate FROM interviews i LEFT JOIN employees e ON i.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE YEAR(i.interview_date) >= YEAR(CURDATE()) - 5 GROUP BY d.department_id, YEAR(i.interview_date) ORDER BY pass_rate DESC) AS subquery GROUP BY year;	2709449383
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-12';	773661226
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND ar.date = '2024-10-01' AND ar.check_in > '09:00';	2010808566
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND ar.date = '2024-09-22' AND ar.check_in > '09:00:00';	201608997
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-10' AND a.check_in > '09:00';	305187601
SELECT d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-04-20' AND p.rating = 'D';	1158176204
SELECT COUNT(DISTINCT a.employee_id) * 1.0 / (SELECT COUNT(DISTINCT b.employee_id) FROM awards b WHERE b.year >= YEAR(CURDATE()) - 1) FROM awards a WHERE a.year >= YEAR(CURDATE()) - 1 AND a.employee_id IN (SELECT p.employee_id FROM performance_evaluations p WHERE p.evaluation_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR) GROUP BY p.employee_id HAVING COUNT(DISTINCT p.rating) > 1);	3838245936
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE YEAR(e.hire_date) = 2023 AND a.award_name = '优秀员工奖' AND a.year = 2023 AND p.rating = 'A+';	2323193672
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-21' AND a.check_in > '09:00';	662747906
SELECT employee_id, SUM(STRFTIME('%s', check_out) - STRFTIME('%s', check_in)) AS total_working_time FROM attendance_records GROUP BY employee_id;	1678101946
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-15' AND a.check_in > '09:00' AND d.name = '客户服务部';	523515982
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '创新奖' AND ar.date = '2024-10-05' AND ar.check_in > '09:00';	2715149255
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND p.rating = 'C';	3069073544
SELECT employee_id FROM awards WHERE year = 2024 AND award_name = '领导力奖' INTERSECT SELECT employee_id FROM performance_evaluations WHERE rating = 'C';	2258483174
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-09-19' AND a.check_in > '09:00' AND e.department_id = '质量控制部';	389046410
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '项目管理奖' AND ar.date = '2024-09-23';	2068076752
SELECT e.name, d.name, p.rating FROM employees e JOIN departments d ON e.department_id = d.department_id LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-20';	406606744
SELECT e.name, m.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE a.date = '2024-09-26' AND a.check_in > '09:30:00';	260151387
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-10-03' AND a.check_in > '09:00' AND e.university = '清华大学';	4070449827
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '研发部' AND a.date = '2024-10-01' AND (strftime('%s', a.check_out) - strftime('%s', a.check_in)) > 36000;	2852580257
SELECT rating FROM performance_evaluations WHERE employee_id IN (SELECT employee_id FROM awards WHERE year = 2023 AND award_name = '优秀员工') AND YEAR(evaluation_date) = 2023;	1727169008
SELECT d.cust_no, d.acct_bal, l.loan_balance, l.loan_type FROM deposit_account_info d JOIN loan_detail_info l ON d.cust_no = l.cust_id WHERE d.data_dt = '2024-07-19' AND d.acct_bal > 100000 AND l.loan_balance > 500000;	1877699859
SELECT cust_no FROM financial_products WHERE currency = '美元' AND wealth_bal > 5000000 AND data_dt = '2024-07-02';	2884293015
SELECT rs_type_name, rs_type FROM five_level_classification WHERE rs_type_id = '不良' AND data_dt = '2024-07-22';	958998120
SELECT c.customer_name, o.occupation_name, lr.description FROM customer c JOIN occupation o ON c.occupation_id = o.id JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id ORDER BY lr.repayment_amount DESC;	1597552663
SELECT c.customer_name, c.id_number, c.phone_number, c.email, c.address FROM customer c JOIN occupation o ON c.occupation_id = o.id WHERE o.occupation_name = '护士' ORDER BY c.customer_name;	2952757264
SELECT COUNT(DISTINCT d.cust_no) FROM deposit_account_info d JOIN loan_application l ON d.cust_no = l.customer_id WHERE d.province = '沈阳' AND d.data_dt = '2024-07-19' AND l.apply_date = '2024-07-19';	469159086
SELECT c.curr_code, c.curr_full_name, b.bank_name, b.bank_level FROM currency c JOIN bank_orgnization b ON c.curr_code = b.bank_id WHERE c.data_dt = '2023-06-30';	731693068
SELECT deposit_id, deposit_name FROM deposit_type WHERE data_dt = '2024-07-22';	1236011704
SELECT cust_nm, residential_address FROM debit_card_information WHERE open_date = '2024-07-15' AND current_bal > 2000;	280502890
SELECT customer_id, credit_score FROM loan_credit WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	236766680
SELECT c.customer_name, c.gender, SUM(lr.repayment_amount) FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id GROUP BY c.gender, c.customer_name;	1413730783
SELECT c.*, la.loan_amount FROM loan_application la JOIN customer c ON la.customer_id = c.id ORDER BY la.loan_amount DESC LIMIT 1;	2991390114
SELECT COUNT(DISTINCT fp.cust_no) FROM financial_products fp JOIN debit_card_information d ON fp.cust_no = d.cust_no WHERE fp.wealth_bal > 1000000 AND d.card_state = '正常';	2514430924
SELECT cust_no, cust_name FROM deposit_account_info WHERE bank_date = '2024-07-19' AND org_nm = '沈阳余淮支行' AND acct_type_code = '活期存款' AND act_mon_avg_bal > 50000;	4288779306
SELECT c.customer_name, l.loan_amount FROM loan_application l JOIN customer c ON l.customer_id = c.id WHERE l.loan_amount > 30000 AND l.status = 'PENDING';	3310831117
SELECT deposit_type_name, COUNT(DISTINCT cust_no) AS customer_count FROM deposit_account_info JOIN deposit_type ON deposit_account_info.acct_type_code = deposit_type.deposit_type_id WHERE cust_no IN (SELECT customer_id FROM loan_application ORDER BY loan_amount DESC LIMIT 20) GROUP BY deposit_type_name;	2450245528
SELECT curr_code, curr_full_name FROM currency WHERE curr_class = '外币' ORDER BY curr_code ASC;	821687353
SELECT customer_id, loan_amount FROM loan_application ORDER BY loan_amount DESC;	3139230407
SELECT cast_type, wealth_sta_m_avg_bal_a FROM financial_products WHERE data_dt = '2024-07' GROUP BY cast_type;	3089791258
SELECT * FROM loan_detail_info WHERE loandate_s > '2024-04-01';	52505136
SELECT c.id FROM customer c JOIN loan_application la ON c.id = la.customer_id WHERE la.loan_amount > (SELECT AVG(loan_amount) * 1.5 FROM loan_application la2 JOIN customer c2 ON la2.customer_id = c2.id WHERE CASE WHEN DATE_PART('year', AGE(c2.birth_date)) BETWEEN 0 AND 20 THEN '0-20' WHEN DATE_PART('year', AGE(c2.birth_date)) BETWEEN 21 AND 40 THEN '21-40' WHEN DATE_PART('year', AGE(c2.birth_date)) BETWEEN 41 AND 60 THEN '41-60' ELSE '61+' END = CASE WHEN DATE_PART('year', AGE(c.birth_date)) BETWEEN 0 AND 20 THEN '0-20' WHEN DATE_PART('year', AGE(c.birth_date)) BETWEEN 21 AND 40 THEN '21-40' WHEN DATE_PART('year', AGE(c.birth_date)) BETWEEN 41 AND 60 THEN '41-60' ELSE '61+' END);	3773590841
SELECT birth_date, gender FROM customer;	2822188040
SELECT cust_id FROM loan_detail_info WHERE loan_balance > 500000 AND loan_orgno = '沈阳分行' AND dw_date = '2024-07-19';	1440558878
SELECT ldi.*, c.curr_full_name, flc.rs_type_name FROM loan_detail_info ldi JOIN currency c ON ldi.currency_type = c.curr_code JOIN five_level_classification flc ON ldi.judgelevel = flc.rs_type_id WHERE ldi.loan_balance > 1000000;	1736005638
SELECT loan_detail_info.cust_id, currency.curr_full_name FROM loan_detail_info JOIN currency ON loan_detail_info.currency_type = currency.curr_code WHERE loan_detail_info.loan_balance > 1000000 ORDER BY loan_detail_info.loan_balance DESC;	2851656495
SELECT customer_id FROM user_behavior WHERE behavior_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY customer_id ORDER BY COUNT(DISTINCT behavior_type) DESC LIMIT 5;	875490154
SELECT SUM(stm_overdu), COUNT(*) FROM credit_card_data WHERE corporation = 'Corp3' AND dw_date = '2024-07-03';	4277933960
SELECT * FROM loan_detail_info WHERE cust_id = '1004';	3853460934
SELECT customer.customer_name, transfer.transfer_amount, transfer.transfer_date FROM customer LEFT JOIN transfer ON customer.id = transfer.source_customer_id;	3090102533
SELECT ub.customer_id, ub.behavior_type, ub.behavior_date, lr.repayment_amount, lr.repayment_date FROM user_behavior ub LEFT JOIN loan_repayment lr ON ub.customer_id = lr.loan_application_id;	1353951750
SELECT dai.cust_name, dai.acct_bal, dt.deposit_type_name FROM deposit_account_info dai JOIN deposit_type dt ON dai.acct_type_code = dt.deposit_type_id WHERE dai.data_dt = '2024-07-21' AND dai.acct_bal > 50000;	2088616407
SELECT la.customer_id, (la.total_loan / p.province_total_loan) * 100 AS loan_percentage FROM (SELECT customer_id, SUM(loan_amount) AS total_loan FROM loan_application GROUP BY customer_id) la JOIN customer c ON la.customer_id = c.id JOIN (SELECT c.province, SUM(la.loan_amount) AS province_total_loan FROM loan_application la JOIN customer c ON la.customer_id = c.id GROUP BY c.province) p ON c.province = p.province;	130934854
SELECT province, occupation_name FROM (SELECT c.province, o.occupation_name, COUNT(CASE WHEN la.status = '通过' THEN 1 END) * 1.0 / COUNT(*) AS pass_rate FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN occupation o ON c.occupation_id = o.id GROUP BY c.province, o.occupation_name) AS subquery GROUP BY province ORDER BY pass_rate DESC;	3921482862
SELECT org_no, SUM(top10_acct_bal) / SUM(total_acct_bal) AS ratio FROM (SELECT org_no, acct_bal AS top10_acct_bal, SUM(acct_bal) OVER (PARTITION BY org_no) AS total_acct_bal, ROW_NUMBER() OVER (PARTITION BY org_no ORDER BY acct_bal DESC) AS rn FROM deposit_account_info) t WHERE rn <= 10 GROUP BY org_no;	2823798793
SELECT cust_nm, tel_no FROM debit_card_information WHERE cust_nm LIKE '%Lee%';	1257769422
SELECT c.customer_name, ub.behavior_type, lr.repayment_amount FROM customer c LEFT JOIN user_behavior ub ON c.id = ub.customer_id LEFT JOIN loan_repayment lr ON c.id = lr.loan_application_id;	3060090955
SELECT DISTINCT lc.customer_id FROM loan_credit lc JOIN loan_repayment lr ON lc.customer_id = lr.loan_application_id WHERE lc.credit_score > 0.75 AND lr.repayment_date = '2021-11-10';	1862922606
SELECT * FROM loan_repayment WHERE repayment_amount > 900;	2509103407
SELECT cust_no, cust_nm, card_no, residential_address FROM debit_card_information WHERE data_dt = '2024-07-09' AND card_state = '正常' AND residential_address = '987 Willow Street';	695694478
SELECT cust_id, loan_amount, loan_balance FROM loan_detail_info;	834672780
SELECT lt.loan_type_name, COUNT(DISTINCT dci.cust_no) AS debit_card_user_count FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN debit_card_information dci ON la.customer_id = dci.cust_no GROUP BY lt.loan_type_name;	4144067238
SELECT loan_type_id, COUNT(DISTINCT customer_id) FROM loan_application GROUP BY loan_type_id;	2026869176
SELECT credit_score, description FROM loan_credit WHERE credit_date = '2011-04-13';	276439287
SELECT SUM(wealth_bal) AS 理财余额总和, SUM(wealth_bal_f) AS 保本理财余额总和 FROM financial_products WHERE data_dt = '2024-07-14' AND bank_nm = '沈阳余淮支行';	3759367452
SELECT customer_id, credit_score FROM loan_credit WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	854057318
SELECT source_customer_id, target_customer_id FROM transfer;	4026685166
SELECT loan_type_name FROM loan_type WHERE loan_type_code = 'MORTGAGE';	3768964878
SELECT cust_nm, card_no FROM debit_card_information WHERE data_dt = '2024-07-05' AND card_state = '正常';	2031979235
SELECT bank_nm, occupation_id, COUNT(*) FROM financial_products JOIN customer ON financial_products.cust_no = customer.id GROUP BY bank_nm, occupation_id;	1154484795
SELECT deposit_name, deposit_type_id FROM deposit_type ORDER BY deposit_name;	1534988899
SELECT status, loan_amount FROM loan_application;	3094943511
SELECT c.* FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id WHERE lc.credit_score = 0.77;	3794501166
SELECT lt.loan_type_name, lt.description, lr.repayment_amount, lr.repayment_date FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN loan_repayment lr ON la.id = lr.loan_application_id;	1460602722
SELECT rs_type_id, rs_type_name FROM five_level_classification;	3806586802
SELECT card_no, closing_date FROM debit_card_information WHERE closing_date > '2024-07-05';	4276410819
SELECT card_type, card_state FROM debit_card_information WHERE card_type IS NOT NULL;	3975346738
SELECT cust_id, SUM(loan_balance) FROM loan_detail_info WHERE dw_date = '2024-07-19' AND loan_balance > 100000 GROUP BY cust_id;	828477757
SELECT CORR(d.acct_bal, l.loan_balance) FROM deposit_account_info d JOIN loan_detail_info l ON d.org_no = l.loan_orgno;	2234207790
SELECT DATE_FORMAT(transfer_date, '%Y-%m') AS month, SUM(transfer_amount) AS total_transfer FROM transfer GROUP BY month UNION ALL SELECT DATE_FORMAT(apply_date, '%Y-%m') AS month, SUM(loan_amount) AS total_loan FROM loan_application GROUP BY month;	1812141267
SELECT customer_name, phone_number FROM customer WHERE province = '上海市';	1984914783
SELECT credit_score, credit_date FROM loan_credit WHERE customer_id = 533302;	1612151566
SELECT * FROM transfer ORDER BY transfer_amount DESC;	1955324709
SELECT customer_id, behavior_type, COUNT(*) FROM user_behavior GROUP BY customer_id, behavior_type;	3342688355
SELECT COUNT(DISTINCT c.id) FROM customer c JOIN deposit_account_info d ON c.id = d.cust_no JOIN credit_card_data cc ON c.id = cc.custr_nbr JOIN bank_orgnization b ON cc.bank = b.bank_id WHERE b.bank_name = '沈阳分行' AND d.acct_bal > 100000 AND cc.stm_overdu > 5000 AND d.data_dt = '2024-07-22' AND cc.dw_date = '2024-07-22';	3958858753
SELECT card_no, cust_nm FROM debit_card_information WHERE org_nm = '北京分行';	4286151760
SELECT COUNT(DISTINCT customer_id) FROM (SELECT customer_id, apply_date, LAG(apply_date) OVER (PARTITION BY customer_id ORDER BY apply_date) AS prev_date, EXTRACT(YEAR FROM apply_date) * 12 + EXTRACT(MONTH FROM apply_date) - EXTRACT(YEAR FROM LAG(apply_date) OVER (PARTITION BY customer_id ORDER BY apply_date)) * 12 - EXTRACT(MONTH FROM LAG(apply_date) OVER (PARTITION BY customer_id ORDER BY apply_date)) AS month_diff FROM loan_application) t WHERE month_diff = 1 GROUP BY customer_id HAVING COUNT(*) >= 2;	3229999001
SELECT cust_no, bank_nm FROM financial_products ORDER BY cust_no;	4182504410
SELECT occupation_code, occupation_name FROM occupation ORDER BY occupation_name;	917603455
SELECT COUNT(*) FROM (SELECT fp.cust_no FROM financial_products fp JOIN debit_card_information dci ON fp.cust_no = dci.cust_no WHERE fp.wealth_bal > dci.current_bal * 10 GROUP BY fp.cust_no) AS subquery;	3406337356
SELECT loan_orgno, loan_balance FROM loan_detail_info WHERE loan_amount > 70000;	1335793922
SELECT lt.loan_type_name, ub.behavior_type FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN user_behavior ub ON la.customer_id = ub.customer_id;	1151279551
SELECT bank_level, COUNT(*) FROM bank_orgnization GROUP BY bank_level;	954153971
SELECT current_bal, fixed_bal FROM debit_card_information WHERE data_dt = '2024-07-15' AND org_nm = '北京东单支行' AND cust_nm = 'Olivia Lee';	45765016
SELECT c.customer_name, lc.description FROM loan_credit lc JOIN customer c ON lc.customer_id = c.id WHERE lc.credit_date = '2017-10-31' AND lc.credit_score > 0.85 ORDER BY lc.credit_score DESC;	3502920391
SELECT loan_amount FROM loan_application JOIN loan_type ON loan_application.loan_type_id = loan_type.id WHERE loan_type.loan_type_name = '汽车贷款';	1646074274
SELECT loan_type_id, AVG(repayment_amount), COUNT(*) FROM loan_repayment JOIN loan_application ON loan_repayment.loan_application_id = loan_application.id GROUP BY loan_type_id;	672526664
SELECT acc_name1, bank, category, day_opened FROM credit_card_data WHERE corporation = 'Corp3' ORDER BY day_opened DESC;	2466786763
SELECT customer_name, address FROM customer;	4227028668
SELECT l.loan_orgno AS bank_no, SUM(l.loan_amount) / SUM(d.current_bal) AS ratio FROM loan_detail_info l JOIN debit_card_information d ON l.loan_orgno = d.bank_no WHERE YEAR(l.loandate_s) = 2023 AND YEAR(d.open_date) = 2023 GROUP BY l.loan_orgno;	2693621587
SELECT * FROM loan_repayment ORDER BY ABS(repayment_amount - (SELECT AVG(repayment_amount) FROM loan_repayment)) LIMIT 1;	4145982837
SELECT DISTINCT lc.customer_id FROM loan_credit lc JOIN financial_products fp ON lc.customer_id = fp.cust_no WHERE lc.credit_score > 0.8 AND lc.credit_date BETWEEN '2024-07-01' AND '2024-07-31' AND fp.data_dt BETWEEN '2024-07-01' AND '2024-07-31';	1544259726
SELECT TO_CHAR(apply_date, 'YYYY-MM') AS month, COUNT(CASE WHEN status = 'APPROVED' THEN 1 END)::FLOAT / COUNT(*) AS approval_rate FROM loan_application GROUP BY TO_CHAR(apply_date, 'YYYY-MM');	1355078743
SELECT b.bank_name, COUNT(DISTINCT c.id) AS new_customers, AVG(l.loan_amount) AS avg_loan_amount FROM customer c JOIN loan_application l ON c.id = l.customer_id JOIN bank_orgnization b ON l.bank_id = b.bank_id WHERE c.birth_date BETWEEN '2024-01-01' AND '2024-03-31' GROUP BY b.bank_name;	1126971637
SELECT bank_parent, AVG(loan_term) AS avg_loan_term, AVG(loan_amount) AS avg_loan_amount FROM loan_application JOIN bank_orgnization ON loan_application.customer_id = bank_orgnization.bank_id GROUP BY bank_parent;	3096647573
SELECT credit_score, credit_date FROM loan_credit;	1447870202
SELECT cust_id, loan_balance FROM loan_detail_info WHERE loandate_e < '2026-01-01';	3139357622
SELECT id, apply_date FROM loan_application;	2354889533
SELECT customer_id, loan_amount FROM loan_application la JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_code = '住房贷款' AND la.status = 'APPROVED' ORDER BY loan_amount DESC;	526851116
SELECT b.bank_name, d.org_nm FROM deposit_account_info d JOIN bank_orgnization b ON d.org_no = b.bank_id GROUP BY d.org_nm, b.bank_name ORDER BY SUM(d.acct_bal) DESC LIMIT 5;	1791411839
SELECT * FROM loan_repayment WHERE description = '严琳';	2162165264
SELECT rs_type_name, COUNT(*) FROM five_level_classification GROUP BY rs_type_name;	76588831
SELECT rs_type_name, COUNT(*) FROM five_level_classification GROUP BY rs_type_name;	3941609286
SELECT b.bank_name, f.cust_no, f.wealth_bal FROM bank_orgnization b JOIN financial_products f ON b.bank_id = f.bank_no;	2101507672
SELECT loan_type_name, description FROM loan_type ORDER BY loan_type_code;	1923349382
SELECT bank_name, bank_parent FROM bank_orgnization WHERE bank_level = '2';	1121179521
SELECT province, customer_name, loan_amount FROM (SELECT c.province, c.customer_name, l.loan_amount, ROW_NUMBER() OVER (PARTITION BY c.province ORDER BY l.loan_amount DESC) AS rn FROM customer c JOIN loan_application l ON c.id = l.customer_id) t WHERE rn <= 3;	2484251331
SELECT * FROM transfer WHERE source_customer_id = 376252;	2203191109
SELECT c.customer_name, c.gender, o.occupation_name FROM customer c JOIN occupation o ON c.occupation_id = o.id;	2236467382
SELECT COUNT(DISTINCT cust_no) AS customer_count, SUM(wealth_bal_f) AS total_wealth_balance FROM financial_products WHERE bank_no = (SELECT bank_id FROM bank_orgnization WHERE bank_name = '沈阳余淮支行') AND data_dt LIKE '2024-07%';	2201430567
SELECT customer_id FROM loan_credit WHERE credit_score > 0.8;	1372106457
SELECT c1.customer_name AS source_customer_name, c2.customer_name AS target_customer_name, t.transfer_amount FROM transfer t JOIN customer c1 ON t.source_customer_id = c1.id JOIN customer c2 ON t.target_customer_id = c2.id WHERE t.transfer_amount > 5000;	3513022788
SELECT DISTINCT customer_id FROM loan_application la JOIN loan_status ls ON la.status = ls.loan_status_code WHERE ls.loan_status_name = 'APPROVED' AND YEAR(la.apply_date) = 2019;	2898422903
SELECT card_type, COUNT(DISTINCT d.cust_no) AS customer_count, AVG(f.wealth_bal) AS avg_wealth_balance FROM debit_card_information d JOIN financial_products f ON d.cust_no = f.cust_no GROUP BY card_type;	3077268751
SELECT c.customer_name, l.loan_amount FROM loan_application l JOIN customer c ON l.customer_id = c.id ORDER BY l.apply_date ASC;	1301921764
SELECT SUM(acct_bal), SUM(act_year_avg_bal) FROM deposit_account_info WHERE cust_type = '对私客户' AND data_dt = '2024-07-19';	3969277636
SELECT c.customer_name, o.occupation_name FROM loan_repayment lr JOIN customer c ON lr.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id WHERE lr.repayment_amount < 500;	3878396052
SELECT cust_name, acct_bal FROM deposit_account_info WHERE data_dt = '2023-07-19';	2773495410
SELECT * FROM loan_application WHERE customer_id = (SELECT cust_no FROM deposit_account_info ORDER BY acct_bal DESC LIMIT 1) ORDER BY apply_date DESC LIMIT 1;	309023757
SELECT occupation_id, COUNT(*) FROM customer GROUP BY occupation_id;	978163931
SELECT customer.customer_name, transfer.transfer_amount FROM transfer JOIN customer ON transfer.source_customer_id = customer.id WHERE transfer.transfer_date = '2016-06-11' AND transfer.transfer_amount > 5000 ORDER BY transfer.transfer_amount DESC;	641452553
SELECT l.cust_id, l.loan_balance, l.loan_type, c.curr_full_name FROM loan_detail_info l JOIN currency c ON l.currency_type = c.curr_code WHERE l.loandate_s > '2024-07-01' AND l.loan_balance > 1000000 ORDER BY l.loan_balance DESC;	1351088256
SELECT * FROM user_behavior WHERE behavior_date = '2018-06-26';	583833982
SELECT * FROM loan_repayment WHERE DAYOFWEEK(repayment_date) IN (6, 7);	2116101795
SELECT deposit_type.deposit_type_name, loan_type.loan_type_name, COUNT(DISTINCT customer.id) FROM deposit_type JOIN deposit_account_info ON deposit_type.deposit_type_id = deposit_account_info.acct_type_code JOIN customer ON deposit_account_info.cust_no = customer.id_number JOIN loan_application ON customer.id = loan_application.customer_id JOIN loan_type ON loan_application.loan_type_id = loan_type.id GROUP BY deposit_type.deposit_type_name, loan_type.loan_type_name ORDER BY COUNT(DISTINCT customer.id) DESC;	985889089
SELECT customer_name, repayment_amount FROM loan_repayment JOIN customer ON loan_repayment.customer_id = customer.id WHERE repayment_date = '2021-11-10' AND repayment_amount > 20 ORDER BY repayment_amount DESC;	2925851112
SELECT loan_type_name, AVG(credit_score) FROM loan_credit lc JOIN loan_application la ON lc.customer_id = la.customer_id JOIN loan_type lt ON la.loan_type_id = lt.id GROUP BY loan_type_name;	714042771
SELECT loan_type_name, loan_type_code FROM loan_type WHERE loan_type_code IS NOT NULL;	3725846926
SELECT status, COUNT(*) FROM loan_application GROUP BY status;	128551642
SELECT customer_id, description FROM loan_credit;	1070169294
SELECT cust_nm, cust_id, tel_no, card_no, current_bal FROM debit_card_information WHERE open_date = '2024-07-15' AND org_nm = '北京东单支行';	3530929289
SELECT cust_type, SUM(loan_amount) FROM loan_detail_info GROUP BY cust_type ORDER BY cust_type;	2475731730
SELECT cust_id FROM loan_detail_info ORDER BY loan_balance / loan_amount DESC LIMIT 10;	2108379659
SELECT customer_id, SUM(loan_amount) FROM loan_application WHERE YEAR(apply_date) = 2019 AND status = 'REJECTED' GROUP BY customer_id;	3717149823
SELECT * FROM bank_orgnization;	1463400602
SELECT loan_detail_info.*, currency.curr_full_name, five_level_classification.rs_type_name FROM loan_detail_info JOIN currency ON loan_detail_info.currency_type = currency.curr_code JOIN five_level_classification ON loan_detail_info.judgelevel = five_level_classification.rs_type_id WHERE loan_detail_info.blc_capital > 10000 AND loan_detail_info.dw_date = '2024-07-22';	3647903773
SELECT card_state, open_date FROM debit_card_information WHERE card_state = '正常';	190467620
SELECT c.customer_name, t.transfer_amount, t.transfer_date FROM transfer t JOIN customer c ON t.source_customer_id = c.id WHERE t.transfer_date = '2023-06-30' ORDER BY t.transfer_amount DESC;	1357323463
SELECT bank_level, bank_name FROM bank_orgnization WHERE data_dt = '2023-06-30';	1614074594
SELECT cust_no, SUM(wealth_bal) FROM financial_products WHERE data_dt = '2024-07-02' AND cast_type = '非保本' GROUP BY cust_no ORDER BY SUM(wealth_bal) DESC;	1411048057
SELECT SUM(loan_amount) FROM loan_application WHERE YEAR(apply_date) = 2019 AND status = 'REJECTED';	2743985170
SELECT org_nm, SUM(acct_bal) FROM deposit_account_info WHERE data_dt = '2024-07-21' AND cust_type = '对公客户' AND bank_no IN (SELECT bank_id FROM bank_orgnization WHERE bank_name = '杭州分行') GROUP BY org_nm;	1124781975
SELECT customer_id, SUM(repayment_amount) AS total_repayment, COUNT(behavior_type) AS behavior_count, AVG(repayment_amount) AS avg_repayment FROM loan_repayment JOIN user_behavior ON loan_repayment.customer_id = user_behavior.customer_id GROUP BY customer_id;	1877601035
SELECT bank_name, bank_level, data_dt FROM bank_orgnization;	3704765747
SELECT c.customer_name, d.acct_bal, o.occupation_name FROM deposit_account_info d LEFT JOIN loan_application l ON d.cust_no = l.customer_id JOIN customer c ON d.cust_no = c.id JOIN occupation o ON c.occupation_id = o.id WHERE l.customer_id IS NULL AND d.acct_bal >= (SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY acct_bal) FROM deposit_account_info);	1929928822
SELECT loan_orgno, SUM(CASE WHEN status = '批准' THEN 1 ELSE 0 END) / COUNT(*) AS success_rate FROM loan_application GROUP BY loan_orgno;	693366950
SELECT acct_bal FROM deposit_account_info WHERE data_dt LIKE '2023-07%';	2017141047
SELECT bank_nm FROM deposit_account_info WHERE data_dt = '2023-06-30' AND acct_bal > 100000 AND cur_type = '美元';	2208770845
SELECT dai.cust_name, dai.acct_type_code, dai.acct_bal, c.curr_full_name FROM deposit_account_info dai JOIN currency c ON dai.cur_type = c.curr_code WHERE dai.data_dt = '2024-07-19' AND dai.acct_bal > 100000;	2411764640
SELECT cust_nm, card_no FROM debit_card_information WHERE card_state = '正常' AND open_date > '2024-07-01' ORDER BY open_date DESC;	2948516213
SELECT deposit_name, deposit_type_id FROM deposit_type ORDER BY deposit_name;	2373067027
SELECT source_customer_id, transfer_amount FROM (SELECT source_customer_id, transfer_amount, COUNT(*) AS cnt FROM transfer GROUP BY source_customer_id, transfer_amount ORDER BY cnt DESC) AS t1 WHERE source_customer_id IN (SELECT source_customer_id FROM transfer GROUP BY source_customer_id ORDER BY COUNT(*) DESC LIMIT 10) GROUP BY source_customer_id, transfer_amount ORDER BY source_customer_id, cnt DESC;	758507051
SELECT COUNT(DISTINCT customer.id) AS customer_count, SUM(loan_detail_info.loan_balance) AS total_loan_balance FROM customer JOIN credit_card_data ON customer.id = credit_card_data.custr_nbr JOIN loan_detail_info ON customer.id = loan_detail_info.cust_id WHERE customer.province = '上海市' AND credit_card_data.acct_sts = '正常';	3655735172
SELECT ldi.*, flc.rs_type_name, lt.loan_type_name FROM loan_detail_info ldi JOIN five_level_classification flc ON ldi.judgelevel = flc.rs_type_id JOIN loan_type lt ON ldi.loan_type = lt.loan_type_code WHERE ldi.dw_date = '2024-07-22' AND ldi.loan_balance > 15000;	2721235050
SELECT COUNT(DISTINCT cust_id) FROM loan_detail_info WHERE cust_id IN (SELECT cust_id FROM loan_detail_info WHERE loan_type = '房贷') AND cust_id IN (SELECT cust_id FROM loan_detail_info WHERE loan_type = '车贷') AND cust_id IN (SELECT a.cust_id FROM loan_detail_info a JOIN loan_detail_info b ON a.cust_id = b.cust_id WHERE a.loan_type = '房贷' AND b.loan_type = '车贷' AND a.loan_amount > b.loan_amount);	4255369233
SELECT c.customer_name, SUM(d.current_bal) AS total_balance FROM debit_card_information d JOIN customer c ON d.cust_no = c.id_number WHERE d.org_nm = '杭州上城区支行' AND d.data_dt = '2024-07-19' GROUP BY c.customer_name ORDER BY total_balance DESC;	2277646392
SELECT vouch_type, AVG(loan_amount) AS avg_loan_amount, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY loan_amount) AS median_loan_amount, PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY loan_amount) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY loan_amount) AS iqr_loan_amount FROM loan_detail_info GROUP BY vouch_type;	3239376234
SELECT SUM(transfer_amount) FROM transfer WHERE transfer_date = '2020-11-03' AND (source_customer_id IN (SELECT customer_id FROM loan_credit WHERE credit_score > 0.8) OR target_customer_id IN (SELECT customer_id FROM loan_credit WHERE credit_score > 0.8));	3541568339
SELECT COUNT(*) FROM loan_application la JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id WHERE la.loan_amount > 50000 AND o.occupation_name = '护士';	1123257910
SELECT c.* FROM loan_application la JOIN customer c ON la.customer_id = c.id WHERE la.apply_date >= '2024-07-01' AND la.apply_date < '2024-08-01';	820431444
SELECT TO_CHAR(apply_date, 'YYYY-MM') AS month, COUNT(*) FILTER (WHERE status = '通过') * 1.0 / COUNT(*) AS pass_rate FROM loan_application GROUP BY TO_CHAR(apply_date, 'YYYY-MM');	2667178372
SELECT bank_nm, SUM(wealth_bal) FROM financial_products WHERE data_dt = '2024-07-02' AND cast_type = '对公' GROUP BY bank_nm;	130622905
SELECT c.id, c.customer_name, l.status FROM customer c JOIN loan_application l ON c.id = l.customer_id;	4174863363
SELECT loan_type_id, COUNT(DISTINCT customer_id) AS customer_count, SUM(loan_amount) AS total_loan_amount FROM loan_application GROUP BY loan_type_id;	3814340700
SELECT 
    CASE 
        WHEN DATE_PART('year', AGE(NOW(), c.birth_date)) BETWEEN 0 AND 20 THEN '0-20'
        WHEN DATE_PART('year', AGE(NOW(), c.birth_date)) BETWEEN 21 AND 40 THEN '21-40'
        WHEN DATE_PART('year', AGE(NOW(), c.birth_date)) BETWEEN 41 AND 60 THEN '41-60'
        ELSE '61+'
    END AS age_group,
    COUNT(CASE WHEN la.status = '通过' THEN 1 END) * 1.0 / COUNT(*) AS pass_rate
FROM 
    customer c
JOIN 
    loan_application la ON c.id = la.customer_id
GROUP BY 
    age_group;	3039598050
SELECT repayment_amount, repayment_date FROM loan_repayment WHERE loan_application_id = 323803;	684098334
SELECT lc.customer_id, lc.credit_score FROM loan_credit lc JOIN customer c ON lc.customer_id = c.id WHERE c.address = '杭州上城区' AND lc.credit_date = '2023-06-30' ORDER BY lc.credit_score DESC LIMIT 1;	2020704797
SELECT * FROM loan_repayment WHERE repayment_date < '2020-02-25';	3613008055
SELECT * FROM transfer WHERE source_customer_id = (SELECT id FROM customer WHERE customer_name = '关飞') OR target_customer_id = (SELECT id FROM customer WHERE customer_name = '关飞');	1250415044
SELECT c.customer_name, c.id_number, ls.loan_status_name FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN loan_status ls ON la.status = ls.loan_status_code;	1513848555
SELECT * FROM user_behavior WHERE behavior_type LIKE '%ILL%';	921285205
SELECT transfer_amount, description FROM transfer ORDER BY transfer_amount ASC;	1784808376
SELECT * FROM user_behavior WHERE description IS NOT NULL;	1450251644
SELECT current_bal FROM debit_card_information WHERE cust_nm = 'James Taylor' AND bank_nm = '杭州上城区支行' AND data_dt = '2024-07-09';	2152314580
SELECT loan_type_name FROM loan_type WHERE description LIKE '%Loan%';	4164431702
SELECT c.curr_num, cu.curr_full_name, COUNT(*) AS account_count FROM credit_card_data c JOIN currency cu ON c.curr_num = cu.curr_code GROUP BY c.curr_num, cu.curr_full_name;	1368623184
SELECT AVG(wealth_sta_m_avg_bal_a) FROM financial_products;	399556639
SELECT loan_type_name, description FROM loan_type WHERE id IN (SELECT loan_type_id FROM loan_application WHERE status = 'APPROVED');	4055303490
SELECT c.customer_name, EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM c.birth_date) AS age, l.loan_amount FROM loan_application l JOIN customer c ON l.customer_id = c.id WHERE EXTRACT(YEAR FROM l.apply_date) = 2023 ORDER BY age DESC LIMIT 5;	4242939153
SELECT COUNT(DISTINCT lc.customer_id) FROM loan_credit lc JOIN bank_orgnization bo ON lc.customer_id = bo.bank_id WHERE bo.bank_name = '杭州上城区支行' AND lc.credit_score > 0.75 AND lc.credit_date = '2023-06-30';	2373959946
SELECT rs_type, COUNT(*) FROM five_level_classification WHERE data_dt = '2024-07-22' GROUP BY rs_type;	3345826641
SELECT rs_type_name, COUNT(*) FROM five_level_classification JOIN user_behavior ON five_level_classification.rs_type_id = user_behavior.customer_id GROUP BY rs_type_name;	4002524997
SELECT * FROM transfer ORDER BY transfer_date;	3440883843
SELECT card_type, card_type_nm, card_state FROM debit_card_information WHERE cust_no = (SELECT cust_no FROM customer WHERE customer_name = 'James Taylor') AND bank_no = (SELECT bank_id FROM bank_orgnization WHERE bank_name = '杭州上城区支行');	2903014629
SELECT SUM(wealth_bal) FROM financial_products WHERE data_dt = '2024-07-02' AND currency = 'USD';	3876498515
SELECT ub.customer_id, COUNT(*) AS behavior_count, lc.credit_score FROM user_behavior ub LEFT JOIN (SELECT customer_id, credit_score FROM loan_credit WHERE (customer_id, credit_date) IN (SELECT customer_id, MAX(credit_date) FROM loan_credit GROUP BY customer_id)) lc ON ub.customer_id = lc.customer_id GROUP BY ub.customer_id, lc.credit_score ORDER BY ub.customer_id;	4258165101
SELECT c1.customer_name AS source_customer_name, c2.customer_name AS target_customer_name, t.transfer_amount FROM transfer t JOIN customer c1 ON t.source_customer_id = c1.id JOIN customer c2 ON t.target_customer_id = c2.id WHERE t.transfer_date = '2023-06-30' AND t.transfer_amount > 1000;	1167360749
SELECT * FROM customer WHERE customer_name = '饶丽';	1853157405
SELECT cust_nm FROM debit_card_information WHERE card_state = '正常' AND data_dt = '2024-07-14';	856149789
SELECT ldi.cust_id, flc.rs_type_name, c.curr_full_name FROM loan_detail_info ldi JOIN five_level_classification flc ON ldi.judgelevel = flc.rs_type_id JOIN currency c ON ldi.currency_type = c.curr_code WHERE ldi.loan_balance > 500000 AND ldi.dw_date = '2024-07-19' ORDER BY ldi.loan_balance DESC;	12643482
SELECT COUNT(*) FROM deposit_account_info WHERE data_dt = '2024-07-19' AND org_nm = '沈阳分行' AND acct_bal > 100000 AND gender_code = '男性';	3675937964
SELECT * FROM loan_type WHERE loan_type_name = '汽车贷款';	517341637
SELECT customer.customer_name, loan_application.loan_amount FROM customer INNER JOIN loan_application ON customer.id = loan_application.customer_id WHERE loan_application.loan_amount > 10000;	317385728
SELECT c.id FROM customer c JOIN deposit_account_info d ON c.id = d.cust_no JOIN loan_credit lc ON c.id = lc.customer_id JOIN loan_repayment lr ON c.id = lr.loan_application_id GROUP BY c.id ORDER BY (0.4 * AVG(d.acct_bal) + 0.3 * AVG(lc.credit_score) + 0.3 * AVG(lr.repayment_amount)) DESC LIMIT 20;	162793313
SELECT occupation_code, description FROM occupation WHERE occupation_name = '护士';	1226891061
SELECT ub.customer_id, ub.behavior_type, ub.behavior_date, ub.description, lc.credit_score FROM user_behavior ub LEFT JOIN loan_credit lc ON ub.customer_id = lc.customer_id WHERE DATE_TRUNC('month', ub.behavior_date) = '2021-08-01';	3649901835
SELECT loan_type_name AS description FROM loan_type UNION SELECT loan_status_name AS description FROM loan_status;	2345937214
SELECT org_nm, SUM(wealth_bal) FROM financial_products WHERE data_dt = '2024-07-02' AND cust_type = '对公客户' GROUP BY org_nm;	726948157
SELECT customer_id FROM loan_application WHERE YEAR(apply_date) = 2019 AND status = 'REJECTED';	428507464
SELECT cust_no, wealth_bal FROM financial_products WHERE data_dt = '2024-07-19' AND wealth_bal > 100000 ORDER BY wealth_bal DESC;	1610322845
SELECT customer_name, email FROM customer;	377073913
SELECT customer_id, DATE_TRUNC('quarter', apply_date) AS quarter, SUM(CASE WHEN status = '成功' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS success_rate FROM loan_application GROUP BY customer_id, quarter;	1405120881
SELECT cust_name, acct_bal FROM deposit_account_info WHERE cur_type = '美元' AND data_dt = '2024-07-19' ORDER BY acct_bal DESC;	965817749
SELECT customer_name, id_number, phone_number, email FROM customer WHERE birth_date > '1980-01-01';	311014935
SELECT o.occupation_name FROM loan_application la JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id ORDER BY la.loan_amount DESC LIMIT 5;	946337978
SELECT cust_type, loan_balance FROM loan_detail_info;	2702285633
SELECT SUM(current_bal), SUM(fixed_bal) FROM debit_card_information WHERE bank_nm = '杭州上城区支行' AND data_dt = '2023-06-30';	1617148541
AMBIGUOUS_QUERY	1580416554
SELECT * FROM customer WHERE id_number = 'c839d762-6392-4005-8386-ed4e2c50997a';	1114816707
SELECT credit_score, description FROM loan_credit WHERE credit_date = '2003-06-22';	808510096
SELECT cust_no FROM deposit_account_info WHERE org_nm = '杭州分行' AND acct_bal > 50000 AND data_dt = '2024-07-21';	3305168434
SELECT l.cust_id, l.loan_balance, d.acct_bal FROM loan_detail_info l JOIN deposit_account_info d ON l.cust_id = d.cust_no WHERE l.loan_balance > 10000;	3107729998
SELECT rs_type_name, COUNT(DISTINCT cust_id) AS user_count, SUM(loan_balance) AS total_loan_balance FROM five_level_classification JOIN loan_detail_info ON five_level_classification.rs_type_id = loan_detail_info.judgelevel GROUP BY rs_type_name;	3912588693
SELECT deposit_name FROM deposit_type WHERE data_dt = '2024-07-22';	158646132
SELECT * FROM transfer WHERE transfer_amount > 500;	3617397322
SELECT c.customer_name, c.id_number, lc.credit_score FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id WHERE c.province = '河北省' AND lc.credit_score > 0.8 ORDER BY lc.credit_score DESC;	397932156
SELECT CASE WHEN DATE_PART('year', AGE(c.birth_date)) BETWEEN 20 AND 30 THEN '20-30' WHEN DATE_PART('year', AGE(c.birth_date)) BETWEEN 31 AND 40 THEN '31-40' WHEN DATE_PART('year', AGE(c.birth_date)) BETWEEN 41 AND 50 THEN '41-50' ELSE '51以上' END AS age_group, l.loan_type_id, SUM(CASE WHEN l.status = '成功' THEN 1 ELSE 0 END)::float / COUNT(*) AS success_rate FROM customer c JOIN loan_application l ON c.id = l.customer_id GROUP BY age_group, l.loan_type_id;	269454572
SELECT ls.loan_status_name, o.occupation_name FROM loan_application la JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id JOIN loan_status ls ON la.status = ls.loan_status_code WHERE o.occupation_code = 'NURSE' AND ls.loan_status_name = 'APPROVED';	3026164558
SELECT occupation_id, COUNT(DISTINCT customer.id) AS customer_count, AVG(loan_amount) AS avg_loan_amount FROM customer JOIN loan_application ON customer.id = loan_application.customer_id GROUP BY occupation_id HAVING COUNT(DISTINCT customer.id) > 100;	308222457
SELECT cust_no FROM financial_products WHERE data_dt = '2024-07-14' AND org_nm = '沈阳余淮支行' AND cast_type = '非保本' AND currency = '新加坡元';	2469695932
SELECT id_number, phone_number FROM customer;	425374562
SELECT cust_nm, open_date FROM debit_card_information WHERE open_date >= '2024-07-05';	2892564169
SELECT COUNT(DISTINCT ub.customer_id) FROM user_behavior ub JOIN (SELECT cust_no FROM financial_products WHERE wealth_bal >= (SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY wealth_bal) FROM financial_products)) fp ON ub.customer_id = fp.cust_no WHERE ub.behavior_type = '登录' AND ub.behavior_date >= NOW() - INTERVAL '30 days';	1640385150
SELECT lc.customer_id, lc.credit_score, ub.description FROM loan_credit lc JOIN user_behavior ub ON lc.customer_id = ub.customer_id WHERE lc.credit_date = '2023-12-10';	3377906541
SELECT bank_id, bank_name FROM bank_orgnization;	365779440
SELECT lr.*, la.* FROM loan_repayment lr JOIN loan_application la ON lr.loan_application_id = la.id WHERE lr.repayment_date = '2024-01-20';	798971312
SELECT c.curr_code, c.curr_full_name, COUNT(t.id) AS transfer_count FROM currency c LEFT JOIN transfer t ON c.curr_code = t.currency_code AND t.transfer_date < '2023-06-30' WHERE c.data_dt = '2023-06-30' GROUP BY c.curr_code, c.curr_full_name;	1756912532
SELECT repayment_amount FROM loan_repayment WHERE loan_application_id = 742969 AND repayment_date = '2021-11-10';	3898093211
SELECT deposit_type.deposit_type_name, AVG(loan_application.loan_amount) AS avg_loan_amount, STDDEV(loan_application.loan_amount) AS stddev_loan_amount FROM loan_application JOIN deposit_type ON loan_application.loan_type_id = deposit_type.deposit_type_id GROUP BY deposit_type.deposit_type_name;	2131176144
SELECT c.customer_name, o.occupation_name, lr.repayment_date FROM customer c JOIN occupation o ON c.occupation_id = o.id JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id;	784123269
SELECT loan_type_id, AVG(loan_amount) AS avg_loan_amount, AVG(acct_bal) AS avg_deposit_balance FROM loan_application, deposit_account_info GROUP BY loan_type_id;	1431165151
SELECT COUNT(DISTINCT la.customer_id) FROM loan_application la JOIN user_behavior ub ON la.customer_id = ub.customer_id WHERE la.apply_date = '2019-01-10' AND la.status = 'REJECTED' AND ub.behavior_date = '2017-10-24' AND ub.behavior_type = 'LOGIN';	2469033655
SELECT c.customer_name, la.loan_amount FROM loan_application la JOIN loan_credit lc ON la.customer_id = lc.customer_id JOIN customer c ON la.customer_id = c.id WHERE YEAR(la.apply_date) = 2019 AND lc.credit_score > 0.8 ORDER BY la.loan_amount DESC;	398304766
SELECT * FROM loan_detail_info WHERE loan_balance > 500000 ORDER BY loan_balance DESC;	3521704142
SELECT customer_id, credit_score FROM loan_credit WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	1896500682
SELECT customer_name, birth_date FROM customer WHERE birth_date > '1990-01-01';	1933728727
SELECT customer_id, MAX(credit_score) - MIN(credit_score) AS score_change FROM loan_credit WHERE credit_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY customer_id ORDER BY score_change DESC LIMIT 5;	3124021686
SELECT behavior_type, COUNT(*) FROM user_behavior GROUP BY behavior_type;	3585096464
SELECT deposit_type_name, COUNT(DISTINCT CASE WHEN data_dt >= DATEADD(year, -1, GETDATE()) THEN cust_no END) * 1.0 / COUNT(DISTINCT cust_no) AS retention_rate FROM deposit_account_info GROUP BY deposit_type_name;	677634919
SELECT SUM(transfer_amount) FROM transfer JOIN customer ON transfer.source_customer_id = customer.id WHERE customer.province = '沈阳' AND transfer.transfer_date = '2024-07-19';	3094639947
SELECT s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' GROUP BY ss.store_id, s.manager_name ORDER BY SUM(ss.profit) DESC LIMIT 1;	1003634069
SELECT profit, sales_quantity FROM salesstatistics;	3101430966
AMBIGUOUS_QUERY	2117960535
SELECT e.name FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id JOIN stores st ON s.store_id = st.store_id WHERE st.store_name = '数码广场店' AND s.order_date = '2023-05-05' AND s.total_amount > 7000;	941218200
SELECT * FROM salesstatistics ORDER BY profit DESC LIMIT 1;	1332840948
SELECT s.store_name, e.name, ss.sales_amount, p.product_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' AND ss.sales_amount > 10000 AND p.supplier_name = '苹果官方旗舰店';	3240310596
SELECT p.product_name, p.supplier_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE s.store_name = '电子城旗舰店';	717197329
SELECT e.store_id, e.position FROM employees e JOIN salesstatistics s ON e.employee_id = s.employee_id JOIN products p ON s.product_id = p.product_id WHERE p.product_name = 'iPad Air' AND s.date = '2023-05-09';	1628648561
SELECT manager_name FROM stores WHERE store_id IN (SELECT store_id FROM salesstatistics WHERE date = '2023-05-05' AND sales_amount > 10000);	2064785597
SELECT e.name, s.total_amount FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id WHERE s.order_date = '2023-05-07' AND s.total_amount > 10000;	3560785170
SELECT store_id FROM salesstatistics WHERE product_id = (SELECT product_id FROM products WHERE product_name = '索尼WH-1000XM4耳机') AND date >= '2023-05-01' AND date <= '2023-05-31' GROUP BY store_id HAVING SUM(profit) > 5000;	251536917
SELECT e.name FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'Nintendo Switch' AND s.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND s.total_amount > 5000;	634768311
SELECT p.product_name, s.profit FROM salesstatistics s JOIN products p ON s.product_id = p.product_id ORDER BY s.sales_amount DESC LIMIT 1;	725261436
SELECT p.product_name, s.total_amount FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id JOIN products p ON o.product_id = p.product_id;	1323416994
SELECT e.name, s.store_name FROM employees e JOIN stores s ON e.store_id = s.store_id;	513278066
SELECT s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-08' GROUP BY s.manager_name;	3418908967
SELECT s.order_id, e.name FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id WHERE s.total_amount > 7000;	1868084525
SELECT stores.store_name, employees.name, salesstatistics.sales_amount, products.product_name FROM salesstatistics JOIN stores ON salesstatistics.store_id = stores.store_id JOIN employees ON salesstatistics.employee_id = employees.employee_id JOIN products ON salesstatistics.product_id = products.product_id WHERE salesstatistics.date >= '2023-05-01' AND salesstatistics.date <= '2023-05-31' AND salesstatistics.sales_amount > 10000 AND products.supplier_name = '苹果官方旗舰店';	3487107783
AMBIGUOUS_QUERY	556239338
SELECT * FROM salesorders WHERE order_id = 'b8b62bfe-a35d-4ff5-9bc9-654b5f67fed2';	2327152729
SELECT employee_id, SUM(total_amount) FROM salesorders GROUP BY employee_id;	3589036319
SELECT product_name, sale_price, purchase_price FROM products;	3750652945
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date >= '2023-05-01' AND so.order_date <= '2023-05-31' GROUP BY so.employee_id, s.manager_name HAVING SUM(so.total_amount) > 10000;	148577634
AMBIGUOUS_QUERY	693418076
SELECT s.store_name, ss.profit FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = 'Apple Watch Series 7' AND ss.date = '2023-05-07';	1476013456
SELECT DISTINCT s.manager_name FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05' AND p.sale_price > 5000 GROUP BY s.manager_name, so.store_id HAVING SUM(so.total_amount) > 10000;	3645006631
SELECT o.order_id, p.product_name, o.quantity FROM orderdetails o JOIN products p ON o.product_id = p.product_id;	1046575296
SELECT * FROM salesorders WHERE store_id = '0887d06a-27a8-46b4-98d6-514702e698da';	1550748576
SELECT s.employee_id FROM salesstatistics s JOIN orderdetails o ON s.product_id = o.product_id WHERE strftime('%Y-%m', s.date) = '2023-05' GROUP BY s.employee_id HAVING SUM(s.sales_quantity) > SUM(o.quantity);	2462853793
SELECT s.store_id, SUM(so.total_amount) FROM products p JOIN salesstatistics ss ON p.product_id = ss.product_id JOIN salesorders so ON ss.store_id = so.store_id AND ss.date = so.order_date WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-01' GROUP BY s.store_id;	1349452785
SELECT od.product_id, od.quantity, so.order_date FROM orderdetails od JOIN salesorders so ON od.order_id = so.order_id;	3541158395
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE strftime('%Y-%m', so.order_date) = '2023-05' GROUP BY so.store_id ORDER BY SUM(so.total_amount) DESC LIMIT 1;	3496741770
AMBIGUOUS_QUERY	2485376576
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-07' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2624059207
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND so.order_date = '2023-05-01' AND so.total_amount > 8000;	509381804
SELECT purchase_price, sale_price FROM products WHERE product_id = '某一商品的ID';	535494901
SELECT product_id, unit_price, quantity FROM orderdetails;	3918531592
SELECT e.name, s.store_name FROM employees e JOIN stores s ON e.store_id = s.store_id WHERE e.employee_id IN (SELECT ss.employee_id FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = 'Apple Watch Series 7' AND ss.date = '2023-05-06');	4213276457
SELECT store_id, SUM(sales_amount) AS total_sales_amount FROM salesstatistics GROUP BY store_id ORDER BY SUM(sales_quantity) DESC LIMIT 1;	1019928378
SELECT DISTINCT e.employee_id, p.category_name FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON so.employee_id = e.employee_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 10000;	1374387165
SELECT e.employee_id, SUM(s.total_amount) FROM employees e JOIN salesorders s ON e.store_id = s.store_id GROUP BY e.employee_id;	765173051
SELECT s.store_id, SUM(so.total_amount) AS total_sales_amount, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date >= '2023-05-01' AND so.order_date < '2023-06-01' GROUP BY s.store_id, s.manager_name;	1497182476
SELECT * FROM orderdetails WHERE product_id IN (SELECT product_id FROM salesstatistics WHERE sales_quantity > 5 AND date >= '2023-05-01' AND date <= '2023-05-31');	1106161896
SELECT p.product_id, SUM(s.sales_quantity) AS sales_quantity, p.sale_price FROM products p JOIN salesstatistics s ON p.product_id = s.product_id GROUP BY p.product_id, p.sale_price;	1170519624
SELECT s.manager_name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '佳能EOS R6' AND ss.date = '2023-05-01';	834717526
SELECT store_name, address, phone FROM stores;	2895234210
SELECT so.order_id, p.product_name FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.total_amount < 5000;	710749857
SELECT store_id, SUM(profit) FROM salesstatistics WHERE date >= '2023-05-01' AND date < '2023-06-01' GROUP BY store_id, employee_id ORDER BY SUM(sales_quantity) DESC LIMIT 1;	1055484680
SELECT store_id, SUM(profit) FROM salesstatistics WHERE product_id = (SELECT product_id FROM products WHERE product_name = '小米电视4A') AND date >= '2023-05-01' AND date < '2023-06-01' GROUP BY store_id;	1417436330
SELECT s.employee_id, SUM(s.profit) FROM salesstatistics s JOIN stores st ON s.store_id = st.store_id JOIN products p ON s.product_id = p.product_id WHERE st.store_name = '智慧街店' AND p.product_name = '小米电视4A' AND s.date = '2023-05-06' GROUP BY s.employee_id;	3793589229
SELECT store_name, phone FROM stores;	1607637139
SELECT s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' AND ss.profit > 1000;	3962541566
SELECT category_name, SUM(sales_quantity) FROM products JOIN salesstatistics ON products.product_id = salesstatistics.product_id GROUP BY category_name;	2338461777
SELECT store_id, employee_id FROM employees;	1062218506
SELECT order_id FROM salesorders WHERE total_amount > (SELECT AVG(total_amount) FROM salesorders);	1070226284
AMBIGUOUS_QUERY	2289172435
SELECT e.employee_id, e.name, s.order_date, s.total_amount FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id;	2176343547
SELECT employee_id, SUM(total_amount) FROM salesorders GROUP BY employee_id;	3778494114
SELECT employee_id, SUM(sales_quantity) AS total_sales_quantity, SUM(profit) AS total_profit FROM salesstatistics GROUP BY employee_id;	230146678
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '佳能EOS R6相机' AND so.order_date >= '2023-05-01' AND so.order_date < '2023-06-01' AND so.total_amount > 10000;	1097733010
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05' GROUP BY so.store_id, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	406428809
SELECT s.store_name, SUM(ss.sales_quantity) AS sales_quantity, SUM(ss.sales_amount) AS sales_amount FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id GROUP BY s.store_name;	224479304
SELECT s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' GROUP BY ss.store_id ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	549557561
AMBIGUOUS_QUERY	4264530712
SELECT order_detail_id, order_id, product_id, quantity, unit_price FROM orderdetails WHERE product_id = '某商品ID';	3474684191
SELECT store_id, SUM(sales_amount), date FROM salesstatistics GROUP BY store_id;	3292698794
SELECT product_name FROM products WHERE purchase_price > 4000;	3179632170
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-09' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	2509582177
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-02' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	1374950508
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-09' AND so.total_amount > 1000;	2266088702
SELECT DISTINCT e.employee_id, p.category_name FROM salesorders s JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE s.order_date >= '2023-05-01' AND s.order_date < '2023-06-01' AND s.total_amount > 10000;	2178886607
SELECT store_name, SUM(profit) FROM salesstatistics JOIN stores ON salesstatistics.store_id = stores.store_id GROUP BY store_name;	2714447935
SELECT s.store_name, e.name, ss.sales_amount, p.product_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' AND ss.sales_amount > 10000 AND p.supplier_name = '索尼官方旗舰店';	1871066617
SELECT od.* FROM orderdetails od JOIN salesorders so ON od.order_id = so.order_id WHERE so.total_amount > 5000;	2023023440
AMBIGUOUS_QUERY	3146544905
SELECT s.sales_quantity, st.store_name FROM salesstatistics s JOIN stores st ON s.store_id = st.store_id WHERE YEAR(s.date) = 2023 AND MONTH(s.date) = 5;	283454282
SELECT product_id, sale_price, purchase_price FROM products;	2083297023
SELECT s.store_name, SUM(ss.sales_quantity) AS sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' AND p.category_name = '智能手表' AND p.supplier_name = '索尼官方旗舰店' GROUP BY s.store_name HAVING SUM(ss.sales_quantity) > 10;	2394150048
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE strftime('%Y-%m', so.order_date) = '2023-05' GROUP BY so.store_id HAVING AVG(so.total_amount) > 10000;	519899560
SELECT store_id, profit FROM salesstatistics WHERE date = '2023-05-02' AND product_id = (SELECT product_id FROM products WHERE product_name = 'iPad Air');	1920836570
AMBIGUOUS_QUERY	3659690943
SELECT store_id, SUM(sales_amount) AS total_sales_amount FROM salesstatistics WHERE date >= '2023-05-01' AND date <= '2023-05-31' AND store_id = (SELECT store_id FROM salesstatistics WHERE date >= '2023-05-01' AND date <= '2023-05-31' GROUP BY store_id, employee_id ORDER BY SUM(sales_quantity) DESC LIMIT 1) GROUP BY store_id;	1937076000
SELECT s.store_name, SUM(so.total_amount) AS total_amount FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN salesorders so ON ss.order_id = so.order_id WHERE p.product_name = 'Apple Watch Series 7' AND ss.date = '2023-05-09' GROUP BY s.store_name;	2659013528
SELECT quantity, unit_price FROM orderdetails;	1610928077
SELECT DISTINCT s.store_name, e.position FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND so.order_date >= '2023-05-01' AND so.order_date <= '2023-05-31';	2010016216
SELECT * FROM salesstatistics WHERE sales_quantity > 1;	1911035258
SELECT s.store_id, SUM(ss.profit) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = 'Nintendo Switch' AND strftime('%Y-%m', ss.date) = '2023-05' GROUP BY s.store_id;	761870148
SELECT total_amount, order_date FROM salesorders;	3087271800
SELECT store_id, SUM(total_amount) AS total_amount, SUM(sales_quantity) AS sales_quantity FROM salesorders JOIN salesstatistics USING (store_id) GROUP BY store_id;	1161484474
SELECT * FROM orderdetails WHERE quantity = 2;	52411810
SELECT e.position FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '戴尔灵越15' AND s.order_date = '2023-05-01';	1664706844
SELECT e.position, s.store_name FROM employees e JOIN stores s ON e.store_id = s.store_id;	3840473394
SELECT store_id, SUM(profit) FROM salesstatistics WHERE date = '2023-05-03' AND product_id = (SELECT product_id FROM products WHERE product_name = '佳能EOS R6') GROUP BY store_id;	2695189368
AMBIGUOUS_QUERY	2733025825
SELECT DISTINCT store_id FROM salesstatistics WHERE date = '2023-05-06' AND product_id = (SELECT product_id FROM products WHERE product_name = '华为Mate 40 Pro') AND sales_quantity > 1;	807812239
SELECT o.order_id, p.product_name, o.quantity FROM orderdetails o JOIN products p ON o.product_id = p.product_id;	4273091220
SELECT e.name, e.position, s.phone FROM employees e JOIN stores s ON e.store_id = s.store_id;	4275534962
SELECT s.store_name, e.name, ss.sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE p.product_name = '戴尔灵越15' AND ss.date = '2023-05-05' AND ss.sales_quantity > 1;	1477929232
SELECT s.order_id, p.product_name FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id JOIN products p ON o.product_id = p.product_id WHERE s.total_amount > 5000;	729968430
SELECT employee_id, total_amount FROM salesorders;	1040158875
SELECT date, profit FROM salesstatistics WHERE profit > 3000;	1660394186
SELECT DISTINCT s.store_id FROM salesorders s JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'Apple Watch Series 7' AND s.order_date = '2023-05-01' AND s.total_amount > 7000;	3002487561
SELECT remaining_quantity, category_name FROM products;	2715847000
SELECT e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-07' AND p.category_name = '相机' GROUP BY e.name HAVING SUM(od.quantity * od.unit_price) > 15000;	1326759420
AMBIGUOUS_QUERY	57033443
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-08' GROUP BY so.store_id ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2455933109
SELECT e.employee_id, e.name, s.sales_quantity, s.sales_amount FROM employees e JOIN salesstatistics s ON e.employee_id = s.employee_id JOIN stores st ON s.store_id = st.store_id JOIN products p ON s.product_id = p.product_id WHERE st.store_name = '数字大道店' AND p.product_name = 'Nintendo Switch' AND s.date = '2023-05-03';	4078619784
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-05' AND p.product_name = '戴森V11' AND ss.profit > 500;	2372435041
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-09' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 2000;	1022758323
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-01' AND so.total_amount > 10000;	2940623149
AMBIGUOUS_QUERY	3177645630
AMBIGUOUS_QUERY	2385992805
SELECT store_name, address, phone FROM stores;	2749807521
SELECT stores.store_name, employees.name, salesorders.total_amount FROM salesorders JOIN employees ON salesorders.employee_id = employees.employee_id JOIN stores ON salesorders.store_id = stores.store_id WHERE salesorders.order_date = '2023-05-02' AND salesorders.total_amount > 2000;	888076621
SELECT store_id, SUM(sales_quantity) AS total_sales_quantity, SUM(profit) AS total_profit FROM salesstatistics GROUP BY store_id;	1648589599
SELECT s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-07' AND ss.profit > 1000;	2992228883
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	3404171320
SELECT store_id FROM salesstatistics WHERE date = '2023-05-09' GROUP BY store_id ORDER BY SUM(profit) DESC LIMIT 1;	952156269
SELECT DISTINCT s.store_id FROM salesorders s JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '佳能EOS R6相机' AND s.total_amount > 5000 AND strftime('%Y-%m', s.order_date) = '2023-05';	4068577452
SELECT DISTINCT s.store_id, e.position FROM salesorders s JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON s.employee_id = e.employee_id WHERE p.product_name = 'iPad Air' AND s.order_date >= '2023-05-01' AND s.order_date <= '2023-05-31';	1242514407
SELECT category_name, sale_price FROM products;	3705049314
SELECT COUNT(DISTINCT e.employee_id) FROM employees e JOIN (SELECT store_id FROM salesstatistics WHERE date >= '2023-05-01' AND date <= '2023-05-31' GROUP BY store_id HAVING SUM(sales_amount) > 10000) s ON e.store_id = s.store_id WHERE e.position = '销售经理';	4213863561
SELECT p.product_id, p.remaining_quantity, SUM(s.sales_quantity) AS sales_quantity FROM products p LEFT JOIN salesstatistics s ON p.product_id = s.product_id GROUP BY p.product_id, p.remaining_quantity;	1964767451
SELECT order_id, order_date, total_amount FROM salesorders;	2226247599
SELECT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '华为Mate 40 Pro' AND ss.date = '2023-05-06' AND ss.sales_quantity > 1;	2202777878
SELECT s.store_name, e.name, e.position FROM employees e JOIN stores s ON e.store_id = s.store_id;	3419270272
SELECT e.employee_id, SUM(so.total_amount) FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE s.store_name = '创客空间店' AND so.order_date = '2023-05-01' AND p.product_name = '华为Mate 40 Pro' GROUP BY e.employee_id;	569246445
SELECT s.store_name, e.position FROM stores s JOIN employees e ON s.store_id = e.store_id JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '戴森V11' AND so.order_date >= '2023-05-01' AND so.order_date <= '2023-05-31';	830322285
SELECT * FROM orderdetails INNER JOIN products ON orderdetails.product_id = products.product_id;	2616706012
SELECT DISTINCT s.employee_id FROM salesstatistics s JOIN products p ON s.product_id = p.product_id WHERE s.date = '2023-05-06' AND s.sales_quantity > 1 AND p.supplier_name = '戴尔官方旗舰店';	2466792320
SELECT product_name, sale_price FROM products;	1812987912
SELECT manager_name, phone FROM stores;	3453098028
SELECT SUM(s.total_amount) AS total_amount, st.store_name FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id JOIN stores st ON s.store_id = st.store_id WHERE e.name = '范莹' AND s.order_date = '2023-05-07' GROUP BY st.store_name;	4200224368
SELECT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'Apple Watch Series 7' AND so.order_date >= '2023-05-01' AND so.order_date < '2023-06-01' GROUP BY s.store_name HAVING SUM(so.total_amount) > 10000;	1555442404
SELECT store_id, SUM(total_amount) FROM salesorders WHERE order_date >= '2023-05-01' AND order_date < '2023-06-01' GROUP BY store_id;	3702552802
SELECT store_name, manager_name FROM stores;	2171002807
SELECT product_name, sale_price, remaining_quantity FROM products;	2060589508
AMBIGUOUS_QUERY	356180662
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND ss.date = '2023-05-08' AND ss.sales_amount > 15000;	4289573231
SELECT s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-09' GROUP BY ss.store_id, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	218019223
SELECT SUM(profit) FROM salesstatistics;	1638224805
AMBIGUOUS_QUERY	2476507165
SELECT s.store_name, SUM(ss.sales_quantity) AS total_sales FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE e.name = '黄萍' AND ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' GROUP BY s.store_name ORDER BY total_sales DESC LIMIT 1;	1748148291
SELECT s.store_id, s.profit FROM salesstatistics s JOIN products p ON s.product_id = p.product_id WHERE p.product_name = 'Nintendo Switch' AND s.date = '2023-05-08';	2979325122
SELECT s.store_id, SUM(so.total_amount) AS total_amount FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND so.order_date = '2023-05-05' GROUP BY s.store_id;	2667320856
SELECT DISTINCT s.employee_id FROM salesorders s JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN stores st ON s.store_id = st.store_id WHERE s.order_date = '2023-05-05' AND st.store_name = '智能生活馆' AND p.supplier_name = '小米官方旗舰店';	1093613959
SELECT s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-07' GROUP BY ss.store_id, s.manager_name ORDER BY SUM(ss.profit) DESC LIMIT 1;	2112449268
SELECT store_id, profit FROM salesstatistics WHERE product_id = (SELECT product_id FROM products WHERE product_name = '索尼WH-1000XM4') AND date = '2023-05-09';	2094309801
AMBIGUOUS_QUERY	3718167842
SELECT s.total_amount, st.store_name FROM salesorders s JOIN stores st ON s.store_id = st.store_id WHERE s.order_date = '2023-05-03';	3764251163
SELECT * FROM orderdetails WHERE quantity > 1;	1497641640
AMBIGUOUS_QUERY	4149606926
SELECT s.order_id, st.store_name FROM salesorders s JOIN stores st ON s.store_id = st.store_id WHERE s.order_date = '2023-05-05';	4134019112
SELECT p.product_name, o.order_id FROM orderdetails o JOIN products p ON o.product_id = p.product_id WHERE o.quantity > 1;	2245397691
SELECT order_id FROM salesorders WHERE order_date BETWEEN '2023-05-01' AND '2023-05-31';	2674486311
SELECT employee_id, SUM(sales_quantity) FROM salesstatistics GROUP BY employee_id;	2993192059
SELECT category_name, remaining_quantity FROM products;	2808717165
SELECT s.store_name, SUM(ss.sales_quantity) AS total_sales FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id GROUP BY ss.employee_id, s.store_name;	3833291686
SELECT order_id, product_id FROM orderdetails;	2280059229
AMBIGUOUS_QUERY	77729748
AMBIGUOUS_QUERY	82660779
SELECT e.name FROM employees e JOIN salesstatistics s ON e.employee_id = s.employee_id JOIN products p ON s.product_id = p.product_id WHERE p.product_name = 'Apple Watch Series 7' AND p.supplier_name = '任天堂官方旗舰店' AND s.date = '2023-05-09';	787968865
SELECT s.store_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-06' GROUP BY s.store_name;	3377021543
AMBIGUOUS_QUERY	813286043
SELECT e.employee_id, e.name, SUM(s.total_amount) AS total_sales_amount FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id JOIN stores st ON s.store_id = st.store_id JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE st.store_name = '智慧街店' AND p.product_name = '佳能EOS R6相机' AND s.order_date = '2023-05-07' GROUP BY e.employee_id, e.name;	727992931
SELECT s.store_id, SUM(o.quantity) AS total_sales_quantity, SUM(s.total_amount) AS total_sales_amount FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id GROUP BY s.store_id;	825037872
SELECT s.store_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '佳能EOS R6' AND so.order_date = '2023-05-05' GROUP BY s.store_name;	4082105822
SELECT * FROM products WHERE sale_price > 15000;	3249720567
SELECT DISTINCT s.store_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = '索尼WH-1000XM4' AND ss.date = '2023-05-08' AND ss.sales_quantity > 1;	2614838216
SELECT s.store_name, e.name, p.product_name, ss.sales_amount FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-01' AND ss.sales_amount > 1000 AND p.supplier_name = '戴森官方旗舰店';	1333469519
AMBIGUOUS_QUERY	2995198030
SELECT s.store_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id GROUP BY s.store_name;	2649378296
AMBIGUOUS_QUERY	746087372
SELECT s.order_id, s.order_date, e.name FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id;	3679313236
SELECT product_name, supplier_name FROM products;	2391253319
SELECT product_name, sale_price, supplier_name FROM products;	1769098425
SELECT od.order_detail_id, od.order_id, od.product_id, od.quantity, od.unit_price, p.product_name, p.sale_price FROM orderdetails od JOIN products p ON od.product_id = p.product_id;	622285765
SELECT store_name, phone FROM stores WHERE store_id IN (SELECT store_id FROM salesstatistics WHERE date >= '2023-05-01' AND date <= '2023-05-31' GROUP BY store_id HAVING SUM(sales_amount) > 3000);	3990639391
SELECT store_name, manager_name FROM stores;	986209829
SELECT e.name, s.phone FROM employees e JOIN stores s ON e.store_id = s.store_id;	2997501252
SELECT employee_id, sales_quantity, profit FROM salesstatistics WHERE date = '2023-05-09' AND store_id = (SELECT store_id FROM stores WHERE store_name = '创新路专卖店') AND product_id = (SELECT product_id FROM products WHERE product_name = 'iPad Air');	3439332131
SELECT employee_id FROM salesorders JOIN stores ON salesorders.store_id = stores.store_id WHERE stores.store_name = '未来城店' AND salesorders.order_date = '2023-05-07' AND salesorders.total_amount > 15000;	3283669448
SELECT product_id, sale_price - purchase_price AS price_difference FROM products;	1627244723
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date >= '2023-05-01' AND so.order_date <= '2023-05-31' GROUP BY s.store_id, s.manager_name HAVING SUM(so.total_amount) > 10000;	1569820240
SELECT store_id, SUM(profit) AS total_profit, SUM(sales_quantity) AS total_sales_quantity FROM salesstatistics GROUP BY store_id;	3499069647
SELECT * FROM salesorders WHERE store_id = '64921abb-1d54-4e03-a15e-ea42f058f31c';	1379442449
SELECT DISTINCT s.store_id FROM salesorders s JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '小米电视4A' AND s.order_date = '2023-05-06' AND s.total_amount > 10000;	2629127246
SELECT DISTINCT s.store_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = 'Nintendo Switch' AND ss.profit > 1000 AND ss.date >= '2023-05-01' AND ss.date <= '2023-05-31';	3788770697
SELECT s.store_name, ss.sales_quantity, ss.sales_amount FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = '索尼WH-1000XM4' AND ss.date = '2023-05-09';	1545362727
AMBIGUOUS_QUERY	2279456937
SELECT manager_name FROM stores WHERE store_id = (SELECT store_id FROM salesorders WHERE order_date = '2023-05-03' GROUP BY store_id ORDER BY SUM(total_amount) DESC LIMIT 1);	2483765707
SELECT manager_name FROM stores WHERE store_id = (SELECT store_id FROM salesstatistics WHERE date = '2023-05-03' GROUP BY store_id ORDER BY SUM(sales_quantity) DESC LIMIT 1);	2155062621
SELECT s.store_id, so.total_amount FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-01';	1172044345
SELECT store_id, SUM(total_amount) FROM salesorders GROUP BY store_id;	413296723
SELECT e.position, COUNT(s.order_id) FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id GROUP BY e.position;	1774082301
AMBIGUOUS_QUERY	1485164601
SELECT s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date >= '2023-05-01' AND so.order_date <= '2023-05-31' GROUP BY s.manager_name HAVING SUM(so.total_amount) > 10000;	1282673925
SELECT DISTINCT s.store_id FROM salesorders s JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE s.order_date = '2023-05-02' AND p.supplier_name = '华为官方旗舰店' GROUP BY s.store_id, s.order_id HAVING SUM(od.quantity * od.unit_price) > 10000;	3234218182
AMBIGUOUS_QUERY	623061772
AMBIGUOUS_QUERY	3776277190
SELECT manager_name FROM stores WHERE store_id = (SELECT store_id FROM salesorders WHERE order_date = '2023-05-04' GROUP BY store_id ORDER BY SUM(total_amount) DESC LIMIT 1);	2220998092
SELECT DISTINCT s.store_id, e.position FROM salesorders s JOIN orderdetails od ON s.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON s.employee_id = e.employee_id WHERE s.order_date = '2023-05-01' AND p.product_name = '华为Mate 40 Pro';	3144588067
SELECT s.manager_name FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE ss.date = '2023-05-06' AND ss.sales_amount > 10000;	3325155262
SELECT s.store_name, e.name, so.total_amount FROM stores s JOIN employees e ON s.store_id = e.store_id JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '戴尔灵越15笔记本电脑' AND so.order_date >= '2023-05-01' AND so.order_date <= '2023-05-31' AND so.total_amount > 5000;	3438936179
SELECT product_id, remaining_quantity, sale_price FROM products;	214316002
SELECT store_id, COUNT(employee_id) FROM employees GROUP BY store_id;	3304679388
SELECT e.employee_id, e.name FROM employees e JOIN salesstatistics s ON e.employee_id = s.employee_id JOIN stores st ON s.store_id = st.store_id JOIN products p ON s.product_id = p.product_id WHERE s.date = '2023-05-05' AND st.store_name = '科技中心店' AND p.product_name = '戴森V11' AND s.sales_quantity > 1;	1528991895
SELECT order_id, total_amount FROM salesorders WHERE store_id = (SELECT store_id FROM stores WHERE store_name = '数码广场店');	127103551
SELECT re.* FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id WHERE ra.risk_level = '高' AND ra.impact_score > 8;	1891291054
SELECT event_id, event_type FROM risk_events WHERE event_type = '合规风险';	491501449
SELECT re.event_id, al.audit_result FROM alerts a JOIN risk_events re ON a.event_id = re.event_id JOIN audit_logs al ON a.alert_id = al.alert_id WHERE a.alert_type = '欺诈嫌疑';	3354532402
SELECT report_type, AVG(severity) FROM risk_reports JOIN risk_events ON risk_reports.event_id = risk_events.event_id WHERE approval_status = '已批准' GROUP BY report_type;	1450781019
SELECT risk_level, COUNT(customer_id), AVG(credit_score) FROM customers GROUP BY risk_level;	3784241191
SELECT risk_indicators.indicator_id, risk_indicators.indicator_name, risk_monitoring_logs.monitoring_date, risk_monitoring_logs.actual_value, risk_monitoring_logs.is_exceeding_threshold FROM risk_indicators JOIN risk_monitoring_logs ON risk_indicators.indicator_id = risk_monitoring_logs.indicator_id WHERE strftime('%Y-%m', risk_monitoring_logs.monitoring_date) = '2023-10';	2169849694
SELECT report_id, author, event_id FROM risk_reports WHERE approval_status = '已批准';	1821041301
SELECT c.risk_level, t.transaction_type, CASE WHEN t.amount <= 1000 THEN '0-1000' WHEN t.amount <= 5000 THEN '1001-5000' WHEN t.amount <= 10000 THEN '5001-10000' ELSE '10001+' END AS amount_range, COUNT(*) AS transaction_count, AVG(t.risk_score) AS avg_risk_score FROM transactions t JOIN customers c ON t.customer_id = c.customer_id GROUP BY c.risk_level, t.transaction_type, amount_range;	2399924571
AMBIGUOUS_QUERY	2832409698
SELECT rr.report_id, rr.report_type, rr.report_date, rr.report_content, re.event_type, re.event_description, re.occurrence_time, ra.assessor, ra.assessment_date, ra.risk_level, ra.impact_score, ra.probability_score, ra.mitigation_plan FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id JOIN risk_assessments ra ON rr.event_id = ra.event_id WHERE rr.author = '周婷';	4007902186
SELECT author, approval_status FROM risk_reports WHERE YEAR(report_date) > 2023;	3766793908
SELECT re.event_description, ra.risk_level, ra.mitigation_plan FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE re.event_description LIKE '%系统%';	379347511
SELECT a.indicator_id, a.actual_value AS current_value, b.actual_value AS value_30_days_ago, (a.actual_value - b.actual_value) / b.actual_value * 100 AS change_percentage FROM (SELECT indicator_id, actual_value FROM risk_monitoring_logs WHERE monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = risk_monitoring_logs.indicator_id)) a JOIN (SELECT indicator_id, actual_value FROM risk_monitoring_logs WHERE monitoring_date = DATE_SUB(CURDATE(), INTERVAL 30 DAY)) b ON a.indicator_id = b.indicator_id;	1838288170
SELECT event_id FROM risk_assessments WHERE risk_level = '高风险' AND assessor = '曾强';	3470826751
SELECT DISTINCT customer_id FROM transactions WHERE transaction_type = '投资' AND risk_score > 60;	1344992090
SELECT event_id, created_at, status FROM risk_events;	1091103550
SELECT customers.customer_id, transactions.risk_score FROM customers JOIN transactions ON customers.customer_id = transactions.customer_id WHERE customers.credit_score < 600;	1666978001
SELECT t.amount, c.customer_name FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.transaction_date LIKE '2023-12%' AND t.status = '成功';	3043489169
SELECT alert_type, alert_content FROM alerts;	228553912
SELECT report_id, approved_by FROM risk_reports;	3145840427
SELECT transaction_type, SUM(CASE WHEN status = '成功' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS success_rate, AVG(risk_score) AS avg_risk_score FROM transactions GROUP BY transaction_type;	2194753030
SELECT a.alert_id, r.rule_description FROM alerts a JOIN rule_configurations r ON a.rule_id = r.rule_id;	2007490591
SELECT t.customer_id, t.status FROM transactions t JOIN (SELECT customer_id, MAX(transaction_date) AS latest_date FROM transactions GROUP BY customer_id) latest ON t.customer_id = latest.customer_id AND t.transaction_date = latest.latest_date;	1993896438
SELECT indicator_id, AVG(actual_value), STDDEV(actual_value), STDDEV(actual_value)/AVG(actual_value) FROM risk_monitoring_logs GROUP BY indicator_id;	2353107053
SELECT DISTINCT t.customer_id FROM transactions t JOIN audit_logs a ON t.transaction_id = a.related_id WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND t.risk_score > 80 AND t.amount > 500000 AND a.audit_result = '未通过';	1348678368
SELECT AVG(impact_score) FROM risk_assessments WHERE mitigation_plan IS NULL;	3331891334
SELECT alert_content, status FROM alerts;	3770586804
SELECT c.customer_id, (COUNT(t.transaction_id) * 2 + COUNT(a.alert_id) * 3 + (1 / c.credit_score) * 1000) AS risk_index FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY) AND t.risk_score = '高风险' LEFT JOIN alerts a ON c.customer_id = a.assigned_to AND a.status = '未处理' GROUP BY c.customer_id ORDER BY risk_index DESC LIMIT 10;	2420031848
SELECT event_type, COUNT(*) AS occurrence_count, AVG(severity) AS avg_severity FROM risk_events WHERE SUBSTR(occurrence_time, 1, 4) = '2023' GROUP BY event_type ORDER BY occurrence_count DESC;	2122948167
SELECT r.report_id, r.event_id, e.event_description FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.report_content LIKE '%合规风险%';	1467350797
SELECT update_frequency, data_source FROM risk_indicators;	1619162011
SELECT re.event_id, rr.report_id FROM risk_events re LEFT JOIN (SELECT event_id, report_id FROM risk_reports WHERE event_id IN (SELECT event_id FROM risk_events WHERE status = '未解决') ORDER BY report_date DESC LIMIT 1) rr ON re.event_id = rr.event_id WHERE re.status = '未解决';	3180110269
SELECT rule_type, COUNT(a.alert_id) / COUNT(DISTINCT r.rule_id) AS avg_trigger_count, MAX(r.updated_at) AS last_updated FROM rule_configurations r LEFT JOIN alerts a ON r.rule_id = a.rule_id GROUP BY rule_type;	491065533
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type ORDER BY COUNT(*) DESC;	210792684
SELECT DISTINCT t.customer_id FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.credit_score < 700 AND t.transaction_date LIKE '2023%';	528895519
SELECT risk_events.event_id, risk_reports.report_id FROM risk_events JOIN risk_reports ON risk_events.event_id = risk_reports.event_id;	3994194373
SELECT COUNT(*) FROM risk_reports WHERE YEAR(report_date) = 2023 AND approval_status = '拒绝';	3108618170
SELECT assessment_id, mitigation_plan FROM risk_assessments;	2756291249
SELECT * FROM risk_monitoring_logs WHERE (indicator_id, monitoring_date) IN (SELECT indicator_id, MAX(monitoring_date) FROM risk_monitoring_logs GROUP BY indicator_id);	3508177846
SELECT rule_id, COUNT(alert_id) AS alert_count FROM rule_configurations LEFT JOIN alerts ON rule_configurations.rule_id = alerts.rule_id GROUP BY rule_id;	3123122302
SELECT * FROM transactions WHERE event_id IN (SELECT event_id FROM risk_events WHERE event_type = '信用风险') AND status = '成功';	3431937746
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	4153763267
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_amount) FROM (SELECT SUM(amount) AS total_amount FROM transactions WHERE customer_id IN (SELECT customer_id FROM customers WHERE registration_date < '2019-01-01' AND risk_level = '高') GROUP BY customer_id) AS customer_totals;	2480143604
SELECT a.rule_id, r.event_description FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.alert_level = '高风险';	1278986057
SELECT created_at, status FROM risk_events;	983609731
SELECT event_type, strftime('%Y-%m', occurrence_time) AS month, COUNT(*) AS frequency, (COUNT(*) - LAG(COUNT(*), 1, 0) OVER (PARTITION BY event_type ORDER BY strftime('%Y-%m', occurrence_time))) / LAG(COUNT(*), 1, 1) OVER (PARTITION BY event_type ORDER BY strftime('%Y-%m', occurrence_time)) AS growth_rate FROM risk_events GROUP BY event_type, strftime('%Y-%m', occurrence_time);	2727402886
SELECT strftime('%Y-%m', transaction_date) AS month, AVG(amount) AS avg_amount, COUNT(transaction_id) AS transaction_count FROM transactions GROUP BY month;	1304137472
SELECT rr.report_id, rr.report_type, rr.approved_by, re.event_description, re.severity FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approval_status = '已批准';	1801532770
SELECT c.risk_level, t.status FROM customers c JOIN transactions t ON c.customer_id = t.customer_id;	2532729979
SELECT transaction_id, transaction_type, amount, transaction_date, status FROM transactions WHERE customer_id IN (SELECT customer_id FROM customers WHERE risk_level = '高');	1467489344
SELECT report_id FROM risk_reports WHERE author = '孙宇' AND approval_status = '未审批';	2860062939
SELECT a.alert_content, r.event_description FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理';	186829469
SELECT risk_level, COUNT(*) FROM customers WHERE risk_level IN ('中', '高') GROUP BY risk_level;	1965814026
SELECT customer_id, COUNT(transaction_id), AVG(risk_score) FROM transactions GROUP BY customer_id;	1229601142
SELECT strftime('%Y-%m', registration_date) AS month, COUNT(*) FROM customers WHERE risk_level = '高' GROUP BY month;	134467671
SELECT rml.log_id, rml.indicator_id, rml.monitoring_date, rml.actual_value, a.alert_id, a.alert_type, al.audit_id, al.audit_result FROM (SELECT indicator_id, MAX(monitoring_date) AS latest_date FROM risk_monitoring_logs GROUP BY indicator_id) AS latest_logs JOIN risk_monitoring_logs rml ON latest_logs.indicator_id = rml.indicator_id AND latest_logs.latest_date = rml.monitoring_date JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id AND ri.risk_level = '高' LEFT JOIN alerts a ON rml.indicator_id = a.alert_id LEFT JOIN audit_logs al ON a.alert_id = al.alert_id;	2051579057
SELECT risk_level, COUNT(*) AS customer_count, AVG(credit_score) AS avg_credit_score FROM customers GROUP BY risk_level;	1467515231
SELECT alert_type FROM alerts WHERE status = '已解决' GROUP BY alert_type ORDER BY AVG(STRFTIME('%s', audit_time) - STRFTIME('%s', alert_time)) DESC LIMIT 1;	928241464
SELECT c.customer_name, t.amount, t.transaction_date FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date LIKE '2023-11%' AND t.amount > 100000;	861248617
SELECT SUM(threshold_value) FROM risk_indicators WHERE indicator_name LIKE '%财务%';	2228247623
SELECT customer_name, credit_score FROM customers;	1010279388
SELECT customer_id, transaction_date, risk_score FROM transactions WHERE (customer_id, transaction_date) IN (SELECT customer_id, MAX(transaction_date) FROM transactions GROUP BY customer_id);	3854618324
SELECT * FROM risk_monitoring_logs WHERE is_exceeding_threshold = '是';	4048786296
SELECT AVG(t.risk_score) FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险';	2208124060
SELECT customer_id, transaction_id, transaction_type, amount, transaction_date, status, risk_score FROM transactions;	2046381691
SELECT report_type, COUNT(*) FROM risk_reports WHERE approval_status = '已拒绝' GROUP BY report_type;	218145680
SELECT customer_name FROM customers WHERE risk_level = '高' AND credit_score < 600;	4118993277
SELECT c.risk_level, AVG(t.amount) AS avg_amount, COUNT(*) AS transaction_count FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY c.risk_level;	4099101626
SELECT * FROM risk_reports WHERE event_id IN (SELECT event_id FROM risk_events WHERE event_type = '流动性风险');	158715771
SELECT COUNT(DISTINCT c.customer_id), SUM(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score BETWEEN 600 AND 800;	1057264197
SELECT report_content FROM risk_reports WHERE approved_by = '王思远' AND report_date LIKE '2023-03%';	2894258616
SELECT * FROM risk_events JOIN risk_reports ON risk_events.event_id = risk_reports.event_id;	1697426124
SELECT * FROM transactions WHERE transaction_date LIKE '2023-06%';	1368489416
SELECT event_id FROM risk_events WHERE severity = 3 AND EXISTS (SELECT 1 FROM audit_logs WHERE audit_logs.event_id = risk_events.event_id);	1079159915
SELECT threshold_value, actual_value FROM risk_indicators JOIN risk_monitoring_logs ON risk_indicators.indicator_id = risk_monitoring_logs.indicator_id WHERE actual_value > threshold_value;	1387862561
SELECT c.customer_id, c.risk_level, t.status FROM customers c JOIN transactions t ON c.customer_id = t.customer_id;	1914208134
SELECT risk_events.event_id, risk_events.event_type, alerts.alert_id, alerts.alert_content FROM risk_events JOIN alerts ON risk_events.event_id = alerts.event_id WHERE alerts.alert_level = '高';	3189905137
SELECT * FROM risk_events JOIN alerts ON risk_events.event_id = alerts.event_id ORDER BY alerts.alert_time;	434260556
SELECT c.risk_level, AVG(t.amount) AS avg_amount, COUNT(*) AS transaction_count FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY) GROUP BY c.risk_level;	3762237075
SELECT customer_name FROM customers WHERE risk_level = '高' AND credit_score < 700;	2322626250
SELECT c.credit_score, t.* FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.status = '失败' ORDER BY t.transaction_date DESC LIMIT 1;	294935919
SELECT c.customer_id FROM risk_assessments ra JOIN transactions t ON ra.event_id = t.event_id JOIN customers c ON t.customer_id = c.customer_id WHERE ra.risk_level = '高风险' AND c.credit_score > 700;	1926912221
SELECT customer_id, customer_name, credit_score FROM customers WHERE customer_type = '企业' ORDER BY credit_score DESC LIMIT 10;	3499522069
SELECT strftime('%Y-%m', created_at) AS month, COUNT(*) AS new_rules_count, AVG(CASE WHEN is_active = '是' THEN 1 ELSE 0 END) AS avg_active_rules FROM rule_configurations GROUP BY strftime('%Y-%m', created_at);	538732127
SELECT author, approval_status FROM risk_reports WHERE approval_status = '已批准';	2736181075
SELECT customer_id, amount, status FROM transactions;	1873450174
SELECT re.event_id, re.event_type, re.event_description, re.occurrence_time, re.severity, re.status, re.reporter, re.created_at, ra.assessment_id, ra.assessor, ra.assessment_date, ra.risk_level, ra.impact_score, ra.probability_score, ra.mitigation_plan FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id;	3031401155
SELECT rmi.indicator_id, AVG(rml.actual_value) AS avg_actual_value, rmi.threshold_value FROM risk_monitoring_logs rml JOIN risk_indicators rmi ON rml.indicator_id = rmi.indicator_id GROUP BY rmi.indicator_id, rmi.threshold_value;	1926763899
SELECT rr.report_id, rr.event_id, re.event_type, re.event_description FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approval_status = '已批准';	2380941668
SELECT DISTINCT t.customer_id FROM transactions t JOIN alerts a ON t.event_id = a.event_id WHERE t.risk_score > 90 AND a.alert_level = '高' AND DATE(t.transaction_date) = DATE(a.alert_time);	1133773952
SELECT t.transaction_id, t.customer_id, t.risk_score, c.customer_name, c.customer_type FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.risk_score > 80;	2358748811
SELECT risk_events.event_description, risk_assessments.assessment_date FROM risk_assessments JOIN risk_events ON risk_assessments.event_id = risk_events.event_id WHERE risk_assessments.risk_level = '高';	634372359
SELECT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高' AND t.status = '失败' ORDER BY t.transaction_date DESC LIMIT 1;	54166415
SELECT event_id, COUNT(*) FROM transactions GROUP BY event_id;	775802297
SELECT t.transaction_id, t.amount, t.transaction_date, c.customer_name FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险' AND t.amount > 500000 AND t.transaction_date BETWEEN '2023-01-01' AND '2023-03-31';	3320369998
SELECT risk_events.event_description, risk_events.severity, risk_assessments.risk_level, risk_assessments.mitigation_plan FROM risk_events JOIN risk_assessments ON risk_events.event_id = risk_assessments.event_id WHERE risk_events.severity IN (4, 5) AND strftime('%Y', risk_events.occurrence_time) = '2023';	4254692719
SELECT * FROM risk_monitoring_logs WHERE is_exceeding_threshold = '否';	3645112410
SELECT rr.author, re.event_type, re.event_description, re.occurrence_time, re.severity, al.audit_result, al.audit_comments, al.audit_time FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id JOIN (SELECT related_id, audit_result, audit_comments, audit_time FROM audit_logs WHERE audit_type = '风险报告' ORDER BY audit_time DESC LIMIT 1) al ON rr.report_id = al.related_id WHERE rr.approval_status = '待审批';	1798162210
SELECT customer_id, customer_name FROM customers WHERE YEAR(registration_date) = 2021 AND risk_level = '高' AND credit_score < 550;	2215350256
AMBIGUOUS_QUERY	1774673651
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	3960174076
SELECT c.customer_name, r.rule_name, COUNT(a.alert_id) AS trigger_count FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN alerts a ON t.event_id = a.event_id JOIN rule_configurations r ON a.rule_id = r.rule_id WHERE c.risk_level = '高' GROUP BY c.customer_name, r.rule_name;	4181335061
SELECT event_type, strftime('%Y-%m', occurrence_time) AS month, COUNT(*) AS event_count, AVG(severity) AS avg_severity, SUM(CASE WHEN status = '已解决' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS resolution_rate FROM risk_events GROUP BY event_type, month;	995864049
SELECT actual_value, threshold_value FROM risk_monitoring_logs JOIN risk_indicators ON risk_monitoring_logs.indicator_id = risk_indicators.indicator_id;	430786160
SELECT c.risk_level, t.transaction_type, AVG(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level, t.transaction_type;	2101060146
SELECT COUNT(*) FROM rule_configurations WHERE is_active = '激活';	1665434378
SELECT risk_level, credit_score FROM customers;	3176119352
SELECT COUNT(*), AVG(update_frequency) FROM risk_indicators WHERE threshold_value > 100;	1713409158
SELECT customer_name, registration_date FROM customers;	1230885426
SELECT indicator_id, actual_value, is_exceeding_threshold FROM risk_monitoring_logs;	1766048190
SELECT indicator_id, data_source, AVG(actual_value) AS avg_value, STDDEV(actual_value) AS std_value FROM risk_monitoring_logs JOIN risk_indicators USING(indicator_id) GROUP BY indicator_id, data_source;	2747654158
SELECT auditor FROM audit_logs WHERE audit_result = '拒绝';	1853147969
SELECT alert_type, alert_content FROM alerts;	2764222826
SELECT a.alert_id, a.alert_type, a.alert_content, a.alert_level, a.alert_time, re.event_description, al.audit_result, al.audit_comments FROM alerts a JOIN risk_events re ON a.event_id = re.event_id LEFT JOIN (SELECT * FROM audit_logs WHERE audit_time = (SELECT MAX(audit_time) FROM audit_logs al2 WHERE al2.alert_id = audit_logs.alert_id)) al ON a.alert_id = al.alert_id WHERE a.status = '未处理';	1328047815
SELECT AVG(alert_time) FROM alerts WHERE status = '未处理';	1153256443
SELECT c.customer_id, COUNT(a.assessment_id) * AVG(a.impact_score) + COUNT(al.alert_id) * 2 AS risk_index FROM customers c LEFT JOIN risk_assessments a ON c.customer_id = a.assessor LEFT JOIN alerts al ON c.customer_id = al.assigned_to GROUP BY c.customer_id;	2529991047
SELECT event_type, COUNT(*) FROM risk_events WHERE status = '未处理' GROUP BY event_type;	1891370109
SELECT t.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '低' AND c.credit_score > 700;	3513778977
SELECT a.alert_id, r.event_id, r.event_description FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理' AND a.alert_level = '高级别';	1342627605
SELECT a.alert_id, a.status FROM alerts a JOIN rule_configurations r ON a.rule_id = r.rule_id WHERE r.rule_type = '合规违规';	2457540425
SELECT c.customer_id, c.risk_level, SUM(t.amount) FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.risk_score > 80 GROUP BY c.customer_id, c.risk_level;	3803553571
SELECT report_content FROM risk_reports WHERE report_type = '月度风险报告' AND approval_status = '已拒绝';	3170647440
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	3365749326
SELECT customer_id FROM transactions WHERE transaction_date = '2023-05-04' AND transaction_type = '转账' AND amount > 200000;	2632721664
SELECT a.assigned_to, r.event_description FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理' AND a.alert_level = '高级别';	2115455156
SELECT report_id FROM risk_reports WHERE approved_by = '高志远' AND strftime('%Y-%m', report_date) = '2023-04';	3669635067
SELECT transaction_type, status, COUNT(*) FROM transactions GROUP BY transaction_type, status;	4274653529
SELECT re.event_id, re.event_type, re.event_description, re.occurrence_time, re.severity, re.status, re.reporter, re.created_at, ra.risk_level, ra.impact_score, ra.probability_score, ra.mitigation_plan FROM risk_events re LEFT JOIN (SELECT event_id, risk_level, impact_score, probability_score, mitigation_plan FROM risk_assessments WHERE (event_id, assessment_date) IN (SELECT event_id, MAX(assessment_date) FROM risk_assessments GROUP BY event_id)) ra ON re.event_id = ra.event_id;	522918260
SELECT c.customer_name, COUNT(DISTINCT ra.assessment_id) AS risk_assessment_count, COUNT(DISTINCT t.transaction_id) AS large_transaction_count FROM customers c JOIN risk_assessments ra ON c.customer_id = ra.event_id JOIN transactions t ON c.customer_id = t.customer_id WHERE ra.risk_level = '高风险' AND t.amount > 500000 AND ra.assessment_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY c.customer_name;	4200581425
AMBIGUOUS_QUERY	4250954216
SELECT event_id, MAX(severity) FROM risk_events GROUP BY event_id;	3376384926
SELECT risk_level, COUNT(customer_id) AS customer_count, AVG(amount) AS avg_transaction_amount FROM customers JOIN transactions ON customers.customer_id = transactions.customer_id GROUP BY risk_level;	1863389546
SELECT a.*, al.audit_result FROM alerts a JOIN audit_logs al ON a.alert_id = al.alert_id WHERE al.auditor = '张强';	1527263926
SELECT actual_value, is_exceeding_threshold FROM risk_monitoring_logs JOIN risk_indicators ON risk_monitoring_logs.indicator_id = risk_indicators.indicator_id;	959044977
SELECT indicator_id, COUNT(*) AS exceed_count, AVG(actual_value - threshold_value) AS avg_exceed_value FROM risk_monitoring_logs WHERE is_exceeding_threshold = '是' AND monitoring_date LIKE '2023%' GROUP BY indicator_id;	3965887957
SELECT alert_id, status FROM alerts WHERE alert_time >= '2023-01-01' AND alert_time <= '2023-12-31';	1868278026
SELECT indicator_id, actual_value FROM risk_monitoring_logs WHERE (indicator_id, monitoring_date) IN (SELECT indicator_id, MAX(monitoring_date) FROM risk_monitoring_logs GROUP BY indicator_id);	739540706
SELECT indicator_id, COUNT(*) AS exceed_count, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM risk_monitoring_logs WHERE is_exceeding_threshold = '是' AND monitoring_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) AS exceed_percentage FROM risk_monitoring_logs WHERE is_exceeding_threshold = '是' AND monitoring_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY indicator_id ORDER BY exceed_count DESC LIMIT 10;	2175305749
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	2458944386
SELECT risk_score, status FROM transactions;	2707842138
SELECT ra.event_id FROM risk_assessments ra JOIN transactions t ON ra.event_id = t.event_id WHERE ra.risk_level = '高风险' AND t.risk_score < 50;	1192678488
SELECT transaction_type FROM transactions WHERE status = '成功' GROUP BY transaction_type ORDER BY COUNT(*) DESC LIMIT 1;	1326015635
SELECT * FROM transactions WHERE status = '失败' AND event_id IN (SELECT event_id FROM risk_events WHERE status = '已解决');	3710680886
SELECT t.transaction_id, c.customer_name, c.customer_type FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.status = '处理中';	581328064
SELECT t.transaction_id, r.event_id FROM transactions t JOIN risk_events r ON t.event_id = r.event_id WHERE t.amount > 1000;	3472554935
SELECT t.transaction_id, t.customer_id, t.amount, t.transaction_date, t.event_id, re.event_type, re.event_description, re.occurrence_time, re.severity, re.status, re.reporter, re.created_at FROM transactions t JOIN customers c ON t.customer_id = c.customer_id JOIN risk_events re ON t.event_id = re.event_id WHERE t.amount > 100000 AND c.risk_level = '高' AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);	72136253
SELECT * FROM risk_assessments WHERE mitigation_plan IS NOT NULL;	3778743836
SELECT transaction_id, customer_id, transaction_type, amount, transaction_date, status, risk_score FROM transactions WHERE customer_id IN (SELECT customer_id FROM customers WHERE risk_level = '高风险');	1975692082
SELECT rml.actual_value, ri.indicator_name FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id WHERE rml.actual_value < ri.threshold_value;	263024116
SELECT event_type, status FROM risk_reports JOIN risk_events ON risk_reports.event_id = risk_events.event_id WHERE approval_status = '已拒绝';	4272740433
SELECT DISTINCT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE YEAR(c.registration_date) = 2021 AND c.credit_score > 700 AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);	33599686
SELECT a.alert_id, a.alert_type, a.alert_content, a.alert_level, a.alert_time, a.status, a.assigned_to, r.event_type, r.event_description, r.occurrence_time, r.severity, r.status AS event_status, r.reporter, t.transaction_type, t.amount, t.transaction_date, t.status AS transaction_status, t.risk_score FROM alerts a JOIN risk_events r ON a.event_id = r.event_id JOIN transactions t ON r.event_id = t.event_id WHERE a.assigned_to = '陈强';	1531250861
SELECT * FROM risk_reports WHERE report_content LIKE '%合规%';	3898772643
SELECT SUBSTR(r.occurrence_time, 1, 7) AS month, COUNT(r.event_id) AS event_count, AVG(r.severity) AS avg_severity, COUNT(a.alert_id) AS alert_count FROM risk_events r LEFT JOIN alerts a ON r.event_id = a.event_id GROUP BY month;	3314311299
SELECT indicator_name, threshold_value FROM risk_indicators;	648920878
SELECT indicator_id, monitoring_date, actual_value, is_exceeding_threshold FROM (SELECT indicator_id, monitoring_date, actual_value, is_exceeding_threshold, ROW_NUMBER() OVER (PARTITION BY indicator_id ORDER BY monitoring_date DESC) AS rn FROM risk_monitoring_logs) t WHERE rn = 1;	2490177094
SELECT t.*, c.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.amount > 100000;	4125993810
SELECT * FROM risk_reports WHERE approval_status = '已批准';	1573849130
SELECT transaction_type, AVG(risk_score) FROM transactions GROUP BY transaction_type;	180382260
SELECT event_type, AVG(JULIANDAY(occurrence_time) - JULIANDAY(created_at)) AS avg_resolution_time, status, AVG(JULIANDAY(CASE WHEN status = '已解决' THEN occurrence_time ELSE datetime('now') END) - JULIANDAY(created_at)) AS avg_duration_per_status FROM risk_events GROUP BY event_type, status;	3666899871
SELECT alert_type, COUNT(*) AS alert_count, AVG(STRFTIME('%s', audit_logs.audit_time) - STRFTIME('%s', alerts.alert_time)) AS avg_processing_time FROM alerts JOIN audit_logs ON alerts.alert_id = audit_logs.alert_id GROUP BY alert_type;	3229183107
SELECT event_type, AVG(JULIANDAY(status) - JULIANDAY(created_at)) AS avg_processing_time FROM risk_events WHERE status = '已解决' GROUP BY event_type;	1330206790
SELECT a.alert_id, a.rule_id, r.status FROM alerts a JOIN risk_events r ON a.event_id = r.event_id;	1499863131
SELECT c.customer_name, COUNT(DISTINCT t.transaction_id) AS high_risk_transaction_count, COUNT(DISTINCT a.alert_id) AS high_level_alert_count FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN alerts a ON t.event_id = a.event_id WHERE t.risk_score > 80 AND t.transaction_date LIKE '2023%' AND a.alert_level = '高级' GROUP BY c.customer_name;	4020556557
SELECT risk_events.event_id, risk_events.severity, risk_assessments.risk_level FROM risk_events JOIN risk_assessments ON risk_events.event_id = risk_assessments.event_id;	2574806195
AMBIGUOUS_QUERY	368566951
SELECT customer_type, COUNT(*) FROM customers GROUP BY customer_type;	1635727552
SELECT ra.*, re.* FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id;	328924275
AMBIGUOUS_QUERY	206421261
SELECT c.customer_name, c.risk_level, t.transaction_date, t.amount, t.risk_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险' AND t.transaction_date = (SELECT MAX(transaction_date) FROM transactions WHERE customer_id = c.customer_id);	1632035738
SELECT transaction_type, COUNT(*) AS total_count, SUM(CASE WHEN status = '成功' THEN 1 ELSE 0 END) AS success_count FROM transactions GROUP BY transaction_type;	3886658963
SELECT event_id, mitigation_plan, assessor FROM risk_assessments WHERE risk_level = '高';	2797728174
SELECT customer_name FROM customers WHERE risk_level = '高' AND credit_score < 700;	4147622428
SELECT customer_id FROM customers WHERE risk_level = '高' AND credit_score < 600;	2005982395
SELECT risk_level, SUM(amount) FROM customers JOIN transactions ON customers.customer_id = transactions.customer_id WHERE status = '成功' GROUP BY risk_level;	2801172444
SELECT rr.report_id, rr.report_type, rr.report_date, rr.report_content, rr.author, rr.approval_status, rr.approved_by, rr.event_id, re.event_type, re.event_description, re.occurrence_time, re.severity, re.status, re.reporter, re.created_at FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approval_status = '已批准';	449712045
SELECT author FROM risk_reports GROUP BY author ORDER BY COUNT(*) DESC LIMIT 1;	3632195172
SELECT event_id, reporter FROM risk_events WHERE status = '未处理';	673496495
SELECT customer_name, last_update_date FROM customers WHERE registration_date > '2021-01-01';	1638441248
SELECT rr.report_id, rr.report_type, rr.report_date, rr.report_content, rr.author, rr.approval_status, rr.approved_by, rr.event_id, re.event_type, re.event_description, re.occurrence_time, re.severity, re.status, re.reporter, re.created_at FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approved_by = '高志远';	108772594
SELECT ri.indicator_id, rml.actual_value, ri.threshold_value, rml.monitoring_date FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id WHERE rml.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = ri.indicator_id);	4205470451
SELECT * FROM risk_monitoring_logs JOIN risk_indicators ON risk_monitoring_logs.indicator_id = risk_indicators.indicator_id;	3583518096
SELECT AVG(impact_score), AVG(probability_score) FROM risk_assessments;	2055776443
SELECT risk_events.event_id, risk_events.event_type, risk_assessments.assessor, risk_assessments.risk_level FROM risk_events INNER JOIN risk_assessments ON risk_events.event_id = risk_assessments.event_id WHERE risk_assessments.assessor IS NOT NULL;	3949000806
SELECT SUM(amount) FROM transactions WHERE transaction_type = '退款';	2492972672
SELECT ri.*, rml.* FROM risk_indicators ri LEFT JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id WHERE rml.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = ri.indicator_id);	3484790242
SELECT event_type, AVG(STRFTIME('%s', assessment_date)) AS avg_mitigation_time FROM risk_events JOIN risk_assessments ON risk_events.event_id = risk_assessments.event_id GROUP BY event_type;	1982804371
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	4285492578
SELECT ra.*, re.* FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id;	3769897631
SELECT COUNT(*) FROM risk_monitoring_logs WHERE is_exceeding_threshold = '是';	529242231
SELECT risk_events.event_id, risk_assessments.risk_level, risk_assessments.mitigation_plan FROM risk_events JOIN risk_assessments ON risk_events.event_id = risk_assessments.event_id;	3117545473
SELECT report_id, author FROM risk_reports WHERE approval_status = '已批准';	3370993536
SELECT customer_id, customer_name FROM customers WHERE risk_level = '高' AND credit_score > (SELECT AVG(credit_score) FROM customers);	1091114187
SELECT alert_content, assigned_to FROM alerts;	2742425726
SELECT event_description, severity, created_at, occurrence_time FROM risk_events WHERE status = '已解决' ORDER BY (JULIANDAY(occurrence_time) - JULIANDAY(created_at)) DESC LIMIT 10;	2894923077
SELECT rule_configurations.rule_id, rule_configurations.rule_name, risk_indicators.indicator_name FROM rule_configurations INNER JOIN risk_indicators ON rule_configurations.indicator_id = risk_indicators.indicator_id WHERE rule_configurations.is_active = '是';	1904439079
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	1764574936
SELECT event_id, reporter FROM risk_events WHERE status = '未处理';	517879622
SELECT event_id, created_at FROM risk_events WHERE severity >= 3;	2298203203
SELECT mitigation_plan, assessor FROM risk_assessments;	3327856710
SELECT a.alert_id, r.event_description, l.audit_comments FROM alerts a JOIN risk_events r ON a.event_id = r.event_id JOIN (SELECT alert_id, audit_comments FROM audit_logs WHERE alert_id IS NOT NULL ORDER BY audit_time DESC LIMIT 1) l ON a.alert_id = l.alert_id WHERE a.status = '未解决' AND a.alert_level = '高级别';	3186015417
SELECT event_id, mitigation_plan FROM risk_assessments WHERE risk_level = '高';	278998762
SELECT DISTINCT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险' AND t.amount > 100000 AND t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);	3967091987
SELECT * FROM risk_assessments WHERE impact_score > 8 AND risk_level = '高';	4092376057
SELECT risk_events.event_id, risk_events.event_type, risk_reports.report_type, risk_reports.report_content FROM risk_events JOIN risk_reports ON risk_events.event_id = risk_reports.event_id;	4193608347
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 2 AND rr.report_date BETWEEN '2023-07-01' AND '2023-09-30';	1848858966
SELECT report_id, institution_id FROM regulatory_reports WHERE submission_date = '2023-11-01';	4213891451
SELECT DISTINCT c.institution_id FROM capital_adequacy_ratio c JOIN non_performing_loans n ON c.institution_id = n.institution_id WHERE c.report_date = '2023-06-01' AND n.report_date = '2023-06-01' AND c.total_car < 12 AND n.npl_ratio > 2;	1479692348
SELECT fi.institution_name FROM risk_exposure re JOIN financial_institution_info fi ON re.institution_id = fi.institution_id ORDER BY (re.market_risk_exposure / re.total_risk_exposure) DESC LIMIT 1;	1995041708
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM regulatory_reports WHERE report_date BETWEEN '2023-07-01' AND '2023-09-30' AND report_type = '季度报告' AND approval_status = '需修改') AND registered_capital > 50000000;	963624927
SELECT institution_name, risk_weighted_assets / total_assets AS risk_weighted_asset_density FROM financial_institution_info JOIN capital_adequacy_ratio USING (institution_id) JOIN balance_sheet USING (institution_id) ORDER BY risk_weighted_asset_density DESC LIMIT 1;	1658477082
SELECT liquidity_coverage_ratio, net_stable_funding_ratio FROM liquidity_ratio;	4132703668
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM compliance_records WHERE report_date >= '2023-12-01' AND report_date < '2024-01-01' AND status = '未解决');	3320395647
SELECT loans_and_advances, deposits FROM balance_sheet WHERE YEAR(report_date) = 2024;	1564305915
SELECT * FROM balance_sheet WHERE report_date = '2039-06-08';	4026702014
SELECT COUNT(DISTINCT institution_id) FROM non_performing_loans WHERE npl_ratio > 3;	512893913
SELECT net_interest_income, non_interest_income FROM income_statement WHERE report_date = '2023-03-01';	387964381
SELECT npl_amount / total_loans FROM non_performing_loans;	392823504
SELECT DISTINCT rr.institution_id FROM regulatory_reports rr JOIN non_performing_loans npl ON rr.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND YEAR(rr.report_date) = 2023 AND YEAR(npl.report_date) = 2023 AND npl.npl_ratio > 1;	2013521148
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM regulatory_reports WHERE report_date = '2023-10-01' AND report_type = '半年度报告' AND approval_status = '待审核');	1920599339
SELECT institution_name FROM financial_institution_info WHERE institution_type = '非银行金融机构' ORDER BY registered_capital DESC LIMIT 5;	2173229598
SELECT COUNT(DISTINCT b.institution_id) FROM balance_sheet b JOIN non_performing_loans n ON b.institution_id = n.institution_id WHERE b.balance_sheet_id IN (SELECT balance_sheet_id FROM balance_sheet ORDER BY total_assets DESC LIMIT 500) AND n.npl_ratio < 1 AND n.provision_coverage_ratio > 200;	1986299311
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE car.core_tier_1_ratio < 10 AND rr.approval_status = '待审核' AND car.report_date = '2023-12-01' AND rr.report_date = '2023-12-01';	1934474274
SELECT fi.institution_name FROM financial_institution_info fi JOIN (SELECT i1.institution_id, ((i2.net_interest_income + i2.non_interest_income) - (i1.net_interest_income + i1.non_interest_income)) / (i1.net_interest_income + i1.non_interest_income) AS revenue_growth, (i2.net_profit - i1.net_profit) / i1.net_profit AS profit_growth FROM income_statement i1 JOIN income_statement i2 ON i1.institution_id = i2.institution_id AND i1.report_date = '2021-12-31' AND i2.report_date = '2022-12-31') growth ON fi.institution_id = growth.institution_id ORDER BY growth.revenue_growth DESC, growth.profit_growth ASC LIMIT 1;	3102250159
SELECT report_type, approval_status FROM regulatory_reports WHERE report_date = '2023-07-01';	3066710012
SELECT institution_id FROM capital_adequacy_ratio WHERE core_tier_1_ratio > (SELECT AVG(core_tier_1_ratio) FROM capital_adequacy_ratio) AND tier_1_ratio > (SELECT AVG(tier_1_ratio) FROM capital_adequacy_ratio) AND total_car > (SELECT AVG(total_car) FROM capital_adequacy_ratio);	3079904075
SELECT * FROM compliance_records WHERE YEAR(record_date) = 2023 AND status = '已解决';	2257683611
SELECT report_type FROM regulatory_reports WHERE report_date >= '2023-07-01' AND report_date <= '2023-09-30' GROUP BY report_type ORDER BY COUNT(*) DESC LIMIT 1;	722775591
SELECT tier_1_ratio FROM capital_adequacy_ratio;	692012487
SELECT fi.institution_name, lr.report_date FROM liquidity_ratio lr JOIN financial_institution_info fi ON lr.institution_id = fi.institution_id WHERE lr.liquidity_coverage_ratio > 100;	3599351686
SELECT institution_id, liquidity_coverage_ratio FROM liquidity_ratio WHERE institution_id IN (SELECT institution_id FROM (SELECT institution_id, STDDEV(total_liabilities / total_assets) AS asset_liability_volatility FROM balance_sheet WHERE report_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR) GROUP BY institution_id ORDER BY asset_liability_volatility DESC LIMIT 5) AS top_5_institutions) AND report_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);	3317302935
SELECT compliance_type, severity FROM compliance_records WHERE record_date >= '2023-03-01' AND record_date < '2023-04-01';	3773444090
SELECT compliance_type, severity FROM compliance_records WHERE YEAR(record_date) = 2024;	1568439599
SELECT report_type FROM regulatory_reports WHERE report_date = '2023-10-01';	2339192001
SELECT * FROM compliance_records WHERE YEAR(record_date) = 2023 AND severity = '中';	1629609477
SELECT status FROM compliance_records WHERE record_date = '2023-10-01';	3577134167
SELECT institution_id FROM liquidity_ratio WHERE liquidity_coverage_ratio > (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio) AND net_stable_funding_ratio > (SELECT AVG(net_stable_funding_ratio) FROM liquidity_ratio) AND loan_to_deposit_ratio > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio);	1942470085
SELECT fi.institution_name, rr.report_type, rr.submission_date FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id WHERE rr.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND rr.approval_status = '需修改' ORDER BY rr.submission_date DESC;	385930717
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE car.total_car < (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_car) FROM capital_adequacy_ratio) AND npl.npl_ratio < (SELECT AVG(npl_ratio) FROM non_performing_loans);	528420038
SELECT registered_capital, institution_type FROM financial_institution_info;	2513164587
SELECT establishment_date, legal_representative FROM financial_institution_info;	1975090084
SELECT * FROM compliance_records WHERE status = '已解决';	107672657
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND rr.approval_status = '需修改' AND npl.npl_ratio > 1;	1483363664
SELECT institution_id FROM balance_sheet ORDER BY ABS(loans_and_advances / deposits - 1) LIMIT 1;	2929840073
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM non_performing_loans WHERE total_loans > 100000000000);	1300789994
SELECT cash_and_equivalents FROM balance_sheet WHERE report_date = '2026-04-27';	2165898338
SELECT institution_id FROM capital_adequacy_ratio WHERE core_tier_1_ratio < 9;	3755218299
SELECT DISTINCT rr.institution_id FROM regulatory_reports rr JOIN non_performing_loans npl ON rr.institution_id = npl.institution_id WHERE YEAR(rr.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝' AND YEAR(npl.report_date) = 2023 AND npl.npl_ratio > 2;	523740688
SELECT COUNT(DISTINCT b.institution_id) FROM (SELECT c.institution_id FROM capital_adequacy_ratio c JOIN balance_sheet b ON c.institution_id = b.institution_id AND c.report_date = b.report_date ORDER BY (c.risk_weighted_assets / b.total_assets) DESC LIMIT 10) AS top_institutions JOIN risk_exposure r ON top_institutions.institution_id = r.institution_id WHERE r.market_risk_exposure > 1000;	3766160186
SELECT NULL;	3227551380
SELECT DISTINCT re.institution_id FROM risk_exposure re JOIN capital_adequacy_ratio car ON re.institution_id = car.institution_id WHERE (re.market_risk_exposure / re.total_risk_exposure) > 0.2 AND car.core_tier_1_ratio < 8.5;	2211928222
SELECT fii.institution_name, car.core_tier_1_ratio, car.tier_1_ratio, car.total_car FROM financial_institution_info fii JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id WHERE car.report_date = '2023-12-01' AND car.core_tier_1_ratio < 10 AND car.total_car < 12;	1570037252
SELECT COUNT(*) FROM compliance_records WHERE severity = '高' AND EXTRACT(YEAR FROM record_date) = 2023;	1995720794
SELECT institution_name FROM financial_institution_info WHERE institution_id = (SELECT institution_id FROM balance_sheet ORDER BY (cash_and_equivalents / total_assets) DESC LIMIT 1);	2276785796
SELECT institution_id FROM risk_exposure WHERE (market_risk_exposure / total_risk_exposure) > 0.4;	1118569576
SELECT institution_id FROM regulatory_reports WHERE YEAR(report_date) = 2023 ORDER BY LENGTH(comments) DESC LIMIT 1;	201491443
SELECT DISTINCT fii.institution_name FROM financial_institution_info fii JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE car.core_tier_1_ratio < 8 AND rr.approval_status = '已批准' AND YEAR(car.report_date) = 2023 AND YEAR(rr.report_date) = 2023;	883311234
SELECT credit_risk_exposure, operational_risk_exposure FROM risk_exposure WHERE report_date >= '2024-01-01' AND report_date < '2024-02-01';	1131673647
SELECT description, severity FROM compliance_records WHERE record_date = '2023-04-02';	626463466
SELECT npl_ratio FROM non_performing_loans ORDER BY report_date;	4144375691
SELECT institution_id, provision_coverage_ratio FROM non_performing_loans WHERE provision_coverage_ratio > 150;	3229296369
SELECT * FROM related_party_transactions WHERE transaction_date = '2023-12-22';	386496319
SELECT fi.institution_name FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE lr.liquidity_coverage_ratio > 110 AND npl.npl_ratio < 1.5;	1091949185
SELECT DISTINCT fii.institution_name FROM regulatory_reports rr JOIN non_performing_loans npl ON rr.institution_id = npl.institution_id AND YEAR(rr.report_date) = 2023 JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 2;	2649798001
SELECT institution_id FROM income_statement WHERE report_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR) GROUP BY institution_id ORDER BY AVG(net_profit / (net_interest_income + non_interest_income)) DESC LIMIT 5;	3441420122
SELECT institution_type, AVG(npl_ratio) FROM financial_institution_info JOIN non_performing_loans ON financial_institution_info.institution_id = non_performing_loans.institution_id WHERE YEAR(report_date) = 2023 GROUP BY institution_type;	3747732181
SELECT COUNT(DISTINCT re.institution_id) FROM risk_exposure re JOIN capital_adequacy_ratio car ON re.institution_id = car.institution_id AND re.report_date = car.report_date WHERE (re.market_risk_exposure - LAG(re.market_risk_exposure) OVER (PARTITION BY re.institution_id ORDER BY re.report_date)) / LAG(re.market_risk_exposure) OVER (PARTITION BY re.institution_id ORDER BY re.report_date) > 0.5 AND (car.total_car - LAG(car.total_car) OVER (PARTITION BY car.institution_id ORDER BY car.report_date)) < 1;	919872126
SELECT total_assets, total_liabilities FROM balance_sheet;	2908646442
SELECT DISTINCT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN related_party_transactions rpt ON fii.institution_id = rpt.institution_id WHERE rr.approval_status = '需修改' AND rpt.transaction_amount > 5000000 AND (rr.report_date BETWEEN '2023-07-01' AND '2023-07-31' OR rpt.transaction_date BETWEEN '2023-07-01' AND '2023-07-31');	2285587483
SELECT AVG(total_car) FROM capital_adequacy_ratio WHERE institution_id IN (SELECT institution_id FROM balance_sheet WHERE total_assets > 1000000000000);	649523026
SELECT * FROM risk_exposure WHERE report_date = '2023-10-01';	3485650704
SELECT DISTINCT fii.institution_name FROM related_party_transactions rpt JOIN regulatory_reports rr ON rpt.institution_id = rr.institution_id JOIN financial_institution_info fii ON rpt.institution_id = fii.institution_id WHERE rpt.transaction_date = '2023-06-01' AND rpt.transaction_amount > 5000000 AND rr.report_date = '2023-06-01' AND rr.approval_status = '已批准';	1308426053
SELECT b.total_assets, c.total_car FROM balance_sheet b JOIN capital_adequacy_ratio c ON b.institution_id = c.institution_id AND b.report_date = c.report_date;	2884378083
SELECT fi.institution_name FROM financial_institution_info fi JOIN (SELECT institution_id, COUNT(CASE WHEN approval_status = '未通过' THEN 1 END) * 1.0 / COUNT(*) AS unapproved_ratio FROM related_party_transactions WHERE YEAR(transaction_date) = 2023 GROUP BY institution_id HAVING unapproved_ratio > 0.2) rpt ON fi.institution_id = rpt.institution_id;	443478039
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 2;	4005725614
SELECT r.institution_id, r.approval_status, c.compliance_type FROM regulatory_reports r JOIN compliance_records c ON r.institution_id = c.institution_id WHERE YEAR(r.report_date) = 2023 AND YEAR(c.record_date) = 2023;	4256634062
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' AND npl.npl_ratio > 2;	2610777117
SELECT institution_id, liquidity_coverage_ratio, net_stable_funding_ratio FROM liquidity_ratio WHERE report_date = '2023-05-01';	1523818846
SELECT institution_id, SUM(non_interest_income) FROM income_statement WHERE report_date = '2023-03-01' GROUP BY institution_id;	959939959
SELECT * FROM risk_exposure WHERE report_date = '2023-02-01';	1728769608
SELECT COUNT(*) FROM related_party_transactions WHERE YEAR(transaction_date) = 2023 AND transaction_amount > 500000000 AND transaction_type = '资产转移';	192754968
SELECT DISTINCT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN related_party_transactions rpt ON fii.institution_id = rpt.institution_id WHERE rr.report_date = '2023-08-01' AND rr.approval_status = '需修改' AND rpt.transaction_amount > 5000000;	1423558555
SELECT DISTINCT rr.institution_id FROM regulatory_reports rr JOIN income_statement is ON rr.institution_id = is.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '已拒绝' AND YEAR(rr.report_date) = 2023 AND YEAR(is.report_date) = 2023 AND QUARTER(is.report_date) = 1 AND is.net_profit > 10000000;	1234119757
SELECT institution_id FROM regulatory_reports WHERE report_date = '2023-07-01' AND approval_status = '需要修改';	4123846713
SELECT * FROM compliance_records WHERE compliance_type = '内控管理';	2934745000
SELECT DISTINCT rr.institution_id FROM regulatory_reports rr JOIN non_performing_loans npl ON rr.institution_id = npl.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' AND rr.approval_status = '待审核' AND npl.npl_ratio > 1;	2857258268
SELECT institution_type, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl_ratio) AS median_npl_ratio FROM financial_institution_info JOIN non_performing_loans ON financial_institution_info.institution_id = non_performing_loans.institution_id GROUP BY institution_type;	3135361103
SELECT * FROM capital_adequacy_ratio WHERE core_tier_1_ratio < 8;	2627561757
SELECT institution_name FROM regulatory_reports JOIN financial_institution_info ON regulatory_reports.institution_id = financial_institution_info.institution_id WHERE YEAR(report_date) = 2023 AND report_type = '半年度报告' AND approval_status = '待审核' AND registered_capital > 50000000;	1691256900
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM related_party_transactions WHERE transaction_date = '2023-06-01' AND transaction_amount > 5000000 AND approval_status = '待审批');	3500907449
SELECT institution_id FROM liquidity_ratio WHERE loan_to_deposit_ratio > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio) AND liquidity_coverage_ratio < (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio);	1148055259
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM income_statement WHERE report_date = '2023-04-01' AND net_interest_income > 1000000000);	2380032898
SELECT DISTINCT rr.institution_id FROM regulatory_reports rr JOIN non_performing_loans npl ON rr.institution_id = npl.institution_id WHERE YEAR(rr.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND YEAR(npl.report_date) = 2023 AND npl.npl_ratio > 0.01;	3197865400
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE re.report_date = '2023-10-01' AND car.report_date = '2023-10-01' AND re.total_risk_exposure > 3000 AND car.core_tier_1_ratio < 8;	1039966050
SELECT COUNT(DISTINCT institution_id) FROM risk_exposure WHERE report_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND (market_risk_exposure / credit_risk_exposure) <> (SELECT market_risk_exposure / credit_risk_exposure FROM risk_exposure WHERE institution_id = risk_exposure.institution_id AND report_date < DATE_SUB(CURDATE(), INTERVAL 1 YEAR) ORDER BY report_date DESC LIMIT 1);	198071887
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM balance_sheet WHERE loans_and_advances > deposits);	1236237152
SELECT fi.institution_name, rr.report_date, rr.approval_status FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id WHERE YEAR(rr.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	968909295
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM income_statement WHERE report_date = '2023-04-01' AND non_interest_income > 200000000);	2730335394
SELECT institution_id FROM related_party_transactions WHERE transaction_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY institution_id ORDER BY COUNT(transaction_id) DESC LIMIT 1;	3396337586
SELECT fi.institution_name, (re.credit_risk_exposure / re.total_risk_exposure) AS ratio FROM risk_exposure re JOIN financial_institution_info fi ON re.institution_id = fi.institution_id ORDER BY ratio DESC LIMIT 1;	3597519580
SELECT DISTINCT institution_id FROM risk_exposure WHERE YEAR(report_date) = 2023;	3614967513
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE car.report_date = '2023-11-01' AND car.risk_weighted_assets > 120000000000;	2748780530
SELECT severity, resolution_date FROM compliance_records;	2632158975
SELECT COUNT(DISTINCT institution_id) FROM liquidity_ratio WHERE liquidity_coverage_ratio > 100 AND net_stable_funding_ratio > 100;	2902591324
SELECT AVG(npl.npl_ratio) AS avg_npl_ratio, AVG(npl.provision_coverage_ratio) AS avg_provision_coverage_ratio, AVG(car.total_car) AS avg_total_car FROM (SELECT institution_id FROM balance_sheet ORDER BY total_assets DESC LIMIT 1000) AS top_assets JOIN non_performing_loans AS npl ON top_assets.institution_id = npl.institution_id JOIN capital_adequacy_ratio AS car ON top_assets.institution_id = car.institution_id;	1348038828
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND npl.npl_ratio > 1.5 AND rr.report_date = '2023-07-01' AND npl.report_date = '2023-07-01';	3607596195
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2024-01-01' AND rr.report_type = '年度报告' AND rr.approval_status = '已批准' AND npl.npl_ratio > 1;	3633299910
SELECT lr.loan_to_deposit_ratio, bs.loans_and_advances, bs.deposits FROM liquidity_ratio lr JOIN balance_sheet bs ON lr.institution_id = bs.institution_id AND lr.report_date = bs.report_date;	1922989461
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM non_performing_loans WHERE npl_ratio > 1.5 AND report_date = '2023-12-01');	2401722243
SELECT institution_id FROM liquidity_ratio WHERE loan_to_deposit_ratio > 75 AND liquidity_coverage_ratio < 120;	2405354254
SELECT * FROM regulatory_reports WHERE report_type = '半年度报告';	4266831229
SELECT record_id FROM compliance_records ORDER BY (resolution_date - record_date) DESC LIMIT 5;	1742014679
SELECT DISTINCT rr.institution_id FROM regulatory_reports rr JOIN non_performing_loans npl ON rr.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '已拒绝' AND YEAR(rr.report_date) = 2023 AND npl.npl_ratio > 2 AND YEAR(npl.report_date) = 2023;	3817977186
