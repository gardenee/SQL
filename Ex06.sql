-- 테이블 생성
CREATE TABLE book (
    book_id NUMBER(5)
    ,title VARCHAR2(50)
    ,author VARCHAR2(10)
    ,pub_date DATE
);

-- 칼럼 추가 ADD(메소드)
ALTER TABLE book ADD(pubs VARCHAR2(50));

-- 컬럼 수정(자료형 변경)// MODIFY(메소드)
ALTER TABLE book MODIFY(title VARCHAR2(100));

-- 컬럼 수정(컬럼 이름 변경)// RENAME COLUMN ~ TO
ALTER TABLE book RENAME COLUMN title TO subject;

-- 칼럼 삭제 // DROP(메소드)
ALTER TABLE book DROP(author);

-- 테이블 이름 수정
RENAME book TO article;

-- 테이블 삭제
DROP TABLE article;
DROP TABLE author;
DROP TABLE book;

CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);


-- 행 삽입
INSERT INTO author VALUES(1, '박경리', '토지 작가');

INSERT INTO author (author_id, author_name)
VALUES(2, '이문열');

INSERT INTO author (author_name, author_id) 
VALUES('기안84', 3);


CREATE TABLE book (
    book_id NUMBER(10),
    title VARCHAR2(100) NOT NULL,
    pubs VARCHAR2(100),
    pub_date DATE,
    author_id NUMBER(10),
    PRIMARY KEY(book_id),
    CONSTRAINT book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);

INSERT INTO book
VALUES(1, '토지', '마로니에북스', '2012-08-15', 1);

INSERT INTO book
VALUES(2, '삼국지', '민음사', '2002/03/01', 2);

UPDATE author
SET author_desc = '삼국지 작가'
WHERE author_id = 2;

UPDATE author
SET author_desc = '토지 작가'
    ,author_name = '김경리'
WHERE author_id = 1;

-- 조건 만족하는 레코드 삭제
DELETE FROM author
WHERE authoor_id = 1;

-- 조건이 없으면 모든 데이터 삭제
DELETE FROM author

-- 테이블의 모든 ROW 제거
TRUNCATE TABLE article;


-- 작가 시퀀스 만들기
CREATE SEQUENCE seq_author_id
INCREMENT BY 1
START WITH 1
NOCACHE;

INSERT INTO author VALUES(seq_author_id.NEXTVAL, '박경리', '토지 작가');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '이문열', '삼국지 작가');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '기안84', '웹툰 작가');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '황일영', 'JAVA');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '황일영2', 'JAVA2');

SELECT * 
FROM user_sequences;

SELECT seq_author_id.CURRVAL
FROM DUAL;

SELECT seq_author_id.NEXTVAL
FROM DUAL;

DROP SEQUENCE seq_author_id;

ROLLBACK; -- DML만 가능
COMMIT;
--------------------------

SELECT * 
FROM author;

SELECT *
FROM book;