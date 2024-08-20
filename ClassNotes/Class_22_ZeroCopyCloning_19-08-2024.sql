 Session-22
------------------------------

Zero copy cloning

show tables;

select * from test;

create table test_clone
clone test;

select * from test_clone;

delete from test;

select * from test;

// cloning 
  select * from our_first_db.public.movie_titles;

  create or replace table our_first_db.public.movie_titles_clone
  clone our_first_db.public.movie_titles;

//Validate the Data 
SELECT * FROM OUR_FIRST_DB.PUBLIC.MOVIE_TITLES_CLONE;

SHOW TABLES IN OUR_FIRST_DB.PUBLIC;

//Update Cloned table
UPDATE OUR_FIRST_DB.PUBLIC.MOVIE_TITLES_CLONE   
SET type = null;

 SELECT * FROM OUR_FIRST_DB.PUBLIC.MOVIE_TITLES_CLONE;
 
 SELECT * FROM OUR_FIRST_DB.PUBLIC.MOVIE_TITLES;

SHOW TABLES IN OUR_FIRST_DB.PUBLIC;


//Cloning a temporary table is not possible 
CREATE OR REPLACE TEMPORARY TABLE  OUR_FIRST_DB.PUBLIC.TEMP_TABLE (id INT)

CREATE TABLE OUR_FIRST_DB.PUBLIC.TEMP_TABLE_copy
CLONE OUR_FIRST_DB.PUBLIC.TEMP_TABLE

//Temp table cannot be cloned to a permanent table; clone to a transient table instead.
//But we can clone temporary to temporary 


// Cloning Schema
CREATE TRANSIENT SCHEMA OUR_FIRST_DB.COPIED_SCHEMA
CLONE OUR_FIRST_DB.PUBLIC;

SELECT * FROM COPIED_SCHEMA.MOVIE_TITLES;


CREATE TRANSIENT SCHEMA OUR_FIRST_DB.EXTERNAL_STAGES_COPIED
CLONE MANAGE_DB.EXTERNAL_STAGES;



// Cloning Database
CREATE TRANSIENT DATABASE OUR_FIRST_DB_COPY
CLONE OUR_FIRST_DB;

DROP DATABASE OUR_FIRST_DB_COPY;
DROP SCHEMA OUR_FIRST_DB.EXTERNAL_STAGES_COPIED;
unDROP SCHEMA OUR_FIRST_DB.COPIED_SCHEMA;



SELECT * FROM OUR_FIRST_DB.PUBLIC.MOVIE_TITLES ;  --449


DELETE  FROM OUR_FIRST_DB.PUBLIC.MOVIE_TITLES WHERE RELEASE_YEAR  >= 2000;


SELECT * FROM OUR_FIRST_DB.COPIED_SCHEMA.MOVIE_TITLES ; -- 7.8K 


ALTER TABLE OUR_FIRST_DB.COPIED_SCHEMA.MOVIE_TITLES 
 SWAP WITH OUR_FIRST_DB.PUBLIC.MOVIE_TITLES  ;
