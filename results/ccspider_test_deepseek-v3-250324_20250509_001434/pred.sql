SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-13' AND (a.check_out - a.check_in) > INTERVAL '15 hours';	2499788398
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-11' AND a.check_in > '09:00:00';	2790038483
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H03961' AND date BETWEEN '2024-01-01' AND '2024-12-31' AND check_in > '09:00:00';	1518250136
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in < '08:30:00' AND p.rating = 'A+';	2290175818
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-05';	1543926007
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-21' ORDER BY d.name;	3053690473
SELECT COUNT(*)::float / (SELECT COUNT(*) FROM probation_employees) FROM probation_employees WHERE status = '离职' AND end_date - start_date < 90;	1446084728
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-08' AND a.check_in > '09:00:00';	2505330870
SELECT e.name, e.hire_date FROM employees e JOIN probation_employees p ON e.employee_id = p.employee_id;	77372189
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00' AND e.remaining_annual_leave < 5;	1298859483
SELECT e.employee_id, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-10-05';	569704912
SELECT e.employee_id, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-09-26';	399196427
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H05598' AND date BETWEEN '2024-01-01' AND '2024-12-31' AND check_out < '18:00:00';	2805240810
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-28' AND ar.check_in > '09:00:00';	3848816814
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '运营部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	2544920386
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00:00';	2048034491
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-21' AND a.check_in > '09:00:00';	1501079200
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-12-11' AND pe.rating = 'C';	1654155358
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00';	1952426931
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '创新奖' AND p.rating = 'A+';	3946055885
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-09' AND a.check_in > '08:30:00';	2952516110
SELECT COUNT(DISTINCT p.employee_id) FROM probation_employees p JOIN awards a ON p.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工奖' AND p.start_date <= '2023-12-31' AND p.end_date >= '2023-01-01';	3989733729
SELECT e.* FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id WHERE e.hire_date BETWEEN '2021-01-01' AND '2021-12-31' AND a.year = 2022;	241703514
SELECT DISTINCT employee_id FROM attendance_records GROUP BY employee_id, date HAVING COUNT(*) > 1;	4110426671
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:30:00' AND e.remaining_annual_leave < 10;	1958968748
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-19' AND a.check_in > '09:00:00';	1261641813
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-26' AND ar.check_in > '09:00:00' AND pe.rating = 'C';	1404049949
SELECT e.* FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2021 AND a.year = 2021 AND p.rating = 'B';	860878506
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	1830063336
SELECT a.employee_id FROM awards a INNER JOIN probation_employees p ON a.employee_id = p.employee_id WHERE a.year = 2020 AND a.award_name = '优秀员工' AND p.status = '试用期';	1384865982
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.year = 2023 AND p.rating = 'A+';	3542777151
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN probation_employees p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND p.status = '试用期';	1253418500
SELECT employee_id, name, remaining_annual_leave FROM employees;	1306743539
SELECT DISTINCT e.employee_id, e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '技术突破奖' GROUP BY e.employee_id, e.name HAVING AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10;	1998735563
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-20' AND (a.check_out - a.check_in) > interval '8 hours';	3735871221
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-25' AND a.check_in < '09:00:00';	392713451
SELECT e.name FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE pe.rating = 'A+' GROUP BY e.name ORDER BY AVG(ar.check_out - ar.check_in) DESC LIMIT 1;	3464604281
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-04' AND a.check_in > '09:00:00';	1444696553
SELECT e.name FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-18' AND ar.check_in > '09:00:00' AND pe.rating = 'D';	2023290915
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-25' AND a.check_in > '08:30:00' AND p.rating = 'B+';	3746804657
SELECT * FROM interviews WHERE interview_date >= '2024-01-01' AND interview_date <= '2024-12-31' ORDER BY interview_count;	72949237
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '08:30:00' AND p.rating = 'A+';	1155706622
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-27' AND a.check_in > '09:00:00' AND e.remaining_annual_leave < 10;	638989138
SELECT e.name, p.evaluation_date FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id;	2390401103
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-07' AND a.check_in > '09:00:00' AND a.check_out < '17:00:00';	78855873
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-05';	3197959623
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN interviews i ON e.employee_id = i.employee_id GROUP BY d.name ORDER BY AVG(i.interview_count) DESC LIMIT 1;	3699728041
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-27' AND p.rating = 'A+';	3065616199
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '最佳团队奖' AND ar.date = '2024-10-09' AND ar.check_in > '09:00:00';	1681003052
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-10-14' AND a.check_in > '09:00:00';	4050465535
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_out > '13:00:00' AND p.rating = 'B+';	4249036992
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-08' AND a.check_in > '09:00:00';	592982415
SELECT e.name, d.name, a.award_name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2022;	3584914350
SELECT DISTINCT e.employee_id FROM employees e 
JOIN attendance_records ar ON e.employee_id = ar.employee_id 
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id 
WHERE ar.date = '2024-10-12' AND ar.check_in > '09:00:00' AND pe.rating = 'D';	1423306349
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-13' AND a.check_in < '09:30:00';	2203283189
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-22';	3865699446
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND p.rating = 'A+';	1909210649
SELECT e.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-05' AND a.check_in > '08:30:00' AND d.manager_id = 'H05487';	2144085984
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-02' AND (a.check_out - a.check_in) > interval '9 hours';	283013543
SELECT d.name, e.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-03-31' AND p.rating = 'D';	214548501
SELECT name, car_plate FROM employees WHERE employee_type = '正式员工';	3902051234
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-19' AND a.check_in > '09:00:00';	4268232257
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '客户满意度奖' AND ar.date = '2024-10-12' AND ar.check_in > '09:00:00';	2777106158
SELECT a.employee_id FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00:00' AND d.manager_id = 'H00842';	932008813
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2023 AND a.award_name = '领导力奖';	3805690652
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND ar.date = '2024-10-09' AND ar.check_in > '09:00:00';	795140600
SELECT e.employee_id, e.name AS intern_name, d.manager_id 
FROM employees e 
JOIN attendance_records a ON e.employee_id = a.employee_id 
JOIN departments d ON e.department_id = d.department_id 
WHERE e.employee_type = '实习生' 
AND a.date = '2024-10-02' 
AND a.check_in BETWEEN '09:00:00' AND '10:00:00';	3086085668
SELECT d.name FROM employees e JOIN departments d ON e.department_id = d.department_id GROUP BY d.name ORDER BY AVG(EXTRACT(YEAR FROM age(current_date, e.birth_date))) DESC LIMIT 1;	2411560883
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-16' AND p.rating = 'C';	3743308464
SELECT e.* FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-08' AND a.check_in > '09:00:00';	439444083
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-09-20' AND a.check_in > '09:00:00';	3252922075
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > interval '8 hours';	1549624018
SELECT e.name FROM employees e INNER JOIN attendance_records a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-14' AND p.rating = 'A+';	261206730
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-09-27' AND a.check_in > '09:00:00';	1406124018
SELECT d.name, COUNT(e.employee_id) FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id GROUP BY d.name;	1273187788
SELECT e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.rating = 'A+' ORDER BY e.hire_date DESC LIMIT 1;	161130038
SELECT e.employee_id FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN (
    SELECT e.department_id, 
           AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))) AS dept_avg
    FROM employees e
    JOIN attendance_records ar ON e.employee_id = ar.employee_id
    GROUP BY e.department_id
) dept_avg ON e.department_id = dept_avg.department_id
GROUP BY e.employee_id, dept_avg.dept_avg
ORDER BY ABS(AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))) - dept_avg.dept_avg) DESC
LIMIT 1;	2367131410
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > interval '10 hours';	736904101
SELECT e.name, d.name, p.rating FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-12';	87083721
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-11' AND a.check_in > '09:00:00';	1391282019
SELECT e.name, d.name, a_r.check_in, aw.award_name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a_r ON e.employee_id = a_r.employee_id JOIN awards aw ON e.employee_id = aw.employee_id WHERE a_r.date = '2024-09-26' AND aw.year = 2024 AND a_r.check_in > '09:00:00';	1614124608
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-05' AND a.check_in > '09:00:00' AND p.rating = 'A+';	119065582
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '人力资源部' AND a.date = '2024-10-07' AND a.check_in > '09:00:00';	305429407
SELECT e.name, d.name, a.check_in FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-11' AND e.employee_type = '实习生' AND a.check_in <= '09:00:00';	1434754295
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工奖' AND p.rating = 'A+';	1416753262
SELECT d.name, COUNT(*) FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year >= 2018 AND e.position = '核心骨干' GROUP BY d.name;	1966520829
SELECT e.employee_id FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '新人奖' AND ar.date = '2024-10-08';	3742208647
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-02' AND a.check_in > '09:00:00' AND p.rating = 'A+';	681058956
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2024 AND a.award_name = '新人奖';	3929652777
SELECT AVG(m.first_manage_date - e.hire_date) FROM employees e JOIN (SELECT employee_id, MIN(hire_date) AS first_manage_date FROM employees WHERE position LIKE '%经理%' OR position LIKE '%主管%' GROUP BY employee_id) m ON e.employee_id = m.employee_id;	2290314264
SELECT e.employee_id, e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '研发部' AND a.date = '2024-10-06' AND (a.check_out - a.check_in) > interval '10 hours';	2118323252
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '技术突破奖' AND p.rating = 'A+';	1087843451
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND a.check_in > '09:00:00' AND p.rating = 'D';	386106206
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '项目管理奖' AND ar.date = '2024-10-03';	855220810
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND e.hire_date > '2017-12-31';	3375057924
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-16' AND (a.check_out - a.check_in) > interval '8 hours';	4174232427
SELECT DISTINCT e.employee_id FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' INTERSECT SELECT DISTINCT e.employee_id FROM employees e INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2023-06-04' AND p.rating = 'D';	734321783
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	1241353029
SELECT e.name FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-21' AND ar.check_in > '09:00:00' AND pe.rating = 'B';	3667177289
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00:00' AND p.rating = 'C';	4273970415
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-05' AND (a.check_out - a.check_in) > interval '9 hours';	323611946
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-06' AND a.check_in > '09:00:00';	2940103155
SELECT e.name AS employee_name, m.name AS manager_name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE pe.rating = 'A+' AND EXTRACT(YEAR FROM pe.evaluation_date) = 2023;	434694019
SELECT e.employee_id FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-28' AND ar.check_in > '09:00:00' AND pe.rating = 'A';	1289703363
SELECT ar.* FROM attendance_records ar JOIN awards a ON ar.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND ar.date = '2024-10-01';	1722398575
SELECT d.name, e.name FROM employees e JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.rating = 'A+' AND (e.employee_id, pe.evaluation_date - e.hire_date) IN (SELECT e2.employee_id, MIN(pe2.evaluation_date - e2.hire_date) FROM employees e2 JOIN performance_evaluations pe2 ON e2.employee_id = pe2.employee_id WHERE pe2.rating = 'A+' GROUP BY e2.department_id, e2.employee_id) GROUP BY d.name, e.name;	804493985
SELECT a.employee_id, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00';	1306450278
SELECT DISTINCT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND a.award_name = '优秀员工' AND p.rating = 'A+';	1414070332
SELECT e.name, d.name, p.rating FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-10-29';	3925025909
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-17' AND (a.check_out - a.check_in) > interval '9 hours';	1398775192
SELECT e.name, d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2022-06-16' AND p.rating = 'C';	2656339281
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2022 AND a.award_name = '优秀员工' AND p.evaluation_date = '2022-10-30' AND p.rating = 'A+';	3627252999
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-15' AND a.check_in > '09:00:00' AND p.rating = 'B';	2285040147
SELECT e.name, e.position FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE d.name = '销售部';	3934214389
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-23' AND a.check_in > '09:00:00' AND p.rating = 'D';	1649684433
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '客户服务部' AND p.rating = 'D' AND p.evaluation_date <= '2024-10-14' AND e.hire_date <= '2024-10-14' AND (e.start_work_date IS NULL OR e.start_work_date <= '2024-10-14');	1300169145
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND e.hire_date >= '2019-01-01';	3467712746
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in > '09:00:00' AND p.rating = 'A+';	225648923
SELECT e.employee_id, e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.rating = '一般' AND (EXISTS (SELECT 1 FROM awards a WHERE a.employee_id = e.employee_id) OR EXISTS (SELECT 1 FROM departments d WHERE d.manager_id = e.employee_id));	3415487094
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20' AND a.check_in BETWEEN '08:00:00' AND '09:00:00' AND p.rating = 'B';	1027352926
SELECT e.employee_id FROM employees e JOIN (SELECT employee_id, MAX(evaluation_date) AS last_eval_date FROM performance_evaluations GROUP BY employee_id) pe ON e.employee_id = pe.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id AND pe.last_eval_date = p.evaluation_date WHERE p.evaluation_date < '2024-01-01' AND p.rating = 'B';	3444450310
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND a.check_in > '09:00:00' AND p.rating = 'B+';	73955891
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-24' AND (ar.check_out - ar.check_in) > interval '12 hours';	2221450098
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-09-29' AND a.check_in < '09:00:00';	2070780775
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00:00' AND p.rating = 'A';	1554709262
AMBIGUOUS_QUERY	706296760
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '厦门大学' AND a.date = '2024-09-23' AND a.check_in > '09:00:00';	392591213
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-19' AND a.check_in > '09:00:00' AND p.rating = 'D';	3172283899
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-11' AND a.check_in > '08:30:00';	988606028
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-10' AND a.check_in > '09:00:00' AND p.rating = 'D';	2714488838
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2024 AND a.year = 2024 AND a.award_name = '新人奖' AND p.rating = 'A';	4248175692
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-26' AND a.check_in BETWEEN '08:00:00' AND '09:00:00' AND p.rating = 'B+';	302928867
SELECT DISTINCT e.employee_id FROM employees e INNER JOIN awards a ON e.employee_id = a.employee_id INNER JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '创新奖' AND ar.date = '2024-09-25';	886106357
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00:00' AND p.rating = 'D';	4026541630
SELECT d.name, AVG(e.remaining_annual_leave) FROM departments d JOIN employees e ON d.department_id = e.department_id WHERE d.manager_id = 'H03372' GROUP BY d.name;	1802079912
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND p.rating = 'A+';	865528666
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND ar.date = '2024-10-03' AND ar.check_in > '09:00:00';	4061141103
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE d.name = '财务部' AND p.rating = 'A+' AND p.evaluation_date <= '2024-09-15' ORDER BY p.evaluation_date DESC LIMIT 1;	2313524982
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-21' AND a.check_in > '09:00:00';	1992247421
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-25' AND (a.check_out - a.check_in) > interval '8 hours';	165828985
SELECT p.rating FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2022 AND a.award_name = '技术突破奖' AND p.evaluation_date > '2022-07-13';	2853735999
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-11' AND a.check_in > '09:00:00';	2393343950
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-12' AND a.check_in > '09:00:00';	541232515
SELECT d.name FROM departments d JOIN employees e ON d.id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2023-08-06' AND p.rating = 'C';	2805706885
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-01' AND (ar.check_out - ar.check_in) > INTERVAL '12 hours';	642307462
SELECT e.employee_id, e.name FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-10-09' AND ar.check_in > '09:00:00' AND pe.rating = 'A+';	1883744787
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-24' AND d.name = '人力资源部' AND a.check_in > '09:00:00';	2974332534
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-10-02' AND a.check_in > '09:00:00';	3471772100
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-11' AND a.check_out > '21:00:00' AND p.rating = 'B+';	2086845631
SELECT e.name, d.name, e.hire_date FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE EXTRACT(YEAR FROM pe.evaluation_date) = 2022 AND pe.rating = 'B' ORDER BY e.hire_date;	4264799007
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-22' AND d.name = '客户服务部';	3620357144
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00:00' AND pe.rating = 'B';	1491216239
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-02' ORDER BY a.check_in ASC LIMIT 1;	3076427726
SELECT e.employee_id FROM employees e 
JOIN attendance_records ar ON e.employee_id = ar.employee_id 
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id 
WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 
AND ar.date = '2024-10-10' 
AND pe.rating = 'B+';	3105805885
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-04' AND a.check_in > '09:00:00';	619146222
SELECT DISTINCT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND p.rating = 'A+';	701268008
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id WHERE e.employee_id IN (SELECT employee_id FROM probation_employees GROUP BY employee_id ORDER BY COUNT(*) DESC LIMIT 3);	1106812044
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-04' AND a.check_in > '09:00:00';	150140045
SELECT e.name, d.name FROM awards a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.year = 2023 AND a.award_name = '优秀员工';	3067705249
SELECT COUNT(*) FROM awards a JOIN probation_employees p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '客户满意度奖' AND a.date BETWEEN p.start_date AND p.end_date;	370099566
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-24' AND a.check_in > '09:00:00' AND p.rating = 'C';	3404150466
SELECT e.name, a.award_name FROM employees e JOIN awards a ON e.employee_id = a.employee_id;	2389000379
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-13' AND a.check_in < '08:30:00';	3131729527
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-17' AND (a.check_out - a.check_in) > interval '9 hours';	525985276
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-26' AND e.remaining_annual_leave > 10;	331075127
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-09' AND a.check_in > '09:00:00';	1437451129
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-10' AND a.check_in > '09:00:00';	4184935107
SELECT NULL WHERE false;	2884744128
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-25' AND ar.check_in > '09:00:00';	23024706
SELECT e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '客户服务部' AND p.rating = 'A+' AND p.evaluation_date = '2024-09-28';	1389756999
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '法务部' AND a.date = '2024-10-07' AND a.check_in > '09:00:00';	2946411490
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-14';	4118104089
SELECT DISTINCT a.employee_id FROM awards a INNER JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '优秀员工' AND ar.date > '2021-01-01';	2690408936
SELECT AVG(e.remaining_annual_leave) FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2024 AND a.award_name = '领导力奖' AND e.hire_date > '2017-12-31';	312466402
SELECT e.employee_id, e.name FROM employees e LEFT JOIN awards a ON e.employee_id = a.employee_id WHERE e.university NOT IN ('清华大学','北京大学','复旦大学','上海交通大学','浙江大学') AND e.position NOT LIKE '%总监%' AND e.position NOT LIKE '%经理%' GROUP BY e.employee_id, e.name HAVING COUNT(a.id) <= 1 AND MAX(a.award_name) LIKE '%创新%' OR MAX(a.award_name) LIKE '%突破%';	2444022671
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-12-07' AND pe.rating = 'B';	4277707010
SELECT e.name, d.name, a.award_name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.year = 2023;	4268522360
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-25' AND a.check_in > '09:00:00';	4254579364
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-20' AND a.check_in > '09:00:00';	2369381920
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '客户服务部' AND a.date = '2024-09-29' AND (a.check_out - a.check_in) > INTERVAL '10 hours';	4086198634
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-04' AND a.check_in > '08:30:00' AND p.rating = 'A+';	2201325936
SELECT e.employee_id, e.name, COUNT(CASE WHEN a.check_in > '09:00:00' THEN 1 END) AS late_days FROM employees e LEFT JOIN attendance_records a ON e.employee_id = a.employee_id GROUP BY e.employee_id, e.name;	3450923921
SELECT e.name FROM employees e INNER JOIN attendance_records a ON e.employee_id = a.employee_id INNER JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-15' AND p.rating = 'A+';	3735318054
SELECT DISTINCT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '最佳团队奖' AND ar.date = '2024-09-19';	1103295358
SELECT e.* FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-21';	1771528644
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-09-23' AND a.check_in < '09:30:00';	1983289607
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-09' AND a.check_in > '09:00:00' AND e.employee_type = '实习生';	3578772260
SELECT DISTINCT a.employee_id FROM awards a WHERE a.year = 2023 AND a.award_name = '项目管理奖' AND a.employee_id IN (SELECT employee_id FROM attendance_records WHERE date = '2024-09-23');	417939953
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2022 AND a.year = 2023 AND p.rating = 'A+';	1624107441
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-13';	1951693602
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-09-18' AND a.check_in > '09:00:00';	82225620
SELECT e.employee_id, e.name, COUNT(a.id) AS award_count, p.rating 
FROM employees e
LEFT JOIN awards a ON e.employee_id = a.employee_id
LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id
WHERE e.hire_date > CURRENT_DATE - INTERVAL '1 year'
GROUP BY e.employee_id, e.name, p.rating
ORDER BY award_count DESC, p.rating DESC;	3464614512
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '销售部' AND a.date = '2024-09-20' AND a.check_in > '08:00:00';	3644746054
SELECT d.name AS department_name, e.name AS employee_name FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE e.employee_id IN (SELECT employee_id FROM (SELECT employee_id, department_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY birth_date ASC) AS rn FROM employees) t WHERE t.rn = 1);	2589067480
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-09-30' AND a.check_in > '09:00:00';	525741152
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-09-18' AND a.check_in > '09:00:00';	1233829446
SELECT e.name FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-28' AND ar.check_in > '09:30:00' AND pe.rating = 'A+' AND pe.evaluation_date = (SELECT MAX(evaluation_date) FROM performance_evaluations WHERE employee_id = e.employee_id);	1073149875
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-17' AND a.check_in > '09:00:00' AND p.rating = 'B';	2974599681
SELECT DISTINCT e.employee_id FROM employees e JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-09-22' AND pe.rating = 'D';	4292447380
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-10-03' AND p.rating = 'A+';	1372088201
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-07' AND a.check_in > '09:00:00';	1829638261
SELECT e.employee_id, e.name, a.date, a.check_in, a.check_out, p.rating FROM employees e LEFT JOIN attendance_records a ON e.employee_id = a.employee_id LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id;	4051639960
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN awards b ON a.employee_id = b.employee_id WHERE a.date = '2024-10-05' AND a.check_in > '09:00:00' AND b.year = 2021;	3807676634
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-25' AND d.name = '质量控制部' AND a.check_in > '08:30:00';	22049871
SELECT 
    q.quarter,
    q.employee_id,
    q.award_count,
    CASE WHEN a.avg_work_hours = min_work_hours.min_hours THEN '是' ELSE '否' END AS is_most_punctual
