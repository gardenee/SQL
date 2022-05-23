/*  
SELECT문 
- SELECT 절
- FROM 절
*/


-- ////모든 column 조회하기//////////////////
SELECT * 
FROM employees;

SELECT *
FROM departments;

-- /////원하는 column만 조회하기//////////////
SELECT employee_id, first_name, last_name
FROM employees;


--예제)
--사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
SELECT first_name, phone_number, hire_date, salary
FROM employees;

--사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시
--되도록 출력하세요
SELECT first_name
       ,last_name
       ,salary
       ,phone_number
       ,email
       ,hire_date
FROM employees;


-- /////출력할 때 컬럼명 별명으로 사용하기///////////
-- 대소문자, 공백, 특수문자 구분하려면 따옴표를 써야 함

-- 사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
SELECT first_name AS "이름"
       ,phone_number AS "전화번호"
       ,hire_date AS "입사일"
       ,salary AS "급여"
FROM employees;

-- 사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시
-- 되도록 출력하세요
SELECT employee_id "사원번호"
       ,first_name "이름"
       ,last_name "성"
       ,salary "급여"
       ,phone_number "전화번호"
       ,email "이메일"
       ,hire_date "입사일"
FROM employees;


-- ////연결 연산자(칼럼 붙이기)///////////////////
SELECT first_name, last_name
FROM employees;

SELECT first_name || last_name 이름
FROM employees;

SELECT first_name || ' ' || last_name 이름
FROM employees;

SELECT first_name || '의 입사일은 ' || hire_date AS 입사일
FROM employees;


-- ////산술 연산자//////////////////////////
SELECT first_name 성
       ,salary 월급
       ,salary*12 연봉
FROM employees;

/* 
연산이 불가능하면 오류가 남
SELECT job_id*12
FROM employees; 
*/

SELECT first_name || '-' || last_name 성명
       ,salary 급여
       ,salary*12 연봉
       ,salary*12 + 5000 연봉2
       ,phone_number 전화번호
FROM employees;


-- ////WHERE절 ////////////////////////////////////////

SELECT *
FROM employees
WHERE department_id= 10;

-- 문자, 날짜는 ‘ ‘ 로 감싸줌 ‘ ‘는 대소문자를 구분한다

-- 연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요
SELECT first_name || ' ' || last_name 이름
       ,salary 월급
FROM employees
WHERE salary >= 15000;

-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
SELECT first_name || ' ' || last_name 이름
       ,hire_date 입사일
FROM employees
WHERE hire_date >= '07/01/01';

-- 이름이 Lex인 직원의 연봉을 출력하세요
SELECT salary*12 연봉
FROM employees
WHERE first_name = 'Lex';


-- ////조건이 2개 이상일 때/////////////////////////////////
-- 연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
SELECT first_name 이름
       ,salary 급여
FROM employees
WHERE salary >= 14000 
AND salary <= 17000;

-- 연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
SELECT first_name 이름
       ,salary 급여
FROM employees
WHERE salary <= 14000
OR salary >= 17000;

-- 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
SELECT first_name 이름
       ,hire_date 입사일
FROM employees
WHERE hire_date >= '01/01/01'
AND hire_date <= '05/12/31';


-- ////BETWEEN 연산자 - 느림//////////
SELECT first_name, last_name, salary
FROM employees
WHERE salary between 14000 and 17000;


-- ////IN 연산자/////////////////////
SELECT first_name, last_name, salary
FROM employees
WHERE first_name IN ('Neena', 'Lex', 'John');

-- 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
SELECT first_name, last_name, salary
FROM employees
WHERE salary IN (2100, 3100, 4100, 5100);
  

-- ////LIKE 연산자////////////////////
-- %는 임의의 길이 문자열(공백 가능), _ 는 한글자 길이
SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE 'L%';

SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE 'L___';

SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE '%s';

-- 이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE '%am%';

-- 이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE '_a%';
 
-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '___a%';

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '__a_';


