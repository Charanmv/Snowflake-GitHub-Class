Session-4
--------------------------
  CRUD 
C - Create 
R - Read 
U - Update 
D - Delete 

create table TABLE_A (NUM INT);

INSERT INTO TABLE_A (NUM)
VALUES(1),(2),(2),(3),(3),(3),(4),(4),(4),(4),(5),(5),(5),(5),(5),(NULL);

create table TABLE_B (NUM INT);

INSERT INTO TABLE_B (NUM)
VALUES(1),(1),(2),(2),(3),(3),(4),(4),(5),(5),(5),(NULL),(NULL);

DROP TABLE TABLE_B;

SELECT X.*,Y.* FROM TABLE_A X INNER JOIN TABLE_B Y
ON X.NUM = Y.NUM;

SELECT X.*,Y.* FROM TABLE_A X LEFT JOIN TABLE_B Y
ON X.NUM = Y.NUM;

SELECT X.*,Y.* FROM TABLE_A X RIGHT JOIN TABLE_B Y
ON X.NUM = Y.NUM;

SELECT X.*,Y.* FROM TABLE_A X full JOIN TABLE_B Y
ON X.NUM = Y.NUM;

select * from employees;

select first_name from 
employees where first_name like '%s';

select a.* , b.* from table_a a join table_a b
on a.num = b.num;

select * from table_a;

drop table table_b;

CREATE OR REPLACE TABLE   TABLE_A   (NUM INT);

CREATE OR REPLACE TABLE   TABLE_B   (NUM INT);
 INSERT INTO TABLE_A (NUM)  VALUES (1),
(2),
(4),
(5),
(6),
(7),
(8);


  INSERT INTO TABLE_B (NUM)  VALUES (1),
(3),
(4),
(6),
(9),
(8);


SELECT * FROM TABLE_A ;


SELECT * FROM TABLE_B ;

SELECT A.*,B.* 
     FROM  TABLE_A  A , TABLE_B B 
    WHERE A.NUM  = B.NUM ;

SELECT X.*,Y.* 
     FROM  TABLE_A  X INNER JOIN TABLE_B Y
    ON X.NUM  = Y.NUM ;

SELECT X.*,Y.* 
     FROM  TABLE_A  X RIGHT JOIN TABLE_B Y
    ON X.NUM  = Y.NUM ;

SELECT X.*,Y.* 
     FROM  TABLE_A  X FULL JOIN TABLE_B Y
    ON X.NUM  = Y.NUM ;

SHOW TABLES;
