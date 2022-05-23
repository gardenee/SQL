-- ///Join/////////////////////////////////////
--/////////////////////////////////////////////

SELECT employee_id
       ,first_name
       ,salary
       ,department_id
FROM employees;

-- 테이블 두개를 표현해달라고 할 때 > 가능한 모든 쌍 추출
SELECT *
FROM employees, departments;


SELECT employee_id
       ,first_name
       ,department_name
       ,salary
       ,em.department_id "e_dept id"
       ,de.department_id "d_dept id"
FROM employees em, departments de -- 이름 정해주기
WHERE em.department_id = de.department_id; -- ***

-- 모든 직원이름, 부서이름, 업무명 을 출력하세요
SELECT e.first_name 이름
       ,d.department_name 부서이름
       ,j.job_title 업무명
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id 
AND e.job_id = j.job_id;


SELECT e.first_name 이름
       ,d.department_name 부서이름
       ,j.job_title 업무명
       ,e.salary 월급
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id 
AND e.job_id = j.job_id
AND e.salary >= 7000
ORDER BY d.department_name ASC, salary DESC;
-- EQUI JOIN : 양쪽 다 만족하는 경우만 조인됨(null은 조인 안됨)
-- WHERE문 조합은 (테이블개수-1)개가 일반적(PK==FK)



-- ///LEFT-OUTER JOIN///////////////////////////////////
SELECT e.first_name
       ,e.department_id
       ,d.department_name
       ,d.department_id
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

-- 아래는 오라클에서 쓸 수 있는 방식(데이터가 적은 쪽에 +붙임)
SELECT e.first_name
       ,e.department_id
       ,d.department_name
       ,d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);


-- ////RIGHT OUTER JOIN//////////////////////
SELECT e.first_name
       ,e.department_id
       ,d.department_name
       ,d.department_id
FROM employees e RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;


SELECT e.first_name
       ,e.department_id
       ,d.department_name
       ,d.department_id
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;


-- ///FULL OUTER JOIN///////////////////////////
-- 합집합...
SELECT e.first_name
       ,e.department_id
       ,d.department_name
       ,d.department_id
FROM employees e FULL OUTER JOIN departments d
ON e.department_id = d.department_id;


-- ///SELF JOIN//////////////////////////////////
SELECT e.employee_id 사번
       ,e.first_name 이름
       ,e.salary 급여
       ,e.phone_number 전화번호
       ,NVL(m.first_name, '-') "매니저 이름"
FROM employees e, employees m -- 같은 테이블 복사, 꼭 별명 만들어야
WHERE e.manager_id = m.employee_id(+)
ORDER BY e.employee_id;
