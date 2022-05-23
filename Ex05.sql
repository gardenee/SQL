-- ///DCL/////////////////////////////

-- WEBDB 계정 생성(비밀번호: 1234)
CREATE USER webdb IDENTIFIED BY 1234;

-- 권한부여
GRANT resource, connect TO webdb;

-- 비밀번호 변경
ALTER USER webdb IDENTIFIED BY webdb;

-- 계정 삭제
DROP USER webdb CASCADE;



-- 계정보기
SELECT * FROM all_users;

-- 권한보기
SELECT grantee, privilege
FROM DBA_SYS_PRIVS
WHERE grantee = 'RESOURCE';