FROM (
    SELECT 
        EXTRACT(YEAR FROM a.year || '-01-01')::int AS year,
        CEIL(EXTRACT(MONTH FROM a.year || '-01-01')/3) AS quarter,
        a.employee_id,
        COUNT(*) AS award_count,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM a.year || '-01-01')::int, CEIL(EXTRACT(MONTH FROM a.year || '-01-01')/3) ORDER BY COUNT(*) DESC) AS rank
    FROM awards a
    WHERE a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 3
    GROUP BY EXTRACT(YEAR FROM a.year || '-01-01')::int, CEIL(EXTRACT(MONTH FROM a.year || '-01-01')/3), a.employee_id
) q
JOIN (
    SELECT 
        ar.employee_id,
        EXTRACT(YEAR FROM ar.date) AS year,
        CEIL(EXTRACT(MONTH FROM ar.date)/3) AS quarter,
        AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) AS avg_work_hours
    FROM attendance_records ar
    WHERE ar.date >= (CURRENT_DATE - INTERVAL '3 years')
    GROUP BY ar.employee_id, EXTRACT(YEAR FROM ar.date), CEIL(EXTRACT(MONTH FROM ar.date)/3)
) a ON q.employee_id = a.employee_id AND q.year = a.year AND q.quarter = a.quarter
JOIN (
    SELECT 
        year,
        quarter,
        MIN(avg_work_hours) AS min_hours
    FROM (
        SELECT 
            EXTRACT(YEAR FROM ar.date) AS year,
            CEIL(EXTRACT(MONTH FROM ar.date)/3) AS quarter,
            ar.employee_id,
            AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) AS avg_work_hours
        FROM attendance_records ar
        WHERE ar.date >= (CURRENT_DATE - INTERVAL '3 years')
        GROUP BY ar.employee_id, EXTRACT(YEAR FROM ar.date), CEIL(EXTRACT(MONTH FROM ar.date)/3)
    ) t
    GROUP BY year, quarter
) min_work_hours ON a.year = min_work_hours.year AND a.quarter = min_work_hours.quarter
WHERE q.rank = 1;	2830500866
SELECT DISTINCT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2023 AND p.rating = 'A+';	753042700
SELECT DISTINCT a.employee_id FROM awards a INNER JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '质量改进奖' AND ar.date = '2024-10-04' AND ar.check_in > '09:00:00';	3115674665
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	3347041396
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-02' AND a.check_in > '09:00:00';	2106049978
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工' AND p.rating = 'A+';	2418301693
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE p.evaluation_date = '2023-05-31' AND p.rating = 'A+';	3616397443
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-02' AND a.check_in > '09:00:00' AND p.rating = 'A+';	4109172134
SELECT a.* FROM attendance_records a JOIN awards b ON a.employee_id = b.employee_id WHERE b.year = 2021 AND b.award_name = '销售冠军' AND a.date = '2024-09-18';	2161202831
SELECT e.name, d.name FROM performance_evaluations pe JOIN employees e ON pe.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE pe.evaluation_date = '2023-05-27' AND pe.rating = 'A+';	883813840
SELECT e.name, d.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-16' AND a.check_in > '09:00:00';	537717055
SELECT e.name, d.name FROM employees e JOIN departments d ON e.department_id = d.department_id;	2763876996
SELECT name FROM employees WHERE hire_date = (SELECT MIN(hire_date) FROM employees) ORDER BY position ASC LIMIT 1;	2600861795
SELECT e.name FROM employees e JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE e.department_id = 'D00007' AND p.rating = 'A' AND EXTRACT(YEAR FROM p.evaluation_date) = 2024;	2781387557
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2022 AND a.award_name = '创新奖' AND ar.date = '2024-10-12' AND ar.check_in > '09:00:00';	2256872853
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-09-23' AND ar.check_in > '09:00:00';	3830013539
SELECT COUNT(*) FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '质量改进奖' AND p.rating = 'A+';	2490180425
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-23' AND a.check_in > '08:00:00' AND a.check_out < '18:00:00';	2983573490
SELECT d.name FROM departments d JOIN employees e ON d.id = e.department_id JOIN interviews i ON e.employee_id = i.employee_id JOIN awards a ON e.employee_id = a.employee_id WHERE i.interview_date = '2023-10-09' AND a.year = 2023 AND a.award_name = '优秀员工奖';	2710720384
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-12' AND a.check_in < '09:00:00' AND p.rating = 'B+';	737077017
SELECT e.employee_id, e.name 
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-20' AND ar.check_in > '09:00:00' AND pe.rating = 'A+';	1491113326
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2021 AND a.award_name = '质量改进奖' AND p.rating = 'B+';	498106360
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-29' AND d.name = '客户服务部' AND a.check_in > '08:30:00';	640452635
SELECT e.name AS employee_name, m.name AS manager_name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE ar.date = '2024-09-16' AND ar.check_in > '08:30:00';	208690009
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-01' AND a.check_in > '09:00:00' AND e.position = '顾问';	392941851
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-23' AND a.check_in > '09:00:00';	2938732459
SELECT e.name, a.year, a.award_name FROM awards a JOIN employees e ON a.employee_id = e.employee_id WHERE a.year >= EXTRACT(YEAR FROM CURRENT_DATE) - 5 AND a.award_name = '技术创新奖' ORDER BY a.year;	1117540294
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '财务部' AND a.date = '2024-10-06' AND a.check_in > '09:00:00';	1014591026
SELECT e.name, d.name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE ar.date = '2024-10-04' AND ar.check_in > '09:00:00';	1623914717
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-04';	2050714128
SELECT a.employee_id, a.award_name, p.rating, p.evaluation_date FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	3216421294
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-10' AND a.check_in > '09:30:00';	1913384420
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-19';	914649823
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '行政部' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	4047308852
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id GROUP BY d.name ORDER BY AVG(e.remaining_annual_leave) DESC LIMIT 1;	389946505
SELECT DISTINCT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-27' AND a.check_in < '10:00:00' AND p.rating = 'A+';	2789183181
SELECT employee_id, interview_date, interview_count FROM interviews WHERE interview_date >= '2024-01-01' AND interview_date <= '2024-12-31';	2066321300
SELECT e.name, d.name FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-20' AND a.check_in > '09:00:00';	517679865
SELECT e.* FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE d.name = '研发部' AND pe.rating = 'B+' AND ar.date = '2024-09-29';	168044233
SELECT * FROM attendance_records WHERE employee_id IN (SELECT employee_id FROM awards WHERE year = 2022 AND award_name = '销售冠军') AND date = '2024-10-10';	3832137822
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id WHERE a.year = 2023 AND a.award_name = '客户满意度奖' AND e.hire_date > '2020-06-19';	2937344989
SELECT a.employee_id FROM attendance_records a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00' AND p.rating = 'A+';	666608778
SELECT d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2022-06-20' AND p.rating = 'C';	895348774
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND a.award_name = '客户满意度奖' AND p.rating = 'C';	140831793
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '项目管理奖' GROUP BY e.name HAVING AVG(EXTRACT(EPOCH FROM (ar.check_out - ar.check_in))/3600) > 10;	3458227345
SELECT e.name, d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-03-09' AND p.rating = 'D';	1848769486
AMBIGUOUS_QUERY	2500228389
SELECT e.name, d.name, a.check_in, a.check_out FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-08';	2138121838
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-09-26' AND a.check_in > '09:00:00' AND d.name = '人力资源部';	2171081157
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-28' AND a.check_in > '09:00:00' AND p.rating = 'A+';	1610499668
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-09-20' AND a.check_in > '09:00:00';	2819549023
SELECT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records ar ON e.employee_id = ar.employee_id JOIN performance_evaluations pe ON e.employee_id = pe.employee_id WHERE ar.date = '2024-10-13' AND ar.check_in > '09:00:00' AND pe.rating = 'A+';	898575802
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND p.rating >= 'B';	3845606236
SELECT e.employee_id FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE d.name = '财务部' AND a.date = '2024-09-17' AND (a.check_out - a.check_in) > interval '9 hours';	3651268255
SELECT e.name AS employee_name, m.name AS manager_name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE ar.date = '2024-09-18' AND ar.check_in > '09:00:00';	2107787587
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '技术突破奖' AND ar.date = '2024-09-23' AND ar.check_in > '09:00:00';	3117376201
SELECT e.* FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '运营部' AND a.date = '2024-09-26';	480860919
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.year = 2020 AND a.award_name = '优秀员工' AND p.evaluation_date BETWEEN '2023-01-01' AND '2023-12-31' AND p.rating = 'C';	460298626
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-10-03' AND a.check_in > '09:00:00' AND p.rating = 'C';	2730014142
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN departments d ON e.department_id = d.department_id WHERE a.date = '2024-10-12' AND d.name = '法务部' AND a.check_in > '09:00:00';	3912663730
SELECT 
    EXTRACT(YEAR FROM i.interview_date) AS year,
    d.name AS department_name
FROM 
    interviews i
JOIN 
    employees e ON i.employee_id = e.employee_id
JOIN 
    departments d ON e.department_id = d.department_id
WHERE 
    EXTRACT(YEAR FROM i.interview_date) >= EXTRACT(YEAR FROM CURRENT_DATE) - 5
GROUP BY 
    year, d.name
ORDER BY 
    year, 
    COUNT(CASE WHEN e.hire_date IS NOT NULL THEN 1 END) * 1.0 / COUNT(*) DESC
