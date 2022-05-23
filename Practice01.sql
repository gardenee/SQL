-- 문제1
SELECT first_name || ' ' || last_name 이름
       ,salary 월급
       ,phone_number 전화번호
       ,hire_date 입사일
FROM employees
ORDER BY hire_date ASC;

--문제2
SELECT job_title 업무이름
       ,max_salary 최고월급
FROM jobs
ORDER BY max_salary DESC;

--문제3
SELECT first_name||' '||last_name 이름
       ,manager_id 매니저ID
       ,commission_pct "커미션 비율"
       ,salary 월급
FROM employees
WHERE manager_id IS NOT NULL 
AND commission_pct IS NULL
AND salary > 3000;

--문제4
SELECT job_title 업무이름
       ,max_salary 최고월급
FROM JOBS
WHERE max_salary >= 10000
ORDER BY max_salary DESC;

--문제5
SELECT first_name 이름
       ,salary 월급
       ,NVL(commission_pct, 0) 커미션비율
FROM employees
WHERE salary < 14000
AND salary >= 10000
ORDER BY salary DESC;

--문제6
SELECT first_name||' '||last_name 이름
       ,salary 월급
       ,TO_CHAR(hire_date,'YYYY-MM') 입사일
       ,department_id 부서번호
FROM employees
WHERE department_id IN (10, 90, 100);

--문제7
SELECT first_name||' '||last_name 이름
       ,salary 월급
FROM employees
WHERE UPPER(first_name) LIKE('%S%');

--문제8
SELECT *
FROM departments
ORDER BY LENGTH(department_name) DESC;

--문제9
SELECT UPPER(country_name)
FROM countries
ORDER BY UPPER(country_name) ASC;

--문제10
SELECT first_name||' '||last_name 이름
       ,salary 월급
       ,REPLACE(phone_number, '.', '-') 전화번호
       ,hire_date 입사일
FROM employees
WHERE hire_date <= '03/12/31';