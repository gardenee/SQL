--///그룹함수 COUNT///////////
SELECT COUNT(*), SUM(salary)
FROM employees;

SELECT COUNT(*), SUM(salary), AVG(salary)
FROM employees;

SELECT COUNT(*), SUM(salary), AVG(NVL(salary, 0))
FROM employees;

SELECT COUNT(*)
       ,COUNT(manager_id)
       ,COUNT(commission_pct) -- NULL은 COUNT에서 제외
FROM employees;

SELECT COUNT(*)
FROM employees
WHERE salary > 16000; 


-- ////GROUP BY절////////
SELECT department_id
       ,COUNT(*)
       ,SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id ASC;


SELECT department_id
       ,job_id
       ,COUNT(*)
       ,SUM(salary)
       ,AVG(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id ASC; 

-- WHERE절은 GROUP BY를 쓸 수 없다 > 대신 HAVING절 사용
SELECT department_id
       ,COUNT(*)
       ,SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) >= 20000
AND SUM(salary) <= 100000;
--WHERE SUM(salary) >= 20000; 
--HAVING hire_date >= 04/01/01 >> 참여 안한 COLUMN은 못씀

-- ////CASE END문//////////////////////////
SELECT first_name
       ,employee_id
       ,salary,
       CASE WHEN job_id = 'AC_ACCOUNT' THEN salary + salary * 0.1
            WHEN job_id = 'SA_REP' THEN salary + salary * 0.2
            WHEN job_id = 'ST_CLERK' THEN salary + salary * 0.3
       END realSalary
FROM employees;

-- ////DECODE문/////////////////////////
SELECT first_name
       ,employee_id
       ,salary,
       DECODE(job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                      'SA_REP', salary + salary * 0.2,
                      'ST_CLERK', salary + salary * 0.3,
              salary) realSalary
FROM employees;

-- 직원의 이름, 부서, 팀을 출력하세요
-- 팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
-- 60~100이면 ‘B-TEAM’ 110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
SELECT first_name
       ,department_id,
       CASE WHEN department_id >= 10 AND department_id <= 50 THEN 'A-TEAM'
            WHEN department_id >= 60 AND department_id <= 100 THEN 'B-TEAM'
            WHEN department_id >= 110 AND department_id <= 150 THEN 'C-TEAM'
            ELSE '팀없음'
       END teamName
FROM employees;