FETCH FIRST 1 ROW WITH TIES PER year;	2709449383
SELECT e.* FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-12';	773661226
SELECT a.employee_id FROM awards a JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '领导力奖' AND ar.date = '2024-10-01' AND ar.check_in > '09:00:00';	2010808566
SELECT e.employee_id FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2023 AND a.award_name = '销售冠军' AND ar.date = '2024-09-22' AND ar.check_in > '09:00:00';	201608997
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '人力资源部' AND a.date = '2024-10-10' AND a.check_in > '09:00:00';	305187601
SELECT e.name, d.name FROM performance_evaluations p JOIN employees e ON p.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id WHERE p.evaluation_date = '2023-04-20' AND p.rating = 'D';	1158176204
SELECT 
  COUNT(DISTINCT CASE WHEN a.employee_id IS NOT NULL AND p.employee_id IS NOT NULL THEN e.employee_id END)::float / 
  COUNT(DISTINCT e.employee_id) AS proportion
FROM employees e
LEFT JOIN (SELECT DISTINCT employee_id FROM awards WHERE year >= EXTRACT(YEAR FROM CURRENT_DATE) - 1) a ON e.employee_id = a.employee_id
LEFT JOIN (SELECT DISTINCT employee_id FROM performance_evaluations WHERE evaluation_date >= CURRENT_DATE - INTERVAL '2 years' AND rating = '提升') p ON e.employee_id = p.employee_id;	3838245936
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE e.hire_date BETWEEN '2023-01-01' AND '2023-12-31' AND a.year = 2023 AND a.award_name = '优秀员工奖' AND p.rating = 'A+';	2323193672
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-21' AND a.check_in > '09:00:00';	662747906
SELECT employee_id, date, check_in, check_out, (check_out - check_in) AS working_hours FROM attendance_records;	1678101946
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-09-15' AND a.check_in > '09:00:00';	523515982
SELECT e.name FROM employees e JOIN awards a ON e.employee_id = a.employee_id JOIN attendance_records ar ON e.employee_id = ar.employee_id WHERE a.year = 2021 AND a.award_name = '创新奖' AND ar.date = '2024-10-05' AND ar.check_in > '09:00:00';	2715149255
SELECT DISTINCT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND p.rating = 'C';	3069073544
SELECT a.employee_id FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2024 AND a.award_name = '领导力奖' AND p.rating = 'C';	2258483174
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '质量控制部' AND a.date = '2024-09-19' AND a.check_in > '09:00:00';	389046410
SELECT a.employee_id FROM awards a INNER JOIN attendance_records ar ON a.employee_id = ar.employee_id WHERE a.year = 2024 AND a.award_name = '项目管理奖' AND ar.date = '2024-09-23';	2068076752
SELECT e.name, d.name, p.rating FROM attendance_records a JOIN employees e ON a.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id LEFT JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE a.date = '2024-09-20';	406606744
SELECT e.name AS employee_name, m.name AS manager_name FROM attendance_records ar JOIN employees e ON ar.employee_id = e.employee_id JOIN departments d ON e.department_id = d.department_id JOIN employees m ON d.manager_id = m.employee_id WHERE ar.date = '2024-09-26' AND ar.check_in > '09:30:00';	260151387
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE e.university = '清华大学' AND a.date = '2024-10-03' AND a.check_in > '09:00:00';	4070449827
SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '研发部' AND a.date = '2024-10-01' AND (a.check_out - a.check_in) > interval '10 hours';	2852580257
SELECT p.rating FROM awards a JOIN performance_evaluations p ON a.employee_id = p.employee_id WHERE a.year = 2023 AND a.award_name = '优秀员工' AND EXTRACT(YEAR FROM p.evaluation_date) = 2023;	1727169008
	1877699859
	2884293015
	958998120
	1597552663
	2952757264
	469159086
	731693068
	1236011704
	280502890
	236766680
	1413730783
	2991390114
	2514430924
	4288779306
	3310831117
	2450245528
	821687353
	3139230407
	3089791258
	52505136
	3773590841
	2822188040
	1440558878
	1736005638
	2851656495
	875490154
	4277933960
	3853460934
	3090102533
	1353951750
	2088616407
	130934854
	3921482862
	2823798793
	1257769422
	3060090955
	1862922606
	2509103407
	695694478
	834672780
	4144067238
	2026869176
	276439287
	3759367452
	854057318
	4026685166
	3768964878
	2031979235
	1154484795
	1534988899
	3094943511
	3794501166
	1460602722
	3806586802
	4276410819
	3975346738
	828477757
	2234207790
	1812141267
	1984914783
	1612151566
	1955324709
	3342688355
	3958858753
	4286151760
	3229999001
	4182504410
	917603455
	3406337356
	1335793922
	1151279551
	954153971
	45765016
	3502920391
	1646074274
	672526664
	2466786763
	4227028668
	2693621587
	4145982837
	1544259726
	1355078743
	1126971637
	3096647573
	1447870202
	3139357622
	2354889533
	526851116
	1791411839
	2162165264
	76588831
	3941609286
	2101507672
	1923349382
	1121179521
	2484251331
	2203191109
	2236467382
	2201430567
	1372106457
	3513022788
	2898422903
	3077268751
	1301921764
	3969277636
	3878396052
	2773495410
	309023757
	978163931
	641452553
	1351088256
	583833982
	2116101795
	985889089
	2925851112
	714042771
	3725846926
	128551642
	1070169294
	3530929289
	2475731730
	2108379659
	3717149823
	1463400602
	3647903773
	190467620
	1357323463
	1614074594
	1411048057
	2743985170
	1124781975
	1877601035
	3704765747
	1929928822
	693366950
	2017141047
	2208770845
	2411764640
	2948516213
	2373067027
	758507051
	3655735172
	2721235050
	4255369233
	2277646392
	3239376234
	3541568339
	1123257910
	820431444
	2667178372
	130622905
	4174863363
	3814340700
	3039598050
	684098334
	2020704797
	3613008055
	1250415044
	1513848555
	921285205
	1784808376
	1450251644
	2152314580
	4164431702
	1368623184
	399556639
	4055303490
	4242939153
	2373959946
	3345826641
	4002524997
	3440883843
	2903014629
	3876498515
	4258165101
	1167360749
	1853157405
	856149789
	12643482
	3675937964
	517341637
	317385728
	162793313
	1226891061
	3649901835
	2345937214
	726948157
	428507464
	1610322845
	377073913
	1405120881
	965817749
	311014935
	946337978
	2702285633
	1617148541
AMBIGUOUS_QUERY	1580416554
	1114816707
	808510096
	3305168434
	3107729998
	3912588693
	158646132
	3617397322
	397932156
	269454572
	3026164558
	308222457
	2469695932
	425374562
	2892564169
	1640385150
	3377906541
	365779440
	798971312
	1756912532
	3898093211
	2131176144
	784123269
	1431165151
	2469033655
	398304766
	3521704142
	1896500682
	1933728727
	3124021686
	3585096464
	677634919
	3094639947
