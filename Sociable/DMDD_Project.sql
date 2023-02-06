show databases;

DROP DATABASE IF EXISTS oneTest;

CREATE Database oneTest;

USE oneTest;

DROP TABLE IF EXISTS sampleData;

CREATE TABLE sampleData (
UserName varchar(255)
);



INSERT INTO sampleData (UserName)
VALUES ('Patty O’Furniture');

INSERT INTO sampleData (UserName)
VALUES ('Paddy O’Furniture');

INSERT INTO sampleData (UserName)
VALUES ('Olive Yew');

INSERT INTO sampleData (UserName)
VALUES ('Paddy O’Furniture');

INSERT INTO sampleData (UserName)
VALUES ('Maureen Biologist');

INSERT INTO sampleData (UserName)
VALUES ('Teri Dactyl');

INSERT INTO sampleData (UserName)
VALUES ('Peg Legge');

INSERT INTO sampleData (UserName)
VALUES ('Liz Erd');

INSERT INTO sampleData (UserName)
VALUES ('Allie Grater');

INSERT INTO sampleData (UserName)
VALUES ('A. Musedl');

INSERT INTO sampleData (UserName)
VALUES ('Peg Legge');

INSERT INTO sampleData (UserName)
VALUES ('Constance Noring');

INSERT INTO sampleData (UserName)
VALUES ('Lois Di Nominator');

INSERT INTO sampleData (UserName)
VALUES ('Harshila');

INSERT INTO sampleData (UserName)
VALUES ('Yash');

# Gender sample data

DROP TABLE IF EXISTS GenderInfo;

CREATE TABLE GenderInfo (
Gender varchar(15)
);

INSERT INTO GenderInfo (Gender)
VALUES ('Male');

INSERT INTO GenderInfo (Gender)
VALUES ('Female');

# Country sample data

DROP TABLE IF EXISTS Country;

CREATE TABLE Country (
CountryName varchar(15)
);

INSERT INTO Country (CountryName)
VALUES ('Australia');

INSERT INTO Country (CountryName)
VALUES ('USA');

INSERT INTO Country (CountryName)
VALUES ('India');

INSERT INTO Country (CountryName)
VALUES ('Africa');

INSERT INTO Country (CountryName)
VALUES ('Nepal');

INSERT INTO Country (CountryName)
VALUES ('Italy');


DROP TABLE IF EXISTS USER;

CREATE TABLE User (
user_id int not null AUTO_INCREMENT,
name varchar(255),
password varchar(255),
gender varchar(255),
nickname varchar(255),
country varchar(255),
age int,
Is_Deleted boolean,
Is_Verified boolean,
last_login timestamp,
created_at timestamp,
PRIMARY KEY (user_id)
);



select * from sampleData;




drop procedure if exists create_user;

delimiter #
create procedure create_user()
begin

declare v_max int unsigned default 200;
declare v_counter int unsigned default 0;

  truncate table user;
  start transaction;
  while v_counter < v_max do
    
    
    
INSERT INTO USER (name, password, gender, nickname, country, age, Is_Deleted, Is_Verified, last_login, created_at) VALUES
    ((SELECT UserName FROM sampleData
ORDER BY RAND()
LIMIT 1 ), (select MD5(RAND())), 
(SELECT Gender FROM GenderInfo
ORDER BY RAND()
LIMIT 1),
(SELECT UserName FROM sampleData
ORDER BY RAND()
LIMIT 1 ),
 (SELECT countryName FROM Country
ORDER BY RAND()
LIMIT 1), 
(select LPAD(FLOOR(RAND() * 999999.99), 2, '0')), 
(SELECT FLOOR(RAND()*10) MOD 2),
 (SELECT FLOOR(RAND()*10) MOD 2),
(select FROM_UNIXTIME(
        UNIX_TIMESTAMP('2010-04-30 14:53:27') + FLOOR(0 + (RAND() * 63072000))
    )),
    (select FROM_UNIXTIME(
        UNIX_TIMESTAMP('2010-04-30 14:53:27') + FLOOR(0 + (RAND() * 63072000))
    )));
    
    set v_counter=v_counter+1;
  end while;
  commit;
end #

delimiter ;

call create_user();

select * from user;

update user u
inner join user temp on
    u.name = temp.name
set u.nickname = temp.name
