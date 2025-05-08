SELECT e.employee_id FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-13' AND (a.check_out - a.check_in) > INTERVAL '15 hours';	2499788398
SELECT e.name FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-11' AND a.check_in > '09:00:00' AND e.university = '清华大学';	2790038483
SELECT COUNT(*) FROM attendance_records WHERE employee_id = 'H03961' AND date BETWEEN '2024-01-01' AND '2024-12-31' AND check_in > '09:00:00';	1518250136
SELECT e.employee_id, e.name 
FROM employees e
JOIN attendance_records ar ON e.employee_id = ar.employee_id
JOIN performance_evaluations pe ON e.employee_id = pe.employee_id
WHERE ar.date = '2024-09-24' 
AND ar.check_in < '08:30:00'
AND pe.rating = 'A+'
AND pe.evaluation_date = (SELECT MAX(evaluation_date) FROM performance_evaluations WHERE employee_id = e.employee_id);	2290175818
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-10-05';	1543926007
SELECT e.name, d.name, a.check_in, a.check_out FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-21' ORDER BY d.name;	3053690473
SELECT (COUNT(CASE WHEN end_date - start_date < 90 AND status = '离职' THEN 1 END) * 100.0 / COUNT(*)) FROM probation_employees;	1446084728
SELECT e.name FROM employees e JOIN departments d ON e.department_id = d.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE d.name = '客户服务部' AND a.date = '2024-10-08' AND a.check_in > '09:00:00';	2505330870
SELECT e.name, e.hire_date FROM employees e JOIN probation_employees p ON e.employee_id = p.employee_id;	77372189
SELECT DISTINCT d.name FROM departments d JOIN employees e ON d.department_id = e.department_id JOIN attendance_records a ON e.employee_id = a.employee_id WHERE a.date = '2024-09-22' AND a.check_in > '09:00:00' AND e.remaining_annual_leave < 5;	1298859483
SELECT e.name, p.rating FROM employees e JOIN attendance_records a ON e.employee_id = a.employee_id JOIN performance_evaluations p ON e.employee_id = p.employee_id WHERE EXTRACT(YEAR FROM e.hire_date) = 2023 AND a.date = '2024-10-05';	569704912
