SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-13' AND d.name = '客户服务部' AND (a.check_out - a.check_in) > '15:00:00'::interval;	2499788398
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-11' AND a.check_in > '09:00:00';	2790038483
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H03961' AND EXTRACT(YEAR FROM date) = 2024 AND check_in > '09:00:00';	1518250136
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in < '08:30:00' AND p.rating = 'A+';	2290175818
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-05';	1543926007
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-21' ORDER BY d.name;	3053690473
SELECT COUNT(*) FILTER (WHERE end_date - start_date < 90 AND status = '离职') * 100.0 / COUNT(*) AS 离职比例 FROM probation_employees;	1446084728
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-08' AND d.name = '客户服务部' AND a.check_in > '09:00:00';	2505330870
SELECT e.name, e.hire_date FROM employees e INNER JOIN probation_employees p ON e.employee_id = p.employee_id;	77372189
SELECT d.name, e.name, a.check_in, e.remaining_annual_leave FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00' AND e.remaining_annual_leave < 5;	1298859483
SELECT e.name, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-10-05';	569704912
SELECT e.name, e.hire_date, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-09-26' AND p.evaluation_date = (SELECT MAX(evaluation_date) FROM performance_evaluations WHERE employee_id = e.employee_id);	399196427
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H05598' AND date BETWEEN '2024-01-01' AND '2024-12-31' AND check_out < '18:00:00';	2805240810
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-28' AND ar.check_in > '09:00:00';	3848816814
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '运营部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	2544920386
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-11' AND ar.check_in > '09:00:00';	2048034491
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-21' AND a.check_in > '09:00:00' AND d.name = '销售部';	1501079200
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-12-11' AND pe.rating = 'C';	1654155358
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-22' AND ar.check_in > '09:00:00';	1952426931
SELECT a.employee_id, e.name, a.award_name, pe.rating FROM awards a INNER JOIN employees e ON a.employee_id = e.employee_id INNER JOIN performance_evaluations pe ON a.employee_id = pe.employee_id WHERE a.year = 2023 AND a.award_name = '创新奖' AND pe.rating = 'A+';	3946055885
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-09' AND a.check_in > '08:30:00';	2952516110
SELECT COUNT(DISTINCT pe.employee_id) FROM probation_employees pe JOIN awards a ON pe.employee_id = a.employee_id WHERE pe.start_date >= '2023-01-01' AND pe.end_date <= '2023-12-31' AND a.year = 2023 AND a.award_name = '优秀员工奖';	3989733729
SELECT e.name, a.award_name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2021 AND a.year = 2022;	241703514
SELECT DISTINCT employee_id FROM attendance_records GROUP BY employee_id, date HAVING COUNT(*) > 1;	4110426671
SELECT d.name, e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-24' AND a.check_in > '09:30:00' AND e.remaining_annual_leave < 10;	1958968748
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-19' AND d.name = '销售部' AND a.check_in > '09:00:00';	1261641813
SELECT d.name, e.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-26' AND ar.check_in > '09:00:00' AND pe.rating = 'C';	1404049949
SELECT e.name, a.award_name, pe.rating FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2021 AND a.year = 2021 AND pe.rating = 'B';	860878506
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '销售部' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	1830063336
SELECT e.name, p.status FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN probation_employees p ON e.employee_id = p.employee_id WHERE a.year = 2020 AND a.award_name = '优秀员工' AND p.status = '试用中' AND CURRENT_DATE BETWEEN p.start_date AND p.end_date;	1384865982
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE e.hire_date BETWEEN '2023-01-01' AND '2023-12-31' AND a.year = 2023 AND pe.rating = 'A+';	3542777151
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN probation_employees p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND '2024-09-19' BETWEEN p.start_date AND p.end_date;	1253418500
SELECT e.employee_id, e.name, e.hire_date, e.remaining_annual_leave, COUNT(a.id) FROM employees e LEFT JOIN attendance_records a ON e.employee_id = a.employee_id GROUP BY e.employee_id, e.name, e.hire_date, e.remaining_annual_leave;	1306743539
SELECT e.name, a.date, a.check_in, a.check_out FROM employees e JOIN awards aw ON e.employee_id = aw.employee_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE aw.year = 2022 AND aw.award_name = '技术突破奖' AND (a.check_out - a.check_in) > interval '10 hours';	1998735563
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-20' AND a.check_out - a.check_in > interval '8 hours';	3735871221
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-25' AND a.check_in < '09:00:00';	392713451
SELECT e.name FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE pe.rating = 'A+' GROUP BY e.name ORDER BY AVG(ar.check_out - ar.check_in) DESC LIMIT 1;	3464604281
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-04' AND d.name = '销售部' AND a.check_in > '09:00:00';	1444696553
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-18' AND a.check_in > '09:00:00' AND p.rating = 'D';	2023290915
SELECT e.name, a.check_in, p.rating FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-25' AND a.check_in > '08:30:00' AND p.rating = 'B+';	3746804657
SELECT * FROM interviews WHERE EXTRACT(YEAR FROM interview_date) = 2024 ORDER BY interview_count;	72949237
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '08:30:00' AND p.rating = 'A+';	1155706622
SELECT d.name, e.name, a.check_in, e.remaining_annual_leave FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-27' AND a.check_in > '09:00:00' AND e.remaining_annual_leave < 10;	638989138
SELECT e.name, p.evaluation_date FROM employees e LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id;	2390401103
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-07' AND a.check_in > '09:00:00' AND a.check_out < '17:00:00';	78855873
SELECT e.name, d.name, ar.check_in, ar.check_out FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-05';	3197959623
SELECT e.department_id, AVG(i.interview_count) FROM employees e JOIN interviews i ON e.employee_id = i.employee_id GROUP BY e.department_id ORDER BY AVG(i.interview_count) DESC LIMIT 1;	3699728041
SELECT e.name, e.employee_id, a.date, a.check_in, a.check_out, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-27' AND p.rating = 'A+';	3065616199
SELECT e.name, a.check_in FROM employees e JOIN awards aw ON e.employee_id = aw.employee_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE aw.year = 2024 AND aw.award_name = '最佳团队奖' AND a.date = '2024-10-09' AND a.check_in > '09:00:00';	1681003052
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON a.employee_id = e.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-10-14' AND a.check_in > '09:00:00';	4050465535
SELECT e.name, a.check_out, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_out > '13:00:00' AND p.rating = 'B+';	4249036992
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-08' AND ar.check_in > '09:00:00';	592982415
SELECT e.name, d.name, a.award_name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2022;	3584914350
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND a.check_in > '09:00:00' AND p.rating = 'D' AND p.evaluation_date = (SELECT MAX(evaluation_date) FROM performance_evaluations WHERE employee_id = e.employee_id);	1423306349
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-13' AND e.university = '清华大学' AND a.check_in < '09:30:00';	2203283189
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-22';	3865699446
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND pe.rating = 'A+';	1909210649
SELECT e.name, e.employee_id, a.check_in, d.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-05' AND a.check_in > '08:30:00' AND d.manager_id = 'H05487';	2144085984
SELECT e.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-02' AND (a.check_out - a.check_in) > interval '9 hours';	283013543
SELECT d.name, e.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-03-31' AND pe.rating = 'D';	214548501
SELECT name, car_plate FROM employees WHERE employee_type = '正式';	3902051234
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-19' AND d.name = '质量控制部' AND a.check_in > '09:00:00';	4268232257
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '客户满意度奖' AND ar.date = '2024-10-12' AND ar.check_in > '09:00:00';	2777106158
SELECT e.name, e.employee_id, a.check_in, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00:00' AND d.manager_id = 'H00842';	932008813
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2023 AND a.award_name = '领导力奖';	3805690652
SELECT e.name, a.check_in FROM awards aw JOIN attendance_records a ON aw.employee_id = a.employee_id JOIN employees e ON a.employee_id = e.employee_id WHERE aw.year = 2023 AND aw.award_name = '领导力奖' AND a.date = '2024-10-09' AND a.check_in > '09:00:00';	795140600
SELECT e.name, d.name, d.manager_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE e.employee_type = '实习生' AND a.date = '2024-10-02' AND a.check_in BETWEEN '09:00:00' AND '10:00:00';	3086085668
SELECT d.name FROM employees e JOIN departments d ON e.department_id = d.department_id GROUP BY d.name ORDER BY AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.birth_date))) DESC LIMIT 1;	2411560883
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-16' AND p.rating = 'C';	3743308464
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '研发部' AND a.date = '2024-10-08' AND a.check_in > '09:00:00';	439444083
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-20' AND d.name = '财务部' AND a.check_in > '09:00:00';	3252922075
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '人力资源部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > interval '8 hours';	1549624018
SELECT e.name, e.employee_id, a.date, a.check_in, a.check_out, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-14' AND p.rating = 'A+';	261206730
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-09-27' AND a.check_in > '09:00:00';	1406124018
SELECT d.name, COUNT(e.employee_id) FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.name;	1273187788
SELECT e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.rating = 'A+' ORDER BY e.hire_date DESC LIMIT 1;	161130038
SELECT e.employee_id, e.name, e.department_id, a.total_hours, d.avg_hours, ABS(a.total_hours - d.avg_hours) FROM employees e JOIN (SELECT employee_id, SUM(EXTRACT(EPOCH FROM (check_out - check_in))/3600) AS total_hours FROM attendance_records GROUP BY employee_id) a ON e.employee_id = a.employee_id JOIN (SELECT e.department_id, AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) AS avg_hours FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id GROUP BY e.department_id) d ON e.department_id = d.department_id ORDER BY ABS(a.total_hours - d.avg_hours) DESC;	2367131410
SELECT e.name, e.employee_id, a.check_in, a.check_out, (a.check_out - a.check_in) FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '研发部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > '10:00:00';	736904101
SELECT e.name, d.name, pe.rating FROM employees e INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id INNER JOIN departments d ON e.department_id = d.department_id INNER JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-10-12';	87083721
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND d.name = '销售部' AND a.check_in > '09:00:00';	1391282019
SELECT e.name, d.name, ar.check_in, a.award_name FROM employees e INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id INNER JOIN departments d ON e.department_id = d.department_id INNER JOIN awards a ON e.employee_id = a.employee_id WHERE ar.date = '2024-09-26' AND ar.check_in > '09:00:00' AND a.year = 2024 AND a.award_name IS NOT NULL;	1614124608
SELECT e.name, e.employee_id, a.check_in, p.rating FROM employees e INNER JOIN attendance_records a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-05' AND a.check_in > '09:00:00' AND p.rating = 'A+';	119065582
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-07' AND a.check_in > '09:00:00';	305429407
SELECT e.name, d.name, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND e.employee_type = '实习生' AND a.check_in <= '09:00:00';	1434754295
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工奖' AND pe.rating = 'A+';	1416753262
SELECT e.department_id, COUNT(DISTINCT pe.employee_id) FROM awards a JOIN performance_evaluations pe ON a.employee_id = pe.employee_id JOIN employees e ON a.employee_id = e.employee_id WHERE a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5 AND pe.rating = '优秀' GROUP BY e.department_id;	1966520829
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '新人奖' AND ar.date = '2024-10-08';	3742208647
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-02' AND a.check_in > '09:00:00' AND p.rating = 'A+';	681058956
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2024 AND a.award_name = '新人奖';	3929652777
SELECT AVG(EXTRACT(YEAR FROM AGE(e.start_work_date, e.hire_date))) FROM employees e JOIN departments d ON e.employee_id = d.manager_id;	2290314264
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-06' AND (a.check_out - a.check_in) > interval '10 hours';	2118323252
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE a.year = 2023 AND a.award_name = '技术突破奖' AND pe.rating = 'A+';	1087843451
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND a.check_in > '09:00:00' AND p.rating = 'D';	386106206
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '项目管理奖' AND ar.date = '2024-10-03';	855220810
SELECT e.name, e.hire_date, a.award_name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND e.hire_date > '2017-12-31';	3375057924
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-16' AND a.check_out - a.check_in > interval '8 hours';	4174232427
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND p.evaluation_date = '2023-06-04' AND p.rating = 'D';	734321783
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-12' AND d.name = '客户服务部' AND a.check_in > '09:00:00';	1241353029
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-21' AND a.check_in > '09:00:00' AND p.rating = 'B';	3667177289
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-24' AND ar.check_in > '09:00:00' AND pe.rating = 'C';	4273970415
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > interval '9 hours';	323611946
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-06' AND a.check_in > '09:00:00';	2940103155
SELECT e.name, d.name, d.manager_id FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.rating = 'A+' AND pe.evaluation_date BETWEEN '2023-01-01' AND '2023-12-31';	434694019
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:00:00' AND p.rating = 'A';	1289703363
SELECT ar.id, ar.employee_id, ar.date, ar.check_in, ar.check_out FROM attendance_records ar INNER JOIN awards a ON ar.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND ar.date = '2024-10-01';	1722398575
SELECT e.department_id, e.employee_id, e.name, MIN(pe.evaluation_date - e.hire_date) FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE pe.rating = 'A+' GROUP BY e.department_id, e.employee_id, e.name HAVING MIN(pe.evaluation_date - e.hire_date) = (SELECT MIN(pe2.evaluation_date - e2.hire_date) FROM employees e2 JOIN performance_evaluations pe2 ON e2.employee_id = pe2.employee_id WHERE pe2.rating = 'A+' AND e2.department_id = e.department_id GROUP BY e2.department_id);	804493985
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00';	1306450278
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE a.year = 2024 AND a.award_name = '优秀员工' AND pe.rating = 'A+';	1414070332
SELECT e.name, d.name, pe.rating FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-10-29';	3925025909
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-17' AND (a.check_out - a.check_in) > interval '9 hours';	1398775192
SELECT e.name, d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2022-06-16' AND p.rating = 'C';	2656339281
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2022 AND a.award_name = '优秀员工' AND p.evaluation_date = '2022-10-30' AND p.rating = 'A+';	3627252999
SELECT e.name, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-15' AND a.check_in > '09:00:00' AND p.rating = 'B';	2285040147
SELECT e.name, e.position FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE d.name = '销售部';	3934214389
SELECT e.name, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-23' AND a.check_in >= '09:00:00' AND p.rating = 'D';	1649684433
SELECT e.name, e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '客户服务部' AND p.rating = 'D' AND p.evaluation_date = '2024-10-14';	1300169145
SELECT e.name, e.hire_date, a.award_name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND e.hire_date >= '2019-01-01';	3467712746
SELECT d.name, e.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON ar.employee_id = e.employee_id JOIN performance_evaluations pe ON pe.employee_id = e.employee_id WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00:00' AND pe.rating = 'A+';	225648923
SELECT e.employee_id, e.name FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN awards a ON e.employee_id = a.employee_id WHERE pe.rating = '一般';	3415487094
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in BETWEEN '08:00:00' AND '09:00:00' AND p.rating = 'B';	1027352926
SELECT e.employee_id, e.name 
FROM employees e 
JOIN (
    SELECT employee_id, evaluation_date, rating,
           ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY evaluation_date DESC) as rn
    FROM performance_evaluations
) pe ON e.employee_id = pe.employee_id AND pe.rn = 1
WHERE pe.evaluation_date < '2024-01-01' AND pe.rating = 'B';	3444450310
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND a.check_in > '09:00:00' AND p.rating = 'B+';	73955891
SELECT e.name, d.name, a.check_in, a.check_out, (a.check_out - a.check_in) FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-24' AND (a.check_out - a.check_in) > INTERVAL '12 hours';	2221450098
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-29' AND a.check_in < '09:00:00';	2070780775
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00:00' AND p.rating = 'A';	1554709262
AMBIGUOUS_QUERY	706296760
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '厦门大学' AND a.date = '2024-09-23' AND a.check_in > '09:00:00';	392591213
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND a.check_in > '09:00:00' AND p.rating = 'D';	3172283899
SELECT e.name, e.employee_id, a.date, a.check_in FROM employees e INNER JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-11' AND a.check_in > '08:30:00';	988606028
SELECT e.name, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '09:00:00' AND p.rating = 'D';	2714488838
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE e.hire_date BETWEEN '2024-01-01' AND '2024-12-31' AND a.year = 2024 AND a.award_name = '新人奖' AND pe.rating = 'A';	4248175692
SELECT e.name, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-26' AND a.check_in BETWEEN '08:00:00' AND '09:00:00' AND p.rating = 'B+';	302928867
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '创新奖' AND ar.date = '2024-09-25';	886106357
SELECT e.name, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00:00' AND p.rating = 'D';	4026541630
SELECT d.name, AVG(e.remaining_annual_leave) FROM departments d JOIN employees e ON d.department_id = e.department_id WHERE d.manager_id = 'H03372' GROUP BY d.name;	1802079912
SELECT e.name, a.date, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND p.rating = 'A+';	865528666
SELECT e.name, a.date, a.check_in FROM awards aw JOIN attendance_records a ON aw.employee_id = a.employee_id JOIN employees e ON a.employee_id = e.employee_id WHERE aw.year = 2023 AND aw.award_name = '质量改进奖' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	4061141103
SELECT e.name, e.employee_id, d.name, pe.rating FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE d.name = '财务部' AND pe.rating = 'A+';	2313524982
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '质量控制部' AND a.date = '2024-09-21'::date AND a.check_in > '09:00:00'::time;	1992247421
SELECT e.name, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-25' AND d.name = '销售部' AND (a.check_out - a.check_in) > '08:00:00';	165828985
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE a.year = 2022 AND a.award_name = '技术突破奖' AND pe.evaluation_date > '2022-07-13';	2853735999
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '财务部' AND a.date = '2024-10-11' AND a.check_in > '09:00:00';	2393343950
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	541232515
SELECT DISTINCT d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-08-06' AND pe.rating = 'C';	2805706885
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-01' AND (a.check_out - a.check_in) > interval '12 hours';	642307462
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-09' AND a.check_in > '09:00:00' AND p.rating = 'A+';	1883744787
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-24' AND d.name = '人力资源部' AND a.check_in > '09:00:00';	2974332534
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-02' AND a.check_in > '09:00:00';	3471772100
SELECT e.name, a.check_out, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-11' AND a.check_out > '21:00:00' AND p.rating = 'B+';	2086845631
SELECT e.name, d.name, e.hire_date FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.rating = 'B' AND pe.evaluation_date BETWEEN '2022-01-01' AND '2022-12-31' ORDER BY e.hire_date;	4264799007
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND d.name = '客户服务部';	3620357144
SELECT d.name, e.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in > '09:00:00' AND p.rating = 'B';	1491216239
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-02' ORDER BY a.check_in ASC LIMIT 1;	3076427726
SELECT e.name, e.employee_id, a.date, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-10-10' AND p.rating = 'B+';	3105805885
SELECT e.name, e.employee_id, a.date, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-04' AND a.check_in > '09:00:00';	619146222
SELECT e.name, a.date, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND p.rating = 'A+';	701268008
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id WHERE e.employee_id IN (SELECT employee_id FROM probation_employees GROUP BY employee_id ORDER BY COUNT(*) DESC LIMIT 3);	1106812044
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-04' AND d.name = '财务部' AND a.check_in > '09:00:00';	150140045
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2023 AND a.award_name = '优秀员工';	3067705249
SELECT COUNT(DISTINCT a.employee_id) FROM awards a JOIN probation_employees pe ON a.employee_id = pe.employee_id WHERE a.year = 2023 AND a.award_name = '客户满意度奖' AND pe.status = '进行中' AND a.employee_id IN (SELECT employee_id FROM probation_employees WHERE start_date <= '2023-12-31' AND end_date >= '2023-01-01');	370099566
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00:00' AND p.rating = 'C';	3404150466
SELECT e.name, a.award_name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id;	2389000379
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-13' AND a.check_in < '08:30:00';	3131729527
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-17' AND (a.check_out - a.check_in) > interval '9 hours';	525985276
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-26' AND e.remaining_annual_leave > 10;	331075127
SELECT e.name, e.employee_id, a.check_in FROM employees e INNER JOIN departments d ON e.department_id = d.department_id INNER JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-09' AND a.check_in > '09:00:00';	1437451129
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-10' AND d.name = '客户服务部' AND a.check_in > '09:00:00';	4184935107
SELECT e.employee_id, e.name, COUNT(a.id) FROM employees e LEFT JOIN awards a ON e.employee_id = a.employee_id GROUP BY e.employee_id, e.name ORDER BY COUNT(a.id) DESC;	2884744128
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-25' AND a.check_in > '09:00:00';	23024706
SELECT e.name, e.employee_id, p.rating FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '客户服务部' AND p.rating = 'A+' AND p.evaluation_date = '2024-09-28';	1389756999
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-07' AND a.check_in > '09:00:00';	2946411490
SELECT e.name, d.name, ar.check_in, ar.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE ar.date = '2024-10-14';	4118104089
SELECT DISTINCT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '优秀员工' AND ar.date > '2021-01-01';	2690408936
SELECT AVG(e.remaining_annual_leave) FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2024 AND a.award_name = '领导力奖' AND e.hire_date > '2017-12-31';	312466402
SELECT e.employee_id, e.name 
FROM employees e
LEFT JOIN awards a ON e.employee_id = a.employee_id
LEFT JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
JOIN departments d ON e.employee_id = d.manager_id
WHERE a.id IS NULL AND (pe.id IS NULL OR pe.rating != '优秀');	2444022671
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-12-07' AND pe.rating = 'B';	4277707010
SELECT e.name, d.name, a.award_name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN awards a ON e.employee_id = a.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.year = 2023;	4268522360
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-25' AND d.name = '销售部' AND a.check_in > '09:00:00';	4254579364
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-20' AND a.check_in > '09:00:00';	2369381920
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '客户服务部' AND a.date = '2024-09-29' AND (a.check_out - a.check_in) > interval '10 hours';	4086198634
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-04' AND a.check_in > '08:30:00' AND p.rating = 'A+';	2201325936
SELECT employee_id, COUNT(*) FROM attendance_records WHERE check_in > '09:00:00' GROUP BY employee_id;	3450923921
SELECT e.name, e.employee_id FROM employees e INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id INNER JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-15' AND pe.rating = 'A+';	3735318054
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '最佳团队奖' AND ar.date = '2024-09-19';	1103295358
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-21';	1771528644
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '财务部' AND a.date = '2024-09-23' AND a.check_in < '09:30:00';	1983289607
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-09' AND e.employee_type = '实习' AND a.check_in > '09:00:00';	3578772260
SELECT e.name, a.date, a.check_in, a.check_out FROM employees e INNER JOIN awards aw ON e.employee_id = aw.employee_id INNER JOIN attendance_records a ON e.employee_id = a.employee_id WHERE aw.year = 2023 AND aw.award_name = '项目管理奖' AND a.date = '2024-09-23';	417939953
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2022 AND a.year = 2023 AND pe.rating = 'A+';	1624107441
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-13' AND d.name = '人力资源部';	1951693602
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-09-18' AND a.check_in > '09:00:00';	82225620
SELECT '导师计划' AS "导师计划", 0 AS "count";	3464614512
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-20' AND a.check_in > '08:00:00';	3644746054
SELECT e.department_id, e.employee_id, e.name, MAX(AGE(date('now'), e.birth_date)) FROM employees e WHERE (e.department_id, AGE(date('now'), e.birth_date)) IN (SELECT department_id, MAX(AGE(date('now'), birth_date)) FROM employees GROUP BY department_id) GROUP BY e.department_id, e.employee_id, e.name;	2589067480
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-30' AND d.name = '人力资源部' AND a.check_in > '09:00:00';	525741152
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-18' AND a.check_in > '09:00:00' AND d.name = '研发部';	1233829446
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:30:00' AND p.rating = 'A+';	1073149875
SELECT e.name, a.check_in, p.rating FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND a.check_in > '09:00:00' AND p.rating = 'B';	2974599681
SELECT e.name, e.employee_id, a.date, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-22' AND p.rating = 'D';	4292447380
SELECT e.name, e.employee_id, a.date, a.check_in, a.check_out, p.rating FROM employees e INNER JOIN attendance_records a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-03' AND p.rating = 'A+';	1372088201
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-07' AND d.name = '客户服务部' AND a.check_in > '09:00:00';	1829638261
SELECT ar.employee_id, ar.date, ar.check_in, ar.check_out, pe.rating FROM attendance_records ar LEFT JOIN performance_evaluations pe ON ar.employee_id = pe.employee_id ORDER BY ar.employee_id, ar.date;	4051639960
SELECT e.name, a.award_name FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN awards a ON e.employee_id = a.employee_id WHERE ar.date = '2024-10-05' AND ar.check_in > '09:00:00' AND a.year = 2021;	3807676634
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-25' AND a.check_in > '08:30:00';	22049871
SELECT EXTRACT(YEAR FROM a.year || '-01-01'::date) FROM (
    SELECT 
        EXTRACT(YEAR FROM a.year || '-01-01'::date) AS year,
        EXTRACT(QUARTER FROM a.year || '-01-01'::date) AS quarter,
        a.employee_id,
        COUNT(*) AS award_count,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM a.year || '-01-01'::date), EXTRACT(QUARTER FROM a.year || '-01-01'::date) ORDER BY COUNT(*) DESC) AS rank
    FROM awards a
    WHERE a.year >= EXTRACT(YEAR FROM CURRENT_DATE - INTERVAL '3 years')
    GROUP BY EXTRACT(YEAR FROM a.year || '-01-01'::date), EXTRACT(QUARTER FROM a.year || '-01-01'::date), a.employee_id
) a
WHERE a.rank = 1
GROUP BY EXTRACT(YEAR FROM a.year || '-01-01'::date);	2830500866
SELECT a.employee_id, e.name, a.award_name, pe.rating FROM awards a INNER JOIN employees e ON a.employee_id = e.employee_id INNER JOIN performance_evaluations pe ON pe.employee_id = e.employee_id WHERE a.year = 2023 AND pe.rating = 'A+';	753042700
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '质量改进奖' AND ar.date = '2024-10-04' AND ar.check_in > '09:00:00';	3115674665
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-03' AND d.name = '客户服务部' AND a.check_in > '09:00:00';	3347041396
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '人力资源部' AND a.date = '2024-10-02' AND a.check_in > '09:00:00';	2106049978
SELECT e.name, p.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工' AND p.rating = 'A+';	2418301693
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2023-05-31' AND p.rating = 'A+';	3616397443
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-02' AND a.check_in > '09:00:00' AND p.rating = 'A+';	4109172134
SELECT ar.date, ar.check_in, ar.check_out FROM attendance_records ar INNER JOIN employees e ON ar.employee_id = e.employee_id INNER JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2021 AND a.award_name = '销售冠军' AND ar.date = '2024-09-18';	2161202831
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-05-27' AND pe.rating = 'A+';	883813840
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-16' AND ar.check_in > '09:00:00';	537717055
SELECT e.name, d.name FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id;	2763876996
SELECT * FROM employees WHERE position = (SELECT MIN(position) FROM employees) ORDER BY hire_date ASC LIMIT 1;	2600861795
SELECT e.name FROM employees e INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE e.department_id = 'D00007' AND p.rating = 'A' AND EXTRACT(YEAR FROM p.evaluation_date) = 2024;	2781387557
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '创新奖' AND ar.date = '2024-10-12' AND ar.check_in > '09:00:00';	2256872853
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-23' AND ar.check_in > '09:00:00';	3830013539
SELECT COUNT(DISTINCT a.employee_id) FROM awards a INNER JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND p.rating = 'A+';	2490180425
SELECT DISTINCT d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-23' AND ar.check_in > '08:00:00' AND ar.check_out < '18:00:00';	2983573490
SELECT d.name, e.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN interviews i ON e.employee_id = i.employee_id JOIN awards a ON e.employee_id = a.employee_id WHERE i.interview_date = '2023-10-09' AND i.interview_count <= 1 AND a.award_name LIKE '%优秀员工%';	2710720384
SELECT e.name, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND a.check_in < '09:00:00' AND p.rating = 'B+';	737077017
SELECT e.name, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in > '09:00:00' AND p.rating = 'A+';	1491113326
SELECT e.name, a.award_name, pe.rating FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations pe ON a.employee_id = pe.employee_id WHERE a.year = 2021 AND a.award_name = '质量改进奖' AND pe.rating = 'B+';	498106360
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-29' AND d.name = '客户服务部' AND a.check_in > '08:30:00';	640452635
SELECT e.name, d.name, d.manager_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-16' AND a.check_in > '08:30:00';	208690009
SELECT e.name, e.position, a.check_in FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-10-01' AND a.check_in > '09:00:00' AND e.position = '顾问';	392941851
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-23' AND d.name = '客户服务部' AND a.check_in > '09:00:00';	2938732459
SELECT a.year, e.name, a.award_name, pe.status FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations pe ON a.employee_id = pe.employee_id WHERE a.award_name LIKE '%技术创新%' AND a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5;	1117540294
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-06' AND d.name = '财务部' AND a.check_in > '09:00:00';	1014591026
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-04' AND ar.check_in > '09:00:00';	1623914717
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-04';	2050714128
SELECT a.employee_id, a.award_name, pe.rating, pe.evaluation_date FROM awards a JOIN performance_evaluations pe ON a.employee_id = pe.employee_id WHERE a.year = 2023 AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023;	3216421294
SELECT e.name, d.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '09:30:00';	1913384420
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-19';	914649823
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-03' AND d.name = '行政部' AND a.check_in > '09:00:00';	4047308852
SELECT e.department_id, AVG(e.remaining_annual_leave) FROM employees e GROUP BY e.department_id ORDER BY AVG(e.remaining_annual_leave) DESC LIMIT 1;	389946505
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-27' AND a.check_in < '10:00:00' AND p.rating = 'A+';	2789183181
SELECT interview_date, interview_count FROM interviews WHERE EXTRACT(YEAR FROM interview_date) = 2024;	2066321300
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00:00';	517679865
SELECT e.name, e.employee_id, d.name, pe.rating FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE d.name = '研发部' AND pe.rating = 'B+' AND e.hire_date <= '2024-09-29' AND (e.start_work_date IS NULL OR e.start_work_date <= '2024-09-29');	168044233
SELECT ar.id, ar.employee_id, ar.date, ar.check_in, ar.check_out FROM attendance_records ar WHERE ar.employee_id IN (SELECT employee_id FROM awards WHERE year = 2022 AND award_name = '销售冠军') AND ar.date = '2024-10-10';	3832137822
SELECT e.name, e.hire_date, a.award_name FROM awards a JOIN employees e ON a.employee_id = e.employee_id WHERE a.year = 2023 AND a.award_name = '客户满意度奖' AND e.hire_date > '2020-06-19';	2937344989
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00' AND p.rating = 'A+';	666608778
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2022-06-20' AND p.rating = 'C';	895348774
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE a.year = 2024 AND a.award_name = '客户满意度奖' AND pe.rating = 'C';	140831793
SELECT e.name, AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))) FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '项目管理奖' GROUP BY e.name HAVING AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))) > 36000;	3458227345
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-03-09' AND pe.rating = 'D';	1848769486
AMBIGUOUS_QUERY	2500228389
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-08';	2138121838
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-09-26' AND a.check_in > '09:00:00';	2171081157
SELECT e.name, a.check_in FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id JOIN employees e ON a.employee_id = e.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:00:00' AND p.rating = 'A+';	1610499668
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-20' AND d.name = '研发部' AND a.check_in > '09:00:00';	2819549023
SELECT d.name, e.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-10-13' AND ar.check_in > '09:00:00' AND pe.rating = 'A+';	898575802
SELECT e.name, a.award_name, p.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND p.rating IN ('A', 'B');	3845606236
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-17' AND d.name = '财务部' AND (a.check_out - a.check_in) > interval '9 hours';	3651268255
SELECT e.name, e.employee_id, a.check_in, d.name, d.manager_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-18' AND a.check_in > '09:00:00';	2107787587
SELECT e.name, a.check_in FROM employees e JOIN awards aw ON e.employee_id = aw.employee_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE aw.year = 2023 AND aw.award_name = '技术突破奖' AND a.date = '2024-09-23' AND a.check_in > '09:00:00';	3117376201
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '运营部' AND a.date = '2024-09-26';	480860919
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2020 AND a.award_name = '优秀员工' AND EXTRACT(YEAR FROM p.evaluation_date) = 2023 AND p.rating = 'C';	460298626
SELECT e.name, a.check_in, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-03' AND a.check_in > '09:00:00' AND p.rating = 'C';	2730014142
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	3912663730
SELECT EXTRACT(YEAR FROM i.interview_date) FROM interviews i JOIN employees e ON i.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE EXTRACT(YEAR FROM i.interview_date) >= EXTRACT(YEAR FROM CURRENT_DATE) - 5 GROUP BY EXTRACT(YEAR FROM i.interview_date), d.department_id ORDER BY COUNT(DISTINCT CASE WHEN e.hire_date IS NOT NULL THEN e.employee_id END) * 1.0 / COUNT(DISTINCT i.employee_id) DESC, EXTRACT(YEAR FROM i.interview_date) LIMIT 1;	2709449383
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-12';	773661226
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND ar.date = '2024-10-01' AND ar.check_in > '09:00:00';	2010808566
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND ar.date = '2024-09-22' AND ar.check_in > '09:00:00';	201608997
SELECT e.name, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '人力资源部' AND a.date = '2024-10-10'::date AND a.check_in > '09:00:00'::time;	305187601
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-04-20' AND pe.rating = 'D';	1158176204
SELECT COUNT(DISTINCT a.employee_id) * 1.0 / COUNT(DISTINCT e.employee_id) FROM employees e LEFT JOIN (SELECT DISTINCT employee_id FROM awards WHERE year >= EXTRACT(YEAR FROM CURRENT_DATE) - 1) a ON e.employee_id = a.employee_id LEFT JOIN (SELECT DISTINCT employee_id FROM performance_evaluations WHERE evaluation_date >= CURRENT_DATE - INTERVAL '2 years') pe ON e.employee_id = pe.employee_id WHERE a.employee_id IS NOT NULL AND pe.employee_id IS NOT NULL;	3838245936
SELECT e.employee_id, e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE e.hire_date BETWEEN '2023-01-01' AND '2023-12-31' AND a.year = 2023 AND a.award_name = '优秀员工奖' AND pe.rating = 'A+';	2323193672
SELECT e.name, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-21' AND a.check_in > '09:00:00';	662747906
SELECT employee_id, SUM(EXTRACT(EPOCH FROM (check_out - check_in))) FROM attendance_records GROUP BY employee_id;	1678101946
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-15' AND a.check_in > '09:00:00';	523515982
SELECT e.name, a.date, a.check_in FROM employees e JOIN awards aw ON e.employee_id = aw.employee_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE aw.award_name = '创新奖' AND aw.year = 2021 AND a.date = '2024-10-05' AND a.check_in > '09:00:00';	2715149255
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE a.year = 2024 AND pe.rating = 'C';	3069073544
SELECT e.name, a.award_name, pe.rating FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE a.year = 2024 AND a.award_name = '领导力奖' AND pe.rating = 'C';	2258483174
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-19' AND a.check_in > '09:00:00';	389046410
SELECT e.name FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '项目管理奖' AND ar.date = '2024-09-23';	2068076752
SELECT e.name, d.name, pe.rating FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id LEFT JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-20';	406606744
SELECT e.name, d.name, d.manager_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-26' AND a.check_in > '09:30:00';	260151387
SELECT e.name, e.employee_id, a.check_in FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	4070449827
SELECT e.name, e.employee_id, a.check_in, a.check_out FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '研发部' AND a.date = '2024-10-01' AND (a.check_out - a.check_in) > '10:00:00';	2852580257
SELECT e.name, a.award_name, pe.rating FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN performance_evaluations pe ON a.employee_id = pe.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工' AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023;	1727169008
SELECT d.cust_no, d.acct_bal, l.loan_balance, l.loan_type FROM deposit_account_info d JOIN loan_detail_info l ON d.cust_no = l.cust_id WHERE d.data_dt = '2024-07-19' AND d.acct_bal > 100000 AND l.loan_balance > 500000 AND l.loandate_s <= '2024-07-19' AND l.loandate_e >= '2024-07-19';	1877699859
SELECT cust_no, wealth_bal FROM financial_products WHERE data_dt = '2024-07-02' AND currency = '美元' AND wealth_bal > 5000000;	2884293015
SELECT rs_type_name, rs_type_id FROM five_level_classification WHERE data_dt = '2024-07-22' AND rs_type = '不良';	958998120
SELECT c.customer_name, o.occupation_name, lr.description FROM customer c LEFT JOIN occupation o ON c.occupation_id = o.id LEFT JOIN loan_application la ON c.id = la.customer_id LEFT JOIN loan_repayment lr ON la.id = lr.loan_application_id ORDER BY lr.repayment_amount DESC;	1597552663
SELECT c.customer_name, c.id_number, c.phone_number, c.email, c.address FROM customer c JOIN occupation o ON c.occupation_id = o.id WHERE o.occupation_name = '护士' ORDER BY c.customer_name;	2952757264
SELECT COUNT(DISTINCT da.cust_no) FROM deposit_account_info da JOIN loan_detail_info ld ON da.cust_no = ld.cust_id JOIN bank_orgnization bo ON da.org_no = bo.bank_id WHERE da.data_dt = '2024-07-19' AND bo.bank_name = '沈阳分行' AND da.cust_type = '1';	469159086
SELECT c.curr_code, c.curr_full_name, b.bank_name, b.bank_level FROM currency c CROSS JOIN bank_orgnization b WHERE c.data_dt = '2023-06-30' AND b.data_dt = '2023-06-30' AND c.curr_class != '本币';	731693068
SELECT deposit_id, deposit_name FROM deposit_type WHERE data_dt = '2024-07-22';	1236011704
SELECT d.card_no, d.cust_nm, d.residential_address FROM debit_card_information d WHERE DATE(d.open_date) = '2024-07-15' AND d.current_bal > 2000;	280502890
SELECT customer_id, credit_score FROM loan_credit WHERE credit_score > 0.75 AND credit_date = '2003-06-22';	236766680
SELECT c.gender, c.customer_name, lr.repayment_amount FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id GROUP BY c.gender, c.customer_name, lr.repayment_amount;	1413730783
SELECT la.loan_amount, da.customer_name FROM loan_application la JOIN customer da ON la.customer_id = da.id ORDER BY la.loan_amount DESC LIMIT 1;	2991390114
SELECT COUNT(DISTINCT fp.cust_no) FROM financial_products fp JOIN debit_card_information d ON fp.cust_no = d.cust_no WHERE fp.wealth_bal > 1000000 AND d.card_state = '正常';	2514430924
SELECT dai.cust_name, dai.ci_ref_acct, dai.act_mon_avg_bal FROM deposit_account_info dai WHERE dai.data_dt = '2024-07-19' AND dai.org_nm = '沈阳余淮支行' AND dai.acct_type_code = '01' AND dai.act_mon_avg_bal > 50000;	4288779306
SELECT c.customer_name, l.loan_amount FROM customer c JOIN loan_application l ON c.id = l.customer_id WHERE l.loan_amount > 30000 AND l.status = 'PENDING';	3310831117
SELECT cust_id FROM deposit_account_info WHERE cust_id IN (SELECT cust_id FROM loan_detail_info ORDER BY loan_amount DESC LIMIT 20) GROUP BY acct_type_code;	2450245528
SELECT curr_code, curr_full_name FROM currency WHERE curr_class = '外币' ORDER BY curr_code ASC;	821687353
SELECT la.customer_id, la.loan_amount FROM loan_application la ORDER BY la.loan_amount DESC;	3139230407
SELECT f.cast_type, AVG(f.wealth_sta_m_avg_bal_b) FROM financial_products f WHERE f.data_dt >= '2024-07-01' AND f.data_dt < '2024-08-01' GROUP BY f.cast_type;	3089791258
SELECT * FROM loan_detail_info WHERE to_date(loandate_s, 'YYYY-MM-DD') > '2024-04-01';	52505136
SELECT CASE WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 0 AND 20 THEN '0-20' WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 21 AND 40 THEN '21-40' WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 41 AND 60 THEN '41-60' ELSE '61+' END AS age_group, AVG(l.loan_amount) FROM customer c JOIN loan_application l ON c.id = l.customer_id WHERE l.loan_amount > (SELECT AVG(loan_amount) * 1.5 FROM loan_application la JOIN customer cu ON la.customer_id = cu.id WHERE CASE WHEN DATE_PART('year', AGE(date('now'), cu.birth_date)) BETWEEN 0 AND 20 THEN '0-20' WHEN DATE_PART('year', AGE(date('now'), cu.birth_date)) BETWEEN 21 AND 40 THEN '21-40' WHEN DATE_PART('year', AGE(date('now'), cu.birth_date)) BETWEEN 41 AND 60 THEN '41-60' ELSE '61+' END = CASE WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 0 AND 20 THEN '0-20' WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 21 AND 40 THEN '21-40' WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 41 AND 60 THEN '41-60' ELSE '61+' END) GROUP BY age_group;	3773590841
SELECT birth_date, gender FROM customer;	2822188040
SELECT d.cust_id, d.loan_balance FROM loan_detail_info d JOIN bank_orgnization b ON d.loan_orgno = b.bank_id WHERE d.dw_date = '2024-07-19' AND b.bank_name = '沈阳分行' AND d.loan_balance > 500000;	1440558878
SELECT ldi.reportid, ldi.loan_balance, c.curr_full_name, flc.rs_type_name FROM loan_detail_info ldi LEFT JOIN currency c ON ldi.currency_type = c.curr_code LEFT JOIN five_level_classification flc ON ldi.judgelevel = flc.rs_type WHERE ldi.loan_balance > 1000000;	1736005638
SELECT ldi.cust_id, c.curr_full_name, ldi.loan_balance FROM loan_detail_info ldi JOIN currency c ON ldi.currency_type = c.curr_code WHERE ldi.loan_balance > 1000000 ORDER BY ldi.loan_balance DESC;	2851656495
SELECT ub.customer_id, COUNT(DISTINCT ub.behavior_type) FROM user_behavior ub WHERE ub.behavior_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY ub.customer_id ORDER BY COUNT(DISTINCT ub.behavior_type) DESC LIMIT 5;	875490154
SELECT SUM(age1 + age2 + age3 + age4 + age5 + age6), COUNT(*) FROM credit_card_data WHERE corporation = 'Corp3' AND cycle_nbr::date = '2024-07-03';	4277933960
SELECT * FROM loan_detail_info WHERE cust_id = '1004';	3853460934
SELECT c.customer_name, t.transfer_amount, t.transfer_date FROM customer c LEFT JOIN transfer t ON c.id = t.source_customer_id OR c.id = t.target_customer_id;	3090102533
SELECT ub.customer_id, ub.behavior_type, lr.repayment_amount FROM user_behavior ub JOIN customer c ON ub.customer_id = c.id JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id;	1353951750
SELECT dai.cust_name, dai.acct_bal, dt.deposit_name FROM deposit_account_info dai JOIN deposit_type dt ON dai.acct_type_code = dt.deposit_type_id WHERE dai.data_dt = '2024-07-21' AND dai.acct_bal > 50000;	2088616407
SELECT c.id, c.customer_name, c.province, SUM(l.loan_amount) FROM customer c JOIN loan_application l ON c.id = l.customer_id GROUP BY c.id, c.customer_name, c.province;	130934854
SELECT c.province, o.occupation_name, COUNT(*), SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*), ROW_NUMBER() OVER (PARTITION BY c.province ORDER BY SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*) DESC) FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN occupation o ON c.occupation_id = o.id GROUP BY c.province, o.occupation_name HAVING ROW_NUMBER() OVER (PARTITION BY c.province ORDER BY SUM(CASE WHEN la.status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*) DESC) = 1;	3921482862
SELECT bank_nm, SUM(current_bal + fixed_bal) FROM (SELECT bank_nm, current_bal, fixed_bal, ROW_NUMBER() OVER (PARTITION BY bank_nm ORDER BY (current_bal + fixed_bal) DESC) AS rn FROM debit_card_information) t WHERE rn <= 10 GROUP BY bank_nm;	2823798793
SELECT cust_nm, tel_no FROM debit_card_information WHERE cust_nm LIKE '%Lee%';	1257769422
SELECT ub.customer_id, ub.behavior_type, lr.repayment_amount FROM user_behavior ub LEFT JOIN customer c ON ub.customer_id = c.id LEFT JOIN loan_repayment lr ON c.id = lr.id;	3060090955
SELECT DISTINCT lr.loan_application_id, lc.customer_id FROM loan_credit lc JOIN loan_application la ON lc.customer_id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id WHERE lc.credit_score > 0.75 AND lr.repayment_date = '2021-11-10';	1862922606
SELECT * FROM loan_repayment WHERE repayment_amount > 900;	2509103407
SELECT dci.cust_no, dci.cust_nm, dci.card_no, dci.residential_address FROM debit_card_information dci WHERE dci.card_state = '正常' AND dci.residential_address = '987 Willow Street' AND dci.data_dt = '2024-07-09';	695694478
SELECT ld.cust_id, ld.loan_balance FROM loan_detail_info ld;	834672780
SELECT lt.loan_type_name, COUNT(DISTINCT d.cust_no) FROM loan_type lt LEFT JOIN loan_application la ON lt.id = la.loan_type_id LEFT JOIN customer c ON la.customer_id = c.id LEFT JOIN debit_card_information d ON c.id_number = d.cust_id GROUP BY lt.loan_type_name;	4144067238
SELECT ld.loan_type, COUNT(DISTINCT ld.cust_id) FROM loan_detail_info ld GROUP BY ld.loan_type;	2026869176
SELECT credit_score, description FROM loan_credit WHERE credit_date = '2011-04-13';	276439287
SELECT SUM(fp.wealth_bal), SUM(fp.wealth_bal_t) FROM financial_products fp JOIN deposit_account_info dai ON fp.org_no = dai.org_no AND fp.cust_no = dai.cust_no WHERE fp.data_dt = '2024-07-14' AND dai.data_dt = '2024-07-14' AND dai.org_nm = '沈阳余淮支行' AND fp.cast_type = '对公';	3759367452
SELECT customer_id, credit_score FROM loan_credit WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	854057318
SELECT source_customer_id, target_customer_id FROM transfer;	4026685166
SELECT loan_type_name FROM loan_type WHERE loan_type_code = 'MORTGAGE';	3768964878
SELECT cust_nm, card_no FROM debit_card_information WHERE card_state = '正常' AND open_date <= '2024-07-05 00:00:00' AND (closing_date IS NULL OR closing_date > '2024-07-05 00:00:00');	2031979235
SELECT f.bank_nm, f.cast_type, COUNT(*) FROM financial_products f GROUP BY f.bank_nm, f.cast_type;	1154484795
SELECT deposit_name, deposit_type_id FROM deposit_type ORDER BY deposit_name;	1534988899
SELECT la.status, la.loan_amount FROM loan_application la;	3094943511
SELECT customer_id FROM loan_credit WHERE credit_score = 0.77;	3794501166
SELECT lt.description, lr.repayment_amount FROM loan_type lt LEFT JOIN loan_application la ON lt.id = la.loan_type_id LEFT JOIN loan_repayment lr ON la.id = lr.loan_application_id;	1460602722
SELECT rs_type_id, rs_type_name FROM five_level_classification;	3806586802
SELECT card_no, closing_date FROM debit_card_information WHERE closing_date > '2024-07-05';	4276410819
SELECT card_type_nm, card_state FROM debit_card_information WHERE card_type_nm IS NOT NULL;	3975346738
SELECT cust_id, SUM(loan_balance) FROM loan_detail_info WHERE DATE(dw_date) = '2024-07-19' AND loan_balance > 100000 GROUP BY cust_id;	828477757
SELECT d.bank_nm, d.cust_no, SUM(d.current_bal + d.fixed_bal), SUM(CASE WHEN lt.loan_type_name IS NOT NULL THEN d.current_bal + d.fixed_bal ELSE 0 END) FROM debit_card_information d LEFT JOIN loan_detail_info lt ON d.cust_no = lt.cust_id AND d.bank_nm = lt.loan_orgno GROUP BY d.bank_nm, d.cust_no;	2234207790
SELECT DATE_TRUNC('month', COALESCE(t.transfer_date, l.apply_date)) AS month, SUM(t.transfer_amount) AS total_transfer, SUM(l.loan_amount) AS total_loan FROM transfer t FULL OUTER JOIN loan_application l ON DATE_TRUNC('month', t.transfer_date) = DATE_TRUNC('month', l.apply_date) GROUP BY month ORDER BY month;	1812141267
SELECT customer_name, phone_number FROM customer WHERE province = '上海市';	1984914783
SELECT credit_score, credit_date FROM loan_credit WHERE customer_id = 533302;	1612151566
SELECT * FROM transfer ORDER BY transfer_amount DESC;	1955324709
SELECT customer_id, COUNT(DISTINCT behavior_type) FROM user_behavior GROUP BY customer_id;	3342688355
SELECT COUNT(DISTINCT da.cust_no) FROM deposit_account_info da JOIN bank_orgnization bo ON da.org_no = bo.bank_id JOIN credit_card_data cc ON da.cust_no = cc.custr_nbr WHERE da.data_dt = '2024-07-22' AND bo.bank_name = '沈阳分行' AND da.acct_bal > 100000 AND cc.stm_overdu > 5000;	3958858753
SELECT card_no, cust_nm FROM debit_card_information WHERE org_nm = '北京分行';	4286151760
SELECT customer_id, DATE_TRUNC('month', apply_date) FROM (
    SELECT customer_id, apply_date, 
           DATE_TRUNC('month', apply_date) - (ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY DATE_TRUNC('month', apply_date)) * INTERVAL '1 month') AS grp
    FROM (SELECT DISTINCT customer_id, DATE_TRUNC('month', apply_date) AS apply_date FROM loan_application) t
) t
GROUP BY customer_id, grp
HAVING COUNT(*) >= 3;	3229999001
SELECT f.cust_no, f.bank_nm FROM financial_products f ORDER BY f.cust_no;	4182504410
SELECT occupation_code, occupation_name FROM occupation ORDER BY occupation_name;	917603455
SELECT COUNT(*) FROM (SELECT fp.cust_no FROM financial_products fp JOIN debit_card_information d ON fp.cust_no = d.cust_no GROUP BY fp.cust_no HAVING SUM(fp.wealth_bal) > SUM(d.current_bal) * 10) AS subquery;	3406337356
SELECT ld.loan_orgno, ld.loan_balance FROM loan_detail_info ld WHERE ld.loan_amount > 70000;	1335793922
SELECT lt.loan_type_name, ub.behavior_type FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN customer c ON la.customer_id = c.id JOIN user_behavior ub ON c.id = ub.customer_id;	1151279551
SELECT bank_level, COUNT(*) FROM bank_orgnization GROUP BY bank_level;	954153971
SELECT d.current_bal, d.fixed_bal FROM debit_card_information d JOIN bank_orgnization b ON d.org_no = b.bank_id WHERE d.cust_nm = 'Olivia Lee' AND b.bank_name = '北京东单支行' AND d.data_dt = '2024-07-15 00:00:00';	45765016
SELECT c.customer_name, lc.description FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id WHERE lc.credit_date = '2017-10-31' AND lc.credit_score > 0.85 ORDER BY lc.credit_score DESC;	3502920391
SELECT la.loan_amount FROM loan_application la JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_name = '汽车贷款';	1646074274
SELECT lt.loan_type_name, AVG(lr.repayment_amount), COUNT(lr.id) FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN loan_repayment lr ON la.id = lr.loan_application_id GROUP BY lt.loan_type_name;	672526664
SELECT acc_name1, bank, category, day_opened FROM credit_card_data WHERE corporation = 'Corp3' ORDER BY day_opened DESC;	2466786763
SELECT customer_name, address FROM customer;	4227028668
SELECT loan_orgno, SUM(loan_amount) FROM loan_detail_info WHERE dw_date >= '2023-01-01' AND dw_date < '2024-01-01' GROUP BY loan_orgno;	2693621587
SELECT * FROM loan_repayment ORDER BY ABS(repayment_amount - (SELECT AVG(repayment_amount) FROM loan_repayment)) LIMIT 1;	4145982837
SELECT DISTINCT l.customer_id FROM loan_credit l INNER JOIN financial_products f ON l.customer_id = f.cust_no::integer WHERE l.credit_score > 0.8 AND EXTRACT(YEAR FROM f.data_dt) = 2024 AND EXTRACT(MONTH FROM f.data_dt) = 7;	1544259726
SELECT EXTRACT(YEAR FROM apply_date) FROM loan_application GROUP BY EXTRACT(YEAR FROM apply_date);	1355078743
SELECT DISTINCT ON (cust_id) cust_id, loan_orgno, loan_amount FROM loan_detail_info WHERE cust_id IN (SELECT id FROM customer WHERE EXTRACT(YEAR FROM birth_date) = 2024 AND EXTRACT(MONTH FROM birth_date) BETWEEN 1 AND 3);	1126971637
SELECT dai.bank_nm, AVG(la.loan_term), AVG(la.loan_amount) 
FROM loan_application la 
JOIN customer c ON la.customer_id = c.id 
JOIN debit_card_information dai ON c.id_number = dai.cust_no 
GROUP BY dai.bank_nm;	3096647573
SELECT customer_id, credit_score, credit_date FROM loan_credit;	1447870202
SELECT l.cust_id, l.loan_balance FROM loan_detail_info l WHERE TO_DATE(l.loandate_e, 'YYYY-MM-DD') < '2026-01-01';	3139357622
SELECT apply_date, loan_amount FROM loan_application;	2354889533
SELECT la.customer_id, la.loan_amount FROM loan_application la JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_name = '住房贷款' AND la.status = 'APPROVED' ORDER BY la.loan_amount DESC;	526851116
SELECT dai.org_nm, dai.bank_nm, SUM(dai.acct_bal) FROM deposit_account_info dai GROUP BY dai.org_nm, dai.bank_nm ORDER BY SUM(dai.acct_bal) DESC LIMIT 5;	1791411839
SELECT lr.* FROM loan_repayment lr JOIN loan_application la ON lr.loan_application_id = la.id JOIN customer c ON la.customer_id = c.id WHERE c.customer_name = '严琳';	2162165264
SELECT rs_type, COUNT(*) FROM five_level_classification GROUP BY rs_type;	76588831
SELECT rs_type, COUNT(*) FROM five_level_classification GROUP BY rs_type;	3941609286
SELECT b.bank_name, f.cust_no, f.wealth_bal FROM bank_orgnization b JOIN financial_products f ON b.bank_id = f.bank_no;	2101507672
SELECT loan_type_name, description FROM loan_type ORDER BY loan_type_code;	1923349382
SELECT b1.bank_name, b2.bank_name FROM bank_orgnization b1 JOIN bank_orgnization b2 ON b1.bank_parent = b2.bank_id WHERE b1.bank_level = '2';	1121179521
SELECT c.province, c.customer_name, l.loan_amount FROM customer c JOIN loan_application l ON c.id = l.customer_id WHERE (SELECT COUNT(*) FROM loan_application l2 JOIN customer c2 ON c2.id = l2.customer_id WHERE c2.province = c.province AND l2.loan_amount >= l.loan_amount) <= 3 ORDER BY c.province, l.loan_amount DESC;	2484251331
SELECT * FROM transfer WHERE source_customer_id = 376252;	2203191109
SELECT c.customer_name, c.gender, o.occupation_name FROM customer c LEFT JOIN occupation o ON c.occupation_id = o.id;	2236467382
SELECT COUNT(DISTINCT fp.cust_no), SUM(fp.wealth_bal_f) FROM financial_products fp JOIN bank_orgnization bo ON fp.org_no = bo.bank_id WHERE bo.bank_name = '余淮支行' AND bo.bank_parent = '沈阳' AND fp.wealth_bal_f > 0 AND fp.data_dt >= '2024-07-01' AND fp.data_dt < '2024-08-01';	2201430567
SELECT customer_id FROM loan_credit WHERE credit_score > 0.8;	1372106457
SELECT c1.customer_name, c2.customer_name, t.transfer_amount FROM transfer t JOIN customer c1 ON t.source_customer_id = c1.id JOIN customer c2 ON t.target_customer_id = c2.id WHERE t.transfer_amount > 5000;	3513022788
SELECT la.customer_id FROM loan_application la WHERE la.apply_date BETWEEN '2019-01-01' AND '2019-12-31' AND la.status = 'APPROVED';	2898422903
SELECT dci.card_type, dci.card_type_nm, COUNT(DISTINCT dci.cust_no), AVG(fp.wealth_bal) FROM debit_card_information dci JOIN financial_products fp ON dci.cust_no = fp.cust_no GROUP BY dci.card_type, dci.card_type_nm;	3077268751
SELECT c.customer_name, a.loan_amount FROM loan_application a JOIN customer c ON a.customer_id = c.id ORDER BY a.apply_date ASC;	1301921764
SELECT SUM(acct_bal), SUM(act_year_avg_bal) FROM deposit_account_info WHERE data_dt = '2024-07-19' AND cust_type = '1';	3969277636
SELECT c.customer_name, o.occupation_name FROM loan_repayment lr JOIN loan_application la ON lr.loan_application_id = la.id JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id WHERE lr.repayment_amount < 500;	3878396052
SELECT d.cust_name, d.acct_bal FROM deposit_account_info d WHERE d.data_dt = '2023-07-19';	2773495410
SELECT dai.cust_no, dai.acct_bal, la.loan_amount, la.apply_date FROM deposit_account_info dai LEFT JOIN (SELECT customer_id, loan_amount, apply_date, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY apply_date DESC) as rn FROM loan_application) la ON dai.cust_no = la.customer_id::text AND la.rn = 1 ORDER BY dai.acct_bal DESC LIMIT 1;	309023757
SELECT o.occupation_name, COUNT(c.id) FROM occupation o LEFT JOIN customer c ON o.id = c.occupation_id GROUP BY o.occupation_name;	978163931
SELECT c.customer_name, t.transfer_amount FROM transfer t JOIN customer c ON (t.source_customer_id = c.id OR t.target_customer_id = c.id) WHERE t.transfer_date = '2016-06-11' AND t.transfer_amount > 5000 ORDER BY t.transfer_amount DESC;	641452553
SELECT ldi.cust_id, ldi.loan_balance, ldi.loan_type, c.curr_full_name FROM loan_detail_info ldi JOIN currency c ON ldi.currency_type = c.curr_code WHERE ldi.loandate_s::date > '2024-07-01' AND ldi.loan_balance > 1000000 ORDER BY ldi.loan_balance DESC;	1351088256
SELECT * FROM user_behavior WHERE behavior_date = '2018-06-26';	583833982
SELECT * FROM loan_repayment WHERE EXTRACT(DOW FROM repayment_date) IN (0, 6);	2116101795
SELECT dt.deposit_name, lt.loan_type_name, COUNT(DISTINCT c.id) FROM customer c JOIN deposit_account_info dai ON c.id_number = dai.cust_no JOIN deposit_type dt ON dai.acct_type_code = dt.deposit_id JOIN loan_application la ON c.id = la.customer_id JOIN loan_type lt ON la.loan_type_id = lt.id GROUP BY dt.deposit_name, lt.loan_type_name ORDER BY COUNT(DISTINCT c.id) DESC;	985889089
SELECT c.customer_name, lr.repayment_amount FROM loan_repayment lr JOIN loan_application la ON lr.loan_application_id = la.id JOIN customer c ON la.customer_id = c.id WHERE lr.repayment_date = '2021-11-10' AND lr.repayment_amount > 20 ORDER BY lr.repayment_amount DESC;	2925851112
SELECT lt.loan_type_name, AVG(lc.credit_score) FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN loan_credit lc ON la.customer_id = lc.customer_id GROUP BY lt.loan_type_name;	714042771
SELECT loan_type_name, loan_type_code FROM loan_type WHERE loan_type_code IS NOT NULL;	3725846926
SELECT ls.loan_status_name, COUNT(la.id) FROM loan_application la JOIN loan_status ls ON la.status = ls.loan_status_code GROUP BY ls.loan_status_name;	128551642
SELECT customer_id, description FROM loan_credit;	1070169294
SELECT dci.cust_nm, dci.cust_id, dci.tel_no, dci.card_no, dci.current_bal FROM debit_card_information dci WHERE date(dci.open_date) = '2024-07-15' AND dci.org_nm = '北京东单支行';	3530929289
SELECT l.cust_type, SUM(l.loan_amount) FROM loan_detail_info l GROUP BY l.cust_type ORDER BY l.cust_type;	2475731730
SELECT *, (loan_balance / loan_amount) FROM loan_detail_info ORDER BY (loan_balance / loan_amount) DESC LIMIT 10;	2108379659
SELECT la.customer_id, SUM(la.loan_amount) FROM loan_application la JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_name = '住房贷款' AND la.status = 'REJECTED' AND EXTRACT(YEAR FROM la.apply_date) = 2019 GROUP BY la.customer_id;	3717149823
SELECT * FROM bank_orgnization;	1463400602
SELECT ldi.reportid, ldi.cust_id, ldi.loan_balance, ldi.blc_capital, c.curr_full_name, flc.rs_type_name FROM loan_detail_info ldi JOIN currency c ON ldi.currency_type = c.curr_code JOIN five_level_classification flc ON ldi.judgelevel = flc.rs_type_id WHERE ldi.dw_date = '2024-07-22' AND ldi.blc_capital > 10000;	3647903773
SELECT card_state, open_date FROM debit_card_information WHERE card_state = '正常';	190467620
SELECT c.customer_name, t.transfer_amount, t.transfer_date FROM customer c JOIN transfer t ON c.id = t.source_customer_id WHERE t.transfer_date = '2023-06-30' ORDER BY t.transfer_amount DESC;	1357323463
SELECT b.bank_name, b.bank_level FROM bank_orgnization b WHERE b.data_dt = '2023-06-30';	1614074594
SELECT cust_no, SUM(wealth_bal_f) FROM financial_products WHERE data_dt = '2024-07-02' AND cast_type = '非保本' GROUP BY cust_no ORDER BY SUM(wealth_bal_f) DESC;	1411048057
SELECT SUM(loan_amount) FROM loan_application WHERE EXTRACT(YEAR FROM apply_date) = 2019 AND status = 'REJECTED';	2743985170
SELECT d.org_nm, SUM(d.acct_bal) FROM deposit_account_info d JOIN bank_orgnization b ON d.org_no = b.bank_id WHERE d.data_dt = '2024-07-21' AND d.cust_type = '2' AND b.bank_parent IN (SELECT bank_id FROM bank_orgnization WHERE bank_name = '杭州分行') GROUP BY d.org_nm;	1124781975
SELECT lr.loan_application_id, SUM(lr.repayment_amount), COUNT(ub.id), AVG(lr.repayment_amount) FROM loan_repayment lr JOIN loan_application la ON lr.loan_application_id = la.id JOIN user_behavior ub ON la.customer_id = ub.customer_id GROUP BY lr.loan_application_id;	1877601035
SELECT bank_name, bank_level, data_dt FROM bank_orgnization;	3704765747
WITH top_10_percent_customers AS (
    SELECT cust_no, acct_bal
    FROM (
        SELECT cust_no, acct_bal, 
               NTILE(10) OVER (ORDER BY acct_bal DESC) AS percentile
        FROM deposit_account_info
    ) ranked
    WHERE percentile = 1
)
SELECT c.id, c.customer_name, c.occupation_id, dai.acct_bal
FROM customer c
JOIN deposit_account_info dai ON c.id_number = dai.cert_code
JOIN top_10_percent_customers t ON dai.cust_no = t.cust_no
WHERE c.id NOT IN (SELECT customer_id FROM loan_application);	1929928822
SELECT dai.org_nm, COUNT(CASE WHEN la.status = 'APPROVED' THEN 1 END) / COUNT(*) FROM loan_application la JOIN loan_detail_info dai ON la.customer_id = dai.cust_id GROUP BY dai.org_nm;	693366950
SELECT cust_name, acct_bal FROM deposit_account_info WHERE data_dt BETWEEN '2023-07-01' AND '2023-07-31';	2017141047
SELECT b.bank_name, d.cust_name, d.acct_bal, d.cur_type FROM bank_orgnization b JOIN deposit_account_info d ON b.bank_id = d.bank_no WHERE d.data_dt = '2023-06-30' AND d.acct_bal > 100000 AND d.cur_type = '美元';	2208770845
SELECT d.cust_name, d.acct_type_code, d.acct_bal, c.curr_full_name FROM deposit_account_info d JOIN currency c ON d.cur_type = c.curr_code WHERE d.data_dt = '2024-07-19' AND d.acct_bal > 100000;	2411764640
SELECT cust_nm, card_no FROM debit_card_information WHERE card_state = '正常' AND open_date > '2024-07-01' ORDER BY open_date DESC;	2948516213
SELECT deposit_name, deposit_type_id FROM deposit_type ORDER BY deposit_name;	2373067027
SELECT source_customer_id, COUNT(*), MODE() WITHIN GROUP (ORDER BY transfer_amount) FROM transfer GROUP BY source_customer_id ORDER BY COUNT(*) DESC LIMIT 10;	758507051
SELECT COUNT(DISTINCT c.id), SUM(ldi.loan_balance) FROM customer c JOIN credit_card_data ccd ON c.id::text = ccd.custr_nbr JOIN loan_detail_info ldi ON c.id::text = ldi.cust_id WHERE c.province = '上海市' AND ccd.acct_sts = '正常';	3655735172
SELECT ldi.reportid, ldi.loan_balance, flc.rs_type_name, ldi.loan_type FROM loan_detail_info ldi LEFT JOIN five_level_classification flc ON ldi.judgelevel = flc.rs_type WHERE ldi.dw_date = '2024-07-22' AND ldi.loan_balance > 15000;	2721235050
SELECT c.id, MAX(CASE WHEN lt.loan_type_name = '房贷' THEN l.loan_amount END) AS mortgage_amount, MAX(CASE WHEN lt.loan_type_name = '车贷' THEN l.loan_amount END) AS car_loan_amount FROM customer c JOIN loan_application l ON c.id = l.customer_id JOIN loan_type lt ON l.loan_type_id = lt.id WHERE lt.loan_type_name IN ('房贷', '车贷') GROUP BY c.id HAVING COUNT(DISTINCT lt.loan_type_name) = 2 AND MAX(CASE WHEN lt.loan_type_name = '房贷' THEN l.loan_amount END) > MAX(CASE WHEN lt.loan_type_name = '车贷' THEN l.loan_amount END);	4255369233
SELECT dci.cust_nm, SUM(dci.current_bal + dci.fixed_bal) FROM debit_card_information dci JOIN bank_orgnization bo ON dci.org_no = bo.bank_id WHERE bo.bank_name = '杭州上城区支行' AND dci.data_dt = '2024-07-19' GROUP BY dci.cust_nm ORDER BY SUM(dci.current_bal + dci.fixed_bal) DESC;	2277646392
SELECT vouch_type, AVG(loan_amount), PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY loan_amount), PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY loan_amount) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY loan_amount) FROM loan_detail_info GROUP BY vouch_type;	3239376234
SELECT SUM(t.transfer_amount) FROM transfer t JOIN loan_credit lc1 ON t.source_customer_id = lc1.customer_id AND lc1.credit_score > 0.8 JOIN loan_credit lc2 ON t.target_customer_id = lc2.customer_id AND lc2.credit_score > 0.8 WHERE t.transfer_date = '2020-11-03';	3541568339
SELECT COUNT(DISTINCT c.id) FROM loan_application la JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id WHERE la.loan_amount > 50000 AND o.occupation_name = '护士';	1123257910
SELECT ld.cust_id, ld.loan_amount FROM loan_detail_info ld WHERE ld.loandate_s >= '2024-07-01' AND ld.loandate_s < '2024-08-01';	820431444
SELECT DATE_TRUNC('month', apply_date), COUNT(*), SUM(CASE WHEN status = 'APPROVED' THEN 1 ELSE 0 END) / COUNT(*) FROM loan_application GROUP BY DATE_TRUNC('month', apply_date) ORDER BY DATE_TRUNC('month', apply_date);	2667178372
SELECT b.bank_name, SUM(f.wealth_bal) FROM financial_products f JOIN deposit_account_info d ON f.cust_no=d.cust_no AND f.data_dt=d.data_dt JOIN bank_orgnization b ON f.bank_no=b.bank_id WHERE d.cust_type='2' AND f.data_dt='2024-07-02' GROUP BY b.bank_name;	130622905
SELECT c.customer_name, l.status FROM customer c LEFT JOIN loan_application l ON c.id = l.customer_id;	4174863363
SELECT lt.loan_type_name, COUNT(la.customer_id), SUM(la.loan_amount) FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id GROUP BY lt.loan_type_name;	3814340700
SELECT CASE WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 0 AND 20 THEN '0-20' WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 21 AND 40 THEN '21-40' WHEN DATE_PART('year', AGE(date('now'), c.birth_date)) BETWEEN 41 AND 60 THEN '41-60' ELSE '61+' END AS age_group, COUNT(CASE WHEN l.status = 'APPROVED' THEN 1 END)::numeric / COUNT(*) AS approval_rate FROM customer c JOIN loan_application l ON c.id = l.customer_id GROUP BY age_group;	3039598050
SELECT repayment_amount, repayment_date FROM loan_repayment WHERE loan_application_id = 323803;	684098334
SELECT lc.customer_id, lc.credit_score FROM bank_orgnization bo JOIN customer c ON bo.bank_id = c.province JOIN loan_credit lc ON c.id = lc.customer_id WHERE bo.bank_name = '杭州上城区支行' AND bo.data_dt = '2023-06-30' ORDER BY lc.credit_score DESC LIMIT 1;	2020704797
SELECT * FROM loan_repayment WHERE repayment_date < '2020-02-25';	3613008055
SELECT t.transfer_amount, t.transfer_date FROM transfer t JOIN customer c ON (t.source_customer_id = c.id OR t.target_customer_id = c.id) WHERE c.customer_name = '关飞';	1250415044
SELECT c.customer_name, c.id_number, s.loan_status_name FROM loan_application la INNER JOIN customer c ON la.customer_id = c.id INNER JOIN loan_status s ON la.status = s.loan_status_code;	1513848555
SELECT * FROM user_behavior WHERE behavior_type LIKE '%ILL%';	921285205
SELECT * FROM transfer ORDER BY transfer_amount ASC;	1784808376
SELECT * FROM user_behavior WHERE description IS NOT NULL;	1450251644
SELECT d.current_bal FROM debit_card_information d JOIN customer c ON d.cust_id = c.id_number JOIN bank_orgnization b ON d.org_no = b.bank_id WHERE c.customer_name = 'James Taylor' AND b.bank_name = '杭州上城区支行' AND d.data_dt = '2024-07-09';	2152314580
SELECT * FROM loan_type WHERE description LIKE '%Loan%';	4164431702
SELECT c.curr_code, c.curr_full_name, COUNT(ccd.curr_num) FROM credit_card_data ccd JOIN currency c ON ccd.curr_num = c.curr_code GROUP BY c.curr_code, c.curr_full_name;	1368623184
SELECT AVG(f.wealth_t_m_avg_bal_a) FROM financial_products f;	399556639
SELECT lt.loan_type_name, lt.description FROM loan_type lt INNER JOIN loan_application la ON lt.id = la.loan_type_id WHERE la.status = 'APPROVED';	4055303490
SELECT c.customer_name, DATE_PART('year', AGE(date('now'), c.birth_date)), l.loan_amount FROM customer c INNER JOIN loan_application l ON c.id = l.customer_id WHERE EXTRACT(YEAR FROM l.apply_date) = 2023 ORDER BY AGE(date('now'), c.birth_date) DESC LIMIT 5;	4242939153
SELECT COUNT(DISTINCT lc.customer_id) FROM loan_credit lc JOIN customer c ON lc.customer_id = c.id JOIN deposit_account_info dai ON c.id_number = dai.cert_code JOIN bank_orgnization bo ON dai.org_nm = bo.bank_name WHERE bo.bank_name = '杭州上城区支行' AND lc.credit_score > 0.75 AND lc.credit_date = '2023-06-30';	2373959946
SELECT rs_type, COUNT(*) FROM five_level_classification WHERE data_dt = '2024-07-22' GROUP BY rs_type;	3345826641
SELECT flc.rs_type_name, COUNT(ub.id) FROM five_level_classification flc JOIN loan_detail_info ldi ON flc.rs_type = ldi.judgelevel JOIN customer c ON ldi.cust_id = c.id_number JOIN user_behavior ub ON c.id = ub.customer_id GROUP BY flc.rs_type_name;	4002524997
SELECT * FROM transfer ORDER BY transfer_date;	3440883843
SELECT d.card_type, d.card_type_nm, d.card_state FROM debit_card_information d JOIN customer c ON d.cust_id = c.id_number JOIN bank_orgnization b ON d.bank_no = b.bank_id WHERE c.customer_name = 'James Taylor' AND b.bank_name = '杭州上城区支行' AND d.data_dt >= '2024-07-01' AND d.data_dt <= '2024-07-31';	2903014629
SELECT SUM(wealth_bal) FROM financial_products WHERE data_dt = '2024-07-02' AND currency = 'USD';	3876498515
SELECT ub.customer_id, COUNT(ub.id), MAX(lc.credit_score) FROM user_behavior ub LEFT JOIN loan_credit lc ON ub.customer_id = lc.customer_id GROUP BY ub.customer_id ORDER BY ub.customer_id;	4258165101
SELECT t.transfer_amount, c1.customer_name, c2.customer_name FROM transfer t JOIN customer c1 ON t.source_customer_id = c1.id JOIN customer c2 ON t.target_customer_id = c2.id WHERE t.transfer_date = '2023-06-30' AND t.transfer_amount > 1000;	1167360749
SELECT * FROM customer WHERE customer_name = '饶丽';	1853157405
SELECT d.card_no, d.cust_nm FROM debit_card_information d WHERE d.data_dt = '2024-07-14' AND d.card_state = '正常';	856149789
SELECT ldi.cust_id, ldi.loan_balance, flc.rs_type_name, c.curr_full_name FROM loan_detail_info ldi LEFT JOIN five_level_classification flc ON ldi.judgelevel = flc.rs_type_id LEFT JOIN currency c ON ldi.currency_type = c.curr_code WHERE ldi.dw_date = '2024-07-19' AND ldi.loan_balance > 500000 ORDER BY ldi.loan_balance DESC;	12643482
SELECT COUNT(*) FROM deposit_account_info d JOIN customer c ON d.cert_code=c.id_number WHERE d.org_nm='沈阳分行' AND d.acct_bal>100000 AND c.gender='男' AND d.data_dt='2024-07-19';	3675937964
SELECT la.* FROM loan_application la INNER JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_name = '汽车贷款';	517341637
SELECT c.customer_name, la.loan_amount FROM customer c JOIN loan_application la ON c.id = la.customer_id WHERE la.loan_amount > 10000;	317385728
SELECT c.id, c.customer_name, COALESCE(SUM(dai.acct_bal), 0), AVG(lc.credit_score), AVG(CASE WHEN ldi.judgelevel = '1' THEN 100 WHEN ldi.judgelevel = '2' THEN 80 WHEN ldi.judgelevel = '3' THEN 60 WHEN ldi.judgelevel = '4' THEN 40 WHEN ldi.judgelevel = '5' THEN 20 ELSE 0 END) FROM customer c LEFT JOIN deposit_account_info dai ON c.id_number = dai.cust_no LEFT JOIN loan_credit lc ON c.id = lc.customer_id LEFT JOIN loan_detail_info ldi ON c.id_number = ldi.cust_id GROUP BY c.id, c.customer_name ORDER BY (COALESCE(SUM(dai.acct_bal), 0) + AVG(lc.credit_score) + AVG(CASE WHEN ldi.judgelevel = '1' THEN 100 WHEN ldi.judgelevel = '2' THEN 80 WHEN ldi.judgelevel = '3' THEN 60 WHEN ldi.judgelevel = '4' THEN 40 WHEN ldi.judgelevel = '5' THEN 20 ELSE 0 END))/3 DESC LIMIT 20;	162793313
SELECT occupation_code, description FROM occupation WHERE occupation_name = '护士';	1226891061
SELECT ub.customer_id, ub.behavior_type, lc.credit_score FROM user_behavior ub JOIN loan_credit lc ON ub.customer_id = lc.customer_id WHERE ub.behavior_date BETWEEN '2021-08-01' AND '2021-08-31';	3649901835
SELECT lt.loan_type_name, ls.loan_status_name, ls.description FROM loan_type lt CROSS JOIN loan_status ls;	2345937214
SELECT f.bank_nm, SUM(f.wealth_bal) FROM financial_products f WHERE f.data_dt = '2024-07-02' AND f.cust_type = '2' GROUP BY f.bank_nm;	726948157
SELECT la.customer_id, lt.loan_type_name, la.loan_amount, la.loan_term, la.apply_date, la.status FROM loan_application la JOIN loan_type lt ON la.loan_type_id = lt.id WHERE lt.loan_type_name = '住房贷款' AND la.apply_date BETWEEN '2019-01-01' AND '2019-12-31' AND la.status = 'REJECTED';	428507464
SELECT cust_no, wealth_bal_f FROM financial_products WHERE data_dt = '2024-07-19' AND wealth_bal_f > 100000 ORDER BY wealth_bal_f DESC;	1610322845
SELECT customer_name, email FROM customer;	377073913
SELECT c.id, c.customer_name, DATE_TRUNC('quarter', l.apply_date) AS quarter, COUNT(CASE WHEN l.status = 'APPROVED' THEN 1 END)::float / COUNT(*) AS approval_rate FROM customer c JOIN loan_application l ON c.id = l.customer_id GROUP BY c.id, quarter ORDER BY c.id, quarter;	1405120881
SELECT dai.cust_name, dai.acct_bal FROM deposit_account_info dai WHERE dai.data_dt = '2024-07-19' AND dai.cur_type = 'F' AND dai.reality_ir_y = 'USD' ORDER BY dai.acct_bal DESC;	965817749
SELECT customer_name, id_number, phone_number, email FROM customer WHERE birth_date > '1980-12-31';	311014935
SELECT c.customer_name, o.occupation_name, la.loan_amount FROM loan_application la JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id ORDER BY la.loan_amount DESC LIMIT 5;	946337978
SELECT cust_type, loan_balance FROM loan_detail_info;	2702285633
SELECT SUM(d.current_bal), SUM(d.fixed_bal) FROM debit_card_information d JOIN bank_orgnization b ON d.org_no = b.bank_id WHERE b.bank_name LIKE '%杭州上城区支行%' AND d.data_dt = '2023-06-30';	1617148541
AMBIGUOUS_QUERY	1580416554
SELECT * FROM customer WHERE id_number = 'c839d762-6392-4005-8386-ed4e2c50997a';	1114816707
SELECT credit_score, description FROM loan_credit WHERE credit_date = '2003-06-22';	808510096
SELECT d.cust_name, d.acct_bal FROM deposit_account_info d WHERE d.data_dt = '2024-07-21' AND d.org_nm = '杭州分行' AND d.acct_bal > 50000;	3305168434
SELECT l.cust_id, l.loan_balance, d.acct_bal FROM loan_detail_info l JOIN deposit_account_info d ON l.cust_id = d.cust_no WHERE l.loan_balance > 10000;	3107729998
SELECT f.rs_type_name, COUNT(*), SUM(l.loan_balance) FROM loan_detail_info l JOIN five_level_classification f ON l.judgelevel = f.rs_type_id GROUP BY f.rs_type_name;	3912588693
SELECT deposit_name FROM deposit_type WHERE data_dt = '2024-07-22';	158646132
SELECT * FROM transfer WHERE transfer_amount > 500;	3617397322
SELECT c.customer_name, c.id_number, lc.credit_score FROM customer c JOIN loan_credit lc ON c.id = lc.customer_id WHERE c.province = '河北省' AND lc.credit_score > 0.8 ORDER BY lc.credit_score DESC;	397932156
SELECT c.id, CASE WHEN EXTRACT(YEAR FROM AGE(current_date, c.birth_date)) BETWEEN 20 AND 30 THEN '20-30岁' WHEN EXTRACT(YEAR FROM AGE(current_date, c.birth_date)) BETWEEN 31 AND 40 THEN '31-40岁' WHEN EXTRACT(YEAR FROM AGE(current_date, c.birth_date)) BETWEEN 41 AND 50 THEN '41-50岁' WHEN EXTRACT(YEAR FROM AGE(current_date, c.birth_date)) > 50 THEN '51岁以上' END AS age_group FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN loan_type lt ON la.loan_type_id = lt.id;	269454572
SELECT ls.loan_status_name, o.occupation_name FROM loan_status ls JOIN loan_application la ON ls.loan_status_code = la.status JOIN customer c ON la.customer_id = c.id JOIN occupation o ON c.occupation_id = o.id WHERE o.occupation_code = 'NURSE' AND ls.loan_status_code = 'APPROVED';	3026164558
SELECT o.occupation_name, COUNT(DISTINCT c.id), AVG(l.loan_amount) FROM occupation o JOIN customer c ON o.id = c.occupation_id JOIN loan_application l ON c.id = l.customer_id GROUP BY o.occupation_name HAVING COUNT(DISTINCT c.id) > 100;	308222457
SELECT f.cust_no, f.org_nm, f.currency, f.wealth_bal_f FROM financial_products f WHERE f.org_nm = '沈阳余淮支行' AND f.currency = '新加坡元' AND f.wealth_bal_f > 0 AND f.data_dt = '2024-07-14';	2469695932
SELECT id_number, phone_number FROM customer;	425374562
SELECT cust_nm, open_date FROM debit_card_information WHERE open_date >= '2024-07-05';	2892564169
WITH top_10_percent_customers AS (
    SELECT cust_no
    FROM (
        SELECT 
            cust_no,
            wealth_bal,
            PERCENT_RANK() OVER (ORDER BY wealth_bal DESC) AS percentile
        FROM financial_products
        WHERE data_dt = (SELECT MAX(data_dt) FROM financial_products)
    ) ranked
    WHERE percentile <= 0.1
)
SELECT DISTINCT t.cust_no
FROM top_10_percent_customers t
JOIN user_behavior ub ON ub.customer_id::text = t.cust_no
WHERE ub.behavior_type = '登录'
AND ub.behavior_date >= CURRENT_DATE - INTERVAL '30 days';	1640385150
SELECT lc.customer_id, lc.credit_score, ub.description FROM loan_credit lc JOIN user_behavior ub ON lc.customer_id = ub.customer_id WHERE lc.credit_date = '2023-12-10' AND ub.behavior_date = '2023-12-10';	3377906541
SELECT bank_id, bank_name FROM bank_orgnization;	365779440
SELECT lr.repayment_amount, la.loan_amount FROM loan_repayment lr JOIN loan_application la ON lr.loan_application_id = la.id WHERE lr.repayment_date = '2024-01-20';	798971312
SELECT c.curr_code, c.curr_full_name, COUNT(t.id) FROM currency c LEFT JOIN transfer t ON c.curr_code = t.currency AND t.transfer_date < '2023-06-30' WHERE c.data_dt = '2023-06-30' AND c.curr_class != '本币' GROUP BY c.curr_code, c.curr_full_name;	1756912532
SELECT repayment_amount FROM loan_repayment WHERE repayment_date = '2021-11-10' AND loan_application_id = 742969;	3898093211
SELECT d.deposit_type_name, AVG(l.loan_amount), STDDEV(l.loan_amount) FROM deposit_type d JOIN deposit_account_info dai ON d.deposit_type_id = dai.acct_type_code JOIN customer c ON dai.cert_code = c.id_number JOIN loan_application l ON c.id = l.customer_id GROUP BY d.deposit_type_name;	2131176144
SELECT c.customer_name, o.occupation_name, lr.repayment_date FROM customer c JOIN occupation o ON c.occupation_id = o.id JOIN loan_application la ON c.id = la.customer_id JOIN loan_repayment lr ON la.id = lr.loan_application_id;	784123269
SELECT lt.loan_type_name, AVG(la.loan_amount), AVG(dai.acct_bal) FROM loan_type lt JOIN loan_application la ON lt.id = la.loan_type_id JOIN customer c ON la.customer_id = c.id JOIN deposit_account_info dai ON c.id_number = dai.cust_no GROUP BY lt.loan_type_name;	1431165151
SELECT COUNT(DISTINCT ub.customer_id) FROM loan_application la JOIN user_behavior ub ON la.customer_id = ub.customer_id WHERE la.apply_date = '2019-01-10' AND la.status = 'REJECTED' AND ub.behavior_date = '2017-10-24' AND ub.behavior_type = 'LOGIN';	2469033655
SELECT c.customer_name, la.loan_amount FROM customer c JOIN loan_application la ON c.id = la.customer_id JOIN loan_credit lc ON c.id = lc.customer_id WHERE la.apply_date BETWEEN '2019-01-01' AND '2019-12-31' AND lc.credit_score > 0.8 ORDER BY la.loan_amount DESC;	398304766
SELECT * FROM loan_detail_info WHERE loan_balance > 500000 ORDER BY loan_balance DESC;	3521704142
SELECT customer_id, credit_score FROM loan_credit WHERE credit_date = '2003-06-22' AND credit_score > 0.75;	1896500682
SELECT customer_name, birth_date FROM customer WHERE birth_date > '1989-12-31';	1933728727
SELECT customer_id, MAX(credit_score) - MIN(credit_score) AS credit_score_increase FROM loan_credit WHERE credit_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY customer_id ORDER BY credit_score_increase DESC LIMIT 5;	3124021686
SELECT ub.behavior_type, COUNT(DISTINCT ub.customer_id) FROM user_behavior ub GROUP BY ub.behavior_type;	3585096464
SELECT DISTINCT dt.deposit_name, dai.cust_no FROM deposit_type dt JOIN deposit_account_info dai ON dt.deposit_id = dai.acct_type_code WHERE dai.data_dt >= (CURRENT_DATE - INTERVAL '1 year');	677634919
SELECT SUM(t.transfer_amount) FROM transfer t JOIN customer c ON (t.source_customer_id = c.id OR t.target_customer_id = c.id) JOIN bank_orgnization b ON c.province = '沈阳' AND b.bank_name LIKE '%沈阳分行%' WHERE t.transfer_date = '2024-07-19';	3094639947
SELECT s.store_name, s.manager_name, MAX(ss.profit) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' GROUP BY s.store_name, s.manager_name ORDER BY MAX(ss.profit) DESC LIMIT 1;	1003634069
SELECT profit, sales_quantity FROM salesstatistics;	3101430966
AMBIGUOUS_QUERY	2117960535
SELECT e.name, e.position, s.store_name, so.total_amount FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05' AND s.store_name = '数码广场店' AND so.total_amount > 7000;	941218200
SELECT * FROM salesstatistics ORDER BY profit DESC LIMIT 1;	1332840948
SELECT s.store_name, e.name, SUM(od.quantity * od.unit_price), p.product_name FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND p.supplier_name = '苹果官方旗舰店' GROUP BY s.store_name, e.name, p.product_name HAVING SUM(od.quantity * od.unit_price) > 10000;	3240310596
SELECT DISTINCT p.product_name, p.supplier_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id JOIN products p ON ss.product_id = p.product_id WHERE s.store_name = '电子城旗舰店';	717197329
SELECT s.store_name, e.name, e.position FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-09';	1628648561
SELECT s.store_name, s.manager_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id WHERE ss.date = '2023-05-05' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.sales_amount) > 10000;	2064785597
SELECT e.name, so.total_amount FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id WHERE so.order_date = '2023-05-07' AND so.total_amount > 10000;	3560785170
SELECT s.store_name, e.name, SUM(ss.profit) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, e.name HAVING SUM(ss.profit) > 5000;	251536917
SELECT DISTINCT e.employee_id, e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'Nintendo Switch' AND so.order_date >= '2023-05-01' AND so.order_date <= '2023-05-31' AND so.total_amount > 5000;	634768311
SELECT p.product_name, MAX(ss.sales_amount) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id GROUP BY p.product_name ORDER BY MAX(ss.sales_amount) DESC LIMIT 1;	725261436
SELECT od.order_detail_id, p.product_name, so.total_amount FROM orderdetails od JOIN products p ON od.product_id = p.product_id JOIN salesorders so ON od.order_id = so.order_id;	1323416994
SELECT e.name, st.store_name FROM employees e JOIN stores st ON e.store_id = st.store_id;	513278066
SELECT s.store_name, s.manager_name, SUM(ss.sales_amount) FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id WHERE ss.date = '2023-05-08' GROUP BY s.store_name, s.manager_name;	3418908967
SELECT so.order_id, e.name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id WHERE so.total_amount > 7000;	1868084525
SELECT s.store_name, e.name, SUM(od.quantity * od.unit_price), p.product_name FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.supplier_name = '苹果官方旗舰店' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, e.name, p.product_name HAVING SUM(od.quantity * od.unit_price) > 10000;	3487107783
AMBIGUOUS_QUERY	556239338
SELECT * FROM salesorders WHERE order_id = 'b8b62bfe-a35d-4ff5-9bc9-654b5f67fed2';	2327152729
SELECT e.name, SUM(so.total_amount) FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id GROUP BY e.name;	3589036319
SELECT p.product_name, p.sale_price, p.purchase_price FROM products p;	3750652945
SELECT e.name, s.manager_name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN stores s ON e.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY e.employee_id, e.name, s.manager_name HAVING SUM(so.total_amount) > 10000;	148577634
AMBIGUOUS_QUERY	693418076
SELECT s.store_name, e.name, p.product_name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-07' AND p.product_name = 'Apple Watch Series 7';	1476013456
SELECT DISTINCT s.store_name, e.name FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN stores s ON so.store_id = s.store_id JOIN employees e ON so.employee_id = e.employee_id WHERE so.order_date = '2023-05-05' AND so.total_amount > 10000 AND p.sale_price > 5000 AND e.position = '销售经理';	3645006631
SELECT od.order_detail_id, p.product_name, od.quantity FROM orderdetails od JOIN products p ON od.product_id = p.product_id;	1046575296
SELECT * FROM salesorders WHERE store_id = '0887d06a-27a8-46b4-98d6-514702e698da';	1550748576
SELECT e.employee_id, e.name FROM employees e WHERE EXISTS (SELECT 1 FROM salesstatistics ss WHERE ss.employee_id = e.employee_id AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY ss.employee_id HAVING SUM(ss.sales_quantity) > (SELECT COALESCE(SUM(od.quantity), 0) FROM orderdetails od JOIN salesorders so ON od.order_id = so.order_id WHERE so.employee_id = e.employee_id AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31'));	2462853793
SELECT s.store_name, e.name, SUM(so.total_amount) FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-01' GROUP BY s.store_name, e.name;	1349452785
SELECT pd.product_name, SUM(od.quantity), so.order_date FROM products pd JOIN orderdetails od ON pd.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id GROUP BY pd.product_name, so.order_date;	3541158395
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	3496741770
AMBIGUOUS_QUERY	2485376576
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-07' GROUP BY s.store_id, s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2624059207
SELECT s.store_name, e.name, so.total_amount FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-01' AND so.total_amount > 8000 AND p.product_name = '索尼WH-1000XM4耳机';	509381804
SELECT purchase_price, sale_price FROM products WHERE product_id = '某商品ID';	535494901
SELECT product_id, unit_price, quantity FROM orderdetails;	3918531592
SELECT e.name, s.store_name FROM products p JOIN salesstatistics ss ON p.product_id = ss.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Apple Watch Series 7' AND ss.date = '2023-05-06';	4213276457
SELECT st.store_name, SUM(od.quantity), SUM(so.total_amount) FROM stores st JOIN salesorders so ON st.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id GROUP BY st.store_name ORDER BY SUM(od.quantity) DESC LIMIT 1;	1019928378
SELECT DISTINCT e.name, p.category_name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 10000;	1374387165
SELECT e.name, s.store_name, SUM(so.total_amount) FROM employees e JOIN stores s ON e.store_id = s.store_id JOIN salesorders so ON e.employee_id = so.employee_id GROUP BY e.name, s.store_name;	765173051
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name;	1497182476
SELECT pd.product_name, SUM(od.quantity) FROM products pd JOIN orderdetails od ON pd.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY pd.product_name HAVING SUM(od.quantity) > 5;	1106161896
SELECT p.product_name, SUM(od.quantity), p.sale_price FROM products p JOIN orderdetails od ON p.product_id = od.product_id GROUP BY p.product_name, p.sale_price;	1170519624
SELECT s.store_name, e.name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE p.product_name = '佳能EOS R6' AND ss.date = '2023-05-01' AND e.position = '销售经理';	834717526
SELECT st.store_name, st.phone, st.address FROM stores st;	2895234210
SELECT so.order_id, p.product_name FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.total_amount < 5000;	710749857
SELECT s.store_name, e.name, SUM(ss.sales_quantity), SUM(ss.profit) FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, e.name HAVING SUM(ss.sales_quantity) = (SELECT MAX(total_qty) FROM (SELECT SUM(sales_quantity) AS total_qty FROM salesstatistics WHERE date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY employee_id) AS subq);	1055484680
SELECT s.store_name, SUM(ss.profit) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '小米电视4A' AND ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' GROUP BY s.store_name;	1417436330
SELECT e.name, SUM(ss.profit) FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' AND s.store_name = '智慧街店' AND p.product_name = '小米电视4A' GROUP BY e.name;	3793589229
SELECT store_name, phone FROM stores;	1607637139
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.profit) > 1000;	3962541566
SELECT p.category_name, SUM(ss.sales_quantity) FROM products p JOIN salesstatistics ss ON p.product_id = ss.product_id GROUP BY p.category_name;	2338461777
SELECT s.store_name, e.name FROM stores s JOIN employees e ON e.store_id = s.store_id;	1062218506
SELECT so.order_id FROM salesorders so WHERE so.total_amount > (SELECT AVG(total_amount) FROM salesorders);	1070226284
AMBIGUOUS_QUERY	2289172435
SELECT e.name, so.order_date, so.total_amount FROM employees e LEFT JOIN salesorders so ON e.employee_id = so.employee_id;	2176343547
SELECT e.name, SUM(so.total_amount) FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id GROUP BY e.name;	3778494114
SELECT e.name, SUM(ss.sales_quantity), SUM(ss.profit) AS total_profit FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id GROUP BY e.name;	230146678
SELECT DISTINCT s.store_name FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = '佳能EOS R6' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 10000;	1097733010
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	406428809
SELECT s.store_name, SUM(ss.sales_quantity), SUM(ss.sales_amount) FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id GROUP BY s.store_name;	224479304
SELECT s.store_name, s.manager_name, SUM(ss.sales_quantity) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	549557561
AMBIGUOUS_QUERY	4264530712
SELECT od.order_detail_id, od.unit_price FROM orderdetails od WHERE od.product_id = :product_id;	3474684191
SELECT s.store_name, ss.sales_amount, ss.date FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id;	3292698794
SELECT DISTINCT p.product_name FROM products p JOIN salesstatistics ss ON p.product_id = ss.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.purchase_price > 4000 AND s.store_name = '未来城店';	3179632170
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-09' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	2509582177
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-02' GROUP BY s.store_id, s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	1374950508
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-09' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.sales_amount) > 1000;	2266088702
SELECT DISTINCT e.name, p.category_name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 10000;	2178886607
SELECT s.store_name, SUM(ss.profit) FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id GROUP BY s.store_name;	2714447935
SELECT s.store_name, e.name, od.unit_price * od.quantity, p.product_name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND od.unit_price * od.quantity > 10000 AND p.supplier_name = '索尼官方旗舰店';	1871066617
SELECT so.order_id, so.total_amount, od.product_id, od.quantity FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id WHERE so.total_amount > 5000;	2023023440
AMBIGUOUS_QUERY	3146544905
SELECT ss.sales_quantity, s.store_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31';	283454282
SELECT product_name, sale_price, purchase_price FROM products;	2083297023
SELECT s.store_name, SUM(ss.sales_quantity) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND p.category_name = '智能手表' AND p.supplier_name = '索尼官方旗舰店' GROUP BY s.store_name HAVING SUM(ss.sales_quantity) > 10;	2394150048
SELECT s.store_name, s.manager_name, AVG(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE EXTRACT(YEAR FROM so.order_date) = 2023 AND EXTRACT(MONTH FROM so.order_date) = 5 GROUP BY s.store_name, s.manager_name HAVING AVG(so.total_amount) > 10000;	519899560
SELECT s.store_name, e.name, p.product_name, ss.sales_quantity, ss.sales_amount, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-02' AND p.product_name = 'iPad Air';	1920836570
AMBIGUOUS_QUERY	3659690943
SELECT s.store_name, SUM(ss.sales_quantity), SUM(ss.sales_amount) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' GROUP BY s.store_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	1937076000
SELECT s.store_name, e.name, SUM(so.total_amount) FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'Apple Watch Series 7' AND so.order_date = '2023-05-09' GROUP BY s.store_name, e.name;	2659013528
SELECT quantity, unit_price FROM orderdetails;	1610928077
SELECT DISTINCT s.store_name, e.name, e.position FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	2010016216
SELECT * FROM salesstatistics WHERE sales_quantity > 1;	1911035258
SELECT s.store_name, SUM(ss.profit) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name;	761870148
SELECT so.order_date, SUM(so.total_amount) FROM salesorders so GROUP BY so.order_date;	3087271800
SELECT st.store_name, SUM(so.total_amount), COUNT(so.order_id) FROM stores st JOIN salesorders so ON st.store_id = so.store_id GROUP BY st.store_name;	1161484474
SELECT * FROM orderdetails WHERE quantity = 2;	52411810
SELECT s.store_name, e.name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '戴尔灵越15' AND ss.date = '2023-05-01';	1664706844
SELECT e.name, e.position, st.store_name FROM employees e JOIN stores st ON e.store_id = st.store_id;	3840473394
SELECT s.store_name, e.name, SUM(ss.profit) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-03' AND p.product_name = '佳能EOS R6' GROUP BY s.store_name, e.name;	2695189368
AMBIGUOUS_QUERY	2733025825
SELECT s.store_name, e.name, ss.sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' AND p.product_name = '华为Mate 40 Pro' AND ss.sales_quantity > 1;	807812239
SELECT od.order_detail_id, p.product_name, od.quantity FROM orderdetails od JOIN products p ON od.product_id = p.product_id;	4273091220
SELECT e.name, e.position, s.phone FROM employees e JOIN stores s ON e.store_id = s.store_id;	4275534962
SELECT s.store_name, e.name, od.quantity FROM orderdetails od JOIN products p ON od.product_id = p.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = '戴尔灵越15' AND so.order_date = '2023-05-05' AND od.quantity > 1;	1477929232
SELECT so.order_id, so.total_amount, od.product_id, od.quantity FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id WHERE so.total_amount > 5000;	729968430
SELECT e.name, so.order_id, so.total_amount FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id;	1040158875
SELECT ss.statistic_id, ss.date FROM salesstatistics ss WHERE ss.profit > 3000;	1660394186
SELECT s.store_name, e.name, so.total_amount FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = 'Apple Watch Series 7' AND so.order_date = '2023-05-01' AND so.total_amount > 7000;	3002487561
SELECT p.product_name, p.remaining_quantity, p.category_name FROM products p;	2715847000
SELECT DISTINCT e.employee_id, e.name, e.position FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-07' AND p.category_name = '相机' AND so.total_amount > 15000;	1326759420
AMBIGUOUS_QUERY	57033443
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-08' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2455933109
SELECT e.name, ss.sales_quantity, ss.sales_amount FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE s.store_name = '数字大道店' AND p.product_name = 'Nintendo Switch' AND ss.date = '2023-05-03';	4078619784
SELECT s.store_name, e.name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-05' AND p.product_name = '戴森V11' AND ss.profit > 500;	2372435041
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-09' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.sales_amount) > 2000;	1022758323
SELECT s.store_name, s.manager_name FROM stores s JOIN (SELECT store_id, SUM(total_amount) AS total_sales FROM salesorders WHERE order_date = '2023-05-01' GROUP BY store_id HAVING SUM(total_amount) > 10000) so ON s.store_id = so.store_id;	2940623149
AMBIGUOUS_QUERY	3177645630
AMBIGUOUS_QUERY	2385992805
SELECT s.store_name, s.address, s.phone FROM stores s;	2749807521
SELECT s.store_name, e.name, so.total_amount FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-02' AND so.total_amount > 2000;	888076621
SELECT store_id, SUM(sales_quantity), SUM(profit) FROM salesstatistics GROUP BY store_id;	1648589599
SELECT s.store_name, SUM(st.profit) AS profit, s.manager_name FROM salesstatistics st JOIN stores s ON st.store_id = s.store_id WHERE st.date = '2023-05-07' GROUP BY s.store_name, s.manager_name HAVING SUM(st.profit) > 1000;	2992228883
SELECT s.store_name, s.manager_name, ss.sales_quantity FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' ORDER BY ss.sales_quantity DESC LIMIT 1;	3404171320
SELECT ss.store_id, SUM(ss.profit) FROM salesstatistics ss WHERE ss.date = '2023-05-09' GROUP BY ss.store_id ORDER BY SUM(ss.profit) DESC LIMIT 1;	952156269
SELECT s.store_name, e.name, SUM(od.quantity * od.unit_price) FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = '佳能EOS R6相机' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, e.name HAVING SUM(od.quantity * od.unit_price) > 5000;	4068577452
SELECT DISTINCT s.store_name, e.name, e.position FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = 'iPad Air' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	1242514407
SELECT category_name, sale_price FROM products;	3705049314
SELECT s.store_name, COUNT(e.employee_id) FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN employees e ON s.store_id = e.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND e.position = '销售经理' GROUP BY s.store_name HAVING SUM(so.total_amount) > 10000;	4213863561
SELECT p.product_name, p.remaining_quantity, SUM(od.quantity) FROM products p LEFT JOIN orderdetails od ON p.product_id = od.product_id GROUP BY p.product_name, p.remaining_quantity;	1964767451
SELECT so.order_id, so.order_date, so.total_amount FROM salesorders so;	2226247599
SELECT s.store_name, e.name, p.product_name, ss.sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' AND p.product_name = '华为Mate 40 Pro' AND ss.sales_quantity > 1;	2202777878
SELECT s.store_name, e.name, e.position FROM stores s JOIN employees e ON s.store_id = e.store_id ORDER BY s.store_name;	3419270272
SELECT e.name, SUM(od.quantity * od.unit_price) FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-01' AND s.store_name = '创客空间店' AND p.product_name = '华为Mate 40 Pro' GROUP BY e.name;	569246445
SELECT DISTINCT s.store_name, e.name, e.position 
FROM salesstatistics ss 
JOIN products p ON ss.product_id = p.product_id 
JOIN employees e ON ss.employee_id = e.employee_id 
JOIN stores s ON ss.store_id = s.store_id 
WHERE p.product_name = '戴森V11' 
AND ss.date >= '2023-05-01' 
AND ss.date <= '2023-05-31';	830322285
SELECT od.order_detail_id, p.product_name, od.quantity FROM orderdetails od JOIN products p ON od.product_id = p.product_id;	2616706012
SELECT DISTINCT e.employee_id, e.name FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-06' AND ss.sales_quantity > 1 AND p.supplier_name = '戴尔官方旗舰店';	2466792320
SELECT product_name, sale_price FROM products;	1812987912
SELECT manager_name, phone FROM stores;	3453098028
SELECT so.total_amount, st.store_name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores st ON so.store_id = st.store_id WHERE e.name = '范莹' AND so.order_date = '2023-05-07';	4200224368
SELECT s.store_name, SUM(so.total_amount) FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'Apple Watch Series 7' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name HAVING SUM(so.total_amount) > 10000;	1555442404
SELECT s.store_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name;	3702552802
SELECT store_name, manager_name FROM stores;	2171002807
SELECT p.product_name, p.sale_price, p.remaining_quantity FROM products p;	2060589508
AMBIGUOUS_QUERY	356180662
SELECT s.store_name, e.name, so.total_amount FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND so.order_date = '2023-05-08' AND so.total_amount > 15000;	4289573231
SELECT s.store_name, s.manager_name, MAX(ss.sales_quantity) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-09' GROUP BY s.store_name, s.manager_name ORDER BY MAX(ss.sales_quantity) DESC LIMIT 1;	218019223
SELECT SUM(profit) FROM salesstatistics;	1638224805
AMBIGUOUS_QUERY	2476507165
SELECT s.store_name, SUM(ss.sales_quantity) FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE e.name = '黄萍' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	1748148291
SELECT s.store_name, e.name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE ss.date = '2023-05-08' AND p.product_name = 'Nintendo Switch';	2979325122
SELECT s.store_name, e.name, so.total_amount FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-05' AND p.product_name = '索尼WH-1000XM4耳机';	2667320856
SELECT e.name, e.position, p.product_name FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-05' AND s.store_name = '智能生活馆' AND p.supplier_name = '小米官方旗舰店';	1093613959
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-07' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.profit) DESC LIMIT 1;	2112449268
SELECT s.store_name, e.name, p.product_name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-09' AND p.product_name = '索尼WH-1000XM4耳机';	2094309801
AMBIGUOUS_QUERY	3718167842
SELECT s.store_name, so.total_amount FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-03';	3764251163
SELECT * FROM orderdetails WHERE quantity > 1;	1497641640
AMBIGUOUS_QUERY	4149606926
SELECT so.order_id, so.total_amount, s.store_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05';	4134019112
SELECT p.product_name, od.order_id FROM orderdetails od JOIN products p ON od.product_id = p.product_id WHERE od.quantity > 1;	2245397691
SELECT so.order_id, so.order_date, so.total_amount FROM salesorders so WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	2674486311
SELECT employee_id, SUM(sales_quantity) FROM salesstatistics GROUP BY employee_id;	2993192059
SELECT category_name, remaining_quantity FROM products;	2808717165
SELECT e.name, SUM(ss.sales_quantity), s.store_name FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN stores s ON e.store_id = s.store_id GROUP BY e.name, s.store_name;	3833291686
SELECT od.order_id, od.product_id FROM orderdetails od;	2280059229
AMBIGUOUS_QUERY	77729748
AMBIGUOUS_QUERY	82660779
SELECT e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-09' AND p.product_name = 'Apple Watch Series 7' AND p.supplier_name = '任天堂官方旗舰店';	787968865
SELECT so.total_amount, s.store_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-06';	3377021543
AMBIGUOUS_QUERY	813286043
SELECT e.name, s.store_name, p.product_name, SUM(o.total_amount) FROM salesorders o JOIN employees e ON o.employee_id = e.employee_id JOIN stores s ON o.store_id = s.store_id JOIN orderdetails od ON o.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE o.order_date = '2023-05-07' AND s.store_name = '智慧街店' AND p.product_name = '佳能EOS R6' GROUP BY e.name, s.store_name, p.product_name;	727992931
SELECT st.store_name, SUM(od.quantity), SUM(od.quantity * od.unit_price) FROM stores st JOIN salesorders so ON st.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id GROUP BY st.store_name;	825037872
SELECT s.store_name, e.name, SUM(od.quantity * od.unit_price) FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = '佳能EOS R6相机' AND so.order_date = '2023-05-05' GROUP BY s.store_name, e.name;	4082105822
SELECT * FROM products WHERE sale_price > 15000;	3249720567
SELECT s.store_name, e.name, p.product_name, ss.sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' AND p.product_name = '索尼WH-1000XM4' AND ss.sales_quantity > 1;	2614838216
SELECT s.store_name, e.name, p.product_name, ss.sales_amount FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-01' AND ss.sales_amount > 1000 AND p.supplier_name = '戴森官方旗舰店';	1333469519
AMBIGUOUS_QUERY	2995198030
SELECT s.store_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id GROUP BY s.store_name;	2649378296
AMBIGUOUS_QUERY	746087372
SELECT so.order_id, so.order_date, e.name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id;	3679313236
SELECT product_name, supplier_name FROM products;	2391253319
SELECT p.sale_price, p.supplier_name FROM products p;	1769098425
SELECT od.order_detail_id, p.product_name, od.unit_price FROM orderdetails od JOIN products p ON od.product_id = p.product_id;	622285765
SELECT s.store_name, s.phone FROM stores s JOIN salesorders so ON s.store_id = so.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.phone HAVING SUM(so.total_amount) > 3000;	3990639391
SELECT store_name, manager_name FROM stores;	986209829
SELECT e.name, st.phone FROM employees e JOIN stores st ON e.store_id = st.store_id;	2997501252
SELECT e.name, ss.sales_quantity, ss.profit FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-09' AND s.store_name = '创新路专卖店' AND p.product_name = 'iPad Air';	3439332131
SELECT e.name, e.position, s.store_name, so.total_amount FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-07' AND s.store_name = '未来城店' AND so.total_amount > 15000;	3283669448
SELECT product_name, sale_price - purchase_price FROM products;	1627244723
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	1569820240
SELECT st.store_name, SUM(ss.profit), SUM(ss.sales_quantity) FROM stores st JOIN salesstatistics ss ON st.store_id = ss.store_id GROUP BY st.store_name;	3499069647
SELECT * FROM salesorders WHERE store_id = '64921abb-1d54-4e03-a15e-ea42f058f31c';	1379442449
SELECT s.store_name, e.name, p.product_name, so.total_amount FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-06' AND p.product_name = '小米电视4A' AND so.total_amount > 10000;	2629127246
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' AND ss.profit > 1000;	3788770697
SELECT s.store_name, e.name, od.quantity, od.unit_price * od.quantity FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = '索尼WH-1000XM4' AND so.order_date = '2023-05-09';	1545362727
AMBIGUOUS_QUERY	2279456937
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-03' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2483765707
SELECT s.store_name, s.manager_name, ss.sales_quantity FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-03' ORDER BY ss.sales_quantity DESC LIMIT 1;	2155062621
SELECT s.store_name, e.name, so.total_amount FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-01';	1172044345
SELECT store_id, SUM(total_amount) FROM salesorders GROUP BY store_id;	413296723
SELECT e.position, COUNT(so.order_id) FROM employees e LEFT JOIN salesorders so ON e.employee_id = so.employee_id GROUP BY e.position;	1774082301
AMBIGUOUS_QUERY	1485164601
SELECT s.store_name, s.manager_name, SUM(o.total_amount) FROM salesorders o JOIN stores s ON o.store_id = s.store_id WHERE o.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name HAVING SUM(o.total_amount) > 10000;	1282673925
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-02' AND ss.sales_amount > 10000 AND p.supplier_name = '华为官方旗舰店';	3234218182
AMBIGUOUS_QUERY	623061772
AMBIGUOUS_QUERY	3776277190
SELECT s.store_name, s.manager_name, SUM(so.total_amount) FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-04' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2220998092
SELECT s.store_name, e.name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-01' AND p.product_name = '华为Mate 40 Pro';	3144588067
SELECT e.name, s.manager_name FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' AND ss.sales_amount > 10000;	3325155262
SELECT s.store_name, e.name, SUM(od.quantity * od.unit_price) FROM orderdetails od JOIN products p ON od.product_id = p.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = '戴尔灵越15笔记本电脑' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, e.name HAVING SUM(od.quantity * od.unit_price) > 5000;	3438936179
SELECT product_id, remaining_quantity, sale_price FROM products;	214316002
SELECT s.store_name, COUNT(e.employee_id) FROM stores s LEFT JOIN employees e ON s.store_id = e.store_id GROUP BY s.store_name;	3304679388
SELECT e.name, e.position, od.quantity 
FROM employees e
JOIN salesorders so ON e.employee_id = so.employee_id
JOIN orderdetails od ON so.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN stores s ON so.store_id = s.store_id
WHERE s.store_name = '科技中心店' 
  AND p.product_name = '戴森V11' 
  AND so.order_date = '2023-05-05' 
  AND od.quantity > 1;	1528991895
SELECT so.order_id, so.total_amount FROM salesorders so, stores s WHERE so.store_id = s.store_id AND s.store_name = '数码广场店';	127103551
SELECT a.assessment_id, a.risk_level, a.impact_score, e.event_type, e.event_description FROM risk_assessments a JOIN risk_events e ON a.event_id = e.event_id WHERE a.risk_level = '高' AND a.impact_score > 8;	1891291054
SELECT event_id FROM risk_events WHERE event_type = '合规风险';	491501449
SELECT re.event_description, a.status FROM risk_events re JOIN alerts a ON re.event_id = a.event_id WHERE a.alert_type = '欺诈嫌疑';	3354532402
SELECT r.report_type, AVG(e.severity) FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approval_status = '已批准' GROUP BY r.report_type;	1450781019
SELECT risk_level, COUNT(*), AVG(credit_score) FROM customers GROUP BY risk_level;	3784241191
SELECT ri.indicator_id, ri.indicator_name, ml.monitoring_date, ml.actual_value FROM risk_indicators ri JOIN risk_monitoring_logs ml ON ri.indicator_id = ml.indicator_id WHERE ml.monitoring_date >= '2023-10-01' AND ml.monitoring_date < '2023-11-01';	2169849694
SELECT rr.report_id, rr.report_date, rr.author, rr.event_id FROM risk_reports rr WHERE rr.approval_status = '已批准';	1821041301
SELECT c.risk_level, t.transaction_type, CASE WHEN t.amount <= 1000 THEN '低额' WHEN t.amount <= 10000 THEN '中额' ELSE '高额' END, COUNT(*), AVG(t.risk_score) FROM transactions t JOIN customers c ON t.customer_id = c.customer_id GROUP BY c.risk_level, t.transaction_type, CASE WHEN t.amount <= 1000 THEN '低额' WHEN t.amount <= 10000 THEN '中额' ELSE '高额' END;	2399924571
AMBIGUOUS_QUERY	2832409698
SELECT r.report_id, r.report_type, e.event_description, a.risk_level FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id JOIN risk_assessments a ON e.event_id = a.event_id WHERE r.author = '周婷';	4007902186
SELECT rr.report_id, rr.report_date, rr.author, rr.approval_status FROM risk_reports rr WHERE rr.report_date > '2022-12-31';	3766793908
SELECT e.event_id, e.event_description, a.risk_level, a.impact_score, a.probability_score, a.mitigation_plan FROM risk_events e JOIN risk_assessments a ON e.event_id = a.event_id WHERE e.event_description LIKE '%系统%';	379347511
SELECT indicator_id, actual_value FROM risk_monitoring_logs WHERE monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs);	1838288170
SELECT re.event_id, re.event_description, ra.risk_level, ra.mitigation_plan FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE ra.risk_level = '高风险' AND ra.assessor = '曾强';	3470826751
SELECT DISTINCT c.customer_name FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_type = '投资' AND t.risk_score > 60;	1344992090
SELECT re.event_id, re.created_at, re.status FROM risk_events re;	1091103550
SELECT c.customer_name, t.risk_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score < 600;	1666978001
SELECT t.amount, c.customer_name FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.status = '成功' AND t.transaction_date BETWEEN '2023-12-01' AND '2023-12-31';	3043489169
SELECT alert_type, alert_content FROM alerts;	228553912
SELECT report_id, report_type, approved_by FROM risk_reports;	3145840427
SELECT transaction_type, COUNT(*), SUM(CASE WHEN status = '成功' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS success_rate, AVG(risk_score) FROM transactions GROUP BY transaction_type;	2194753030
SELECT a.alert_id, a.alert_content, rc.rule_description FROM alerts a JOIN rule_configurations rc ON a.rule_id = rc.rule_id;	2007490591
SELECT DISTINCT ON (c.customer_id) c.customer_id, c.customer_name, t.status FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id ORDER BY c.customer_id, t.transaction_date DESC;	1993896438
SELECT i.indicator_id, i.indicator_name, AVG(l.actual_value), STDDEV(l.actual_value), CASE WHEN AVG(l.actual_value) != 0 THEN STDDEV(l.actual_value) / AVG(l.actual_value) ELSE NULL END FROM risk_indicators i JOIN risk_monitoring_logs l ON i.indicator_id = l.indicator_id GROUP BY i.indicator_id, i.indicator_name;	2353107053
SELECT DISTINCT c.customer_id, c.customer_name FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.risk_score > 80 AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year' INTERSECT SELECT DISTINCT c.customer_id, c.customer_name FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN audit_logs a ON t.transaction_id = a.transaction_id WHERE t.amount > 500000 AND a.audit_result = '未通过' AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	1348678368
SELECT AVG(impact_score) FROM risk_assessments WHERE mitigation_plan IS NULL;	3331891334
SELECT alert_id, alert_content, status FROM alerts;	3770586804
SELECT c.customer_id, c.customer_name, COUNT(CASE WHEN t.risk_score > 80 AND t.transaction_date >= date('now') - INTERVAL '90 days' THEN 1 END) AS high_risk_tx_count, COUNT(CASE WHEN a.status = '未处理' THEN 1 END) AS unprocessed_alerts, c.credit_score FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id LEFT JOIN risk_events re ON t.event_id = re.event_id LEFT JOIN alerts a ON re.event_id = a.event_id GROUP BY c.customer_id, c.customer_name, c.credit_score ORDER BY (COUNT(CASE WHEN t.risk_score > 80 AND t.transaction_date >= date('now') - INTERVAL '90 days' THEN 1 END) * 2 + COUNT(CASE WHEN a.status = '未处理' THEN 1 END) * 3 + (1.0/NULLIF(c.credit_score,0)) * 1000) DESC LIMIT 10;	2420031848
SELECT event_type, COUNT(*), AVG(severity) FROM risk_events WHERE occurrence_time >= '2023-01-01' AND occurrence_time < '2024-01-01' GROUP BY event_type ORDER BY COUNT(*) DESC;	2122948167
SELECT rr.*, re.event_type, re.event_description FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.report_content LIKE '%合规风险%';	1467350797
SELECT ri.indicator_id, ri.update_frequency, ri.data_source FROM risk_indicators ri;	1619162011
SELECT re.event_id, re.event_type, re.status, rr.report_content, rr.report_date FROM risk_events re LEFT JOIN (SELECT DISTINCT ON (event_id) event_id, report_content, report_date FROM risk_reports ORDER BY event_id, report_date DESC) rr ON re.event_id = rr.event_id WHERE re.status != '已解决';	3180110269
SELECT r.rule_type, AVG(alert_count) AS avg_alert_count, MAX(r.updated_at) AS last_updated 
FROM (SELECT a.rule_id, COUNT(*) AS alert_count FROM alerts a GROUP BY a.rule_id) AS rule_alerts 
JOIN rule_configurations r ON rule_alerts.rule_id = r.rule_id 
GROUP BY r.rule_type;	491065533
SELECT event_type, COUNT(event_id) FROM risk_events GROUP BY event_type ORDER BY COUNT(event_id) DESC;	210792684
SELECT DISTINCT c.customer_id, c.customer_name, c.credit_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date BETWEEN '2023-01-01' AND '2023-12-31' AND c.credit_score < 700;	528895519
SELECT re.event_id, re.event_type, rr.report_id FROM risk_events re LEFT JOIN risk_reports rr ON re.event_id = rr.event_id;	3994194373
SELECT COUNT(*) FROM risk_reports WHERE approval_status = '被拒绝' AND report_date BETWEEN '2023-01-01' AND '2023-12-31';	3108618170
SELECT ra.assessment_id, ra.mitigation_plan, ra.assessor FROM risk_assessments ra;	2756291249
SELECT m.log_id, m.actual_value, m.is_exceeding_threshold FROM (SELECT log_id, actual_value, is_exceeding_threshold, indicator_id, ROW_NUMBER() OVER (PARTITION BY indicator_id ORDER BY monitoring_date DESC) AS rn FROM risk_monitoring_logs) m WHERE m.rn = 1;	3508177846
SELECT rc.rule_id, rc.rule_name, COUNT(a.alert_id) FROM rule_configurations rc LEFT JOIN alerts a ON rc.rule_id = a.rule_id GROUP BY rc.rule_id, rc.rule_name;	3123122302
SELECT re.event_id, re.event_description, t.transaction_id, t.amount FROM risk_events re JOIN transactions t ON re.event_id = t.event_id WHERE re.event_type = '信用风险' AND t.status = '成功';	3431937746
SELECT c.risk_level, COUNT(c.customer_id) FROM customers c GROUP BY c.risk_level;	4153763267
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_amount) FROM (SELECT c.customer_id, SUM(t.amount) AS total_amount FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.registration_date < '2019-01-01' AND c.risk_level = '高' GROUP BY c.customer_id) AS customer_totals;	2480143604
SELECT rc.rule_name, re.event_description FROM alerts a JOIN rule_configurations rc ON a.rule_id = rc.rule_id JOIN risk_events re ON a.event_id = re.event_id WHERE a.alert_level = '高风险';	1278986057
SELECT event_id, created_at, status FROM risk_events;	983609731
SELECT DATE_TRUNC('month', created_at), event_type, COUNT(*) FROM risk_events GROUP BY DATE_TRUNC('month', created_at), event_type;	2727402886
SELECT DATE_TRUNC('month', transaction_date), AVG(amount), COUNT(*) FROM transactions GROUP BY DATE_TRUNC('month', transaction_date);	1304137472
SELECT rr.report_id, rr.report_type, rr.approved_by, re.event_description, re.severity FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approval_status = '已批准';	1801532770
SELECT c.customer_name, c.risk_level, t.status FROM customers c JOIN transactions t ON c.customer_id = t.customer_id;	2532729979
SELECT c.customer_name, t.transaction_type, t.status FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险';	1467489344
SELECT * FROM risk_reports WHERE author = '孙宇' AND (approval_status != '已审批' OR approval_status IS NULL);	2860062939
SELECT a.alert_content, e.event_description FROM alerts a JOIN risk_events e ON a.event_id = e.event_id WHERE a.status != '已处理';	186829469
SELECT risk_level, COUNT(*) FROM customers WHERE risk_level IN ('中', '高') GROUP BY risk_level;	1965814026
SELECT c.customer_id, c.customer_name, COUNT(t.transaction_id), AVG(t.risk_score) FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.customer_id, c.customer_name;	1229601142
SELECT DATE_TRUNC('month', registration_date), COUNT(*) FROM customers WHERE risk_level = '高风险' GROUP BY DATE_TRUNC('month', registration_date);	134467671
SELECT indicator_id, MAX(monitoring_date) FROM risk_monitoring_logs GROUP BY indicator_id;	2051579057
SELECT risk_level, COUNT(*), AVG(credit_score) FROM customers GROUP BY risk_level;	1467515231
SELECT a.alert_type, MAX(EXTRACT(EPOCH FROM (al.audit_time - a.alert_time))) FROM alerts a JOIN audit_logs al ON a.alert_id = al.alert_id WHERE a.status = '已解决' GROUP BY a.alert_type;	928241464
SELECT c.customer_name, t.amount, t.transaction_date FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date BETWEEN '2023-11-01' AND '2023-11-30' AND t.amount > 100000;	861248617
SELECT SUM(threshold_value) FROM risk_indicators WHERE indicator_name LIKE '%财务%';	2228247623
SELECT customer_name, credit_score FROM customers;	1010279388
SELECT c.customer_id, c.customer_name, t.transaction_id, t.transaction_date, t.risk_score FROM customers c JOIN (SELECT transaction_id, customer_id, transaction_date, risk_score, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_date DESC) AS rn FROM transactions) t ON c.customer_id = t.customer_id WHERE t.rn = 1;	3854618324
SELECT log_id, actual_value FROM risk_monitoring_logs WHERE is_exceeding_threshold = true;	4048786296
SELECT t.transaction_id, t.transaction_date, t.amount, t.risk_score, AVG(t.risk_score) OVER () FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险';	2208124060
SELECT t.transaction_id, t.risk_score FROM transactions t;	2046381691
SELECT report_type, COUNT(*) FROM risk_reports WHERE approval_status = '已拒绝' GROUP BY report_type;	218145680
SELECT c.customer_id, c.customer_name, c.credit_score, c.risk_level FROM customers c WHERE c.risk_level = '高' AND c.credit_score < 600;	4118993277
SELECT c.risk_level, AVG(t.amount), COUNT(t.transaction_id) / COUNT(DISTINCT c.customer_id) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY c.risk_level;	4099101626
SELECT rr.* FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE re.event_type = '流动性风险';	158715771
SELECT COUNT(DISTINCT c.customer_id), SUM(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score BETWEEN 600 AND 800;	1057264197
SELECT report_content FROM risk_reports WHERE approved_by = '王思远' AND report_date BETWEEN '2023-03-01' AND '2023-03-31';	2894258616
SELECT re.event_id, rr.report_id, rr.approval_status FROM risk_events re LEFT JOIN risk_reports rr ON re.event_id = rr.event_id;	1697426124
SELECT * FROM transactions WHERE transaction_date >= '2023-06-01' AND transaction_date <= '2023-06-30';	1368489416
SELECT re.event_id, re.event_type, re.event_description, al.audit_id, al.audit_type, al.audit_result FROM risk_events re INNER JOIN audit_logs al ON re.event_id = al.event_id WHERE re.severity = 3;	1079159915
SELECT ri.indicator_name, ri.threshold_value, rml.actual_value FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id WHERE rml.is_exceeding_threshold = true;	1387862561
SELECT DISTINCT c.customer_id, c.customer_name, c.credit_score, t.status FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id;	1914208134
SELECT re.event_id, re.event_description, a.alert_level, a.alert_content FROM risk_events re JOIN alerts a ON re.event_id = a.event_id WHERE a.alert_level = '高';	3189905137
SELECT re.event_id, re.event_description, a.alert_id, a.alert_time FROM risk_events re LEFT JOIN alerts a ON re.event_id = a.event_id ORDER BY a.alert_time;	434260556
SELECT c.risk_level, AVG(t.amount), COUNT(t.transaction_id) / COUNT(DISTINCT c.customer_id) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date >= CURRENT_DATE - INTERVAL '90 days' GROUP BY c.risk_level;	3762237075
SELECT c.customer_id, c.customer_name, c.credit_score FROM customers c WHERE c.risk_level = '高' AND c.credit_score < 700;	2322626250
SELECT c.customer_id, c.credit_score, t.transaction_id, t.status FROM customers c JOIN (SELECT transaction_id, customer_id, status, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_date DESC) AS rn FROM transactions WHERE status = '失败') t ON c.customer_id = t.customer_id AND t.rn = 1;	294935919
SELECT ra.assessment_id, ra.event_id, c.customer_id, c.customer_name, c.credit_score FROM risk_assessments ra JOIN transactions t ON ra.event_id = t.event_id JOIN customers c ON t.customer_id = c.customer_id WHERE ra.risk_level = '高风险' AND c.credit_score > 700;	1926912221
SELECT * FROM customers WHERE customer_type = '企业' ORDER BY credit_score DESC LIMIT 10;	3499522069
SELECT DATE_TRUNC('month', created_at), COUNT(*), AVG(SUM(CASE WHEN is_active THEN 1 ELSE 0 END)) OVER (ORDER BY DATE_TRUNC('month', created_at) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM rule_configurations GROUP BY DATE_TRUNC('month', created_at);	538732127
SELECT rr.author, rr.approval_status FROM risk_reports rr WHERE rr.approval_status = '已批准';	2736181075
SELECT c.customer_name, t.amount, t.status FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id;	1873450174
SELECT re.event_id, ra.assessment_id, ra.risk_level FROM risk_events re LEFT JOIN risk_assessments ra ON re.event_id = ra.event_id;	3031401155
SELECT ri.indicator_id, ri.indicator_name, ri.threshold_value, AVG(rml.actual_value) FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id GROUP BY ri.indicator_id, ri.indicator_name, ri.threshold_value;	1926763899
SELECT rr.report_id, rr.report_type, rr.report_content, re.event_type, re.event_description FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approval_status = '已批准';	2380941668
SELECT DISTINCT c.customer_id, c.customer_name, t.transaction_date FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN alerts a ON DATE(t.transaction_date) = DATE(a.alert_time) WHERE t.risk_score > 80 AND a.alert_level IN ('高', 'critical');	1133773952
SELECT t.transaction_id, c.customer_name FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.risk_score > 80;	2358748811
SELECT re.event_description, ra.assessment_date FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE ra.risk_level = '高';	634372359
SELECT c.customer_name, t.status FROM customers c JOIN (SELECT customer_id, status, transaction_date, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_date DESC) AS rn FROM transactions WHERE status = '失败') t ON c.customer_id = t.customer_id AND t.rn = 1 WHERE c.risk_level = '高风险';	54166415
SELECT re.event_id, COUNT(t.transaction_id) FROM risk_events re LEFT JOIN transactions t ON re.event_id = t.event_id GROUP BY re.event_id;	775802297
SELECT t.transaction_id, t.amount, t.transaction_date, c.customer_name, c.risk_level FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险' AND t.amount > 500000 AND t.transaction_date >= '2023-01-01' AND t.transaction_date < '2023-04-01';	3320369998
SELECT re.event_id, re.event_description, re.severity, ra.risk_level, ra.mitigation_plan FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE re.severity IN (4, 5) AND EXTRACT(YEAR FROM re.occurrence_time) = 2023;	4254692719
SELECT ml.log_id, ml.notes FROM risk_monitoring_logs ml WHERE ml.is_exceeding_threshold = false;	3645112410
SELECT r.report_id, r.report_type, r.author, e.event_type, e.severity, al.audit_result, al.audit_comments FROM risk_reports r LEFT JOIN risk_events e ON r.event_id = e.event_id LEFT JOIN (SELECT *, ROW_NUMBER() OVER (PARTITION BY related_id ORDER BY audit_time DESC) AS rn FROM audit_logs WHERE audit_type = '风险报告审核') al ON al.related_id = r.report_id AND al.rn = 1 WHERE r.approval_status = '待审批';	1798162210
SELECT c.customer_id, c.customer_name, c.credit_score, c.risk_level FROM customers c WHERE EXTRACT(YEAR FROM c.registration_date) = 2021 AND c.risk_level = '高' AND c.credit_score < 550;	2215350256
AMBIGUOUS_QUERY	1774673651
SELECT re.event_type, COUNT(re.event_id) FROM risk_events re GROUP BY re.event_type;	3960174076
SELECT c.customer_name, rc.rule_name, COUNT(*) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN risk_events re ON t.event_id = re.event_id JOIN alerts a ON re.event_id = a.event_id JOIN rule_configurations rc ON a.rule_id = rc.rule_id WHERE c.risk_level = '高' GROUP BY c.customer_name, rc.rule_name;	4181335061
SELECT DATE_TRUNC('month', re.occurrence_time), re.event_type, COUNT(*), AVG(re.severity), SUM(CASE WHEN re.status = '已解决' THEN 1 ELSE 0 END) / COUNT(*) FROM risk_events re GROUP BY DATE_TRUNC('month', re.occurrence_time), re.event_type;	995864049
SELECT ml.monitoring_date, ml.actual_value, ri.threshold_value FROM risk_monitoring_logs ml JOIN risk_indicators ri ON ml.indicator_id = ri.indicator_id;	430786160
SELECT c.risk_level, t.transaction_type, AVG(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level, t.transaction_type;	2101060146
SELECT COUNT(*) FROM rule_configurations WHERE is_active = true;	1665434378
SELECT customer_id, customer_name, risk_level, credit_score FROM customers;	3176119352
SELECT COUNT(*), AVG(update_frequency) FROM risk_indicators WHERE threshold_value > 100;	1713409158
SELECT customer_name, registration_date FROM customers;	1230885426
SELECT ri.indicator_id, ri.indicator_name, ml.log_id, ml.actual_value, ml.is_exceeding_threshold FROM risk_indicators ri LEFT JOIN risk_monitoring_logs ml ON ri.indicator_id = ml.indicator_id;	1766048190
SELECT ri.indicator_id, ri.indicator_name, ri.data_source, AVG(rml.actual_value), STDDEV(rml.actual_value) FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id GROUP BY ri.indicator_id, ri.indicator_name, ri.data_source;	2747654158
SELECT al.audit_id, al.audit_result, al.auditor FROM audit_logs al WHERE al.audit_result = '拒绝';	1853147969
SELECT alert_type, alert_content FROM alerts;	2764222826
SELECT a.alert_id, a.alert_type, a.alert_content, e.event_description, al.audit_result, al.audit_comments FROM alerts a JOIN risk_events e ON a.event_id = e.event_id LEFT JOIN (SELECT DISTINCT ON (alert_id) alert_id, audit_result, audit_comments FROM audit_logs WHERE alert_id IS NOT NULL ORDER BY alert_id, audit_time DESC) al ON a.alert_id = al.alert_id WHERE a.status = '未处理';	1328047815
SELECT AVG(EXTRACT(EPOCH FROM (NOW() - alert_time))) FROM alerts WHERE status = '未处理';	1153256443
SELECT c.customer_id, COUNT(ra.assessment_id), AVG(CASE WHEN ra.risk_level = '高' THEN 3 WHEN ra.risk_level = '中' THEN 2 ELSE 1 END), COUNT(a.alert_id) FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id LEFT JOIN risk_assessments ra ON t.event_id = ra.event_id LEFT JOIN alerts a ON t.event_id = a.event_id GROUP BY c.customer_id;	2529991047
SELECT event_type, COUNT(*) FROM risk_events WHERE status = '未处理' GROUP BY event_type;	1891370109
SELECT t.* FROM customers c INNER JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '低' AND c.credit_score > 700;	3513778977
SELECT a.alert_id, a.alert_type, a.alert_content, a.alert_level, re.event_id, re.event_type, re.severity FROM alerts a JOIN risk_events re ON a.event_id = re.event_id WHERE a.status = '未处理' AND a.alert_level = '高级';	1342627605
SELECT a.alert_content, a.status FROM alerts a JOIN rule_configurations r ON a.rule_id = r.rule_id WHERE r.rule_type = '合规违规';	2457540425
SELECT c.customer_id, c.risk_level, SUM(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高' GROUP BY c.customer_id, c.risk_level;	3803553571
SELECT report_content FROM risk_reports WHERE report_type = '月度风险报告' AND approval_status = '已拒绝';	3170647440
SELECT re.event_type, COUNT(re.event_id) FROM risk_events re GROUP BY re.event_type;	3365749326
SELECT c.customer_name, t.amount, t.transaction_date FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_type = '转账' AND t.amount > 200000 AND t.transaction_date >= '2023-05-04 00:00:00' AND t.transaction_date < '2023-05-05 00:00:00';	2632721664
SELECT a.alert_id, a.alert_content, a.alert_level, a.assigned_to, e.event_description FROM alerts a JOIN risk_events e ON a.event_id = e.event_id WHERE a.status = '未处理' AND a.alert_level = '高级别';	2115455156
SELECT rr.report_id, rr.report_content FROM risk_reports rr WHERE rr.report_date BETWEEN '2023-04-01' AND '2023-04-30' AND rr.approved_by = '高志远';	3669635067
SELECT transaction_type, COUNT(CASE WHEN status = '成功' THEN 1 END), COUNT(CASE WHEN status = '失败' THEN 1 END) FROM transactions GROUP BY transaction_type;	4274653529
SELECT re.event_id, ra.risk_level FROM risk_events re LEFT JOIN (SELECT event_id, risk_level, ROW_NUMBER() OVER (PARTITION BY event_id ORDER BY assessment_date DESC) AS rn FROM risk_assessments) ra ON re.event_id = ra.event_id AND ra.rn = 1;	522918260
SELECT c.customer_name, COUNT(DISTINCT ra.assessment_id), COUNT(DISTINCT t.transaction_id) FROM customers c INNER JOIN transactions t ON c.customer_id = t.customer_id INNER JOIN risk_assessments ra ON ra.event_id = t.event_id WHERE ra.risk_level = '高' AND t.amount > 500000 AND (ra.assessment_date >= CURRENT_DATE - INTERVAL '1 year' OR t.transaction_date >= CURRENT_DATE - INTERVAL '1 year') GROUP BY c.customer_id, c.customer_name;	4200581425
AMBIGUOUS_QUERY	4250954216
SELECT event_id, MAX(severity) FROM risk_events GROUP BY event_id;	3376384926
SELECT c.risk_level, COUNT(DISTINCT c.customer_id), AVG(t.amount) FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level;	1863389546
SELECT audit_time, audit_result FROM audit_logs WHERE auditor = '张强' AND alert_id IS NOT NULL;	1527263926
SELECT ml.log_id, ml.actual_value, ml.is_exceeding_threshold, ri.indicator_name FROM risk_monitoring_logs ml JOIN risk_indicators ri ON ml.indicator_id = ri.indicator_id;	959044977
SELECT ri.indicator_name, COUNT(*), AVG((rml.actual_value - ri.threshold_value) / ri.threshold_value * 100) FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id WHERE rml.is_exceeding_threshold = true AND rml.monitoring_date >= '2023-01-01' AND rml.monitoring_date < '2024-01-01' GROUP BY ri.indicator_name;	3965887957
SELECT a.alert_id, a.alert_content, a.status FROM alerts a WHERE a.alert_time >= '2023-01-01' AND a.alert_time < '2024-01-01';	1868278026
SELECT ri.indicator_id, ri.indicator_name, ml.monitoring_date, ml.actual_value FROM risk_indicators ri JOIN (SELECT indicator_id, monitoring_date, actual_value, ROW_NUMBER() OVER(PARTITION BY indicator_id ORDER BY monitoring_date DESC) AS rn FROM risk_monitoring_logs) ml ON ri.indicator_id = ml.indicator_id WHERE ml.rn = 1;	739540706
SELECT ri.indicator_id, ri.indicator_name, ri.threshold_value, COUNT(*), SUM(CASE WHEN rml.is_exceeding_threshold THEN 1 ELSE 0 END) FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id WHERE rml.monitoring_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY ri.indicator_id, ri.indicator_name, ri.threshold_value ORDER BY SUM(CASE WHEN rml.is_exceeding_threshold THEN 1 ELSE 0 END) DESC LIMIT 10;	2175305749
SELECT risk_level, COUNT(customer_id) FROM customers GROUP BY risk_level;	2458944386
SELECT customer_id, risk_score, status FROM transactions;	2707842138
SELECT ra.assessment_id, ra.risk_level, t.transaction_id, t.risk_score FROM risk_assessments ra INNER JOIN risk_events re ON ra.event_id = re.event_id INNER JOIN transactions t ON t.event_id = re.event_id WHERE ra.risk_level = '高风险' AND t.risk_score < 50;	1192678488
SELECT transaction_type, COUNT(*) FROM transactions WHERE status = '成功' GROUP BY transaction_type ORDER BY COUNT(*) DESC;	1326015635
SELECT t.transaction_id, t.amount, re.status FROM transactions t JOIN risk_events re ON t.event_id = re.event_id WHERE t.status = '失败' AND re.status = '已解决';	3710680886
SELECT t.transaction_id, c.customer_name FROM transactions t INNER JOIN customers c ON t.customer_id = c.customer_id WHERE t.status = '处理中';	581328064
SELECT t.transaction_id, t.amount, re.event_description FROM transactions t INNER JOIN risk_events re ON t.event_id = re.event_id WHERE t.amount > 1000;	3472554935
SELECT t.transaction_id, t.amount, t.transaction_date, c.customer_name, re.event_type, re.event_description FROM transactions t JOIN customers c ON t.customer_id = c.customer_id JOIN risk_events re ON t.event_id = re.event_id WHERE t.amount > 100000 AND c.risk_level = '高' AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	72136253
SELECT assessment_id, mitigation_plan FROM risk_assessments WHERE mitigation_plan IS NOT NULL;	3778743836
SELECT t.transaction_id, t.risk_score FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险';	1975692082
SELECT rml.actual_value, ri.indicator_name FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id WHERE rml.actual_value < ri.threshold_value;	263024116
SELECT rr.report_content, re.event_type, re.status FROM risk_reports rr INNER JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approval_status = '已拒绝';	4272740433
SELECT DISTINCT c.customer_name, c.credit_score, c.registration_date, t.transaction_date FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE EXTRACT(YEAR FROM c.registration_date) = 2021 AND c.credit_score > 700 AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	33599686
SELECT a.alert_id, a.alert_type, a.alert_content, re.event_id, re.event_type, t.transaction_id, t.amount FROM alerts a LEFT JOIN risk_events re ON a.event_id = re.event_id LEFT JOIN transactions t ON a.event_id = t.event_id WHERE a.assigned_to = '陈强';	1531250861
SELECT * FROM risk_reports WHERE report_content LIKE '%合规%';	3898772643
SELECT DATE_TRUNC('month', re.occurrence_time), COUNT(DISTINCT re.event_id), AVG(re.severity), COUNT(a.alert_id) FROM risk_events re LEFT JOIN alerts a ON re.event_id = a.event_id GROUP BY DATE_TRUNC('month', re.occurrence_time) ORDER BY DATE_TRUNC('month', re.occurrence_time);	3314311299
SELECT indicator_name, threshold_value FROM risk_indicators;	648920878
SELECT ri.indicator_name, rml.* FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id WHERE rml.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = rml.indicator_id);	2490177094
SELECT t.transaction_id, t.amount, c.customer_name, c.customer_type FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.amount > 100000;	4125993810
SELECT * FROM risk_reports WHERE approval_status = '已批准';	1573849130
SELECT transaction_type, AVG(risk_score) FROM transactions GROUP BY transaction_type;	180382260
SELECT event_id, event_type, created_at, MAX(CASE WHEN status = '处理中' THEN occurrence_time END), MAX(CASE WHEN status = '已解决' THEN occurrence_time END) FROM risk_events GROUP BY event_id, event_type, created_at;	3666899871
SELECT a.alert_type, COUNT(*) AS alert_count, AVG(EXTRACT(EPOCH FROM (al.audit_time - a.alert_time))) AS avg_processing_time FROM alerts a LEFT JOIN audit_logs al ON a.alert_id = al.alert_id GROUP BY a.alert_type;	3229183107
SELECT re.event_type, AVG(EXTRACT(EPOCH FROM (a.alert_time - re.created_at))) FROM risk_events re JOIN alerts a ON re.event_id = a.event_id WHERE a.status = '已解决' GROUP BY re.event_type;	1330206790
SELECT a.alert_content, re.status FROM alerts a JOIN risk_events re ON a.event_id = re.event_id;	1499863131
SELECT c.customer_name, COUNT(DISTINCT t.transaction_id), COUNT(DISTINCT a.alert_id) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN risk_events re ON t.event_id = re.event_id JOIN alerts a ON re.event_id = a.event_id WHERE t.transaction_date BETWEEN '2023-01-01' AND '2023-12-31' AND t.risk_score > 80 AND a.alert_level = '高级别' GROUP BY c.customer_name;	4020556557
SELECT re.event_id, re.severity, ra.risk_level FROM risk_events re LEFT JOIN risk_assessments ra ON re.event_id = ra.event_id;	2574806195
AMBIGUOUS_QUERY	368566951
SELECT c.customer_type, COUNT(c.customer_id) FROM customers c GROUP BY c.customer_type;	1635727552
SELECT ra.assessment_id, re.event_description FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id;	328924275
AMBIGUOUS_QUERY	206421261
SELECT c.customer_id, c.customer_name, c.risk_level, t.transaction_date, t.amount, t.risk_score FROM customers c JOIN (SELECT transaction_id, customer_id, transaction_date, amount, risk_score, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_date DESC) as rn FROM transactions) t ON c.customer_id = t.customer_id AND t.rn = 1 WHERE c.risk_level = '高风险';	1632035738
SELECT t.transaction_type, COUNT(t.transaction_id), COUNT(CASE WHEN t.status = '成功' THEN 1 END) FROM transactions t GROUP BY t.transaction_type;	3886658963
SELECT e.event_id, e.event_type, a.risk_level, a.mitigation_plan, a.assessor FROM risk_events e JOIN risk_assessments a ON e.event_id = a.event_id WHERE a.risk_level = '高';	2797728174
SELECT c.customer_id, c.customer_name, c.credit_score FROM customers c WHERE c.risk_level = '高' AND c.credit_score < 700;	4147622428
SELECT * FROM customers WHERE risk_level = '高' AND credit_score < 600;	2005982395
SELECT c.customer_id, c.risk_level, SUM(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.status = '成功' GROUP BY c.customer_id, c.risk_level;	2801172444
SELECT rr.report_id, rr.report_type, rr.approval_status, re.event_type, re.event_description FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approval_status = '已批准';	449712045
SELECT author, COUNT(*) FROM risk_reports GROUP BY author ORDER BY COUNT(*) DESC LIMIT 1;	3632195172
SELECT event_id, event_type, reporter FROM risk_events WHERE status = '未处理';	673496495
SELECT c.customer_name, c.last_update_date FROM customers c WHERE c.registration_date > '2021-01-01';	1638441248
SELECT rr.*, re.event_type, re.event_description FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approved_by = '高志远';	108772594
SELECT ri.indicator_id, ri.indicator_name, ri.threshold_value, rml.actual_value, rml.monitoring_date FROM risk_indicators ri JOIN (SELECT indicator_id, actual_value, monitoring_date, ROW_NUMBER() OVER (PARTITION BY indicator_id ORDER BY monitoring_date DESC) AS rn FROM risk_monitoring_logs) rml ON ri.indicator_id = rml.indicator_id WHERE rml.rn = 1;	4205470451
SELECT ml.log_id, ml.actual_value, ri.indicator_name FROM risk_monitoring_logs ml JOIN risk_indicators ri ON ml.indicator_id = ri.indicator_id;	3583518096
SELECT AVG(impact_score), AVG(probability_score) FROM risk_assessments;	2055776443
SELECT re.event_id, re.event_description, ra.assessor FROM risk_events re INNER JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE ra.assessor IS NOT NULL;	3949000806
SELECT SUM(amount) FROM transactions WHERE transaction_type = '退款';	2492972672
SELECT ri.*, rml.actual_value, rml.monitoring_date FROM risk_indicators ri LEFT JOIN (SELECT indicator_id, actual_value, monitoring_date FROM risk_monitoring_logs WHERE (indicator_id, monitoring_date) IN (SELECT indicator_id, MAX(monitoring_date) FROM risk_monitoring_logs GROUP BY indicator_id)) rml ON ri.indicator_id = rml.indicator_id;	3484790242
SELECT re.event_type, AVG(ra.assessment_date - re.occurrence_time) FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id GROUP BY re.event_type;	1982804371
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	4285492578
SELECT ra.assessment_id, re.event_description, ra.assessor FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id;	3769897631
SELECT *, COUNT(*) OVER() AS total_count FROM risk_monitoring_logs WHERE is_exceeding_threshold = TRUE;	529242231
SELECT re.event_id, ra.assessment_id, ra.mitigation_plan FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id;	3117545473
SELECT report_id, report_type, report_date, author FROM risk_reports WHERE approval_status = '已批准';	3370993536
SELECT c.* FROM customers c WHERE c.risk_level = '高' AND c.credit_score > (SELECT AVG(credit_score) FROM customers);	1091114187
SELECT alert_id, alert_content, assigned_to FROM alerts;	2742425726
SELECT re.event_id, re.event_description, re.severity, re.created_at, MAX(ra.assessment_date), MAX(ra.assessment_date) - re.created_at FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE re.status = '已解决' GROUP BY re.event_id ORDER BY MAX(ra.assessment_date) - re.created_at DESC LIMIT 10;	2894923077
SELECT rc.*, ri.indicator_name FROM rule_configurations rc JOIN risk_indicators ri ON rc.indicator_id = ri.indicator_id WHERE rc.is_active = true;	1904439079
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	1764574936
SELECT event_id, event_description, reporter FROM risk_events WHERE status != '已处理';	517879622
SELECT created_at FROM risk_events WHERE severity >= 3;	2298203203
SELECT ra.assessment_id, ra.mitigation_plan, ra.assessor FROM risk_assessments ra;	3327856710
SELECT a.alert_id, a.alert_content, a.alert_level, re.event_description, al.audit_comments, al.audit_time FROM alerts a JOIN risk_events re ON a.event_id = re.event_id JOIN (SELECT alert_id, audit_comments, audit_time, ROW_NUMBER() OVER (PARTITION BY alert_id ORDER BY audit_time DESC) AS rn FROM audit_logs) al ON a.alert_id = al.alert_id AND al.rn = 1 WHERE a.status != '已解决' AND a.alert_level = '高级';	3186015417
SELECT ra.assessment_id, ra.risk_level, ra.mitigation_plan, re.event_id, re.event_type, re.event_description FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id WHERE ra.risk_level = '高';	278998762
SELECT DISTINCT c.customer_id, c.customer_name, t.amount FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险' AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year' AND t.amount > 100000;	3967091987
SELECT assessment_id, event_id FROM risk_assessments WHERE impact_score > 8 AND risk_level = '高';	4092376057
SELECT re.event_id, rr.report_type, rr.report_content FROM risk_events re LEFT JOIN risk_reports rr ON re.event_id = rr.event_id;	4193608347
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND npl.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 2;	1848858966
SELECT * FROM regulatory_reports WHERE report_date = '2023-11-01';	4213891451
SELECT fii.institution_name FROM financial_institution_info fii JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE car.report_date BETWEEN '2023-06-01' AND '2023-06-30' AND npl.report_date BETWEEN '2023-06-01' AND '2023-06-30' AND car.total_car < 12 AND npl.npl_ratio > 2;	1479692348
SELECT fi.institution_name FROM risk_exposure re JOIN financial_institution_info fi ON re.institution_id = fi.institution_id WHERE re.total_risk_exposure > 0 ORDER BY (re.market_risk_exposure/re.total_risk_exposure) DESC LIMIT 1;	1995041708
SELECT fii.institution_name, rr.report_id, rr.report_type, rr.approval_status, fii.registered_capital FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE rr.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND fii.registered_capital > 50000000;	963624927
SELECT fi.institution_name, (car.risk_weighted_assets / bs.total_assets * 100) FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN balance_sheet bs ON fi.institution_id = bs.institution_id ORDER BY (car.risk_weighted_assets / bs.total_assets * 100) DESC LIMIT 1;	1658477082
SELECT liquidity_coverage_ratio, net_stable_funding_ratio FROM liquidity_ratio;	4132703668
SELECT DISTINCT institution_id FROM compliance_records WHERE report_date BETWEEN '2023-12-01' AND '2023-12-31' AND status != '已解决';	3320395647
SELECT institution_id, SUM(loans_and_advances), SUM(deposits) FROM balance_sheet WHERE EXTRACT(YEAR FROM report_date) = 2024 GROUP BY institution_id;	1564305915
SELECT * FROM balance_sheet WHERE report_date = '2039-06-08';	4026702014
SELECT COUNT(DISTINCT institution_id) FROM non_performing_loans WHERE npl_ratio > 3;	512893913
SELECT net_interest_income, non_interest_income FROM income_statement WHERE report_date = '2023-03-01';	387964381
SELECT npl_amount / total_loans FROM non_performing_loans;	392823504
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE EXTRACT(YEAR FROM rr.report_date) = 2023 AND EXTRACT(YEAR FROM npl.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 1;	2013521148
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' AND rr.approval_status = '待审核';	1920599339
SELECT institution_name, registered_capital FROM financial_institution_info WHERE institution_type = '非银行' ORDER BY registered_capital DESC LIMIT 5;	2173229598
SELECT COUNT(*) FROM (
    SELECT b.institution_id 
    FROM balance_sheet b
    JOIN non_performing_loans n ON b.institution_id = n.institution_id AND b.report_date = n.report_date
    WHERE b.institution_id IN (
        SELECT institution_id 
        FROM balance_sheet 
        ORDER BY total_assets DESC 
        LIMIT 500
    )
    AND n.npl_ratio < 1 
    AND n.provision_coverage_ratio > 200
) AS subquery;	1986299311
SELECT fii.institution_name FROM financial_institution_info fii JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE car.report_date = '2023-12-01' AND rr.report_date = '2023-12-01' AND car.core_tier_1_ratio < 10 AND rr.approval_status = '待审核';	1934474274
SELECT institution_id, (MAX(net_interest_income + non_interest_income) - MIN(net_interest_income + non_interest_income)) / MIN(net_interest_income + non_interest_income) * 100 AS revenue_growth_rate FROM income_statement WHERE report_date >= CURRENT_DATE - INTERVAL '2 years' GROUP BY institution_id ORDER BY revenue_growth_rate DESC, (MAX(net_profit) - MIN(net_profit)) / NULLIF(MIN(net_profit), 0) ASC LIMIT 1;	3102250159
SELECT report_id, approval_status FROM regulatory_reports WHERE report_date = '2023-07-01';	3066710012
SELECT DISTINCT fi.institution_id, fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE car.core_tier_1_ratio > (SELECT AVG(core_tier_1_ratio) FROM capital_adequacy_ratio) AND car.tier_1_ratio > (SELECT AVG(tier_1_ratio) FROM capital_adequacy_ratio) AND car.total_car > (SELECT AVG(total_car) FROM capital_adequacy_ratio);	3079904075
SELECT * FROM compliance_records WHERE status = '已解决' AND record_date BETWEEN '2023-01-01' AND '2023-12-31';	2257683611
SELECT report_type, COUNT(*) FROM regulatory_reports WHERE report_date BETWEEN '2023-07-01' AND '2023-09-30' GROUP BY report_type ORDER BY COUNT(*) DESC LIMIT 1;	722775591
SELECT tier_1_ratio FROM capital_adequacy_ratio;	692012487
SELECT fii.institution_name, lr.report_date FROM financial_institution_info fii JOIN liquidity_ratio lr ON fii.institution_id = lr.institution_id WHERE lr.liquidity_coverage_ratio > 100;	3599351686
SELECT b.institution_id, b.report_date, b.total_liabilities / b.total_assets 
FROM balance_sheet b
JOIN (
    SELECT institution_id, STDDEV(total_liabilities / total_assets) AS ratio_stddev
    FROM balance_sheet
    WHERE report_date >= CURRENT_DATE - INTERVAL '2 years'
    GROUP BY institution_id
    ORDER BY ratio_stddev DESC
    LIMIT 5
) top5 ON b.institution_id = top5.institution_id
WHERE b.report_date >= CURRENT_DATE - INTERVAL '2 years'
ORDER BY b.institution_id, b.report_date;	3317302935
SELECT record_id, institution_id, record_date, resolution_date, description, severity, status, compliance_type FROM compliance_records WHERE record_date BETWEEN '2023-03-01' AND '2023-03-31';	3773444090
SELECT institution_id, record_date, description, severity FROM compliance_records WHERE record_date BETWEEN '2024-01-01' AND '2024-12-31';	1568439599
SELECT report_type FROM regulatory_reports WHERE report_date = '2023-10-01';	2339192001
SELECT * FROM compliance_records WHERE severity = '中' AND report_date BETWEEN '2023-01-01' AND '2023-12-31';	1629609477
SELECT * FROM compliance_records WHERE record_date = '2023-10-01';	3577134167
SELECT DISTINCT lr.institution_id FROM liquidity_ratio lr WHERE lr.liquidity_coverage_ratio > (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio) AND lr.net_stable_funding_ratio > (SELECT AVG(net_stable_funding_ratio) FROM liquidity_ratio) AND lr.loan_to_deposit_ratio > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio);	1942470085
SELECT fii.institution_name, rr.report_type, rr.submission_date FROM regulatory_reports rr JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.submission_date BETWEEN '2023-07-01' AND '2023-09-30' AND rr.approval_status = '需修改' ORDER BY rr.submission_date DESC;	385930717
SELECT fii.institution_name FROM financial_institution_info fii 
WHERE fii.institution_id IN (
    SELECT car.institution_id FROM capital_adequacy_ratio car 
    WHERE car.total_car <= (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY total_car) FROM capital_adequacy_ratio)
) 
AND fii.institution_id IN (
    SELECT npl.institution_id FROM non_performing_loans npl 
    WHERE npl.npl_ratio < (SELECT AVG(npl_ratio) FROM non_performing_loans)
);	528420038
SELECT registered_capital, institution_type FROM financial_institution_info;	2513164587
SELECT establishment_date, legal_representative FROM financial_institution_info;	1975090084
SELECT * FROM compliance_records WHERE status = '已解决';	107672657
SELECT fii.institution_name, rr.approval_status, npl.npl_ratio FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.approval_status = '需修改' AND npl.npl_ratio > 1 AND rr.report_date BETWEEN '2023-07-01' AND '2023-07-31' AND npl.report_date BETWEEN '2023-07-01' AND '2023-07-31';	1483363664
SELECT institution_id FROM balance_sheet ORDER BY ABS(loans_and_advances/NULLIF(deposits,0) - 1) ASC LIMIT 1;	2929840073
SELECT DISTINCT institution_id FROM non_performing_loans WHERE total_loans > 100000000000;	1300789994
SELECT cash_and_equivalents FROM balance_sheet WHERE report_date = '2026-04-27';	2165898338
SELECT DISTINCT institution_id FROM capital_adequacy_ratio WHERE core_tier_1_ratio < 9;	3755218299
SELECT fi.institution_name, rr.report_type, rr.approval_status, npl.npl_ratio FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id JOIN non_performing_loans npl ON rr.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '已拒绝' AND npl.npl_ratio > 2 AND EXTRACT(YEAR FROM rr.report_date) = 2023 AND EXTRACT(YEAR FROM npl.report_date) = 2023;	523740688
SELECT COUNT(*) FROM (SELECT c.institution_id FROM capital_adequacy_ratio c JOIN balance_sheet b ON c.institution_id = b.institution_id AND c.report_date = b.report_date GROUP BY c.institution_id ORDER BY (SUM(c.risk_weighted_assets)/SUM(b.total_assets)) DESC LIMIT 10) top10 JOIN risk_exposure r ON top10.institution_id = r.institution_id WHERE r.market_risk_exposure > (SELECT 1.5 * AVG(market_risk_exposure) FROM risk_exposure);	3766160186
SELECT NULL AS avg_branch_count;	3227551380
SELECT fi.institution_id, fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE (re.market_risk_exposure/re.total_risk_exposure) > 0.2 AND car.core_tier_1_ratio < 8.5;	2211928222
SELECT fii.institution_name, car.core_tier_1_ratio, car.tier_1_ratio, car.total_car FROM financial_institution_info fii JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id WHERE car.report_date = '2023-12-01' AND car.core_tier_1_ratio < 10 AND car.total_car < 12;	1570037252
SELECT COUNT(*) FROM compliance_records WHERE severity = '高' AND record_date BETWEEN '2023-01-01' AND '2023-12-31';	1995720794
SELECT fii.institution_name FROM financial_institution_info fii JOIN balance_sheet bs ON fii.institution_id = bs.institution_id ORDER BY (bs.cash_and_equivalents/bs.total_assets) DESC LIMIT 1;	2276785796
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id WHERE (re.market_risk_exposure / re.total_risk_exposure) > 0.4;	1118569576
SELECT fi.institution_name, rr.approval_status, rr.comments FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.approval_status = '已批准' AND rr.comments IS NOT NULL ORDER BY LENGTH(rr.comments) DESC;	201491443
SELECT fii.institution_name FROM financial_institution_info fii INNER JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id INNER JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE EXTRACT(YEAR FROM car.report_date) = 2023 AND car.core_tier_1_ratio < 8 AND rr.approval_status = '已批准';	883311234
SELECT institution_id, credit_risk_exposure, operational_risk_exposure FROM risk_exposure WHERE report_date BETWEEN '2024-01-01' AND '2024-01-31';	1131673647
SELECT record_id, institution_id, record_date, resolution_date, description, severity, status, compliance_type FROM compliance_records WHERE record_date = '2023-04-02';	626463466
SELECT npl.report_date, npl.npl_ratio, car.total_car FROM non_performing_loans npl JOIN capital_adequacy_ratio car ON npl.institution_id = car.institution_id AND npl.report_date = car.report_date ORDER BY npl.report_date;	4144375691
SELECT institution_id, provision_coverage_ratio FROM non_performing_loans WHERE provision_coverage_ratio > 150;	3229296369
SELECT * FROM related_party_transactions WHERE transaction_date = '2023-12-22';	386496319
SELECT fi.institution_name FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE lr.liquidity_coverage_ratio > 110 AND npl.npl_ratio < 1.5;	1091949185
SELECT r.institution_id, f.institution_name, r.report_type, r.approval_status, n.npl_ratio FROM regulatory_reports r JOIN financial_institution_info f ON r.institution_id = f.institution_id JOIN non_performing_loans n ON r.institution_id = n.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND n.npl_ratio > 2 AND EXTRACT(YEAR FROM n.report_date) = 2023;	2649798001
SELECT institution_id, AVG(net_profit / (net_interest_income + non_interest_income)) FROM income_statement WHERE report_date >= CURRENT_DATE - INTERVAL '2 years' GROUP BY institution_id ORDER BY AVG(net_profit / (net_interest_income + non_interest_income)) DESC LIMIT 5;	3441420122
SELECT fi.institution_type, AVG(npl.npl_ratio) FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE npl.report_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY fi.institution_type;	3747732181
SELECT COUNT(DISTINCT re.institution_id) FROM (SELECT institution_id, report_date, market_risk_exposure, LEAD(market_risk_exposure) OVER (PARTITION BY institution_id ORDER BY report_date DESC) AS prev_market_risk FROM risk_exposure) re JOIN (SELECT institution_id, report_date, total_car, LEAD(total_car) OVER (PARTITION BY institution_id ORDER BY report_date DESC) AS prev_car FROM capital_adequacy_ratio) car ON re.institution_id = car.institution_id AND re.report_date = car.report_date WHERE re.prev_market_risk > 0 AND (re.market_risk_exposure - re.prev_market_risk)/re.prev_market_risk > 0.5 AND (car.total_car - car.prev_car) < 1;	919872126
SELECT institution_id, SUM(total_assets), SUM(total_liabilities) FROM balance_sheet GROUP BY institution_id;	2908646442
SELECT fii.institution_name, rr.approval_status, rpt.transaction_amount FROM financial_institution_info fii INNER JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id INNER JOIN related_party_transactions rpt ON fii.institution_id = rpt.institution_id WHERE rr.report_date BETWEEN '2023-07-01' AND '2023-07-31' AND rr.approval_status = '需修改' AND rpt.transaction_amount > 5000000;	2285587483
SELECT AVG(car.total_car) FROM capital_adequacy_ratio car JOIN (SELECT DISTINCT institution_id FROM balance_sheet WHERE total_assets > 100000000000) bs ON car.institution_id = bs.institution_id;	649523026
SELECT * FROM risk_exposure WHERE report_date = '2023-10-01';	3485650704
SELECT fii.institution_name FROM financial_institution_info fii JOIN related_party_transactions rpt ON fii.institution_id = rpt.institution_id JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE rpt.transaction_date = '2023-06-01' AND rpt.transaction_amount > 5000000 AND rr.report_date = '2023-06-01' AND rr.approval_status = '已批准';	1308426053
SELECT corr(b.total_assets, c.total_car) FROM balance_sheet b JOIN capital_adequacy_ratio c ON b.institution_id = c.institution_id AND b.report_date = c.report_date;	2884378083
SELECT institution_id, COUNT(*), SUM(CASE WHEN approval_status != '已批准' THEN 1 ELSE 0 END) FROM related_party_transactions WHERE transaction_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY institution_id HAVING (SUM(CASE WHEN approval_status != '已批准' THEN 1 ELSE 0 END)::float / COUNT(*)) > 0.2;	443478039
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND npl.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 2;	4005725614
SELECT r.institution_id, r.approval_status, c.compliance_type, c.severity, c.status FROM regulatory_reports r JOIN compliance_records c ON r.institution_id = c.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND EXTRACT(YEAR FROM c.record_date) = 2023;	4256634062
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' AND npl.report_date = '2023-10-01' AND npl.npl_ratio > 2;	2610777117
SELECT institution_id, liquidity_coverage_ratio, net_stable_funding_ratio FROM liquidity_ratio WHERE report_date >= '2023-05-01' AND report_date < '2023-06-01';	1523818846
SELECT institution_id, SUM(non_interest_income) FROM income_statement WHERE report_date = '2023-03-01' GROUP BY institution_id;	959939959
SELECT * FROM risk_exposure WHERE report_date = '2023-02-01';	1728769608
SELECT COUNT(*) FROM related_party_transactions WHERE transaction_date BETWEEN '2023-01-01' AND '2023-12-31' AND transaction_amount > 500000000 AND transaction_type = '资产转移';	192754968
SELECT fii.institution_name FROM financial_institution_info fii INNER JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id INNER JOIN related_party_transactions rpt ON fii.institution_id = rpt.institution_id WHERE rr.report_date = '2023-08-01' AND rr.approval_status = '需修改' AND rpt.transaction_date = '2023-08-01' AND rpt.transaction_amount > 5000000;	1423558555
SELECT r.institution_id, f.institution_name FROM regulatory_reports r JOIN financial_institution_info f ON r.institution_id = f.institution_id JOIN income_statement i ON r.institution_id = i.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND i.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND i.net_profit > 10000000;	1234119757
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE rr.report_date = '2023-07-01' AND rr.approval_status = '需要修改' AND rr.report_type = '季度报告';	4123846713
SELECT * FROM compliance_records WHERE compliance_type = '内控管理';	2934745000
SELECT fii.institution_name, rr.report_type, rr.approval_status, npl.npl_ratio FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.report_date BETWEEN '2023-10-01' AND '2023-10-31' AND npl.report_date BETWEEN '2023-10-01' AND '2023-10-31' AND rr.report_type = '半年度报告' AND rr.approval_status = '待审核' AND npl.npl_ratio > 1;	2857258268
SELECT fi.institution_type, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl.npl_ratio) FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id GROUP BY fi.institution_type;	3135361103
SELECT * FROM capital_adequacy_ratio WHERE core_tier_1_ratio < 0.08;	2627561757
SELECT r.institution_id, f.institution_name, f.registered_capital, r.report_type, r.approval_status FROM regulatory_reports r JOIN financial_institution_info f ON r.institution_id = f.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '半年度报告' AND r.approval_status = '待审核' AND f.registered_capital > 50000000;	1691256900
SELECT fii.institution_name FROM financial_institution_info fii JOIN related_party_transactions rpt ON fii.institution_id = rpt.institution_id WHERE rpt.transaction_date = '2023-06-01' AND rpt.transaction_amount > 5000000 AND rpt.approval_status = '待审批';	3500907449
SELECT lr.institution_id FROM liquidity_ratio lr WHERE lr.loan_to_deposit_ratio > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio) AND lr.liquidity_coverage_ratio < (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio);	1148055259
SELECT f.institution_name FROM financial_institution_info f JOIN income_statement i ON f.institution_id = i.institution_id WHERE i.report_date = '2023-04-01' AND i.net_interest_income > 1000000000;	2380032898
SELECT r.institution_id, r.report_id, r.report_type, r.approval_status, n.npl_ratio FROM regulatory_reports r JOIN non_performing_loans n ON r.institution_id = n.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND n.npl_ratio > 1 AND n.report_date BETWEEN '2023-01-01' AND '2023-12-31';	3197865400
SELECT fii.institution_name, re.total_risk_exposure, car.core_tier_1_ratio FROM financial_institution_info fii JOIN risk_exposure re ON fii.institution_id = re.institution_id JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id WHERE re.report_date = '2023-10-01' AND car.report_date = '2023-10-01' AND re.total_risk_exposure > 3000 AND car.core_tier_1_ratio < 8;	1039966050
SELECT COUNT(DISTINCT re.institution_id) FROM risk_exposure re JOIN (SELECT institution_id, MIN(report_date) as min_date, MAX(report_date) as max_date FROM risk_exposure WHERE report_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY institution_id HAVING COUNT(*) > 1) dates ON re.institution_id = dates.institution_id JOIN (SELECT institution_id, market_risk_exposure/credit_risk_exposure as ratio FROM risk_exposure WHERE report_date = dates.min_date) early ON re.institution_id = early.institution_id JOIN (SELECT institution_id, market_risk_exposure/credit_risk_exposure as ratio FROM risk_exposure WHERE report_date = dates.max_date) late ON re.institution_id = late.institution_id WHERE ABS(late.ratio - early.ratio)/early.ratio > 0.1;	198071887
SELECT b.institution_id FROM balance_sheet b WHERE b.loans_and_advances > b.deposits;	1236237152
SELECT fii.institution_name, rr.report_date, rr.approval_status FROM regulatory_reports rr JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	968909295
SELECT f.institution_name FROM financial_institution_info f JOIN income_statement i ON f.institution_id = i.institution_id WHERE i.report_date = '2023-04-01' AND i.non_interest_income > 200000000;	2730335394
SELECT institution_id, COUNT(*) FROM related_party_transactions WHERE transaction_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY institution_id ORDER BY COUNT(*) DESC LIMIT 1;	3396337586
SELECT fi.institution_name, (re.credit_risk_exposure / re.total_risk_exposure * 100) FROM risk_exposure re JOIN financial_institution_info fi ON re.institution_id = fi.institution_id ORDER BY (re.credit_risk_exposure / re.total_risk_exposure) DESC LIMIT 1;	3597519580
SELECT DISTINCT institution_id FROM risk_exposure WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31';	3614967513
SELECT institution_id FROM capital_adequacy_ratio WHERE EXTRACT(YEAR FROM report_date) = 2023 AND EXTRACT(MONTH FROM report_date) = 11 AND risk_weighted_assets > 1200;	2748780530
SELECT severity, AVG(resolution_date - record_date) FROM compliance_records WHERE resolution_date IS NOT NULL GROUP BY severity;	2632158975
SELECT COUNT(DISTINCT institution_id) FROM liquidity_ratio WHERE liquidity_coverage_ratio >= 100 AND net_stable_funding_ratio >= 100;	2902591324
SELECT AVG(npl.npl_ratio), AVG(npl.provision_coverage_ratio), AVG(car.total_car) FROM (SELECT institution_id FROM balance_sheet WHERE report_date = (SELECT MAX(report_date) FROM balance_sheet) ORDER BY total_assets DESC LIMIT 1000) AS top_institutions JOIN non_performing_loans npl ON top_institutions.institution_id = npl.institution_id AND npl.report_date = (SELECT MAX(report_date) FROM non_performing_loans) JOIN capital_adequacy_ratio car ON top_institutions.institution_id = car.institution_id AND car.report_date = (SELECT MAX(report_date) FROM capital_adequacy_ratio);	1348038828
SELECT fii.institution_name, rr.report_type, npl.npl_ratio FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND npl.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND npl.npl_ratio > 1.5;	3607596195
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.report_date = '2024-01-01' AND rr.report_type = '年度报告' AND rr.approval_status = '已批准' AND npl.report_date = '2024-01-01' AND npl.npl_ratio > 1;	3633299910
SELECT lr.liquidity_coverage_ratio, lr.net_stable_funding_ratio, lr.loan_to_deposit_ratio FROM liquidity_ratio lr;	1922989461
SELECT fi.institution_name FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE EXTRACT(YEAR FROM npl.report_date) = 2023 AND EXTRACT(MONTH FROM npl.report_date) = 12 AND npl.npl_ratio > 1.5;	2401722243
SELECT fi.institution_name FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id WHERE lr.loan_to_deposit_ratio > 75 AND lr.liquidity_coverage_ratio < 120;	2405354254
SELECT * FROM regulatory_reports WHERE report_type = '半年度报告';	4266831229
SELECT * FROM compliance_records WHERE status = '已解决' AND resolution_date IS NOT NULL ORDER BY (resolution_date - record_date) DESC LIMIT 5;	1742014679
SELECT r.institution_id, r.report_id, r.report_type, r.approval_status, n.npl_ratio FROM regulatory_reports r JOIN non_performing_loans n ON r.institution_id = n.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND n.npl_ratio > 2 AND n.report_date BETWEEN '2023-01-01' AND '2023-12-31';	3817977186
SELECT fii.institution_name, rr.report_id, rr.report_date, rr.comments FROM regulatory_reports rr JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	1802118314
SELECT f.institution_name FROM financial_institution_info f JOIN liquidity_ratio l ON f.institution_id = l.institution_id WHERE l.loan_to_deposit_ratio BETWEEN 60 AND 80;	2087453732
SELECT institution_id FROM capital_adequacy_ratio WHERE ABS(core_tier_1_ratio - total_car) = (SELECT MIN(ABS(core_tier_1_ratio - total_car)) FROM capital_adequacy_ratio);	3808399451
SELECT b.institution_id, b.total_liabilities, f.registered_capital FROM balance_sheet b JOIN financial_institution_info f ON b.institution_id = f.institution_id WHERE EXTRACT(YEAR FROM b.report_date) = 2024;	2456149460
SELECT corr(npl.npl_ratio, re.credit_risk_exposure) FROM non_performing_loans npl JOIN risk_exposure re ON npl.institution_id = re.institution_id AND npl.report_date = re.report_date;	3432807420
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id WHERE rr.report_type = '年度报告' AND rr.approval_status = '已批准' AND EXTRACT(YEAR FROM rr.report_date) = 2023 AND car.total_car > 10;	2831855702
SELECT npl_ratio, institution_id FROM non_performing_loans WHERE report_date = '2023-06-01';	937269248
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id WHERE re.report_date BETWEEN '2023-05-01' AND '2023-05-31' AND re.market_risk_exposure > 20000000000;	1582158774
SELECT fii.institution_name, rr.report_date, rr.approval_status FROM regulatory_reports rr JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.report_date BETWEEN '2024-01-01' AND '2024-12-31' AND rr.report_type = '年度报告' AND rr.approval_status = '已批准';	1919719297
SELECT * FROM capital_adequacy_ratio WHERE report_date = '2023-11-01';	290598667
SELECT corr(l.net_stable_funding_ratio, c.core_tier_1_ratio) FROM liquidity_ratio l JOIN capital_adequacy_ratio c ON l.institution_id = c.institution_id AND l.report_date = c.report_date;	2475489916
SELECT fii.institution_name, rr.report_date FROM regulatory_reports rr INNER JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.report_date BETWEEN '2024-01-01' AND '2024-12-31' AND rr.report_type = '年度报告' AND rr.approval_status = '已批准';	3290412838
SELECT * FROM capital_adequacy_ratio WHERE report_date = '2023-11-01';	3667228314
SELECT core_tier_1_ratio, tier_1_ratio, total_car, risk_weighted_assets, report_date FROM capital_adequacy_ratio WHERE institution_id = 2162;	3772456063
SELECT institution_id, SUM(total_loans), SUM(npl_amount) FROM non_performing_loans WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY institution_id;	1771519459
SELECT corr(re.market_risk_exposure / re.total_risk_exposure, is.non_interest_income / (is.net_interest_income + is.non_interest_income)) FROM risk_exposure re JOIN income_statement is ON re.institution_id = is.institution_id AND re.report_date = is.report_date WHERE re.total_risk_exposure != 0 AND (is.net_interest_income + is.non_interest_income) != 0;	3968495722
SELECT institution_id, provision_coverage_ratio FROM non_performing_loans ORDER BY provision_coverage_ratio DESC LIMIT 1;	3848674416
SELECT lr.institution_id, lr.report_date, lr.liquidity_coverage_ratio, lr.net_stable_funding_ratio, lr.loan_to_deposit_ratio, car.core_tier_1_ratio, car.tier_1_ratio, car.total_car FROM liquidity_ratio lr JOIN capital_adequacy_ratio car ON lr.institution_id = car.institution_id AND lr.report_date = car.report_date WHERE lr.report_date BETWEEN '2023-01-01' AND '2023-12-31';	3699682626
SELECT f.institution_name FROM income_statement i JOIN financial_institution_info f ON i.institution_id = f.institution_id WHERE i.report_date = '2023-04-01' ORDER BY i.operating_expenses DESC LIMIT 1;	2936322968
SELECT institution_id, SUM(non_interest_income), SUM(net_profit) FROM income_statement WHERE EXTRACT(YEAR FROM report_date) = 2023 GROUP BY institution_id;	4218229725
SELECT fi.institution_name, rr.report_type, rr.approval_status, npl.npl_ratio FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id JOIN non_performing_loans npl ON rr.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '已拒绝' AND npl.npl_ratio > 2 AND EXTRACT(YEAR FROM rr.report_date) = 2023 AND EXTRACT(YEAR FROM npl.report_date) = 2023;	2633632934
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE car.core_tier_1_ratio < 9 AND car.report_date >= '2023-12-01' AND car.report_date <= '2023-12-31';	2211128720
SELECT institution_id FROM liquidity_ratio WHERE liquidity_coverage_ratio < 110 AND report_date BETWEEN '2023-11-01' AND '2023-11-30';	3020061302
SELECT re.market_risk_exposure, npl.provision_coverage_ratio FROM risk_exposure re INNER JOIN non_performing_loans npl ON re.institution_id = npl.institution_id WHERE re.report_date = '2023-03-01' AND npl.report_date = '2023-03-01';	3525231563
SELECT legal_representative, contact_number FROM financial_institution_info;	2015435463
SELECT fi.institution_name, COUNT(DISTINCT rpt.related_party) FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE EXTRACT(YEAR FROM rpt.transaction_date) = 2023 GROUP BY fi.institution_name ORDER BY COUNT(DISTINCT rpt.related_party) DESC LIMIT 1;	4069066039
SELECT fi.address, AVG(lr.liquidity_coverage_ratio) FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id GROUP BY fi.address ORDER BY AVG(lr.liquidity_coverage_ratio) DESC LIMIT 1;	803154529
SELECT EXTRACT(QUARTER FROM report_date) AS QUARTER FROM regulatory_reports WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY QUARTER ORDER BY QUARTER;	3721655383
SELECT fi.institution_name, npl.provision_coverage_ratio FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id ORDER BY npl.provision_coverage_ratio DESC LIMIT 1;	1629126831
SELECT legal_representative, contact_number FROM financial_institution_info;	4123438074
SELECT fii.institution_name, rr.report_date, rr.submission_date FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE EXTRACT(YEAR FROM rr.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '需修改';	2499994444
SELECT fi.institution_name, car.total_car, npl.npl_ratio FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id AND car.report_date = npl.report_date WHERE car.total_car > 12 AND npl.npl_ratio < 2;	2833113074
SELECT institution_id FROM liquidity_ratio WHERE net_stable_funding_ratio > (SELECT AVG(net_stable_funding_ratio) FROM liquidity_ratio) AND loan_to_deposit_ratio < (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio) GROUP BY institution_id ORDER BY COUNT(*) DESC LIMIT 10;	3586979855
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id WHERE EXTRACT(YEAR FROM re.report_date) = 2023 AND re.credit_risk_exposure > 50000000000;	3035130167
SELECT fi.institution_name FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE npl.npl_ratio > 2;	991328095
SELECT * FROM capital_adequacy_ratio WHERE report_date = '2023-05-01';	193769567
SELECT institution_id, severity, COUNT(*) FROM compliance_records WHERE record_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY institution_id, severity;	1904851109
SELECT fii.institution_name, rr.report_date, rr.comments FROM regulatory_reports rr INNER JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	1910117598
SELECT institution_id, transaction_id, transaction_amount FROM related_party_transactions;	1443528046
SELECT fi.institution_name, rr.report_type, SUM(rpt.transaction_amount) FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' GROUP BY fi.institution_name, rr.report_type HAVING SUM(rpt.transaction_amount) > 10000000;	2822939894
SELECT fii.institution_name, rr.report_id, rr.report_date, rr.comments FROM regulatory_reports rr JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	835822696
SELECT fii.institution_name, rr.report_type, rr.approval_status, rr.submission_date FROM regulatory_reports rr INNER JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	3549330683
SELECT npl.npl_ratio, info.address FROM non_performing_loans npl INNER JOIN financial_institution_info info ON npl.institution_id = info.institution_id;	3331068318
SELECT report_id, institution_id, report_date, report_type, approval_status FROM regulatory_reports WHERE EXTRACT(YEAR FROM report_date) = 2024;	1531917176
SELECT fi.institution_type, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lr.liquidity_coverage_ratio) FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id GROUP BY fi.institution_type;	760513399
SELECT r.institution_id, r.report_id, r.report_type, r.approval_status, c.core_tier_1_ratio FROM regulatory_reports r JOIN capital_adequacy_ratio c ON r.institution_id = c.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND c.report_date = '2023-06-01' AND c.core_tier_1_ratio < 8;	3284405813
SELECT AVG(npl.npl_ratio) FROM (SELECT institution_id FROM capital_adequacy_ratio WHERE report_date BETWEEN '2023-07-01' AND '2023-09-30' ORDER BY total_car DESC LIMIT 10) AS top10 JOIN non_performing_loans npl ON top10.institution_id = npl.institution_id WHERE npl.report_date BETWEEN '2023-07-01' AND '2023-09-30';	2472810304
SELECT fii.institution_name FROM financial_institution_info fii JOIN (SELECT institution_id, COUNT(*) AS unresolved_count FROM compliance_records WHERE status != '已解决' OR resolution_date IS NULL GROUP BY institution_id ORDER BY unresolved_count DESC LIMIT 1) cr ON fii.institution_id = cr.institution_id;	2615993388
SELECT * FROM related_party_transactions WHERE transaction_date BETWEEN '2023-01-01' AND '2023-12-31' AND transaction_amount > 5000000;	377772969
SELECT institution_id FROM risk_exposure WHERE total_risk_exposure > 0 AND (market_risk_exposure / total_risk_exposure) > 0.25;	1308984725
SELECT fii.institution_name, rpt.transaction_amount, rpt.transaction_type FROM related_party_transactions rpt JOIN financial_institution_info fii ON rpt.institution_id = fii.institution_id WHERE rpt.transaction_date BETWEEN '2023-08-01' AND '2023-08-31' AND rpt.transaction_amount > 5000000 AND rpt.approval_status = '待审批';	1150041966
SELECT r.institution_id, f.institution_name FROM regulatory_reports r JOIN financial_institution_info f ON r.institution_id = f.institution_id JOIN income_statement i ON r.institution_id = i.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND i.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND i.net_profit > 50000000;	673273910
SELECT fi.institution_name FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE npl.npl_ratio > (SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY npl_ratio) FROM non_performing_loans) AND npl.provision_coverage_ratio > (SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY provision_coverage_ratio) FROM non_performing_loans) AND car.total_car > (SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY total_car) FROM capital_adequacy_ratio);	419851650
SELECT related_party FROM related_party_transactions ORDER BY transaction_amount DESC LIMIT 1;	3572294732
SELECT f.institution_name FROM financial_institution_info f INNER JOIN regulatory_reports r ON f.institution_id = r.institution_id WHERE r.report_date = '2023-10-01' AND r.approval_status = '待审批';	4283508902
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id WHERE EXTRACT(YEAR FROM re.report_date) = 2023 AND EXTRACT(MONTH FROM re.report_date) = 5 AND re.total_risk_exposure > 15000000000;	1599927341
SELECT r.institution_id, f.institution_name, f.registered_capital FROM regulatory_reports r JOIN financial_institution_info f ON r.institution_id = f.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND f.registered_capital > 50000000;	3420383582
SELECT institution_id, report_date, market_risk_exposure, credit_risk_exposure FROM risk_exposure WHERE EXTRACT(YEAR FROM report_date) = 2023 AND EXTRACT(MONTH FROM report_date) = 11;	499317923
SELECT institution_id, credit_risk_exposure FROM risk_exposure WHERE report_date = '2023-09-01';	457189594
SELECT fii.institution_name, rpt.transaction_amount, rpt.approval_status FROM financial_institution_info fii JOIN related_party_transactions rpt ON fii.institution_id = rpt.institution_id WHERE rpt.transaction_date BETWEEN '2023-05-01' AND '2023-05-31' AND rpt.transaction_amount > 5000000 AND rpt.approval_status = '已批准';	3369481943
SELECT institution_id FROM capital_adequacy_ratio WHERE risk_weighted_assets > 800000000000;	1390640393
SELECT COUNT(DISTINCT fi.institution_id) FROM financial_institution_info fi JOIN balance_sheet bs ON fi.institution_id = bs.institution_id WHERE fi.registered_capital < 1000000000 AND bs.total_assets > 100000000000;	1382464489
SELECT fii.institution_name, car.total_car, npl.npl_ratio FROM financial_institution_info fii JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE car.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND npl.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND car.total_car < 12 AND npl.npl_ratio > 2;	2752170463
SELECT report_date, approval_status FROM regulatory_reports;	3325591137
SELECT fi.institution_name FROM financial_institution_info fi JOIN balance_sheet bs ON fi.institution_id = bs.institution_id WHERE EXTRACT(YEAR FROM bs.report_date) = 2024 ORDER BY bs.total_assets DESC LIMIT 1;	1941989460
SELECT compliance_type, AVG(resolution_date - record_date) FROM compliance_records WHERE severity = '严重' AND record_date >= '2023-01-01' AND record_date <= '2023-12-31' GROUP BY compliance_type ORDER BY AVG(resolution_date - record_date) DESC LIMIT 1;	1530061075
SELECT fii.institution_name, rr.report_type, rpt.transaction_amount FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN related_party_transactions rpt ON fii.institution_id = rpt.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' AND rpt.transaction_amount > 5000000;	3537264682
SELECT AVG(non_interest_income) FROM income_statement WHERE report_date = '2023-01-01';	2919422399
SELECT report_date, npl_amount FROM non_performing_loans WHERE EXTRACT(YEAR FROM report_date) = 2023 AND EXTRACT(MONTH FROM report_date) = 6;	1291795377
SELECT institution_id FROM non_performing_loans WHERE provision_coverage_ratio < 200;	1487045407
SELECT AVG(car.total_car) FROM (SELECT i.institution_id, SUM(i.net_profit) AS total_profit FROM income_statement i WHERE i.report_date BETWEEN '2023-10-01' AND '2023-12-31' GROUP BY i.institution_id ORDER BY total_profit DESC LIMIT 10) top_institutions JOIN capital_adequacy_ratio car ON top_institutions.institution_id = car.institution_id;	1882291622
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN compliance_records c ON f.institution_id = c.institution_id WHERE c.description LIKE '%客户投诉%';	4004951089
SELECT institution_id, net_interest_income, non_interest_income FROM income_statement WHERE report_date BETWEEN '2023-07-01' AND '2023-07-31';	1865006955
SELECT r.institution_id, r.report_id, r.report_type, r.approval_status, n.npl_ratio FROM regulatory_reports r INNER JOIN non_performing_loans n ON r.institution_id = n.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND EXTRACT(YEAR FROM n.report_date) = 2023 AND n.npl_ratio > 1;	3817053665
SELECT npl_amount, provision_coverage_ratio FROM non_performing_loans WHERE report_date = '2023-03-01';	3715884467
SELECT fii.institution_id, fii.registered_capital, car.total_car, lr.liquidity_coverage_ratio, npl.npl_ratio FROM financial_institution_info fii LEFT JOIN (SELECT DISTINCT ON (institution_id) institution_id, total_car, report_date FROM capital_adequacy_ratio ORDER BY institution_id, report_date DESC) car ON fii.institution_id = car.institution_id LEFT JOIN (SELECT DISTINCT ON (institution_id) institution_id, liquidity_coverage_ratio, report_date FROM liquidity_ratio ORDER BY institution_id, report_date DESC) lr ON fii.institution_id = lr.institution_id LEFT JOIN (SELECT DISTINCT ON (institution_id) institution_id, npl_ratio, report_date FROM non_performing_loans ORDER BY institution_id, report_date DESC) npl ON fii.institution_id = npl.institution_id;	294279124
SELECT DISTINCT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE rr.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	3265881008
SELECT COUNT(DISTINCT b1.institution_id) FROM (
    SELECT a.institution_id FROM (
        SELECT b1.institution_id, b1.report_date, b1.loans_and_advances, 
               (b1.loans_and_advances - b2.loans_and_advances) / b2.loans_and_advances AS loan_growth_rate
        FROM balance_sheet b1
        JOIN balance_sheet b2 ON b1.institution_id = b2.institution_id 
            AND b1.report_date = b2.report_date + INTERVAL '1 year'
        WHERE (b1.loans_and_advances - b2.loans_and_advances) / b2.loans_and_advances > 0.2
    ) a
    INTERSECT
    SELECT c.institution_id FROM (
        SELECT institution_id, 
               total_car < LAG(total_car) OVER (PARTITION BY institution_id ORDER BY report_date) AS car_declining
        FROM capital_adequacy_ratio
        WHERE report_date >= CURRENT_DATE - INTERVAL '2 years'
    ) c
    WHERE c.car_declining = true
) b1;	562975454
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE rr.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改';	484628119
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND npl.npl_ratio > 1 AND npl.report_date = '2023-07-01';	3754045686
SELECT DISTINCT institution_id FROM related_party_transactions WHERE EXTRACT(YEAR FROM transaction_date) = 2023 AND EXTRACT(MONTH FROM transaction_date) = 10;	2822411822
SELECT fii.institution_name FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id JOIN non_performing_loans npl ON fii.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND npl.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND npl.npl_ratio > 2;	3908166516
SELECT report_date, total_car, risk_weighted_assets FROM capital_adequacy_ratio ORDER BY report_date;	950743928
SELECT lr.institution_id, lr.liquidity_coverage_ratio, rr.approval_status FROM liquidity_ratio lr JOIN regulatory_reports rr ON lr.institution_id = rr.institution_id AND lr.report_date = rr.report_date WHERE EXTRACT(YEAR FROM lr.report_date) = 2023;	4238047826
SELECT fii.institution_name, rr.report_date, rr.approval_status FROM financial_institution_info fii JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE rr.report_date > '2023-07-01' AND rr.approval_status = '需修改' AND rr.report_type = '季度报告';	3281109935
SELECT COUNT(*) FROM regulatory_reports WHERE report_date BETWEEN '2023-04-01' AND '2023-06-30' AND approval_status = '被拒绝';	1892746955
SELECT * FROM risk_exposure WHERE report_date = '2023-10-01';	3501885418
SELECT f.institution_id, (MAX(b.loans_and_advances) - MIN(b.loans_and_advances)) / MIN(b.loans_and_advances) * 100 AS growth_rate FROM balance_sheet b JOIN financial_institution_info f ON b.institution_id = f.institution_id GROUP BY f.institution_id ORDER BY growth_rate DESC LIMIT 1;	1776872424
SELECT fi.institution_name, (re.market_risk_exposure / NULLIF(car.risk_weighted_assets, 0)) * 100 FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id AND re.report_date = car.report_date WHERE EXTRACT(YEAR FROM re.report_date) = 2023 AND (re.market_risk_exposure / NULLIF(car.risk_weighted_assets, 0)) * 100 > 15;	3857370065
SELECT fii.institution_name, rr.report_type, rr.submission_date FROM regulatory_reports rr JOIN financial_institution_info fii ON rr.institution_id = fii.institution_id WHERE rr.submission_date BETWEEN '2023-01-01' AND '2023-12-31' AND rr.approval_status = '需修改' ORDER BY rr.submission_date DESC;	1089851841
SELECT DISTINCT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND EXTRACT(YEAR FROM rr.report_date) = 2023 AND EXISTS (SELECT 1 FROM related_party_transactions rpt WHERE rpt.institution_id = fi.institution_id AND EXTRACT(YEAR FROM rpt.transaction_date) = 2023 AND rpt.transaction_amount > 10000000);	1021775394
SELECT lr.liquidity_coverage_ratio, fii.institution_type FROM liquidity_ratio lr JOIN financial_institution_info fii ON lr.institution_id = fii.institution_id;	1227391350
SELECT DISTINCT institution_id FROM related_party_transactions WHERE transaction_date BETWEEN '2023-10-01' AND '2023-10-31' AND transaction_amount > 10000000;	993873143
SELECT fi.institution_name, COUNT(rpt.approval_status) FILTER (WHERE rpt.approval_status = '未通过') * 1.0 / COUNT(rpt.approval_status) FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE rpt.transaction_date >= '2023-01-01' GROUP BY fi.institution_name ORDER BY COUNT(rpt.approval_status) FILTER (WHERE rpt.approval_status = '未通过') * 1.0 / COUNT(rpt.approval_status) DESC LIMIT 1;	4220740302
SELECT fi.institution_name, re.operational_risk_exposure / re.total_risk_exposure FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id WHERE re.report_date BETWEEN '2023-01-01' AND '2023-12-31' ORDER BY (re.operational_risk_exposure / re.total_risk_exposure) DESC LIMIT 1;	1254398371
SELECT DISTINCT institution_id FROM regulatory_reports WHERE report_type = '年度报告' AND report_date BETWEEN '2023-01-01' AND '2023-12-31' AND comments IS NOT NULL;	3894797587
SELECT npl.*, fi.institution_name FROM non_performing_loans npl JOIN financial_institution_info fi ON npl.institution_id = fi.institution_id WHERE npl.report_date = '2023-03-01';	1466082382
SELECT institution_name FROM financial_institution_info WHERE legal_representative LIKE '王%';	1640932570
SELECT fii.institution_name, car.total_car FROM financial_institution_info fii JOIN capital_adequacy_ratio car ON fii.institution_id = car.institution_id JOIN regulatory_reports rr ON fii.institution_id = rr.institution_id WHERE car.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND rr.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND rr.report_type LIKE '%资本充足率%' AND car.total_car > 10;	659019966