SELECT s.store_name, s.manager_name FROM stores s WHERE s.store_id = (SELECT store_id FROM salesstatistics WHERE date = '2023-05-06' GROUP BY store_id ORDER BY SUM(profit) DESC LIMIT 1);	1003634069
SELECT profit, sales_quantity FROM salesstatistics;	3101430966
AMBIGUOUS_QUERY	2117960535
SELECT e.name FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id JOIN stores st ON s.store_id = st.store_id WHERE s.order_date = '2023-05-05' AND st.store_name = '数码广场店' AND s.total_amount > 7000;	941218200
SELECT * FROM salesstatistics ORDER BY profit DESC LIMIT 1;	1332840948
SELECT s.store_name, e.name, ss.sales_amount, p.product_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND ss.sales_amount > 10000 AND p.supplier_name = '苹果官方旗舰店';	3240310596
SELECT DISTINCT p.product_name, p.supplier_name FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN stores s ON so.store_id = s.store_id WHERE s.store_name = '电子城旗舰店';	717197329
SELECT s.store_name, e.position FROM stores s JOIN employees e ON s.store_id = e.store_id JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-09';	1628648561
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	2064785597
SELECT e.name, s.total_amount FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id WHERE s.order_date = '2023-05-07' AND s.total_amount > 10000;	3560785170
SELECT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '索尼WH-1000XM4耳机' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name HAVING SUM(ss.profit) > 5000;	251536917
SELECT DISTINCT e.employee_id, e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'Nintendo Switch' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 5000;	634768311
SELECT p.product_name, s.profit FROM salesstatistics s JOIN products p ON s.product_id = p.product_id ORDER BY s.sales_amount DESC LIMIT 1;	725261436
SELECT od.*, p.product_name, so.total_amount FROM orderdetails od JOIN products p ON od.product_id = p.product_id JOIN salesorders so ON od.order_id = so.order_id;	1323416994
SELECT e.name, s.store_name FROM employees e JOIN stores s ON e.store_id = s.store_id;	513278066
SELECT s.manager_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id WHERE so.order_date = '2023-05-08' GROUP BY s.manager_name;	3418908967
SELECT s.order_id, e.name FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id WHERE s.total_amount > 7000;	1868084525
SELECT s.store_name, e.name, ss.sales_amount, p.product_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND ss.sales_amount > 10000 AND p.supplier_name = '苹果官方旗舰店';	3487107783
AMBIGUOUS_QUERY	556239338
SELECT * FROM salesorders WHERE order_id = 'b8b62bfe-a35d-4ff5-9bc9-654b5f67fed2';	2327152729
SELECT employee_id, SUM(sales_amount) FROM salesstatistics GROUP BY employee_id;	3589036319
SELECT product_name, sale_price, purchase_price FROM products;	3750652945
SELECT e.name AS employee_name, s.manager_name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY e.name, s.manager_name HAVING SUM(so.total_amount) > 10000;	148577634
AMBIGUOUS_QUERY	693418076
SELECT s.store_name, ss.profit FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-07' AND p.product_name = 'Apple Watch Series 7';	1476013456
SELECT s.store_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-05' AND p.sale_price > 5000 GROUP BY s.store_name HAVING SUM(so.total_amount) > 10000;	3645006631
SELECT s.order_id, p.product_name, o.quantity FROM orderdetails o JOIN salesorders s ON o.order_id = s.order_id JOIN products p ON o.product_id = p.product_id;	1046575296
SELECT * FROM salesorders WHERE store_id = '0887d06a-27a8-46b4-98d6-514702e698da';	1550748576
SELECT s.employee_id FROM salesstatistics s JOIN salesorders o ON s.order_id = o.order_id JOIN orderdetails od ON o.order_id = od.order_id WHERE EXTRACT(YEAR FROM s.date) = 2023 AND EXTRACT(MONTH FROM s.date) = 5 GROUP BY s.employee_id HAVING SUM(s.sales_quantity) > SUM(od.quantity);	2462853793
SELECT s.store_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-01' GROUP BY s.store_name;	1349452785
SELECT p.product_name, od.quantity, so.order_date FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id;	3541158395
SELECT s.manager_name FROM stores s WHERE s.store_id = (SELECT so.store_id FROM salesorders so WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY so.store_id ORDER BY SUM(so.total_amount) DESC LIMIT 1);	3496741770
AMBIGUOUS_QUERY	2485376576
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-07' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2624059207
SELECT DISTINCT s.store_name FROM stores s JOIN employees e ON s.store_id = e.store_id JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-01' AND p.product_name = '索尼WH-1000XM4耳机' AND so.total_amount > 8000;	509381804
SELECT purchase_price, sale_price FROM products;	535494901
SELECT product_id, unit_price, quantity FROM orderdetails;	3918531592
SELECT e.name, s.store_name FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN products p ON ss.product_id = p.product_id JOIN stores s ON e.store_id = s.store_id WHERE p.product_name = 'Apple Watch Series 7' AND ss.date = '2023-05-06';	4213276457
SELECT store_id, SUM(sales_amount) FROM salesstatistics GROUP BY store_id ORDER BY SUM(sales_quantity) DESC LIMIT 1;	1019928378
SELECT DISTINCT e.name, p.category_name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE date_trunc('month', so.order_date) = '2023-05-01' AND so.total_amount > 10000;	1374387165
SELECT e.employee_id, e.name, s.store_name, SUM(so.total_amount) AS total_order_amount FROM employees e JOIN stores s ON e.store_id = s.store_id JOIN salesorders so ON e.employee_id = so.employee_id GROUP BY e.employee_id, e.name, s.store_name;	765173051
SELECT s.store_name, SUM(so.total_amount) AS total_sales, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name;	1497182476
SELECT p.*, od.* FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id WHERE od.quantity > 5 AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	1106161896
SELECT p.product_name, SUM(od.quantity) AS sales_quantity, p.sale_price FROM products p JOIN orderdetails od ON p.product_id = od.product_id GROUP BY p.product_name, p.sale_price;	1170519624
SELECT s.store_name, s.manager_name, ss.profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-01' AND p.product_name = '佳能EOS R6';	834717526
SELECT store_name, address, phone, manager_name FROM stores;	2895234210
SELECT s.order_id, p.product_name FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id JOIN products p ON o.product_id = p.product_id WHERE s.total_amount < 5000;	710749857
SELECT store_id, SUM(sales_quantity) AS total_quantity, SUM(profit) AS total_profit FROM salesstatistics WHERE date >= '2023-05-01' AND date <= '2023-05-31' GROUP BY store_id ORDER BY total_quantity DESC LIMIT 1;	1055484680
SELECT s.store_name, SUM(ss.profit) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = '小米电视4A' AND ss.date >= '2023-05-01' AND ss.date <= '2023-05-31' GROUP BY s.store_name;	1417436330
SELECT e.name, SUM(s.profit) FROM salesstatistics s JOIN employees e ON s.employee_id = e.employee_id JOIN stores st ON s.store_id = st.store_id JOIN products p ON s.product_id = p.product_id WHERE s.date = '2023-05-06' AND st.store_name = '智慧街店' AND p.product_name = '小米电视4A' GROUP BY e.name;	3793589229
SELECT store_name, phone FROM stores;	1607637139
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.profit) > 1000;	3962541566
SELECT p.category_name, SUM(od.quantity) FROM products p JOIN orderdetails od ON p.product_id = od.product_id GROUP BY p.category_name;	2338461777
SELECT s.store_id, s.store_name, e.employee_id, e.name FROM stores s JOIN employees e ON s.store_id = e.store_id;	1062218506
SELECT order_id FROM salesorders WHERE total_amount > (SELECT AVG(total_amount) FROM salesorders);	1070226284
AMBIGUOUS_QUERY	2289172435
SELECT e.employee_id, e.name, s.order_date, s.total_amount FROM employees e LEFT JOIN salesorders s ON e.employee_id = s.employee_id;	2176343547
SELECT employee_id, SUM(total_amount) FROM salesorders GROUP BY employee_id;	3778494114
SELECT e.name, SUM(ss.sales_quantity) AS total_quantity, SUM(ss.profit) AS total_profit FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id GROUP BY e.name;	230146678
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id=so.store_id JOIN orderdetails od ON so.order_id=od.order_id JOIN products p ON od.product_id=p.product_id WHERE p.product_name='佳能EOS R6相机' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount>10000;	1097733010
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-05' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	406428809
SELECT store_name, SUM(sales_quantity), SUM(sales_amount) FROM salesstatistics JOIN stores ON salesstatistics.store_id = stores.store_id GROUP BY store_name;	224479304
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	549557561
AMBIGUOUS_QUERY	4264530712
SELECT order_detail_id, unit_price FROM orderdetails WHERE product_id = '某商品ID';	3474684191
SELECT store_id, date, SUM(sales_amount) FROM salesstatistics GROUP BY store_id, date;	3292698794
SELECT p.product_name FROM products p JOIN salesstatistics s ON p.product_id = s.product_id JOIN stores st ON s.store_id = st.store_id WHERE st.store_name = '未来城店' AND p.purchase_price > 4000;	3179632170
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-09' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	2509582177
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-02' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	1374950508
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-09' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.sales_amount) > 1000;	2266088702
SELECT DISTINCT e.name, p.category_name FROM salesorders so JOIN employees e ON so.employee_id = e.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 10000;	2178886607
SELECT store_name, SUM(profit) FROM salesstatistics JOIN stores USING(store_id) GROUP BY store_name;	2714447935
SELECT s.store_name, e.name, ss.sales_amount, p.product_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND ss.sales_amount > 10000 AND p.supplier_name = '索尼官方旗舰店';	1871066617
SELECT s.order_id, o.order_detail_id FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id WHERE s.total_amount > 5000;	2023023440
AMBIGUOUS_QUERY	3146544905
SELECT sales_quantity, store_name FROM salesstatistics JOIN stores ON salesstatistics.store_id = stores.store_id WHERE date >= '2023-05-01' AND date <= '2023-05-31';	283454282
SELECT product_id, sale_price, purchase_price FROM products;	2083297023
SELECT s.store_name, SUM(ss.sales_quantity) AS sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND p.category_name = '智能手表' AND p.supplier_name = '索尼官方旗舰店' GROUP BY s.store_name HAVING SUM(ss.sales_quantity) > 10;	2394150048
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name HAVING AVG(so.total_amount) > 10000;	519899560
SELECT s.store_name, ss.profit FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-02' AND p.product_name = 'iPad Air';	1920836570
AMBIGUOUS_QUERY	3659690943
SELECT s.store_name, SUM(ss.sales_amount) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	1937076000
SELECT s.store_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'Apple Watch Series 7' AND so.order_date = '2023-05-09' GROUP BY s.store_name;	2659013528
SELECT quantity, unit_price FROM orderdetails;	1610928077
SELECT DISTINCT s.store_name, e.name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31';	2010016216
SELECT * FROM salesstatistics WHERE sales_quantity > 1;	1911035258
SELECT s.store_name, SUM(ss.profit) FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND date >= '2023-05-01' AND date < '2023-06-01' GROUP BY s.store_name;	761870148
SELECT total_amount, order_date FROM salesorders;	3087271800
SELECT s.store_id, SUM(so.total_amount) AS 订单总金额, SUM(ss.sales_quantity) AS 销售数量 FROM stores s LEFT JOIN salesorders so ON s.store_id = so.store_id LEFT JOIN salesstatistics ss ON s.store_id = ss.store_id GROUP BY s.store_id;	1161484474
SELECT * FROM orderdetails WHERE quantity = 2;	52411810
SELECT s.store_name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-01' AND p.product_name = '戴尔灵越15';	1664706844
SELECT e.position, s.store_name FROM employees e JOIN stores s ON e.store_id = s.store_id;	3840473394
SELECT s.store_name, SUM(ss.profit) AS total_profit FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '佳能EOS R6' AND ss.date = '2023-05-03' GROUP BY s.store_name;	2695189368
AMBIGUOUS_QUERY	2733025825
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' AND p.product_name = '华为Mate 40 Pro' AND ss.sales_quantity > 1;	807812239
SELECT s.order_id, p.product_name, o.quantity FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id JOIN products p ON o.product_id = p.product_id;	4273091220
SELECT e.name, e.position, s.phone FROM employees e JOIN stores s ON e.store_id = s.store_id;	4275534962
SELECT s.store_name, e.name, ss.sales_quantity FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE ss.date = '2023-05-05' AND p.product_name = '戴尔灵越15' AND ss.sales_quantity > 1;	1477929232
SELECT s.order_id, s.total_amount, o.quantity, o.unit_price, p.product_name, p.category_name FROM salesorders s JOIN orderdetails o ON s.order_id = o.order_id JOIN products p ON o.product_id = p.product_id WHERE s.total_amount > 5000;	729968430
SELECT e.name, s.total_amount FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id;	1040158875
SELECT * FROM salesstatistics WHERE profit > 3000;	1660394186
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-01' AND p.product_name = 'Apple Watch Series 7' AND so.total_amount > 7000;	3002487561
SELECT product_name, remaining_quantity, category_name FROM products;	2715847000
SELECT DISTINCT e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-07' AND p.category_name = '相机' AND so.total_amount > 15000;	1326759420
AMBIGUOUS_QUERY	57033443
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-08' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2455933109
SELECT e.name, ss.sales_quantity, ss.sales_amount FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-03' AND s.store_name = '数字大道店' AND p.product_name = 'Nintendo Switch';	4078619784
SELECT stores.store_name FROM salesstatistics JOIN products ON salesstatistics.product_id = products.product_id JOIN stores ON salesstatistics.store_id = stores.store_id WHERE products.product_name = '戴森V11' AND salesstatistics.date = '2023-05-05' AND salesstatistics.profit > 500;	2372435041
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-09' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.sales_amount) > 2000;	1022758323
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-01' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	2940623149
AMBIGUOUS_QUERY	3177645630
AMBIGUOUS_QUERY	2385992805
SELECT store_name, address, phone FROM stores;	2749807521
SELECT s.store_name, e.name, so.total_amount FROM salesorders so JOIN stores s ON so.store_id = s.store_id JOIN employees e ON so.employee_id = e.employee_id WHERE so.order_date = '2023-05-02' AND so.total_amount > 2000;	888076621
SELECT s.store_name, SUM(ss.sales_quantity), SUM(ss.profit) FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id GROUP BY s.store_name;	1648589599
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-07' GROUP BY s.store_name, s.manager_name HAVING SUM(ss.profit) > 1000;	2992228883
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-08' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	3404171320
SELECT store_name FROM stores JOIN salesstatistics ON stores.store_id = salesstatistics.store_id WHERE date = '2023-05-09' GROUP BY store_name ORDER BY SUM(profit) DESC LIMIT 1;	952156269
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '佳能EOS R6相机' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 5000;	4068577452
SELECT DISTINCT s.store_name, e.position FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'iPad Air' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	1242514407
SELECT category_name, sale_price FROM products;	3705049314
SELECT s.store_id, COUNT(DISTINCT e.employee_id) AS manager_count FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN employees e ON s.store_id = e.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND e.position = '销售经理' GROUP BY s.store_id HAVING SUM(so.total_amount) > 10000;	4213863561
SELECT p.product_id, p.remaining_quantity, SUM(s.sales_quantity) AS sales_quantity FROM products p LEFT JOIN salesstatistics s ON p.product_id = s.product_id GROUP BY p.product_id, p.remaining_quantity;	1964767451
SELECT order_id, order_date, total_amount FROM salesorders;	2226247599
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-06' AND p.product_name = '华为Mate 40 Pro' AND ss.sales_quantity > 1;	2202777878
SELECT s.store_name, e.name, e.position FROM stores s JOIN employees e ON s.store_id = e.store_id;	3419270272
SELECT e.name, SUM(od.quantity * od.unit_price) FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-01' AND s.store_name = '创客空间店' AND p.product_name = '华为Mate 40 Pro' GROUP BY e.name;	569246445
SELECT s.store_name, e.position FROM stores s JOIN employees e ON s.store_id = e.store_id JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '戴森V11' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31';	830322285
SELECT * FROM orderdetails JOIN products ON orderdetails.product_id = products.product_id;	2616706012
SELECT DISTINCT employee_id FROM salesstatistics JOIN products ON salesstatistics.product_id = products.product_id WHERE date = '2023-05-06' AND sales_quantity > 1 AND supplier_name = '戴尔官方旗舰店';	2466792320
SELECT product_name, sale_price FROM products;	1812987912
SELECT manager_name, phone FROM stores;	3453098028
SELECT SUM(s.total_amount) AS 总金额, st.store_name AS 门店名称 FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id JOIN stores st ON s.store_id = st.store_id WHERE e.name = '范莹' AND s.order_date = '2023-05-07' GROUP BY st.store_name;	4200224368
SELECT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = 'Apple Watch Series 7' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name HAVING SUM(so.total_amount) > 10000;	1555442404
SELECT s.store_name, SUM(o.total_amount) FROM salesorders o JOIN stores s ON o.store_id = s.store_id WHERE o.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name;	3702552802
SELECT store_name, manager_name FROM stores;	2171002807
SELECT product_name, sale_price, remaining_quantity FROM products;	2060589508
AMBIGUOUS_QUERY	356180662
SELECT DISTINCT s.store_name FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-08' AND p.product_name = '索尼WH-1000XM4' AND so.total_amount > 15000;	4289573231
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-09' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	218019223
SELECT SUM(profit) FROM salesstatistics;	1638224805
AMBIGUOUS_QUERY	2476507165
SELECT s.store_name, SUM(ss.sales_quantity) FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id WHERE e.name = '黄萍' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	1748148291
SELECT s.store_name, ss.profit FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-08' AND p.product_name = 'Nintendo Switch';	2979325122
SELECT s.store_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-05' AND p.product_name = '索尼WH-1000XM4耳机' GROUP BY s.store_name;	2667320856
SELECT e.name FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-05' AND s.store_name = '智能生活馆' AND p.supplier_name = '小米官方旗舰店';	1093613959
SELECT store_name, manager_name FROM stores WHERE store_id = (SELECT store_id FROM salesstatistics WHERE date = '2023-05-07' GROUP BY store_id ORDER BY SUM(profit) DESC LIMIT 1);	2112449268
SELECT s.store_name, ss.profit FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-09' AND p.product_name = '索尼WH-1000XM4耳机';	2094309801
AMBIGUOUS_QUERY	3718167842
SELECT s.total_amount, t.store_name FROM salesorders s JOIN stores t ON s.store_id = t.store_id WHERE s.order_date = '2023-05-03';	3764251163
SELECT * FROM orderdetails WHERE quantity > 1;	1497641640
AMBIGUOUS_QUERY	4149606926
SELECT s.*, st.store_name FROM salesorders s JOIN stores st ON s.store_id = st.store_id WHERE s.order_date = '2023-05-05';	4134019112
SELECT p.product_name, od.order_id FROM orderdetails od JOIN products p ON od.product_id = p.product_id WHERE od.quantity > 1;	2245397691
SELECT * FROM salesorders WHERE order_date BETWEEN '2023-05-01' AND '2023-05-31';	2674486311
SELECT employee_id, SUM(sales_quantity) FROM salesstatistics GROUP BY employee_id;	2993192059
SELECT category_name, remaining_quantity FROM products;	2808717165
SELECT e.employee_id, e.name, s.store_name, SUM(ss.sales_quantity) AS sales_quantity FROM employees e JOIN salesstatistics ss ON e.employee_id = ss.employee_id JOIN stores s ON e.store_id = s.store_id GROUP BY e.employee_id, e.name, s.store_name;	3833291686
SELECT order_id, product_id FROM orderdetails;	2280059229
AMBIGUOUS_QUERY	77729748
AMBIGUOUS_QUERY	82660779
SELECT DISTINCT e.name FROM employees e JOIN salesstatistics s ON e.employee_id = s.employee_id JOIN products p ON s.product_id = p.product_id WHERE s.date = '2023-05-09' AND p.product_name = 'Apple Watch Series 7' AND p.supplier_name = '任天堂官方旗舰店';	787968865
SELECT s.total_amount, t.store_name FROM salesorders s JOIN stores t ON s.store_id = t.store_id WHERE s.order_date = '2023-05-06';	3377021543
AMBIGUOUS_QUERY	813286043
SELECT e.name, SUM(so.total_amount) FROM employees e JOIN salesorders so ON e.employee_id = so.employee_id JOIN stores s ON so.store_id = s.store_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE so.order_date = '2023-05-07' AND s.store_name = '智慧街店' AND p.product_name = '佳能EOS R6相机' GROUP BY e.name;	727992931
SELECT store_id, SUM(quantity) AS total_quantity, SUM(total_amount) AS total_amount FROM salesorders GROUP BY store_id;	825037872
SELECT s.store_name, so.total_amount FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = '佳能EOS R6相机' AND so.order_date = '2023-05-05';	4082105822
SELECT * FROM products WHERE sale_price > 15000;	3249720567
SELECT s.store_name FROM stores s JOIN salesstatistics ss ON s.store_id = ss.store_id JOIN products p ON ss.product_id = p.product_id WHERE p.product_name = '索尼WH-1000XM4' AND ss.date = '2023-05-08' AND ss.sales_quantity > 1;	2614838216
SELECT s.store_name, e.name, p.product_name, ss.sales_amount FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-01' AND ss.sales_amount > 1000 AND p.supplier_name = '戴森官方旗舰店';	1333469519
AMBIGUOUS_QUERY	2995198030
SELECT s.store_name, SUM(so.total_amount) FROM stores s JOIN salesorders so ON s.store_id = so.store_id GROUP BY s.store_name;	2649378296
AMBIGUOUS_QUERY	746087372
SELECT s.order_id, s.order_date, e.name FROM salesorders s JOIN employees e ON s.employee_id = e.employee_id;	3679313236
SELECT product_name, supplier_name FROM products;	2391253319
SELECT product_name, sale_price, supplier_name FROM products;	1769098425
SELECT o.*, p.product_name, p.sale_price FROM orderdetails o JOIN products p ON o.product_id = p.product_id;	622285765
SELECT s.store_name, s.phone FROM stores s JOIN salesorders so ON s.store_id = so.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.phone HAVING SUM(so.total_amount) > 3000;	3990639391
SELECT store_name, manager_name FROM stores;	986209829
SELECT e.name, s.phone FROM employees e JOIN stores s ON e.store_id = s.store_id;	2997501252
SELECT e.name, ss.sales_quantity, ss.profit FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON ss.store_id = s.store_id JOIN products p ON ss.product_id = p.product_id WHERE ss.date = '2023-05-09' AND s.store_name = '创新路专卖店' AND p.product_name = 'iPad Air';	3439332131
SELECT e.name FROM employees e JOIN salesorders s ON e.employee_id = s.employee_id JOIN stores st ON s.store_id = st.store_id WHERE s.order_date = '2023-05-07' AND st.store_name = '未来城店' AND s.total_amount > 15000;	3283669448
SELECT product_id, product_name, sale_price - purchase_price AS price_difference FROM products;	1627244723
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	1569820240
SELECT store_id, SUM(profit) AS total_profit, SUM(sales_quantity) AS total_sales FROM salesstatistics GROUP BY store_id;	3499069647
SELECT * FROM salesorders WHERE store_id = '64921abb-1d54-4e03-a15e-ea42f058f31c';	1379442449
SELECT s.store_name FROM stores s JOIN employees e ON s.store_id = e.store_id JOIN salesorders so ON e.employee_id = so.employee_id JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id WHERE p.product_name = '小米电视4A' AND so.order_date = '2023-05-06' AND so.total_amount > 10000;	2629127246
SELECT DISTINCT s.store_name FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = 'Nintendo Switch' AND ss.date BETWEEN '2023-05-01' AND '2023-05-31' AND ss.profit > 1000;	3788770697
SELECT s.store_name, ss.sales_quantity, ss.sales_amount FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id WHERE p.product_name = '索尼WH-1000XM4' AND ss.date = '2023-05-09';	1545362727
AMBIGUOUS_QUERY	2279456937
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-03' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2483765707
SELECT s.store_name, s.manager_name FROM salesstatistics ss JOIN stores s ON ss.store_id = s.store_id WHERE ss.date = '2023-05-03' GROUP BY s.store_name, s.manager_name ORDER BY SUM(ss.sales_quantity) DESC LIMIT 1;	2155062621
SELECT s.store_name, so.total_amount FROM products p JOIN orderdetails od ON p.product_id = od.product_id JOIN salesorders so ON od.order_id = so.order_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = 'iPad Air' AND so.order_date = '2023-05-01';	1172044345
SELECT store_id, SUM(total_amount) FROM salesorders GROUP BY store_id;	413296723
SELECT e.position, COUNT(o.order_id) FROM employees e LEFT JOIN salesorders o ON e.employee_id = o.employee_id GROUP BY e.position;	1774082301
AMBIGUOUS_QUERY	1485164601
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date BETWEEN '2023-05-01' AND '2023-05-31' GROUP BY s.store_name, s.manager_name HAVING SUM(so.total_amount) > 10000;	1282673925
SELECT s.store_name FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-02' AND p.supplier_name = '华为官方旗舰店' GROUP BY s.store_name HAVING SUM(od.quantity * od.unit_price) > 10000;	3234218182
AMBIGUOUS_QUERY	623061772
AMBIGUOUS_QUERY	3776277190
SELECT s.store_name, s.manager_name FROM salesorders so JOIN stores s ON so.store_id = s.store_id WHERE so.order_date = '2023-05-04' GROUP BY s.store_name, s.manager_name ORDER BY SUM(so.total_amount) DESC LIMIT 1;	2220998092
SELECT s.store_name, e.position FROM salesstatistics ss JOIN products p ON ss.product_id = p.product_id JOIN stores s ON ss.store_id = s.store_id JOIN employees e ON ss.employee_id = e.employee_id WHERE p.product_name = '华为Mate 40 Pro' AND ss.date = '2023-05-01';	3144588067
SELECT e.name, s.manager_name FROM salesstatistics ss JOIN employees e ON ss.employee_id = e.employee_id JOIN stores s ON e.store_id = s.store_id WHERE ss.date = '2023-05-06' AND ss.sales_amount > 10000;	3325155262
SELECT s.store_name, e.name, so.total_amount FROM salesorders so JOIN orderdetails od ON so.order_id = od.order_id JOIN products p ON od.product_id = p.product_id JOIN employees e ON so.employee_id = e.employee_id JOIN stores s ON so.store_id = s.store_id WHERE p.product_name = '戴尔灵越15笔记本电脑' AND so.order_date BETWEEN '2023-05-01' AND '2023-05-31' AND so.total_amount > 5000;	3438936179
SELECT product_id, remaining_quantity, sale_price FROM products;	214316002
SELECT store_name, COUNT(*) FROM stores JOIN employees ON stores.store_id = employees.store_id GROUP BY store_name;	3304679388
SELECT e.name FROM employees e JOIN salesstatistics s ON e.employee_id = s.employee_id JOIN products p ON s.product_id = p.product_id JOIN stores st ON s.store_id = st.store_id WHERE s.date = '2023-05-05' AND st.store_name = '科技中心店' AND p.product_name = '戴森V11' AND s.sales_quantity > 1;	1528991895
SELECT order_id, total_amount FROM salesorders JOIN stores ON salesorders.store_id = stores.store_id WHERE store_name = '数码广场店';	127103551
SELECT ra.*, re.* FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id WHERE ra.risk_level = '高' AND ra.impact_score > 8;	1891291054
SELECT * FROM risk_events WHERE event_type = '合规风险';	491501449
SELECT risk_events.event_id, audit_logs.audit_result FROM alerts JOIN risk_events ON alerts.event_id = risk_events.event_id JOIN audit_logs ON audit_logs.alert_id = alerts.alert_id WHERE alerts.alert_type = '欺诈嫌疑';	3354532402
SELECT report_type, AVG(severity) FROM risk_reports JOIN risk_events ON risk_reports.event_id = risk_events.event_id WHERE approval_status = '已批准' GROUP BY report_type;	1450781019
SELECT risk_level, COUNT(*), AVG(credit_score) FROM customers GROUP BY risk_level;	3784241191
SELECT * FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id WHERE rml.monitoring_date >= '2023-10-01' AND rml.monitoring_date < '2023-11-01';	2169849694
SELECT report_content, author, event_id FROM risk_reports WHERE approval_status = '已批准';	1821041301
SELECT c.risk_level, t.transaction_type, CASE WHEN t.amount < 1000 THEN '小额' WHEN t.amount BETWEEN 1000 AND 10000 THEN '中额' ELSE '大额' END AS amount_range, COUNT(*) AS transaction_count, AVG(t.risk_score) AS avg_risk_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level, t.transaction_type, amount_range;	2399924571
AMBIGUOUS_QUERY	2832409698
SELECT r.report_id, r.report_type, r.report_date, e.event_id, e.event_type, e.event_description, a.assessment_id, a.risk_level, a.impact_score, a.probability_score FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id JOIN risk_assessments a ON e.event_id = a.event_id WHERE r.author = '周婷';	4007902186
SELECT author, approval_status FROM risk_reports WHERE report_date >= '2023-01-01';	3766793908
SELECT re.event_description, ra.risk_level, ra.mitigation_plan FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE re.event_description LIKE '%系统%';	379347511
SELECT 
    ri.indicator_id,
    ri.indicator_name,
    curr.actual_value AS current_value,
    prev.actual_value AS value_30_days_ago,
    ((curr.actual_value - prev.actual_value) / NULLIF(prev.actual_value, 0)) * 100 AS change_percentage
