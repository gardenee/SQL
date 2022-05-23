-- 문제1
-- 평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요
SELECT COUNT(*)
FROM employees
WHERE salary < (SELECT AVG(salary)
                FROM employees);


-- 문제2
-- 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 직원번호, 이름, 급여, 
-- 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요
SELECT employee_id
       ,first_name
       ,salary
FROM employees
WHERE salary >= (SELECT AVG(salary)
                 FROM employees)
AND salary <= (SELECT MAX(salary)
               FROM employees)
ORDER BY salary ASC;


-- 문제3
-- 직원중 steven king이 소속된 부서가 있는 곳의 주소를 알아보려고 한다.
-- 도시 아이디, 거리명, 우편번호, 도시명, 주, 나라아이디를 출력하세요
SELECT l.location_id 도시아이디
       ,l.street_address 거리명
       ,l.postal_code 우편번호
       ,l.city 도시명
       ,l.state_province 주
       ,l.country_id 나라아이디
FROM departments d, locations l, (SELECT department_id id
                                  FROM employees
                                  WHERE first_name = 'Steven'
                                  AND last_name = 'King') e
WHERE d.location_id = l.location_id
AND d.department_id = e.id;


-- 문제4
-- job_id가 'ST_MAN'인 직원의 급여보다 작은 직원의 사번, 이름, 급여를
-- 급여의 내림차순으로 출력하세요 (ANY 연산자 사용)
SELECT employee_id 사번
       ,first_name 이름
       ,salary 급여
FROM employees
WHERE salary < ANY (SELECT salary FROM employees WHERE job_id = 'ST_MAN')
ORDER BY salary DESC;


-- 문제5
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호, 이름과 급여, 부서번호를 조회하세요.
-- 단, 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.
-- 조건절 비교, 테이블 조인 2가지 방법으로 작성하세요.

-- 5-1) 조건절 비교
SELECT employee_id 직원번호
       ,first_name 이름
       ,salary 급여
       ,department_id 부서번호
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary)
                                  FROM employees
                                  GROUP BY department_id)
ORDER BY salary DESC;

-- 5-2) 테이블 조인
SELECT e.employee_id 직원번호
       ,e.first_name 이름
       ,e.salary 급여
       ,e.department_id 부서번호
FROM employees e, (SELECT department_id, MAX(salary) salary
                   FROM employees
                   GROUP BY department_id) s
WHERE e.department_id = s.department_id
AND e.salary = s.salary
ORDER BY e.salary DESC;


-- 문제6
-- 각 업무 별로 연봉의 총합을 구하려고 합니다
-- 연봉 총합이 가장 높은 업무부터 업무명과 연봉 총합을 조회하시오
SELECT j.job_title 업무명
       ,s.salary 연봉총합
FROM jobs j, (SELECT job_id, SUM(salary) salary
              FROM employees
              GROUP BY job_id) s
WHERE j.job_id = s.job_id
ORDER BY s.salary DESC;


-- 문제7
-- 자신의 부서 평균 급여보다 연봉이 많은 직원의 직원번호, 이름과 급여를 조회하세요
SELECT e.employee_id 직원번호
       ,e.first_name 이름
       ,e.salary 급여
FROM employees e, (SELECT department_id, AVG(salary) salary
                   FROM employees
                   GROUP BY department_id) avg
WHERE e.department_id = avg.department_id
AND e.salary > avg.salary;
