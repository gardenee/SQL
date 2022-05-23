-- 문제1
-- 직원들의 사번, 이름, 성과 부서명을 조회하여 부서이름 오름차순, 사번 내림차순 으로 정렬하세요
SELECT e.employee_id 사번
       ,e.first_name 이름
       ,e.last_name 성
       ,d.department_name 부서명
FROM employees e, departments d
WHERE e.department_id = d.department_id
ORDER BY d.department_name ASC, e.employee_id DESC;


-- 문제2 
-- employees 테이블의 job_id 는 현재의 업무아이디를 가지고 있습니다
-- 직원들의 사번, 이름, 급여, 부서명, 현재업무를 사번 오름차순 으로 정렬하세요
-- 부서가없는 Kimberely( 사번 178) 은 표시하지 않습니다
SELECT e.employee_id 사번
       ,e.first_name 이름
       ,e.salary 급여
       ,d.department_name 부서명
       ,j.job_title 현재업무
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id
ORDER BY e.employee_id ASC;

-- 문제 2-1
-- 문제2 에서 부서가 없는 Kimberely( 사번 178) 까지 표시해 보세요
SELECT e.employee_id 사번
       ,e.first_name 이름
       ,e.salary 급여
       ,d.department_name 부서명
       ,j.job_title 현재업무
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id(+)
ORDER BY e.employee_id ASC;

-- 문제3
-- 도시별로 위치한 부서들을 파악하려고 합니다 도시아이디, 도시명 , 부서명 , 부서아이디를 
-- 도시아이디 오름차순 로 정렬하여 출력하세요
-- 부서가 없는 도시는 표시하지 않습니다
SELECT l.location_id 도시아이디
       ,l.city 도시명
       ,d.department_name 부서명
       ,d.department_id 부서아이디
FROM departments d, locations l
WHERE d.location_id = l.location_id
ORDER BY l.location_id ASC;

-- 문제 3-1
-- 문제3 에서 부서가 없는 도시도 표시합니다
SELECT l.location_id 도시아이디
       ,l.city 도시명
       ,d.department_name 부서명
       ,d.department_id 부서아이디
FROM departments d, locations l
WHERE d.location_id(+) = l.location_id
ORDER BY l.location_id ASC;


-- 문제4
-- 지역에 속한 나라들을 지역이름, 나라이름으로 출력하되 지역이름 오름차순, 나라이름 내림차순
-- 으로 정렬하세요
SELECT r.region_name 지역이름
       ,c.country_name 나라이름
FROM regions r, countries c
WHERE r.region_id = c.region_id
ORDER BY r.region_name ASC, c.country_name DESC;


-- 문제5
-- 자신의 매니저보다 채용일이 빠른 사원의 사번, 이름과 채용일, 매니저이름, 
-- 매니저입사일을 조회하세요
SELECT e.employee_id 사번
       ,e.first_name 이름
       ,e.hire_date 채용일
       ,m.first_name 매니저이름
       ,m.hire_date 매니저입사일
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
AND e.hire_date < m.hire_date;


-- 문제6
-- 나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다
-- 나라명, 나라아이디 , 도시명 , 도시아이디 , 부서명 , 부서아이디를 나라명 오름차순 로 정렬하여
-- 출력하세요 값이 없는 경우 표시하지 않습니다
SELECT c.country_name 나라명
       ,c.country_id 나라아이디
       ,l.city 도시명
       ,l.location_id 도시아이디
       ,d.department_name 부서명
       ,d.department_id 부서아이디
FROM countries c, locations l, departments d
WHERE c.country_id = l.country_id
AND d.location_id = l.location_id
ORDER BY c.country_name ASC;


--문제7
-- job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다
-- 과거의 업무아이디가 AC_ACCOUNT로 근무한 사원의 사번, 이름 풀네임, 업무아이디, 시작일, 
-- 종료일을 출력하세요
-- 이름은 first_name 과 last_name 을 합쳐 출력합니다
SELECT e.employee_id 사번
       ,e.first_name || ' ' || e.last_name 이름
       ,j.job_id 업무아이디
       ,j.start_date 시작일
       ,j.end_date 종료일
FROM job_history j, employees e
WHERE j.employee_id = e.employee_id
AND j.job_id = 'AC_ACCOUNT';


-- 문제8
-- 각부서에 대해서 부서번호, 부서이름, 매니저의 이름, 위치), 나라의 이름
-- 그리고 지역구분의 이름까지 전부 출력해 보세요
SELECT d.department_id 부서번호
       ,d.department_name 부서명
       ,m.first_name 매니저이름
       ,l.city 도시명
       ,c.country_name "나라 이름"
       ,r.region_name "지역 구분"
FROM departments d, locations l, countries c, regions r, employees m
WHERE d.location_id = l.location_id
AND l.country_id = c.country_id
AND c.region_id = r.region_id
AND m.employee_id = d.manager_id
ORDER BY d.department_id ASC;


-- 문제9
-- 각 사원에 대해서 사번, 이름, 부서명, 매니저의 이름을 조회하세요.
-- 부서가 없는 직원도 표시합니다
SELECT e.employee_id 사번
       ,e.first_name 이름
       ,d.department_name 부서명
       ,m.first_name 매니저이름
FROM employees e, employees m, departments d
WHERE e.manager_id = m.employee_id
AND e.department_id = d.department_id(+); 
