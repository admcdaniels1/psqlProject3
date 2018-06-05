-- use the psql command
-- \i assg3_select.sql
-- to load and run this batch file.

-- @author Andrew McDaniels & April Crawford
-- @version 28 March 2017

\echo 'Problem 1: Find the names of sailors who have reserved boat 103.'

\echo '\nResult should be:\nsname\nDustin\nLubber\nHoratio\n'

SELECT sname
FROM sailors
WHERE sailors.sid IN (SELECT sid
                     FROM reserves
                     WHERE bid = '103');


\echo 'Problem 2: Find the name of sailors who have reserved a red boat.'

\echo 'Result should be:\nsname\nDustin\nLubber\nHoratio\n'

SELECT sname
FROM sailors
WHERE sailors.sid IN (SELECT sid
                      FROM reserves NATURAL JOIN boats
                      WHERE boats.color = 'red');



\echo 'Problem 3: Find the names of sailors who have not reserved a red boat.'

\echo 'Result should be:\nsname\nBrutus\nAndy\nRusty\nZorba\nHoratio\nArt\nBob\n'

SELECT sname
FROM sailors
WHERE sailors.sid NOT IN (SELECT sid
                          FROM reserves NATURAL JOIN boats
                          WHERE boats.color = 'red');



\echo 'Problem 4:Find the names of sailors who have reserved boat number 103.' 

\echo '\nResult should be:\nsname\nDustin\nLubber\nHoratio\n'

--This is correlated
SELECT sname
FROM sailors AS s
WHERE EXISTS (SELECT *
              FROM reserves AS r
              WHERE bid = '103' AND s.sid = r.sid);



\echo 'Problem 5: Find the sailors whose rating is better than some sailor called Horatio.'

\echo 'Result should be:\nsname\nLubber\nAndy\nRusty\nZorba\nHoratio\n'

\echo 'Result should be:\nsid\n31\n32\n58\n71\n74\n'

SELECT sname, sid
FROM sailors
WHERE rating > SOME (SELECT rating
                     FROM sailors
                     WHERE sname = 'Horatio');



\echo 'Problem 6: Find the sailors whose rating is better than all the sailors called Horatio.'

\echo 'Result should be:\nsname\nRusty\nZorba\n'

\echo 'Result should be:\nsid\n58\n71\n'

SELECT sname, sid
FROM sailors
WHERE rating > ALL (SELECT rating
                    FROM sailors
                    WHERE sname = 'Horatio');



\echo 'Problem 7: Find sailors with the highest rating.'

\echo 'Result should be:\nsname\nRusty\nZorba\n'

\echo 'Result should be:\nsid\n58\n71\n'

SELECT sname, sid
FROM sailors
WHERE rating = (SELECT max(rating)
                FROM sailors);



\echo 'Problem 8: Find the names of sailors who have reserved both a red and a green boat.'

\echo 'Result should be:\nsname\nDustin\nLubber\n'

--This is correlated
SELECT DISTINCT sname
FROM sailors as S NATURAL JOIN boats NATURAL JOIN reserves
WHERE boats.color = 'red' AND EXISTS (SELECT *
                                      FROM sailors as T NATURAL JOIN boats NATURAL JOIN reserves
                                      WHERE boats.color = 'green' AND T.sid = S.sid);



\echo 'Problem 9: Find the names of sailors who have reserved both a red and a green boat.'


\echo 'Result should be:\nsname\nDustin\nLubber\n'


SELECT sname
FROM sailors
WHERE sid IN
    ((SELECT sid
    FROM sailors
    WHERE sailors.sid IN (SELECT sid
                              FROM reserves NATURAL JOIN boats
                              WHERE boats.color = 'red'))
    INTERSECT 
    (SELECT sid
    FROM sailors
    WHERE sailors.sid IN (SELECT sid
                          FROM reserves NATURAL JOIN boats
                          WHERE boats.color = 'green')));


\echo 'Problem 10: Find the names of sailors who have reserved all boats.'

\echo 'Result should be:\nsname\nDustin\n'


WITH rcount(sid, counter) AS(
    SELECT sid, count(*)
    FROM reserves
    GROUP BY sid)
SELECT sname
FROM sailors, rcount
WHERE sailors.sid = rcount.sid AND rcount.counter = (SELECT count(*)
                           FROM boats);


\echo 'Problem 11: Find the names of sailors who have reserved all boats.'

\echo 'Result should be:\nsname\nDustin\n'

WITH rcount(sid, counter) AS(
    SELECT sid, count(*)
    FROM reserves
    GROUP BY sid),
tcount(value) AS(
    SELECT count(*)
    FROM boats)
SELECT sname
FROM sailors, rcount, tcount
WHERE sailors.sid = rcount.sid AND rcount.counter = tcount.value;
