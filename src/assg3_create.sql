--use the psql command
--\i assg3_create.sql
--to load and run this batch file.

--Creates the tables and defines the attributes.
--@author Andrew McDaniels & April Crawford
--@version 28 March 2017

CREATE TABLE sailors(
        sid integer,
        sname varchar(20),
        rating integer,
        age real,
        primary key(sid)
        );

CREATE TABLE boats(
        bid integer,
        bname varchar(20),
        color varchar(20),
        primary key(bid)
        );

CREATE TABLE reserves(
        sid integer,
        bid integer,
        day date,
        primary key(sid, bid),
        foreign key(sid) references sailors,
        foreign key(bid) references boats
        );