--////IS NULL & IS NOT NULL///////////////////////
SELECT first_name
       ,salary
       ,commission_pct
       ,commission_pct * salary
FROM employees
WHERE salary BETWEEN 13000 AND 15000;


SELECT first_name
       ,salary
       ,commission_pct
       ,commission_pct * salary
FROM employees
WHERE commission_pct IS NULL;

-- 커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
SELECT first_name, last_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- 담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
SELECT first_name, last_name
FROM employees
WHERE commission_pct IS NULL 
AND manager_id IS NULL;


-- ////ORDER BY로 정렬//////////////////
-- 날짜는 옛날거가 작은거
SELECT first_name, salary
FROM employees
ORDER BY salary ASC;

SELECT first_name, salary
FROM employees
WHERE salary >= 9000
ORDER BY salary DESC;

-- 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id ASC;

-- 급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
SELECT first_name, salary
FROM employees
WHERE salary >= 10000
ORDER BY salary DESC;

-- 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 
-- 이름을 출력하세요
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id ASC,
         salary DESC;
  
         
-- ////단일행 함수//////////////////////////////////////

-- ////문자함수 INITCPA(컬럼명) >> 첫글자만 대문자, 뒤에는 소문자
-- 부서번호 100인 직원의 이메일주솧와 부서번호를 출력하세요
SELECT email
       ,INITCAP(email) ID
       ,department_id
FROM employees
WHERE department_id = 100;


-- ////문자함수 LOWER/UPPER(컬럼명)////////////////////////////
SELECT first_name ORIGINAL
       ,LOWER(first_name) LOWER
       ,UPPER(first_name) UPPER
FROM employees
WHERE department_id = 100;


-- ////문자함수 SUBSTRING(컬럼명, 시작위치, 글자수)///////////////////
SELECT first_name
       ,SUBSTR(first_name, 1, 3)
       ,SUBSTR(first_name, -3, 2)
FROM employees
WHERE department_id = 100;


-- ////문자함수 LPAD/RPAD(컬럼명, 자리수, 채울문자)///////////
SELECT first_name
       ,RPAD(first_name, 10, '*')
       ,LPAD(first_name, 10, ' ')
FROM employees
WHERE department_id = 100;


-- ////문자함수 REPLACE(컬럼명, 문자1, 문자2)//////////////////////////
SELECT first_name
       ,REPLACE(first_name, 'a', '*')
       ,REPLACE(first_name, SUBSTR(first_name, 2, 3), '***')
FROM employees
WHERE department_id = 100;


-- ////TEST용/////////////////////////////////////////////
-- 가상 테이블 dual을 사용함
SELECT REPLACE('abcdefg', 'bc', '**')
FROM dual;

SELECT SUBSTR('900214-1234234', 8, 1)
FROM dual;


-- ////숫자함수 ROUND(숫자, 출력을 원하는 자리수)/////////////
SELECT ROUND(123.346, 2) "r2"
       ,ROUND(123.456, 0) "r0"
       ,ROUND(123.456, -1) "r-1"
FROM dual;

-- ////숫자함수 TRUNC(숫자, 출력을 원하는 자리수)/////////////
SELECT TRUNC(123.346, 2) "r2"
       ,TRUNC(123.456, 0) "r0"
       ,TRUNC(123.456, -1) "r-1"
FROM dual;


-- ////날짜함수 SYSDATE()//////////////////
SELECT SYSDATE
FROM dual;


-- ////날짜함수 MONTHS_BETWEEN//////////////////
SELECT MONTHS_BETWEEN('22/08/12', '22/05/11')
FROM dual;

SELECT first_name 이름
       ,TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0) || '년' 근속년수
FROM employees;


-- ////TO_CHAR(숫자, '출력모양') 숫자형 -> 문자형 ///////////////////////
SELECT first_name
       ,TO_CHAR(salary*12, '$999,999,999')
FROM employees
WHERE department_id = 110;

SELECT sysdate
       ,TO_CHAR(sysdate, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"')
FROM dual;

SELECT sysdate
       ,TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS')
FROM dual;