-- ////////////////////////////
-- SUB QUERY
-- /////////////////////////////

-- 조건이 2개 이상 일 때 아래처럼 표시
-- Den보다 급여를 많이 받는 사람의 이름은?
SELECT first_name
       ,salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE first_name = 'Den');

-- 같지 않다는 <> 로 표시

-- 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
SELECT first_name
       ,salary
       ,employee_id
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);
                
-- 평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요
SELECT first_name
       ,salary
FROM employees
WHERE salary < (SELECT AVG(salary)
                FROM employees);

-- 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요  
-- 다중행 SUB QUERY
SELECT employee_id
       ,first_name
       ,salary
FROM employees
WHERE salary IN (12008, 8300);

SELECT employee_id
       ,first_name
       ,salary
FROM EMPLOYEES
WHERE salary IN (SELECT salary
                 FROM employees
                 WHERE department_id = 110);
-- IN 을 사용하면 해당하는 데이터를 모두 찾음


-- 각 부서별로 최고급여를 받는 사원을 출력하세요
SELECT department_id 부서명
       ,employee_id 사번
       ,first_name 이름
       ,salary 최대급여
FROM employees 
WHERE (department_id, salary) IN (SELECT department_id
                                         ,MAX(salary)
                                  FROM employees
                                  GROUP BY department_id)
ORDER BY department_id ASC;


-- 다중행 SUBQUERY ""ANY""
-- OR 처럼 사용
-- 부서번호가 110인 직원의 급여보다 큰 모든 직원의
-- 사번, 이름, 급여를 출력하세요
SELECT employee_id 사번
       ,first_name 이름
       ,salary 급여
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE department_id = 110);

-- ""ALL""
-- 이번에는 부서번호가 100인 모든 직원의 급여보다 큰 모든 직원의 급여 출력
SELECT first_name 이름
       ,salary 급여
FROM employees
WHERE salary > ALL (SELECT salary
                    FROM employees
                    WHERE department_id = 110);

-------------------------------------------
-- 각 부서별로 최고급여를 받는 사원을 출력하세요
SELECT department_id 부서명
       ,salary 급여
FROM employees
WHERE (department_id, salary) IN (SELECT department_id
                                         ,MAX(salary)
                                  FROM employees
                                  GROUP BY department_id);


SELECT e.department_id 부서아이디
       ,d.department_name 부서명
       ,e.first_name || ' ' || e.last_name 이름
       ,e.salary 급여
FROM employees e, departments d
WHERE (e.department_id, e.salary) IN (SELECT department_id, MAX(salary)
                                  FROM employees 
                                  GROUP BY department_id)
AND e.department_id = d.department_id
ORDER BY e.department_id;


-- 서브쿼리를 테이블로 사용할 수도 있음
SELECT e.department_id 부서아이디
       ,e.employee_id 사번
       ,e.first_name 이름
       ,e.salary 급여
FROM employees e, (SELECT department_id, MAX(salary) salary
                   FROM employees 
                   GROUP BY department_id) s
WHERE e.department_id = s.department_id
AND e.salary = s.salary;


-- 급여를 가장 많이 받은 5명의 직원의 월급을 출력
SELECT ROWNUM
       ,employee_id
       ,first_name
       ,salary
FROM (SELECT employee_id
             ,first_name
             ,salary
      FROM employees
      ORDER BY salary DESC)
WHERE ROWNUM <= 5;


-- 07년에 입사한 직원 중 급여가 많은 직원 중 3에서 7등의 이름, 급여, 입사일은?
SELECT ref.first_name
       ,ref.salary
       ,ref.hire_date
FROM (SELECT ROWNUM rn             
             ,first_name
             ,salary
             ,hire_date
      FROM employees
      WHERE hire_date >= '07/01/01'
      AND hire_date <= '07/12/31'
      ORDER BY salary DESC) ref
WHERE ref.rn >= 3 
AND ref.rn <= 7;
