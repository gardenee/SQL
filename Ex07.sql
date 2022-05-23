CREATE TABLE author (
    author_id NUMBER(10)
    ,author_name VARCHAR2(10)
    ,author_desc VARCHAR2(500)
    ,PRIMARY KEY(author_id)
);

CREATE TABLE book (
    book_id NUMBER(10)
    ,title VARCHAR2(50)
    ,pubs VARCHAR2 (20)
    ,pub_date DATE
    ,author_id NUMBER(10)
    ,PRIMARY KEY(book_id)
    ,CONSTRAINT book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);

DROP TABLE author;
DROP TABLE book;

CREATE SEQUENCE seq_author_id
INCREMENT BY 1
START WITH 1
NOCACHE;

SELECT seq_author_id.CURRVAL
FROM DUAL;

--
ALTER SEQUENCE seq_author_id INCREMENT BY -1;
SELECT seq_author_id.NEXTVAL
FROM DUAL;
ALTER SEQUENCE seq_author_id INCREMENT BY 1;
--

DROP SEQUENCE seq_author_id;



CREATE SEQUENCE seq_book_id
INCREMENT BY 1
START WITH 1
NOCACHE;

DROP SEQUENCE seq_book_id;

---------------------------------------

INSERT INTO author VALUES(seq_author_id.NEXTVAL, '이문열', '경북 영양');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '박경리', '경상남도 통영');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '유시민', '17대 국회의원');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '기안84', '기안동 84년생');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '강풀', '온라인 만화가 1세대');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '김영하', '알쓸신잡');
INSERT INTO author VALUES(seq_author_id.NEXTVAL, '테스트', '테스트');

INSERT INTO book VALUES(seq_book_id.NEXTVAL, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
INSERT INTO book VALUES(seq_book_id.NEXTVAL, '삼국지', '민음사', '2002-03-01', 1);
INSERT INTO book VALUES(seq_book_id.NEXTVAL, '토지', '마로니에북스', '2012-08-15', 2);
INSERT INTO book VALUES(seq_book_id.NEXTVAL, '유시민의 글쓰기 특강', '생각의길', '2015-04-11', 3);
INSERT INTO book VALUES(seq_book_id.NEXTVAL, '패션왕', '중앙북스(books)', '2012-02-22', 4);
INSERT INTO book VALUES(seq_book_id.NEXTVAL, '순정만화', '재미주의', '2011-08-03', 5);
INSERT INTO book VALUES(seq_book_id.NEXTVAL, '오직두사람', '문학동네', '2017-05-04', 6);
INSERT INTO book VALUES(seq_book_id.NEXTVAL, '26년', '재미주의', '2012-02-04', 5);


UPDATE author
SET author_desc = '서울특별시'
WHERE author_name = '강풀';

DELETE FROM author
WHERE author_name = '테스트';

COMMIT;
ROLLBACK;

---------------------------------------

SELECT b.book_id
       ,b.title
       ,b.pubs
       ,b.pub_date
       ,a.author_id
       ,a.author_name
       ,a.author_desc
FROM author a, book b
WHERE a.author_id = b.author_id;

SELECT * 
FROM book;

SELECT *
FROM author;