FROM 
    risk_indicators ri
JOIN 
    (SELECT indicator_id, actual_value FROM risk_monitoring_logs WHERE monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs)) curr 
    ON ri.indicator_id = curr.indicator_id
JOIN 
    (SELECT indicator_id, actual_value FROM risk_monitoring_logs WHERE monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE monitoring_date <= NOW() - INTERVAL '30 days')) prev 
    ON ri.indicator_id = prev.indicator_id;	1838288170
SELECT event_id FROM risk_assessments WHERE risk_level = '高风险' AND assessor = '曾强';	3470826751
SELECT c.customer_id, c.customer_name FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_type = '投资' AND t.risk_score > 60;	1344992090
SELECT created_at, status FROM risk_events;	1091103550
SELECT c.customer_id, t.risk_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score < 600;	1666978001
SELECT t.amount, c.customer_name FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.transaction_date BETWEEN '2023-12-01' AND '2023-12-31' AND t.status = '成功';	3043489169
SELECT alert_type, alert_content FROM alerts;	228553912
SELECT report_id, report_type, report_date, approved_by FROM risk_reports;	3145840427
SELECT transaction_type, AVG(CASE WHEN status='成功' THEN 1.0 ELSE 0.0 END) AS success_rate, AVG(risk_score) AS avg_risk_score FROM transactions GROUP BY transaction_type;	2194753030
SELECT a.alert_id, r.rule_description FROM alerts a JOIN rule_configurations r ON a.rule_id = r.rule_id;	2007490591
SELECT c.customer_id, t.status FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date = (SELECT MAX(transaction_date) FROM transactions WHERE customer_id = c.customer_id);	1993896438
SELECT indicator_id, AVG(actual_value), STDDEV(actual_value), STDDEV(actual_value)/NULLIF(AVG(actual_value),0)*100 FROM risk_monitoring_logs GROUP BY indicator_id;	2353107053
SELECT DISTINCT t1.customer_id FROM transactions t1 JOIN transactions t2 ON t1.customer_id = t2.customer_id WHERE t1.risk_score > 80 AND t1.transaction_date >= CURRENT_DATE - INTERVAL '1 year' AND t2.amount > 500000 AND t2.status = '未通过审核' AND t2.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	1348678368
SELECT assessment_id, (SELECT AVG(impact_score) FROM risk_assessments WHERE mitigation_plan IS NULL) AS avg_impact_score FROM risk_assessments WHERE mitigation_plan IS NULL;	3331891334
SELECT alert_content, status FROM alerts;	3770586804
SELECT c.customer_id, c.customer_name, 
       (COUNT(CASE WHEN t.transaction_date >= CURRENT_DATE - INTERVAL '90 days' AND t.risk_score > 80 THEN 1 END) * 2 + 
        COUNT(CASE WHEN a.status = '未处理' THEN 1 END) * 3 + 
        (1.0 / NULLIF(c.credit_score, 0)) * 1000) AS risk_index 
FROM customers c 
LEFT JOIN transactions t ON c.customer_id = t.customer_id 
LEFT JOIN alerts a ON c.customer_id = a.assigned_to 
GROUP BY c.customer_id, c.customer_name, c.credit_score 
ORDER BY risk_index DESC 
LIMIT 10;	2420031848
SELECT event_type, COUNT(*) AS event_count, AVG(severity) AS avg_severity FROM risk_events WHERE occurrence_time >= '2023-01-01' AND occurrence_time < '2024-01-01' GROUP BY event_type ORDER BY event_count DESC;	2122948167
SELECT r.report_id, e.* FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.report_content LIKE '%合规风险%';	1467350797
SELECT update_frequency, data_source FROM risk_indicators;	1619162011
SELECT e.*, r.* FROM risk_events e LEFT JOIN risk_reports r ON e.event_id = r.event_id AND r.report_date = (SELECT MAX(report_date) FROM risk_reports WHERE event_id = e.event_id) WHERE e.status = '未解决';	3180110269
SELECT rc.rule_type, COUNT(a.alert_id)/COUNT(DISTINCT rc.rule_id) AS avg_trigger_count, MAX(rc.updated_at) AS last_update_time FROM rule_configurations rc LEFT JOIN alerts a ON rc.rule_id = a.rule_id GROUP BY rc.rule_type;	491065533
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type ORDER BY COUNT(*) DESC;	210792684
SELECT DISTINCT c.customer_id, c.customer_name FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score < 700 AND t.transaction_date >= '2023-01-01' AND t.transaction_date < '2024-01-01';	528895519
SELECT * FROM risk_events JOIN risk_reports ON risk_events.event_id = risk_reports.event_id;	3994194373
SELECT COUNT(*) FROM risk_reports WHERE approval_status = '拒绝' AND report_date BETWEEN '2023-01-01' AND '2023-12-31';	3108618170
SELECT * FROM risk_assessments;	2756291249
SELECT * FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY indicator_id ORDER BY monitoring_date DESC) AS rn FROM risk_monitoring_logs) t WHERE t.rn = 1;	3508177846
SELECT r.rule_id, COUNT(a.alert_id) FROM rule_configurations r LEFT JOIN alerts a ON r.rule_id = a.rule_id GROUP BY r.rule_id;	3123122302
SELECT * FROM transactions JOIN risk_events ON transactions.event_id = risk_events.event_id WHERE risk_events.event_type = '信用风险' AND transactions.status = '成功';	3431937746
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	4153763267
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_amount) FROM (SELECT c.customer_id, SUM(t.amount) AS total_amount FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.registration_date < '2019-01-01' AND c.risk_level = '高' GROUP BY c.customer_id) AS customer_totals;	2480143604
SELECT rc.rule_name, re.event_description FROM alerts a JOIN rule_configurations rc ON a.rule_id = rc.rule_id JOIN risk_events re ON a.event_id = re.event_id WHERE a.alert_level = '高风险';	1278986057
SELECT created_at, status FROM risk_events;	983609731
SELECT event_type, TO_CHAR(occurrence_time, 'YYYY-MM') AS month, COUNT(*) AS count, (COUNT(*) - LAG(COUNT(*)) OVER (PARTITION BY event_type ORDER BY TO_CHAR(occurrence_time, 'YYYY-MM'))) * 100.0 / NULLIF(LAG(COUNT(*)) OVER (PARTITION BY event_type ORDER BY TO_CHAR(occurrence_time, 'YYYY-MM')), 0) AS growth_rate FROM risk_events GROUP BY event_type, TO_CHAR(occurrence_time, 'YYYY-MM') ORDER BY event_type, month;	2727402886
SELECT DATE_TRUNC('month', transaction_date) AS month, AVG(amount) AS avg_amount, COUNT(*) AS transaction_count FROM transactions GROUP BY month;	1304137472
SELECT r.report_id, r.report_type, r.approved_by, e.event_description, e.severity FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approval_status = '已批准';	1801532770
SELECT DISTINCT c.risk_level, t.status FROM customers c JOIN transactions t ON c.customer_id = t.customer_id;	2532729979
SELECT transaction_id, status FROM transactions JOIN customers USING (customer_id) WHERE risk_level = '高风险';	1467489344
SELECT * FROM risk_reports WHERE author = '孙宇' AND approval_status = '未审批';	2860062939
SELECT a.alert_content, r.event_description FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理';	186829469
SELECT risk_level, COUNT(*) FROM customers WHERE risk_level IN ('中','高') GROUP BY risk_level;	1965814026
SELECT c.customer_id, COUNT(t.transaction_id) AS transaction_count, COALESCE(AVG(t.risk_score), 0) AS avg_risk_score FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.customer_id ORDER BY c.customer_id;	1229601142
SELECT TO_CHAR(registration_date, 'YYYY-MM') AS month, COUNT(*) FROM customers WHERE risk_level = '高风险' GROUP BY month ORDER BY month;	134467671
SELECT ri.indicator_id, ri.indicator_name, rml.monitoring_date, rml.actual_value, a.alert_id, a.alert_time, al.audit_id, al.audit_time FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id AND rml.is_exceeding_threshold = true LEFT JOIN rule_configurations rc ON ri.indicator_id = rc.indicator_id LEFT JOIN alerts a ON rc.rule_id = a.rule_id LEFT JOIN audit_logs al ON a.alert_id = al.alert_id WHERE rml.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = ri.indicator_id);	2051579057
SELECT risk_level, COUNT(*) AS customer_count, AVG(credit_score) AS avg_credit_score FROM customers GROUP BY risk_level;	1467515231
SELECT alert_type FROM alerts WHERE status = '已解决' GROUP BY alert_type ORDER BY AVG(EXTRACT(EPOCH FROM (NOW() - alert_time))) DESC LIMIT 1;	928241464
SELECT c.customer_name, t.amount, t.transaction_date FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.amount > 100000 AND t.transaction_date BETWEEN '2023-11-01' AND '2023-11-30';	861248617
SELECT indicator_name, SUM(threshold_value) FROM risk_indicators WHERE indicator_name LIKE '%财务%';	2228247623
SELECT customer_name, credit_score FROM customers;	1010279388
SELECT DISTINCT ON (t.customer_id) t.customer_id, t.transaction_date, t.risk_score FROM transactions t ORDER BY t.customer_id, t.transaction_date DESC;	3854618324
SELECT * FROM risk_monitoring_logs WHERE is_exceeding_threshold = true;	4048786296
SELECT AVG(t.risk_score) FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险';	2208124060
SELECT c.customer_id, c.customer_name, t.* FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id;	2046381691
SELECT report_type, COUNT(*) FROM risk_reports WHERE approval_status = '已拒绝' GROUP BY report_type;	218145680
SELECT customer_id FROM customers WHERE risk_level = '高' AND credit_score < 600;	4118993277
SELECT c.risk_level, AVG(t.amount) AS avg_amount, COUNT(*) AS transaction_count FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY c.risk_level;	4099101626
SELECT report_content FROM risk_reports WHERE event_id IN (SELECT event_id FROM risk_events WHERE event_type = '流动性风险');	158715771
SELECT COUNT(DISTINCT c.customer_id), COALESCE(SUM(t.amount), 0) FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id WHERE c.credit_score BETWEEN 600 AND 800;	1057264197
SELECT report_content FROM risk_reports WHERE approved_by = '王思远' AND report_date BETWEEN '2023-03-01' AND '2023-03-31';	2894258616
SELECT re.*, rr.* FROM risk_events re LEFT JOIN risk_reports rr ON re.event_id = rr.event_id;	1697426124
SELECT * FROM transactions WHERE transaction_date >= '2023-06-01' AND transaction_date < '2023-07-01';	1368489416
SELECT event_id FROM risk_events WHERE severity = 3 AND EXISTS (SELECT 1 FROM audit_logs WHERE audit_logs.event_id = risk_events.event_id);	1079159915
SELECT ri.indicator_name, ri.threshold_value, rml.actual_value FROM risk_indicators ri JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id WHERE rml.actual_value > ri.threshold_value;	1387862561
SELECT c.customer_id, c.customer_name, c.risk_level, t.status FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id;	1914208134
SELECT re.*, a.* FROM risk_events re JOIN alerts a ON re.event_id = a.event_id WHERE a.alert_level = '高';	3189905137
SELECT * FROM risk_events JOIN alerts ON risk_events.event_id = alerts.event_id ORDER BY alerts.alert_time;	434260556
SELECT c.risk_level, AVG(t.amount) AS avg_amount, COUNT(*) AS transaction_count FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_date >= CURRENT_DATE - INTERVAL '90 days' GROUP BY c.risk_level;	3762237075
SELECT customer_id, customer_name FROM customers WHERE risk_level = '高' AND credit_score < 700;	2322626250
SELECT DISTINCT ON (c.customer_id) c.credit_score, t.transaction_id, t.transaction_type, t.amount, t.transaction_date FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.status = '失败' ORDER BY c.customer_id, t.transaction_date DESC;	294935919
SELECT ra.assessment_id, c.customer_id, c.customer_name, c.credit_score, ra.risk_level FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id JOIN transactions t ON re.event_id = t.event_id JOIN customers c ON t.customer_id = c.customer_id WHERE ra.risk_level = '高风险' AND c.credit_score > 700;	1926912221
SELECT * FROM customers WHERE customer_type = '企业' ORDER BY credit_score DESC LIMIT 10;	3499522069
SELECT 
    DATE_TRUNC('month', created_at) AS month,
    COUNT(*) AS new_rules_count,
    AVG(CASE WHEN is_active THEN 1 ELSE 0 END) AS avg_active_rules
