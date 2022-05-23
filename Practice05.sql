-- 문제1
-- 당담 매니저가 배정되었으나 커미션 비율이 없고, 월급 3000 초과인 직원의
-- 이름, 매니저 아이디, 커미션 비율, 월급을 출력하세요.
SELECT first_name 이름
       ,manager_id "매니저 아이디"
       ,commission_pct "커미션 비율"
       ,salary 월급
FROM employees
WHERE manager_id IS NOT NULL
AND commission_pct IS NULL
AND salary > 3000;


-- 문제2
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호, 이름, 급여, 입사일, 전화번호, 부서번호를
-- 조회하세요.
-- 조건절 비교 방법으로 작성하세요
-- 급여의 내림차순으로 정렬하세요
-- 입사일은 2001-01-13 토요일 형식으로 출력합니다
-- 전화번호는 515-1231-4567 형식으로 출력합니다
SELECT employee_id 직원번호
       ,first_name 이름
       ,salary 급여
       ,TO_CHAR(hire_date, 'YYYY-MM-DD DAY') 입사일
       ,REPLACE(phone_number, '.', '-') 전화번호
       ,department_id 부서번호
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary)
                                  FROM employees
                                  GROUP BY department_id)
ORDER BY salary DESC;


-- 문제3
-- 매니저별 당담직원들의 평균급여, 최소급여, 최대급여를 알아보려고 한다
-- 통계대상(직원)은 2005년 이후의 입사자입니다
-- 매니저별 평균급여가 5000 이상만 출력합니다
-- 매니저별 평균급여의 내림차순으로 출력합니다
-- 매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다
-- 출력 내용은 매니저 아이디, 매니저 이름, 매니저별 평균 급여, 매니저별 최소급여,
-- 매니저별 최대급여 입니다.
SELECT m.employee_id "매니저 아이디"
       ,m.first_name "매니저 이름"
       ,e.avg "매니저별 평균 급여"
       ,e.min "매니저별 최소급여"
       ,e.max "매니저별 최대급여"
FROM employees m, (SELECT manager_id, ROUND(AVG(salary), 0) avg, MIN(salary) min, MAX(salary) max
                   FROM employees
                   WHERE hire_date >= '2005/01/01'
                   GROUP BY manager_id) e
WHERE m.employee_id = e.manager_id
AND e.avg >= 5000
ORDER BY e.avg DESC;


-- 문제4
-- 각 사원에 대해서 사번, 이름, 부서명, 매니저의 이름을 조회하세요.
-- 부서가 없는 직원도 표시합니다.
SELECT e.employee_id 사번
       ,e.first_name 이름
       ,d.department_name 부서명
       ,m.first_name "매니저 이름"
FROM employees e, employees m, departments d
WHERE e.manager_id = m.employee_id
AND e.department_id = d.department_id(+)
ORDER BY e.employee_id ASC;


-- 문제5
-- 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
-- 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
SELECT e.사번, e.이름, d.department_name 부서명, e.급여, e.입사일
FROM departments d, (SELECT ROWNUM rn, db.사번, db.이름, db.급여, db.입사일, db.부서번호
                     FROM (SELECT employee_id 사번
                                  ,first_name 이름
                                  ,salary 급여
                                  ,hire_date 입사일
                                  ,department_id 부서번호
                           FROM employees
                           WHERE hire_date >= '2005/01/01'
                           ORDER BY hire_date ASC) db
                    ) e
WHERE d.department_id = e.부서번호
AND e.rn >= 11
AND e.rn <= 20;


-- 문제6
-- 가장 늦게 입사한 직원의 이름과 연봉과 근무하는 부서 이름은?
SELECT e.first_name || ' ' || last_name 이름
       ,e.salary 연봉
       ,d.department_name 부서명
       ,e.hire_date 입사일
FROM employees e, departments d
WHERE hire_date = (SELECT MAX(hire_date) FROM employees)
AND e.department_id = d.department_id;


-- 문제7
-- 평균연봉이 가장 높은 부서 직원들의 직원번호, 이름, 성과 업무, 연봉을 조회하시오
SELECT e.employee_id 직원번호
       ,e.first_name 이름
       ,e.last_name 성
       ,j.job_title 성과업무
       ,round(a.평균급여) 부서평균급여
       ,e.salary 급여
FROM employees e, jobs j, (SELECT department_id, AVG(salary) 평균급여 FROM employees GROUP BY department_id) a
WHERE e.job_id = j.job_id
AND e.department_id = a.department_id
AND a.평균급여 = (SELECT MAX(AVG(salary)) FROM employees GROUP BY department_id)
ORDER BY e.employee_id ASC;


-- 문제8
-- 평균 급여가 가장 높은 부서는?
SELECT department_name
FROM departments
WHERE department_id = (SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        HAVING AVG(salary) = (SELECT MAX(AVG(salary)) FROM employees GROUP BY department_id));                        


SELECT d.department_name 부서명
FROM departments d, (SELECT ROWNUM, department_id, 평균급여
                     FROM (SELECT department_id, ROUND(AVG(salary), 0) 평균급여
                           FROM employees
                           GROUP BY department_id
                           ORDER BY 평균급여 DESC) 
                     WHERE ROWNUM = 1) avg
WHERE d.department_id = avg.department_id;


-- 문제9
--평균 급여가 가장 높은 지역은?
SELECT r.region_name
FROM employees e, departments d, locations l, countries c, regions r
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.country_id = c.country_id
AND c.region_id = r.region_id
GROUP BY r.region_name
HAVING AVG(e.salary) = (SELECT MAX(AVG(e.salary))
                        FROM employees e, departments d, locations l, countries c, regions r
                        WHERE e.department_id = d.department_id
                        AND d.location_id = l.location_id
                        AND l.country_id = c.country_id
                        AND c.region_id = r.region_id
                        GROUP BY r.region_id);


-- 문제10
-- 평균 급여가 제일 높은 업무는?
SELECT 업무명
FROM (SELECT AVG(e.salary)평균급여, j.job_title 업무명
      FROM employees e, jobs j
      WHERE e.job_id = j.job_id
      GROUP BY j.job_title)
WHERE 평균급여 = (SELECT MAX(AVG(e.salary))
                FROM employees e, jobs j
                WHERE e.job_id = j.job_id
                GROUP BY j.job_title);