FROM rule_configurations
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY month;	538732127
SELECT author, approval_status FROM risk_reports WHERE approval_status = '已批准';	2736181075
SELECT c.customer_id, c.customer_name, t.amount, t.status FROM customers c JOIN transactions t ON c.customer_id = t.customer_id;	1873450174
SELECT re.event_id, re.event_type, re.event_description, re.occurrence_time, re.severity, ra.risk_level, ra.impact_score, ra.probability_score FROM risk_events re LEFT JOIN risk_assessments ra ON re.event_id = ra.event_id;	3031401155
SELECT i.indicator_id, i.indicator_name, AVG(l.actual_value) AS avg_value, i.threshold_value FROM risk_indicators i JOIN risk_monitoring_logs l ON i.indicator_id = l.indicator_id GROUP BY i.indicator_id, i.indicator_name, i.threshold_value;	1926763899
SELECT rr.*, re.* FROM risk_reports rr JOIN risk_events re ON rr.event_id = re.event_id WHERE rr.approval_status = '已批准';	2380941668
SELECT DISTINCT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN alerts a ON DATE(t.transaction_date) = DATE(a.alert_time) WHERE t.risk_score > 80 AND a.alert_level = '高';	1133773952
SELECT t.*, c.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.risk_score > 80 OR t.status = '高风险';	2358748811
SELECT e.event_description, a.assessment_date FROM risk_assessments a JOIN risk_events e ON a.event_id = e.event_id WHERE a.risk_level = '高';	634372359
SELECT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险' AND t.status = '失败' AND t.transaction_date = (SELECT MAX(transaction_date) FROM transactions WHERE customer_id = c.customer_id);	54166415
SELECT re.event_id, COUNT(t.transaction_id) FROM risk_events re LEFT JOIN transactions t ON re.event_id = t.event_id GROUP BY re.event_id;	775802297
SELECT t.*, c.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险' AND t.amount > 500000 AND t.transaction_date BETWEEN '2023-01-01' AND '2023-03-31';	3320369998
SELECT re.event_description, re.severity, ra.risk_level, ra.mitigation_plan FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id WHERE EXTRACT(YEAR FROM re.occurrence_time) = 2023 AND re.severity IN (4, 5);	4254692719
SELECT * FROM risk_monitoring_logs WHERE is_exceeding_threshold = false;	3645112410
SELECT rr.report_id, rr.report_type, rr.report_date, rr.author, re.event_type, re.event_description, re.occurrence_time, re.severity, al.audit_time, al.auditor, al.audit_result FROM risk_reports rr LEFT JOIN risk_events re ON rr.event_id = re.event_id LEFT JOIN (SELECT related_id, audit_time, auditor, audit_result FROM audit_logs WHERE audit_type = '风险报告审核' ORDER BY audit_time DESC LIMIT 1) al ON rr.report_id = al.related_id WHERE rr.approval_status = '待审批';	1798162210
SELECT customer_name FROM customers WHERE registration_date BETWEEN '2021-01-01' AND '2021-12-31' AND risk_level = '高' AND credit_score < 550;	2215350256
AMBIGUOUS_QUERY	1774673651
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	3960174076
SELECT c.customer_name, r.rule_name, COUNT(a.alert_id) AS trigger_count FROM customers c JOIN alerts a ON c.customer_id = (SELECT customer_id FROM transactions WHERE event_id = a.event_id LIMIT 1) JOIN rule_configurations r ON a.rule_id = r.rule_id WHERE c.risk_level = '高' GROUP BY c.customer_name, r.rule_name;	4181335061
SELECT event_type, TO_CHAR(occurrence_time, 'YYYY-MM') AS month, COUNT(*) AS event_count, AVG(severity) AS avg_severity, ROUND(100.0 * SUM(CASE WHEN status = '已解决' THEN 1 ELSE 0 END) / COUNT(*), 2) AS resolution_rate FROM risk_events GROUP BY event_type, TO_CHAR(occurrence_time, 'YYYY-MM');	995864049
SELECT rml.log_id, ri.indicator_name, rml.actual_value, ri.threshold_value, rml.is_exceeding_threshold FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id;	430786160
SELECT c.risk_level, t.transaction_type, avg(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level, t.transaction_type;	2101060146
SELECT COUNT(*) FROM rule_configurations WHERE is_active = true;	1665434378
SELECT risk_level, credit_score FROM customers;	3176119352
SELECT COUNT(*) AS count, AVG(update_frequency) AS avg_update_frequency FROM risk_indicators WHERE threshold_value > 100;	1713409158
SELECT customer_name, registration_date FROM customers;	1230885426
SELECT indicator_id, actual_value, is_exceeding_threshold FROM risk_monitoring_logs;	1766048190
SELECT i.indicator_name, i.data_source, AVG(l.actual_value) AS average_value, STDDEV(l.actual_value) AS standard_deviation FROM risk_indicators i JOIN risk_monitoring_logs l ON i.indicator_id = l.indicator_id GROUP BY i.indicator_name, i.data_source;	2747654158
SELECT auditor FROM audit_logs WHERE audit_result = '拒绝';	1853147969
SELECT alert_type, alert_content FROM alerts;	2764222826
SELECT a.alert_id, a.alert_type, a.alert_level, a.alert_time, e.event_description, al.audit_time, al.audit_result, al.audit_comments FROM alerts a LEFT JOIN risk_events e ON a.event_id = e.event_id LEFT JOIN (SELECT DISTINCT ON (alert_id) * FROM audit_logs ORDER BY alert_id, audit_time DESC) al ON a.alert_id = al.alert_id WHERE a.status = '未处理';	1328047815
SELECT AVG(alert_time) FROM alerts WHERE status != '已处理';	1153256443
SELECT c.customer_id, (COUNT(DISTINCT ra.assessment_id) * AVG((ra.impact_score + ra.probability_score)/2) + COUNT(DISTINCT a.alert_id) * 2) AS risk_index FROM customers c LEFT JOIN transactions t ON c.customer_id = t.customer_id LEFT JOIN risk_assessments ra ON t.event_id = ra.event_id LEFT JOIN alerts a ON t.event_id = a.event_id GROUP BY c.customer_id;	2529991047
SELECT event_type, COUNT(*) FROM risk_events WHERE status = '未处理' GROUP BY event_type;	1891370109
SELECT c.customer_id, c.customer_name, t.transaction_id, t.transaction_type, t.amount, t.transaction_date FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '低' AND c.credit_score > 700;	3513778977
SELECT a.alert_id, a.alert_type, a.alert_content, a.alert_time, r.event_type, r.event_description, r.occurrence_time, r.severity FROM alerts a INNER JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理' AND a.alert_level = '高';	1342627605
SELECT alert_id, status FROM alerts WHERE alert_type = '合规违规';	2457540425
SELECT c.customer_name, c.risk_level, SUM(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.risk_score > 80 GROUP BY c.customer_name, c.risk_level;	3803553571
SELECT report_content FROM risk_reports WHERE report_type = '月度风险报告' AND approval_status = '已拒绝';	3170647440
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	3365749326
SELECT c.customer_id, c.customer_name FROM customers c INNER JOIN transactions t ON c.customer_id = t.customer_id WHERE t.transaction_type = '转账' AND t.amount > 200000 AND t.transaction_date BETWEEN '2023-05-04 00:00:00' AND '2023-05-04 23:59:59';	2632721664
SELECT a.alert_id, r.event_description, a.assigned_to FROM alerts a JOIN risk_events r ON a.event_id = r.event_id WHERE a.status = '未处理' AND a.alert_level = '高级';	2115455156
SELECT report_id FROM risk_reports WHERE report_date BETWEEN '2023-04-01' AND '2023-04-30' AND approved_by = '高志远';	3669635067
SELECT transaction_type, status, COUNT(*) FROM transactions GROUP BY transaction_type, status;	4274653529
SELECT re.event_id, re.event_type, ra.risk_level, ra.impact_score, ra.probability_score FROM risk_events re LEFT JOIN (SELECT DISTINCT ON (event_id) * FROM risk_assessments ORDER BY event_id, assessment_date DESC) ra ON re.event_id = ra.event_id;	522918260
SELECT c.customer_name, COUNT(DISTINCT ra.assessment_id) AS risk_assessment_count, COUNT(DISTINCT t.transaction_id) AS large_transaction_count FROM customers c JOIN risk_assessments ra ON ra.event_id IN (SELECT event_id FROM transactions WHERE customer_id = c.customer_id) JOIN transactions t ON t.customer_id = c.customer_id WHERE ra.assessment_date >= CURRENT_TIMESTAMP - INTERVAL '1 year' AND ra.risk_level = '高' AND t.transaction_date >= CURRENT_TIMESTAMP - INTERVAL '1 year' AND t.amount > 500000 GROUP BY c.customer_id, c.customer_name HAVING COUNT(DISTINCT ra.assessment_id) > 0 AND COUNT(DISTINCT t.transaction_id) > 0;	4200581425
AMBIGUOUS_QUERY	4250954216
SELECT event_id, severity FROM risk_events;	3376384926
SELECT c.risk_level, COUNT(DISTINCT c.customer_id) AS customer_count, AVG(t.amount) AS avg_transaction_amount FROM customers c JOIN transactions t ON c.customer_id = t.customer_id GROUP BY c.risk_level;	1863389546
SELECT alerts.*, audit_logs.audit_result FROM alerts JOIN audit_logs ON alerts.alert_id = audit_logs.alert_id WHERE audit_logs.auditor = '张强';	1527263926
SELECT rml.actual_value, rml.is_exceeding_threshold, ri.* FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id;	959044977
SELECT rml.indicator_id, COUNT(*) AS exceed_count, AVG(rml.actual_value - ri.threshold_value) AS avg_exceed_value FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id WHERE rml.is_exceeding_threshold = true AND rml.monitoring_date BETWEEN '2023-01-01' AND '2023-12-31' GROUP BY rml.indicator_id;	3965887957
SELECT alert_content, status FROM alerts WHERE alert_time >= '2023-01-01' AND alert_time < '2024-01-01';	1868278026
SELECT DISTINCT ON (indicator_id) indicator_id, actual_value FROM risk_monitoring_logs ORDER BY indicator_id, monitoring_date DESC;	739540706
SELECT indicator_id, SUM(CASE WHEN is_exceeding_threshold THEN 1 ELSE 0 END) AS exceed_count, SUM(CASE WHEN is_exceeding_threshold THEN 1 ELSE 0 END)*100.0/COUNT(*) AS exceed_percentage FROM risk_monitoring_logs WHERE monitoring_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY indicator_id ORDER BY exceed_count DESC LIMIT 10;	2175305749
SELECT risk_level, COUNT(*) FROM customers GROUP BY risk_level;	2458944386
SELECT c.customer_id, t.risk_score, t.status FROM customers c JOIN transactions t ON c.customer_id = t.customer_id;	2707842138
SELECT * FROM risk_assessments ra JOIN transactions t ON ra.event_id = t.event_id WHERE ra.risk_level = '高风险' AND t.risk_score < 50;	1192678488
SELECT transaction_type FROM transactions WHERE status = '成功' GROUP BY transaction_type ORDER BY count(*) DESC LIMIT 1;	1326015635
SELECT * FROM transactions t JOIN risk_events r ON t.event_id = r.event_id WHERE t.status = '失败' AND r.status = '已解决';	3710680886
SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date, c.customer_id, c.customer_name, c.customer_type FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.status = '处理中';	581328064
SELECT t.transaction_id, t.event_id, r.event_type FROM transactions t JOIN risk_events r ON t.event_id = r.event_id WHERE t.amount > 1000;	3472554935
SELECT t.*, e.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id JOIN risk_events e ON t.event_id = e.event_id WHERE t.amount > 100000 AND c.risk_level = '高' AND t.transaction_date >= current_date - interval '1 year';	72136253
SELECT * FROM risk_assessments WHERE mitigation_plan IS NOT NULL;	3778743836
SELECT t.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE c.risk_level = '高风险';	1975692082
SELECT rml.actual_value, ri.indicator_name FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id WHERE rml.actual_value < ri.threshold_value;	263024116
SELECT r.report_id, e.event_type, e.status FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approval_status = '已拒绝';	4272740433
SELECT customer_name FROM customers WHERE registration_date BETWEEN '2021-01-01' AND '2021-12-31' AND credit_score > 700 AND customer_id IN (SELECT DISTINCT customer_id FROM transactions WHERE transaction_date >= (CURRENT_DATE - INTERVAL '1 year')) ORDER BY customer_name;	33599686
SELECT a.*, r.*, t.* FROM alerts a JOIN risk_events r ON a.event_id = r.event_id JOIN transactions t ON a.event_id = t.event_id WHERE a.assigned_to = '陈强';	1531250861
SELECT * FROM risk_reports WHERE report_content LIKE '%合规%';	3898772643
SELECT to_char(occurrence_time, 'YYYY-MM') AS month, COUNT(DISTINCT re.event_id) AS event_count, AVG(severity) AS avg_severity, COUNT(a.alert_id) AS alert_count FROM risk_events re LEFT JOIN alerts a ON re.event_id = a.event_id GROUP BY month ORDER BY month;	3314311299
SELECT indicator_name, threshold_value FROM risk_indicators;	648920878
SELECT rml.indicator_id, ri.indicator_name, rml.monitoring_date, rml.actual_value, ri.threshold_value, rml.is_exceeding_threshold FROM risk_monitoring_logs rml JOIN risk_indicators ri ON rml.indicator_id = ri.indicator_id JOIN (SELECT indicator_id, MAX(monitoring_date) AS latest_date FROM risk_monitoring_logs GROUP BY indicator_id) latest ON rml.indicator_id = latest.indicator_id AND rml.monitoring_date = latest.latest_date;	2490177094
SELECT t.*, c.* FROM transactions t JOIN customers c ON t.customer_id = c.customer_id WHERE t.amount > 100000;	4125993810
SELECT * FROM risk_reports WHERE approval_status = '已批准';	1573849130
SELECT transaction_type, AVG(risk_score) FROM transactions GROUP BY transaction_type;	180382260
SELECT 
    event_type,
    AVG(CASE WHEN status = '已解决' THEN EXTRACT(EPOCH FROM (occurrence_time - created_at))/3600 ELSE NULL END) AS avg_resolution_time_hours,
    AVG(CASE WHEN status = '未处理' THEN EXTRACT(EPOCH FROM (NOW() - created_at))/3600 ELSE NULL END) AS avg_pending_time_hours,
    AVG(CASE WHEN status = '处理中' THEN EXTRACT(EPOCH FROM (NOW() - created_at))/3600 ELSE NULL END) AS avg_processing_time_hours
FROM risk_events
GROUP BY event_type;	3666899871
SELECT a.alert_type, COUNT(*) AS alert_count, AVG(EXTRACT(EPOCH FROM (al.audit_time - a.alert_time))) AS avg_processing_time FROM alerts a INNER JOIN audit_logs al ON a.alert_id = al.alert_id WHERE a.status = '已处理' GROUP BY a.alert_type;	3229183107
SELECT e.event_type, AVG(a.audit_time - e.created_at) AS avg_processing_time FROM risk_events e JOIN audit_logs a ON e.event_id = a.event_id WHERE a.audit_result = '已解决' GROUP BY e.event_type;	1330206790
SELECT a.alert_content, r.status FROM alerts a JOIN risk_events r ON a.event_id = r.event_id;	1499863131
SELECT c.customer_name, COUNT(DISTINCT t.transaction_id) AS high_risk_transactions, COUNT(DISTINCT a.alert_id) AS high_level_alerts FROM customers c JOIN transactions t ON c.customer_id = t.customer_id JOIN alerts a ON c.customer_id = (SELECT customer_id FROM transactions WHERE transaction_id = a.event_id) WHERE t.risk_score > 80 AND EXTRACT(YEAR FROM t.transaction_date) = 2023 AND a.alert_level = '高级' GROUP BY c.customer_id, c.customer_name HAVING COUNT(DISTINCT t.transaction_id) > 0 AND COUNT(DISTINCT a.alert_id) > 0;	4020556557
SELECT re.severity, ra.risk_level FROM risk_events re JOIN risk_assessments ra ON re.event_id = ra.event_id;	2574806195
AMBIGUOUS_QUERY	368566951
SELECT customer_type, count(*) FROM customers GROUP BY customer_type;	1635727552
SELECT ra.*, re.* FROM risk_assessments ra INNER JOIN risk_events re ON ra.event_id = re.event_id;	328924275
AMBIGUOUS_QUERY	206421261
SELECT c.customer_name, c.risk_level, t.transaction_date, t.amount, t.risk_score FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险' AND t.transaction_date = (SELECT MAX(transaction_date) FROM transactions WHERE customer_id = c.customer_id);	1632035738
SELECT transaction_type, COUNT(*), SUM(CASE WHEN status = '成功' THEN 1 ELSE 0 END) / COUNT(*)::float FROM transactions GROUP BY transaction_type;	3886658963
SELECT e.event_id, e.event_type, e.event_description, a.mitigation_plan, a.assessor FROM risk_events e JOIN risk_assessments a ON e.event_id = a.event_id WHERE a.risk_level = '高';	2797728174
SELECT customer_id FROM customers WHERE risk_level = '高' AND credit_score < 700;	4147622428
SELECT * FROM customers WHERE risk_level = '高' AND credit_score < 600;	2005982395
SELECT c.risk_level, SUM(t.amount) FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE t.status = '成功' GROUP BY c.risk_level;	2801172444
SELECT r.report_id, r.report_type, r.report_date, e.event_id, e.event_type, e.event_description, e.occurrence_time, e.severity FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approval_status = '已批准';	449712045
SELECT author FROM risk_reports GROUP BY author ORDER BY count(*) DESC LIMIT 1;	3632195172
SELECT event_id, reporter FROM risk_events WHERE status = '未处理';	673496495
SELECT customer_name, last_update_date FROM customers WHERE registration_date > '2021-01-01';	1638441248
SELECT r.report_id, r.report_type, r.report_date, e.event_id, e.event_type, e.event_description, e.occurrence_time, e.severity FROM risk_reports r JOIN risk_events e ON r.event_id = e.event_id WHERE r.approved_by = '高志远';	108772594
SELECT ri.indicator_name, rml.actual_value, ri.threshold_value, rml.monitoring_date FROM risk_indicators ri LEFT JOIN risk_monitoring_logs rml ON ri.indicator_id = rml.indicator_id WHERE rml.monitoring_date = (SELECT MAX(monitoring_date) FROM risk_monitoring_logs WHERE indicator_id = ri.indicator_id) OR rml.monitoring_date IS NULL;	4205470451
SELECT * FROM risk_monitoring_logs JOIN risk_indicators ON risk_monitoring_logs.indicator_id = risk_indicators.indicator_id;	3583518096
SELECT AVG(impact_score), AVG(probability_score) FROM risk_assessments;	2055776443
SELECT * FROM risk_events JOIN risk_assessments ON risk_events.event_id = risk_assessments.event_id WHERE risk_assessments.assessor IS NOT NULL;	3949000806
SELECT SUM(amount) FROM transactions WHERE transaction_type = '退款';	2492972672
SELECT ri.*, rml.* FROM risk_indicators ri LEFT JOIN (SELECT DISTINCT ON (indicator_id) * FROM risk_monitoring_logs ORDER BY indicator_id, monitoring_date DESC) rml ON ri.indicator_id = rml.indicator_id;	3484790242
SELECT e.event_type, AVG(a.assessment_date - e.occurrence_time) AS avg_mitigation_time FROM risk_events e JOIN risk_assessments a ON e.event_id = a.event_id GROUP BY e.event_type;	1982804371
SELECT event_type, COUNT(*) FROM risk_events GROUP BY event_type;	4285492578
SELECT ra.assessment_id, ra.assessor, re.event_id, re.event_type FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id;	3769897631
SELECT *, COUNT(*) OVER() AS total_count FROM risk_monitoring_logs WHERE is_exceeding_threshold = true;	529242231
SELECT re.event_id, ra.risk_level, ra.mitigation_plan FROM risk_events re LEFT JOIN risk_assessments ra ON re.event_id = ra.event_id;	3117545473
SELECT report_content, author FROM risk_reports WHERE approval_status = '已批准';	3370993536
SELECT customer_id, customer_name FROM customers WHERE risk_level = '高' AND credit_score > (SELECT AVG(credit_score) FROM customers);	1091114187
SELECT alert_content, assigned_to FROM alerts;	2742425726
SELECT event_description, severity, created_at, occurrence_time FROM risk_events WHERE status = '已解决' ORDER BY (occurrence_time - created_at) DESC LIMIT 10;	2894923077
SELECT rc.*, ri.* FROM rule_configurations rc JOIN risk_indicators ri ON rc.indicator_id = ri.indicator_id WHERE rc.is_active = true;	1904439079
SELECT risk_level, COUNT(customer_id) FROM customers GROUP BY risk_level;	1764574936
SELECT event_id, reporter FROM risk_events WHERE status != '已处理';	517879622
SELECT event_id, created_at FROM risk_events WHERE severity >= 3;	2298203203
SELECT mitigation_plan, assessor FROM risk_assessments;	3327856710
SELECT a.alert_id, re.event_description, al.audit_comments FROM alerts a JOIN risk_events re ON a.event_id = re.event_id LEFT JOIN (SELECT alert_id, audit_comments FROM audit_logs WHERE (alert_id, audit_time) IN (SELECT alert_id, MAX(audit_time) FROM audit_logs GROUP BY alert_id)) al ON a.alert_id = al.alert_id WHERE a.status != '已解决' AND a.alert_level = '高级';	3186015417
SELECT re.event_id, ra.mitigation_plan FROM risk_assessments ra JOIN risk_events re ON ra.event_id = re.event_id WHERE ra.risk_level = '高';	278998762
SELECT DISTINCT c.customer_id FROM customers c JOIN transactions t ON c.customer_id = t.customer_id WHERE c.risk_level = '高风险' AND t.amount > 100000 AND t.transaction_date >= CURRENT_DATE - INTERVAL '1 year';	3967091987
SELECT * FROM risk_assessments WHERE impact_score > 8 AND risk_level = '高';	4092376057
SELECT re.*, rr.report_type, rr.report_content FROM risk_events re LEFT JOIN risk_reports rr ON re.event_id = rr.event_id;	4193608347
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 2 AND rr.report_date BETWEEN '2023-07-01' AND '2023-09-30' AND npl.report_date BETWEEN '2023-07-01' AND '2023-09-30';	1848858966
SELECT * FROM regulatory_reports WHERE report_date = '2023-11-01';	4213891451
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE car.report_date = '2023-06-30' AND npl.report_date = '2023-06-30' AND car.total_car < 12 AND npl.npl_ratio > 2;	1479692348
SELECT fi.institution_name FROM risk_exposure re JOIN financial_institution_info fi ON re.institution_id = fi.institution_id ORDER BY re.market_risk_exposure / re.total_risk_exposure DESC LIMIT 1;	1995041708
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND fi.registered_capital > 50000000 AND rr.report_date BETWEEN '2023-07-01' AND '2023-09-30';	963624927
SELECT f.institution_name, AVG(c.risk_weighted_assets/b.total_assets) AS risk_weighted_asset_density FROM financial_institution_info f JOIN capital_adequacy_ratio c ON f.institution_id = c.institution_id JOIN balance_sheet b ON f.institution_id = b.institution_id AND c.report_date = b.report_date GROUP BY f.institution_name ORDER BY risk_weighted_asset_density DESC LIMIT 1;	1658477082
SELECT liquidity_coverage_ratio, net_stable_funding_ratio FROM liquidity_ratio;	4132703668
SELECT DISTINCT institution_name FROM financial_institution_info JOIN compliance_records USING(institution_id) WHERE EXTRACT(YEAR FROM record_date) = 2023 AND EXTRACT(MONTH FROM record_date) = 12 AND (status != '已解决' OR status IS NULL);	3320395647
SELECT institution_id, SUM(loans_and_advances) AS total_loans, SUM(deposits) AS total_deposits FROM balance_sheet WHERE report_date >= '2024-01-01' AND report_date < '2025-01-01' GROUP BY institution_id;	1564305915
SELECT * FROM balance_sheet WHERE report_date = '2039-06-08';	4026702014
SELECT COUNT(DISTINCT institution_id) FROM non_performing_loans WHERE npl_ratio > 3;	512893913
SELECT net_interest_income, non_interest_income FROM income_statement WHERE report_date = '2023-03-01';	387964381
SELECT npl_amount/total_loans FROM non_performing_loans;	392823504
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE r.report_type = '季度报告' AND r.approval_status = '需修改' AND n.npl_ratio > 1 AND EXTRACT(YEAR FROM r.report_date) = 2023 AND EXTRACT(YEAR FROM n.report_date) = 2023;	2013521148
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM regulatory_reports WHERE report_date = '2023-10-01' AND report_type = '半年度报告' AND approval_status = '待审核');	1920599339
SELECT institution_name FROM financial_institution_info WHERE institution_type = '非银行' ORDER BY registered_capital DESC LIMIT 5;	2173229598
SELECT COUNT(*) FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE fi.institution_id IN (SELECT institution_id FROM balance_sheet GROUP BY institution_id ORDER BY SUM(total_assets) DESC LIMIT 500) AND npl.npl_ratio < 1 AND npl.provision_coverage_ratio > 200;	1986299311
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE car.report_date = '2023-12-01' AND rr.report_date = '2023-12-01' AND car.core_tier_1_ratio < 10 AND rr.approval_status = '待审核';	1934474274
SELECT fi.institution_name FROM financial_institution_info fi JOIN (SELECT i1.institution_id, ((i2.net_interest_income+i2.non_interest_income)-(i1.net_interest_income+i1.non_interest_income))/(i1.net_interest_income+i1.non_interest_income) AS revenue_growth, (i2.net_profit-i1.net_profit)/i1.net_profit AS profit_growth FROM income_statement i1 JOIN income_statement i2 ON i1.institution_id=i2.institution_id AND i1.report_date=(SELECT MAX(report_date) FROM income_statement WHERE report_date<=(SELECT MAX(report_date) FROM income_statement)-INTERVAL '1 year') AND i2.report_date=(SELECT MAX(report_date) FROM income_statement) WHERE i1.report_date>=CURRENT_DATE-INTERVAL '2 years' AND i2.report_date>=CURRENT_DATE-INTERVAL '1 year' ORDER BY revenue_growth DESC, profit_growth ASC LIMIT 1) t ON fi.institution_id=t.institution_id;	3102250159
SELECT report_type, approval_status FROM regulatory_reports WHERE report_date = '2023-07-01';	3066710012
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE car.core_tier_1_ratio > (SELECT AVG(core_tier_1_ratio) FROM capital_adequacy_ratio) AND car.tier_1_ratio > (SELECT AVG(tier_1_ratio) FROM capital_adequacy_ratio) AND car.total_car > (SELECT AVG(total_car) FROM capital_adequacy_ratio);	3079904075
SELECT * FROM compliance_records WHERE EXTRACT(YEAR FROM record_date) = 2023 AND status = '已解决';	2257683611
SELECT report_type FROM regulatory_reports WHERE submission_date BETWEEN '2023-07-01' AND '2023-09-30' GROUP BY report_type ORDER BY COUNT(*) DESC LIMIT 1;	722775591
SELECT tier_1_ratio FROM capital_adequacy_ratio;	692012487
SELECT fi.institution_name, lr.report_date FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id WHERE lr.liquidity_coverage_ratio > 100;	3599351686
SELECT f.institution_name, 
       STDDEV(b.total_liabilities/b.total_assets) AS asset_liability_ratio_stddev,
       ARRAY_AGG(l.liquidity_coverage_ratio ORDER BY l.report_date) AS lcr_trend
FROM financial_institution_info f
JOIN balance_sheet b ON f.institution_id = b.institution_id
JOIN liquidity_ratio l ON f.institution_id = l.institution_id
WHERE b.report_date >= CURRENT_DATE - INTERVAL '2 years'
  AND l.report_date >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY f.institution_id, f.institution_name
ORDER BY asset_liability_ratio_stddev DESC
LIMIT 5;	3317302935
SELECT description, severity FROM compliance_records WHERE EXTRACT(YEAR FROM record_date) = 2023 AND EXTRACT(MONTH FROM record_date) = 3;	3773444090
SELECT description, severity FROM compliance_records WHERE record_date >= '2024-01-01' AND record_date <= '2024-12-31';	1568439599
SELECT report_type FROM regulatory_reports WHERE report_date = '2023-10-01';	2339192001
SELECT * FROM compliance_records WHERE EXTRACT(YEAR FROM record_date) = 2023 AND severity = '中';	1629609477
SELECT * FROM compliance_records WHERE record_date = '2023-10-01';	3577134167
SELECT fi.institution_name FROM financial_institution_info fi JOIN liquidity_ratio lr ON fi.institution_id = lr.institution_id WHERE lr.liquidity_coverage_ratio > (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio) AND lr.net_stable_funding_ratio > (SELECT AVG(net_stable_funding_ratio) FROM liquidity_ratio) AND lr.loan_to_deposit_ratio > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio);	1942470085
SELECT fi.institution_name, rr.report_type, rr.submission_date FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.submission_date BETWEEN '2023-07-01' AND '2023-09-30' AND rr.approval_status = '需修改' ORDER BY rr.submission_date DESC;	385930717
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id AND car.report_date = npl.report_date WHERE car.total_car < (SELECT percentile_cont(0.25) WITHIN GROUP (ORDER BY total_car) FROM capital_adequacy_ratio) AND npl.npl_ratio < (SELECT AVG(npl_ratio) FROM non_performing_loans);	528420038
SELECT registered_capital, institution_type FROM financial_institution_info;	2513164587
SELECT establishment_date, legal_representative FROM financial_institution_info;	1975090084
SELECT * FROM compliance_records WHERE status = '已解决';	107672657
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date BETWEEN '2023-07-01' AND '2023-07-31' AND rr.approval_status = '需修改' AND npl.report_date BETWEEN '2023-07-01' AND '2023-07-31' AND npl.npl_ratio > 1;	1483363664
SELECT fi.institution_name FROM financial_institution_info fi JOIN balance_sheet bs ON fi.institution_id = bs.institution_id ORDER BY ABS(bs.loans_and_advances/bs.deposits - 1) LIMIT 1;	2929840073
SELECT fi.institution_name, fi.institution_type, fi.license_number FROM financial_institution_info fi INNER JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE npl.total_loans > 100000000000;	1300789994
SELECT cash_and_equivalents FROM balance_sheet WHERE report_date = '2026-04-27';	2165898338
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE car.core_tier_1_ratio < 9;	3755218299
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND n.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND n.npl_ratio > 2;	523740688
SELECT COUNT(*) FROM (
    SELECT car.institution_id 
    FROM capital_adequacy_ratio car 
    JOIN balance_sheet bs ON car.institution_id = bs.institution_id AND car.report_date = bs.report_date 
    ORDER BY (car.risk_weighted_assets / bs.total_assets) DESC 
    LIMIT 10
) AS top_institutions 
WHERE EXISTS (
    SELECT 1 FROM risk_exposure re 
    WHERE re.institution_id = top_institutions.institution_id 
    AND re.market_risk_exposure > 10000000
);	3766160186
-- 无法回答，数据库缺少分支机构相关信息;	3227551380
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE re.market_risk_exposure/re.total_risk_exposure > 0.2 AND car.core_tier_1_ratio < 8.5;	2211928222
SELECT fi.institution_name, car.core_tier_1_ratio, car.tier_1_ratio, car.total_car FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE car.report_date = '2023-12-01' AND car.core_tier_1_ratio < 10 AND car.total_car < 12;	1570037252
SELECT COUNT(*) FROM compliance_records WHERE severity = '高' AND record_date BETWEEN '2023-01-01' AND '2023-12-31';	1995720794
SELECT institution_name FROM financial_institution_info JOIN balance_sheet USING(institution_id) ORDER BY (cash_and_equivalents/total_assets) DESC LIMIT 1;	2276785796
SELECT institution_name FROM financial_institution_info JOIN risk_exposure ON financial_institution_info.institution_id = risk_exposure.institution_id WHERE (market_risk_exposure/total_risk_exposure) > 0.4;	1118569576
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rr.report_date >= '2023-01-01' AND rr.report_date <= '2023-12-31' AND rr.approval_status = '已批准' AND rr.comments IS NOT NULL GROUP BY fi.institution_name ORDER BY COUNT(*) DESC LIMIT 1;	201491443
SELECT DISTINCT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id AND car.report_date = rr.report_date WHERE EXTRACT(YEAR FROM car.report_date) = 2023 AND car.core_tier_1_ratio < 8 AND rr.approval_status = '已批准';	883311234
SELECT credit_risk_exposure, operational_risk_exposure FROM risk_exposure WHERE report_date BETWEEN '2024-01-01' AND '2024-01-31';	1131673647
SELECT description, severity FROM compliance_records WHERE record_date = '2023-04-02';	626463466
SELECT report_date, npl_ratio FROM non_performing_loans ORDER BY report_date;	4144375691
SELECT f.institution_name, n.provision_coverage_ratio FROM non_performing_loans n JOIN financial_institution_info f ON n.institution_id = f.institution_id WHERE n.provision_coverage_ratio > 150;	3229296369
SELECT * FROM related_party_transactions WHERE transaction_date = '2023-12-22';	386496319
SELECT i.institution_name FROM financial_institution_info i JOIN liquidity_ratio l ON i.institution_id = l.institution_id JOIN non_performing_loans n ON i.institution_id = n.institution_id AND l.report_date = n.report_date WHERE l.liquidity_coverage_ratio > 110 AND n.npl_ratio < 1.5;	1091949185
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND n.npl_ratio > 2;	2649798001
SELECT f.institution_name FROM financial_institution_info f JOIN income_statement i ON f.institution_id = i.institution_id WHERE i.report_date >= CURRENT_DATE - INTERVAL '2 years' GROUP BY f.institution_name ORDER BY AVG(i.net_profit / (i.net_interest_income + i.non_interest_income)) DESC LIMIT 5;	3441420122
SELECT fi.institution_type, AVG(npl.npl_ratio) FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE EXTRACT(YEAR FROM npl.report_date) = 2023 GROUP BY fi.institution_type;	3747732181
SELECT COUNT(DISTINCT fi.institution_id) FROM financial_institution_info fi
JOIN risk_exposure re1 ON fi.institution_id = re1.institution_id
JOIN risk_exposure re2 ON re1.institution_id = re2.institution_id AND re1.report_date > re2.report_date
JOIN capital_adequacy_ratio car1 ON fi.institution_id = car1.institution_id AND re1.report_date = car1.report_date
JOIN capital_adequacy_ratio car2 ON car1.institution_id = car2.institution_id AND car1.report_date > car2.report_date
WHERE (re1.market_risk_exposure - re2.market_risk_exposure)/re2.market_risk_exposure > 0.5
AND (car1.total_car - car2.total_car) < 1;	919872126
SELECT total_assets, total_liabilities FROM balance_sheet;	2908646442
SELECT DISTINCT i.institution_name FROM financial_institution_info i JOIN regulatory_reports r ON i.institution_id = r.institution_id JOIN related_party_transactions t ON i.institution_id = t.institution_id WHERE r.report_date BETWEEN '2023-07-01' AND '2023-07-31' AND r.approval_status = '需修改' AND t.transaction_amount > 5000000;	2285587483
SELECT AVG(c.total_car) FROM capital_adequacy_ratio c JOIN balance_sheet b ON c.institution_id = b.institution_id WHERE b.total_assets > 1000000000000;	649523026
SELECT * FROM risk_exposure WHERE report_date = '2023-10-01';	3485650704
SELECT fi.institution_name FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id WHERE rpt.transaction_date = '2023-06-01' AND rpt.transaction_amount > 5000000 AND rr.report_date = '2023-06-01' AND rr.approval_status = '已批准';	1308426053
SELECT corr(b.total_assets, c.total_car) FROM balance_sheet b JOIN capital_adequacy_ratio c ON b.institution_id = c.institution_id AND b.report_date = c.report_date;	2884378083
SELECT f.institution_name FROM financial_institution_info f JOIN (SELECT institution_id, COUNT(*) FILTER (WHERE approval_status = '未通过')::numeric / COUNT(*) AS rejection_rate FROM related_party_transactions WHERE EXTRACT(YEAR FROM transaction_date) = 2023 GROUP BY institution_id HAVING COUNT(*) FILTER (WHERE approval_status = '未通过')::numeric / COUNT(*) > 0.2) t ON f.institution_id = t.institution_id;	443478039
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-07-01' AND rr.report_type = '季度报告' AND rr.approval_status = '需修改' AND npl.npl_ratio > 2;	4005725614
SELECT r.institution_id, r.approval_status, c.description, c.severity, c.status FROM regulatory_reports r JOIN compliance_records c ON r.institution_id = c.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND EXTRACT(YEAR FROM c.record_date) = 2023;	4256634062
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2023-10-01' AND rr.report_type = '半年度报告' AND npl.report_date = '2023-10-01' AND npl.npl_ratio > 2;	2610777117
SELECT i.institution_name, l.liquidity_coverage_ratio, l.net_stable_funding_ratio FROM financial_institution_info i JOIN liquidity_ratio l ON i.institution_id = l.institution_id WHERE l.report_date BETWEEN '2023-05-01' AND '2023-05-31';	1523818846
SELECT institution_id, SUM(non_interest_income) FROM income_statement WHERE report_date = '2023-03-01' GROUP BY institution_id;	959939959
SELECT institution_id, credit_risk_exposure, market_risk_exposure, operational_risk_exposure, total_risk_exposure FROM risk_exposure WHERE report_date = '2023-02-01';	1728769608
SELECT COUNT(*) FROM related_party_transactions WHERE transaction_date BETWEEN '2023-01-01' AND '2023-12-31' AND transaction_amount > 500000000 AND transaction_type = '资产转移';	192754968
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN related_party_transactions t ON f.institution_id = t.institution_id WHERE r.report_date = '2023-08-01' AND r.approval_status = '需修改' AND t.transaction_amount > 5000000;	1423558555
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN income_statement i ON f.institution_id = i.institution_id WHERE r.report_date BETWEEN '2023-01-01' AND '2023-12-31' AND r.report_type = '季度报告' AND r.approval_status = '已拒绝' AND i.report_date BETWEEN '2023-01-01' AND '2023-03-31' AND i.net_profit > 10000000;	1234119757
SELECT institution_name FROM financial_institution_info JOIN regulatory_reports ON financial_institution_info.institution_id = regulatory_reports.institution_id WHERE report_date = '2023-07-01' AND approval_status = '需要修改' AND report_type = '季度报告';	4123846713
SELECT * FROM compliance_records WHERE compliance_type = '内控管理';	2934745000
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_type = '半年度报告' AND rr.approval_status = '待审核' AND npl.npl_ratio > 1 AND rr.report_date BETWEEN '2023-10-01' AND '2023-10-31' AND npl.report_date BETWEEN '2023-10-01' AND '2023-10-31';	2857258268
SELECT fi.institution_type, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY npl.npl_ratio) FROM financial_institution_info fi JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id GROUP BY fi.institution_type;	3135361103
SELECT * FROM capital_adequacy_ratio WHERE core_tier_1_ratio < 8;	2627561757
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '半年度报告' AND r.approval_status = '待审核' AND f.registered_capital > 50000000;	1691256900
SELECT fi.institution_name FROM financial_institution_info fi JOIN related_party_transactions rpt ON fi.institution_id = rpt.institution_id WHERE rpt.transaction_date = '2023-06-01' AND rpt.transaction_amount > 5000000 AND rpt.approval_status = '待审批';	3500907449
SELECT i.institution_name FROM financial_institution_info i JOIN liquidity_ratio l ON i.institution_id = l.institution_id WHERE l.loan_to_deposit_ratio > (SELECT AVG(loan_to_deposit_ratio) FROM liquidity_ratio) AND l.liquidity_coverage_ratio < (SELECT AVG(liquidity_coverage_ratio) FROM liquidity_ratio);	1148055259
SELECT institution_name FROM financial_institution_info JOIN income_statement USING(institution_id) WHERE report_date = '2023-04-01' AND net_interest_income > 1000000000;	2380032898
SELECT DISTINCT f.institution_name FROM financial_institution_info f JOIN regulatory_reports r ON f.institution_id = r.institution_id JOIN non_performing_loans n ON f.institution_id = n.institution_id WHERE EXTRACT(YEAR FROM r.report_date) = 2023 AND r.report_type = '季度报告' AND r.approval_status = '需修改' AND EXTRACT(YEAR FROM n.report_date) = 2023 AND n.npl_ratio > 0.01;	3197865400
SELECT fi.institution_name FROM financial_institution_info fi JOIN risk_exposure re ON fi.institution_id = re.institution_id JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE re.report_date = '2023-10-01' AND car.report_date = '2023-10-01' AND re.total_risk_exposure > 3000 AND car.core_tier_1_ratio < 8;	1039966050
SELECT COUNT(DISTINCT institution_id) FROM (SELECT institution_id, (market_risk_exposure/NULLIF(credit_risk_exposure,0)) / NULLIF(LAG(market_risk_exposure/NULLIF(credit_risk_exposure,0)) OVER (PARTITION BY institution_id ORDER BY report_date),0) - 1 AS ratio_change FROM risk_exposure WHERE report_date >= CURRENT_DATE - INTERVAL '1 year') t WHERE ABS(ratio_change) > 0.2;	198071887
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM balance_sheet WHERE loans_and_advances > deposits);	1236237152
SELECT fi.institution_name, rr.report_date, rr.approval_status FROM regulatory_reports rr JOIN financial_institution_info fi ON rr.institution_id = fi.institution_id WHERE EXTRACT(YEAR FROM rr.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝';	968909295
SELECT institution_name FROM financial_institution_info JOIN income_statement ON financial_institution_info.institution_id = income_statement.institution_id WHERE report_date = '2023-04-01' AND non_interest_income > 200000000;	2730335394
SELECT institution_name FROM financial_institution_info JOIN related_party_transactions USING(institution_id) WHERE transaction_date >= CURRENT_DATE - INTERVAL '1 year' GROUP BY institution_name ORDER BY COUNT(*) DESC LIMIT 1;	3396337586
SELECT f.institution_name, (r.credit_risk_exposure/r.total_risk_exposure)*100 AS credit_risk_ratio FROM risk_exposure r JOIN financial_institution_info f ON r.institution_id = f.institution_id ORDER BY credit_risk_ratio DESC LIMIT 1;	3597519580
SELECT DISTINCT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM risk_exposure WHERE report_date BETWEEN '2023-01-01' AND '2023-12-31');	3614967513
SELECT fi.institution_name FROM financial_institution_info fi JOIN capital_adequacy_ratio car ON fi.institution_id = car.institution_id WHERE car.report_date BETWEEN '2023-11-01' AND '2023-11-30' AND car.risk_weighted_assets > 120000000000;	2748780530
SELECT CORR(EXTRACT(DAY FROM (resolution_date - record_date)), CASE severity WHEN '高' THEN 3 WHEN '中' THEN 2 WHEN '低' THEN 1 END) FROM compliance_records WHERE resolution_date IS NOT NULL;	2632158975
SELECT COUNT(DISTINCT institution_id) FROM liquidity_ratio WHERE liquidity_coverage_ratio >= 100 AND net_stable_funding_ratio >= 100;	2902591324
SELECT AVG(npl.npl_ratio) AS avg_npl_ratio, AVG(npl.provision_coverage_ratio) AS avg_provision_coverage_ratio, AVG(car.total_car) AS avg_car FROM (SELECT institution_id FROM balance_sheet ORDER BY total_assets DESC LIMIT 1000) AS top_inst JOIN non_performing_loans npl ON top_inst.institution_id = npl.institution_id JOIN capital_adequacy_ratio car ON top_inst.institution_id = car.institution_id;	1348038828
SELECT fi.institution_name FROM regulatory_reports rr JOIN non_performing_loans npl ON rr.institution_id=npl.institution_id JOIN financial_institution_info fi ON rr.institution_id=fi.institution_id WHERE rr.report_date='2023-07-01' AND rr.report_type='季度报告' AND npl.report_date='2023-07-01' AND npl.npl_ratio>1.5;	3607596195
SELECT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE rr.report_date = '2024-01-01' AND rr.report_type = '年度报告' AND rr.approval_status = '已批准' AND npl.report_date = '2024-01-01' AND npl.npl_ratio > 1;	3633299910
SELECT l.institution_id, l.report_date, l.liquidity_coverage_ratio, l.net_stable_funding_ratio, l.loan_to_deposit_ratio, b.loans_and_advances/b.deposits AS calculated_loan_to_deposit FROM liquidity_ratio l JOIN balance_sheet b ON l.institution_id = b.institution_id AND l.report_date = b.report_date;	1922989461
SELECT fi.institution_name FROM non_performing_loans npl JOIN financial_institution_info fi ON npl.institution_id = fi.institution_id WHERE npl.report_date BETWEEN '2023-12-01' AND '2023-12-31' AND npl.npl_ratio > 1.5;	2401722243
SELECT institution_name FROM financial_institution_info WHERE institution_id IN (SELECT institution_id FROM liquidity_ratio WHERE loan_to_deposit_ratio > 75 AND liquidity_coverage_ratio < 120);	2405354254
SELECT * FROM regulatory_reports WHERE report_type = '半年度报告';	4266831229
SELECT fi.institution_name, cr.description, (cr.resolution_date - cr.record_date) AS resolution_time FROM compliance_records cr JOIN financial_institution_info fi ON cr.institution_id = fi.institution_id WHERE cr.resolution_date IS NOT NULL ORDER BY resolution_time DESC LIMIT 5;	1742014679
SELECT DISTINCT fi.institution_name FROM financial_institution_info fi JOIN regulatory_reports rr ON fi.institution_id = rr.institution_id JOIN non_performing_loans npl ON fi.institution_id = npl.institution_id WHERE EXTRACT(YEAR FROM rr.report_date) = 2023 AND rr.report_type = '季度报告' AND rr.approval_status = '已拒绝' AND EXTRACT(YEAR FROM npl.report_date) = 2023 AND npl.npl_ratio > 2;	3817977186
